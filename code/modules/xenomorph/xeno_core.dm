/obj/structure/xeno/core
	name = "Xeno mind core"
	icon = 'icons/Xeno/resin_silo.dmi'
	icon_state = "weed_silo"
	desc = "A slimy, oozy resin bed filled with foul-looking egg-like ...things."
	bound_width = 96
	bound_height = 96
	max_integrity = 5000
	resistance_flags = UNACIDABLE | DROPSHIP_IMMUNE | PLASMACUTTER_IMMUNE
	xeno_structure_flags = IGNORE_WEED_REMOVAL|CRITICAL_STRUCTURE

	///For minimap icon change if silo takes damage or nearby hostile
	var/warning

	var/turf/center_turf
	COOLDOWN_DECLARE(damage_alert_cooldown)
	COOLDOWN_DECLARE(proxy_alert_cooldown)

/obj/structure/xeno/core/Initialize(mapload, _hivenumber)
	. = ..()
	center_turf = get_step(src, NORTHEAST)
	if(!istype(center_turf))
		center_turf = loc

	for(var/turfs in RANGE_TURFS(XENO_SILO_DETECTION_RANGE, src))
		RegisterSignal(turfs, COMSIG_ATOM_ENTERED, PROC_REF(proxy_alert))

	update_minimap_icon()

/obj/structure/xeno/core/Destroy()
	for(var/i in contents)
		var/atom/movable/AM = i
		AM.forceMove(get_step(center_turf, pick(CARDINAL_ALL_DIRS)))
	center_turf = null
	STOP_PROCESSING(SSslowprocess, src)
	return ..()

///Change minimap icon if silo is under attack or not
/obj/structure/xeno/core/proc/update_minimap_icon()
	SSminimaps.remove_marker(src)
	SSminimaps.add_marker(src, MINIMAP_FLAG_XENO, image('icons/UI_icons/map_blips.dmi', null, "silo[warning ? "_warn" : "_passive"]", VERY_HIGH_FLOAT_LAYER))

///Alerts the Hive when hostiles get too close to their resin silo
/obj/structure/xeno/core/proc/proxy_alert(datum/source, atom/movable/hostile, direction)
	SIGNAL_HANDLER

	if(!COOLDOWN_CHECK(src, proxy_alert_cooldown)) //Proxy alert triggered too recently; abort
		return

	if(!isliving(hostile))
		return

	var/mob/living/living_triggerer = hostile
	if(living_triggerer.stat == DEAD) //We don't care about the dead
		return

	if(isxeno(hostile))
		var/mob/living/carbon/xenomorph/X = hostile
		if(X.hive == GLOB.hive_datums[hivenumber]) //Trigger proxy alert only for hostile xenos
			return

	warning = TRUE
	update_minimap_icon()
	GLOB.hive_datums[hivenumber].xeno_message("Our [name] has detected a nearby hostile [hostile] at [get_area(hostile)] (X: [hostile.x], Y: [hostile.y]).", "xenoannounce", 5, FALSE, hostile, 'sound/voice/alien/help1.ogg', FALSE, null, /atom/movable/screen/arrow/leader_tracker_arrow)
	COOLDOWN_START(src, proxy_alert_cooldown, XENO_SILO_DETECTION_COOLDOWN) //set the cooldown.
	addtimer(CALLBACK(src, PROC_REF(clear_warning)), XENO_SILO_DETECTION_COOLDOWN) //clear warning

/obj/structure/xeno/core/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	. = ..()

	//We took damage, so it's time to start regenerating if we're not already processing
	if(!CHECK_BITFIELD(datum_flags, DF_ISPROCESSING))
		START_PROCESSING(SSslowprocess, src)

	damage_alert()

/obj/structure/xeno/core/obj_destruction(damage_amount, damage_type, damage_flag)
	if(GLOB.hive_datums[hivenumber])
		GLOB.hive_datums[hivenumber].xeno_message("A xeno core has been destroyed at [AREACOORD_NO_Z(src)]!", "xenoannounce", 5, FALSE, src.loc, 'sound/voice/alien/help2.ogg',FALSE , null, /atom/movable/screen/arrow/silo_damaged_arrow)
		notify_ghosts("\ A xeno core has been destroyed at [AREACOORD_NO_Z(src)]!", source = get_turf(src), action = NOTIFY_JUMP)
		playsound(loc,'sound/effects/alien/egg_burst.ogg', 75)

	if(length(GLOB.xenoden_cores_locs))
		var/turf/T = pick(GLOB.xenoden_cores_locs)
		new /obj/structure/xeno/core(T)
		GLOB.xenoden_cores_locs -= T
		if(GLOB.hive_datums[hivenumber])
			GLOB.hive_datums[hivenumber].xeno_message("A new xeno core has been appeared at [AREACOORD_NO_Z(src)]!", "xenoannounce", 5, FALSE, T.loc, null, FALSE, null, /atom/movable/screen/arrow/silo_damaged_arrow)
	else
		var/datum/game_mode/infestation/mode = SSticker.mode //make sure mode is points defence
		mode.round_stage = INFESTATION_MARIN_RUSH_MAJOR

	return ..()

/obj/structure/xeno/core/proc/damage_alert()
	if(!COOLDOWN_CHECK(src, damage_alert_cooldown))
		return
	warning = TRUE
	update_minimap_icon()
	GLOB.hive_datums[hivenumber].xeno_message("Our [name] at [AREACOORD_NO_Z(src)] is under attack! It has [obj_integrity]/[max_integrity] Health remaining.", "xenoannounce", 5, FALSE, src, 'sound/voice/alien/help1.ogg',FALSE, null, /atom/movable/screen/arrow/silo_damaged_arrow)
	COOLDOWN_START(src, damage_alert_cooldown, XENO_SILO_HEALTH_ALERT_COOLDOWN) //set the cooldown.
	addtimer(CALLBACK(src, PROC_REF(clear_warning)), XENO_SILO_HEALTH_ALERT_COOLDOWN) //clear warning

///Clears the warning for minimap if its warning for hostiles
/obj/structure/xeno/core/proc/clear_warning()
	warning = FALSE
	update_minimap_icon()

/obj/structure/xeno/core/process()
	//Regenerate if we're at less than max integrity
	if(obj_integrity < max_integrity)
		obj_integrity = min(obj_integrity + 25, max_integrity) //Regen 5 HP per sec

/obj/structure/xeno/core/examine(mob/user)
	. = ..()
	var/current_integrity = (obj_integrity / max_integrity) * 100
	switch(current_integrity)
		if(0 to 20)
			. += span_warning("It's barely holding, there's leaking oozes all around, and most eggs are broken. Yet it is not inert.")
		if(20 to 40)
			. += span_warning("It looks severely damaged, it's movements are slow.")
		if(40 to 60)
			. += span_warning("It's quite beat up, but it seems alive.")
		if(60 to 80)
			. += span_warning("It's slightly damaged, but still seems healthy.")
		if(80 to 100)
			. += span_info("It appears to be in a good shape, pulsating healthily.")
