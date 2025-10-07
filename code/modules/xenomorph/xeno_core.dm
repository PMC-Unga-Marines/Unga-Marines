/obj/structure/xeno/core
	name = "Hivemind core"
	icon = 'icons/Xeno/resin_silo.dmi'
	icon_state = "weed_silo"
	desc = "A slimy, oozy resin bed filled with foul-looking egg-like ...things."
	bound_width = 96
	bound_height = 96
	bound_x = -32
	bound_y = -32
	pixel_x = -32
	pixel_y = -24
	max_integrity = 5000
	resistance_flags = UNACIDABLE | DROPSHIP_IMMUNE | PLASMACUTTER_IMMUNE
	xeno_structure_flags = IGNORE_WEED_REMOVAL|CRITICAL_STRUCTURE|XENO_STRUCT_WARNING_RADIUS|XENO_STRUCT_DAMAGE_ALERT

/obj/structure/xeno/core/Initialize(mapload, _hivenumber)
	. = ..()
	update_minimap_icon()

/obj/structure/xeno/core/Destroy()
	for(var/i in contents)
		var/atom/movable/AM = i
		AM.forceMove(get_step(src, pick(CARDINAL_ALL_DIRS)))
	STOP_PROCESSING(SSslowprocess, src)
	return ..()

/obj/structure/xeno/core/update_minimap_icon()
	SSminimaps.remove_marker(src)
	SSminimaps.add_marker(src, MINIMAP_FLAG_XENO, image('icons/UI_icons/map_blips.dmi', null, "silo[threat_warning ? "_warn" : "_passive"]", MINIMAP_LABELS_LAYER))

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
