/obj/structure/xeno
	hit_sound = SFX_ALIEN_RESIN_BREAK
	layer = RESIN_STRUCTURE_LAYER
	resistance_flags = UNACIDABLE
	///Bitflags specific to xeno structures
	var/xeno_structure_flags
	///Which hive(number) do we belong to?
	var/hivenumber = XENO_HIVE_NORMAL
	///Is the structure currently detecting a threat
	var/threat_warning
	///List of turfs we are checking for hostiles in
	var/list/prox_warning_turfs = list()
	COOLDOWN_DECLARE(proxy_alert_cooldown)
	COOLDOWN_DECLARE(damage_alert_cooldown)

/obj/structure/xeno/Initialize(mapload, _hivenumber)
	. = ..()
	if(!(xeno_structure_flags & IGNORE_WEED_REMOVAL))
		RegisterSignal(loc, COMSIG_TURF_WEED_REMOVED, PROC_REF(weed_removed))
	if(_hivenumber) ///because admins can spawn them
		hivenumber = _hivenumber
	LAZYADDASSOC(GLOB.xeno_structures_by_hive, hivenumber, src)
	if(xeno_structure_flags & CRITICAL_STRUCTURE)
		LAZYADDASSOC(GLOB.xeno_critical_structures_by_hive, hivenumber, src)
	if((xeno_structure_flags & XENO_STRUCT_WARNING_RADIUS))
		set_proximity_warning()

/obj/structure/xeno/Destroy()
	//prox_warning_turfs = null
	if(!locate(src) in GLOB.xeno_structures_by_hive[hivenumber])
		//We dont want to CRASH because that'd block deletion completely. Just trace it and continue.
		stack_trace("[src] not found in the list of xeno structures!")
	else
		GLOB.xeno_structures_by_hive[hivenumber] -= src
	if(xeno_structure_flags & CRITICAL_STRUCTURE)
		if(!locate(src) in GLOB.xeno_critical_structures_by_hive[hivenumber])
			stack_trace("[src] not found in the list of critical xeno structures!")
		else
			GLOB.xeno_critical_structures_by_hive[hivenumber] -= src
	return ..()

/obj/structure/xeno/ex_act(severity)
	take_damage(severity * 0.8, BRUTE, BOMB)

/obj/structure/xeno/attack_hand(mob/living/user)
	balloon_alert(user, "You only scrape at it")
	return TRUE

/obj/structure/xeno/fire_act(burn_level, flame_color)
	take_damage(burn_level / 3, BURN, FIRE)

/obj/structure/xeno/effect_smoke(obj/effect/particle_effect/smoke/S)
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_XENO_ACID))
		return
	return ..()

/// Destroy the xeno structure when the weed it was on is destroyed
/obj/structure/xeno/proc/weed_removed()
	SIGNAL_HANDLER
	var/obj/alien/weeds/found_weed = locate(/obj/alien/weeds) in loc
	if(found_weed.obj_integrity <= 0)
		obj_destruction(damage_flag = MELEE)
	else
		obj_destruction()

/obj/structure/xeno/take_damage(damage_amount, damage_type = BRUTE, armor_type = null, effects = TRUE, attack_dir, armour_penetration = 0, mob/living/blame_mob)
	. = ..()
	if(xeno_structure_flags & XENO_STRUCT_DAMAGE_ALERT)
		damage_alert()

/obj/structure/xeno/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount, damage_type, damage_flag, effects, armor_penetration, isrightclick)
	if(!(HAS_TRAIT(xeno_attacker, TRAIT_VALHALLA_XENO) && xeno_attacker.a_intent == INTENT_HARM && (tgui_alert(xeno_attacker, "Are you sure you want to tear down [src]?", "Tear down [src]?", list("Yes","No"))) == "Yes"))
		return ..()
	if(!do_after(xeno_attacker, 3 SECONDS, NONE, src))
		return
	xeno_attacker.do_attack_animation(src, ATTACK_EFFECT_CLAW)
	balloon_alert_to_viewers("\The [xeno_attacker] tears down \the [src]!", "We tear down \the [src].")
	playsound(src, SFX_ALIEN_RESIN_BREAK, 25)
	take_damage(max_integrity) // Ensure its destroyed

/obj/structure/xeno/plasmacutter_act(mob/living/user, obj/item/tool/pickaxe/plasmacutter/I)
	if(user.do_actions)
		return FALSE
	if(!(obj_flags & CAN_BE_HIT) || CHECK_BITFIELD(resistance_flags, PLASMACUTTER_IMMUNE) || CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return FALSE
	if(!I.powered || (I.item_flags & NOBLUDGEON))
		return FALSE
	var/charge_cost = PLASMACUTTER_BASE_COST * PLASMACUTTER_VLOW_MOD
	if(!I.start_cut(user, name, src, charge_cost, no_string = TRUE))
		return FALSE
	user.changeNext_move(I.attack_speed)
	user.do_attack_animation(src, used_item = I)
	I.cut_apart(user, name, src, charge_cost)
	take_damage(max(0, I.force * (1 + PLASMACUTTER_RESIN_MULTIPLIER)), I.damtype, MELEE)
	playsound(src, SFX_ALIEN_RESIN_BREAK, 25)
	return TRUE

/obj/structure/xeno/silo/Moved(atom/old_loc, movement_dir, forced, list/old_locs)
	. = ..()
	if((xeno_structure_flags & XENO_STRUCT_WARNING_RADIUS))
		set_proximity_warning()

///Sets the proxy signals for our loc, removing the old ones if any
/obj/structure/xeno/proc/set_proximity_warning()
	for(var/old_turf in prox_warning_turfs)
		UnregisterSignal(old_turf, COMSIG_ATOM_ENTERED)
	prox_warning_turfs.Cut()

	for(var/new_turf in RANGE_TURFS(XENO_STRUCTURE_DETECTION_RANGE, src))
		RegisterSignal(new_turf, COMSIG_ATOM_ENTERED, PROC_REF(proxy_alert))
		prox_warning_turfs += new_turf

///Alerts the Hive when hostiles get too close to this structure
/obj/structure/xeno/proc/proxy_alert(datum/source, atom/movable/hostile)
	SIGNAL_HANDLER

	if(!COOLDOWN_CHECK(src, proxy_alert_cooldown))
		return

	if(!iscarbon(hostile) && !isvehicle(hostile))
		return

	if(iscarbon(hostile))
		var/mob/living/carbon/carbon_triggerer = hostile
		if(carbon_triggerer.stat == DEAD)
			return
		if(isxeno(hostile))
			var/mob/living/carbon/xenomorph/xeno_triggerer = hostile
			if(xeno_triggerer.hive == GLOB.hive_datums[hivenumber]) //Trigger proxy alert only for hostile xenos
				return
			
	threat_warning = TRUE
	GLOB.hive_datums[hivenumber].xeno_message("Our [name] has detected a nearby hostile [hostile] at [get_area(hostile)] (X: [hostile.x], Y: [hostile.y]).", "xenoannounce", 5, FALSE, hostile, 'sound/voice/alien/help1.ogg', FALSE, null, /atom/movable/screen/arrow/leader_tracker_arrow)
	COOLDOWN_START(src, proxy_alert_cooldown, XENO_STRUCTURE_DETECTION_COOLDOWN)
	addtimer(CALLBACK(src, PROC_REF(clear_warning)), XENO_STRUCTURE_DETECTION_COOLDOWN)
	update_minimap_icon()
	update_appearance(UPDATE_ICON)

///Notifies the hive when we take damage
/obj/structure/xeno/proc/damage_alert()
	if(!COOLDOWN_CHECK(src, damage_alert_cooldown))
		return
	threat_warning = TRUE
	update_minimap_icon()
	GLOB.hive_datums[hivenumber].xeno_message("Our [name] at [AREACOORD_NO_Z(src)] is under attack! It has [obj_integrity]/[max_integrity] Health remaining.", "xenoannounce", 5, FALSE, src, 'sound/voice/alien/help1.ogg',FALSE, null, /atom/movable/screen/arrow/silo_damaged_arrow)
	COOLDOWN_START(src, damage_alert_cooldown, XENO_STRUCTURE_HEALTH_ALERT_COOLDOWN)
	addtimer(CALLBACK(src, PROC_REF(clear_warning)), XENO_STRUCTURE_HEALTH_ALERT_COOLDOWN)

///Clears any threat warnings
/obj/structure/xeno/proc/clear_warning()
	threat_warning = FALSE
	update_minimap_icon()
	update_appearance(UPDATE_ICON)

///resets minimap icon for structure
/obj/structure/xeno/proc/update_minimap_icon()
	return
