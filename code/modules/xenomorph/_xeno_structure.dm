/obj/structure/xeno
	hit_sound = "alien_resin_break"
	layer = RESIN_STRUCTURE_LAYER
	resistance_flags = UNACIDABLE
	///Bitflags specific to xeno structures
	var/xeno_structure_flags
	///Which hive(number) do we belong to?
	var/hivenumber = XENO_HIVE_NORMAL

/obj/structure/xeno/Initialize(mapload, _hivenumber)
	. = ..()
	if(!(xeno_structure_flags & IGNORE_WEED_REMOVAL))
		RegisterSignal(loc, COMSIG_TURF_WEED_REMOVED, PROC_REF(weed_removed))
	if(_hivenumber) ///because admins can spawn them
		hivenumber = _hivenumber
	LAZYADDASSOC(GLOB.xeno_structures_by_hive, hivenumber, src)
	if(xeno_structure_flags & CRITICAL_STRUCTURE)
		LAZYADDASSOC(GLOB.xeno_critical_structures_by_hive, hivenumber, src)

/obj/structure/xeno/Destroy()
	if(!locate(src) in GLOB.xeno_structures_by_hive[hivenumber]+GLOB.xeno_critical_structures_by_hive[hivenumber]) //The rest of the proc is pointless to look through if its not in the lists
		stack_trace("[src] not found in the list of (potentially critical) xeno structures!") //We dont want to CRASH because that'd block deletion completely. Just trace it and continue.
		return ..()
	GLOB.xeno_structures_by_hive[hivenumber] -= src
	if(xeno_structure_flags & CRITICAL_STRUCTURE)
		GLOB.xeno_critical_structures_by_hive[hivenumber] -= src
	return ..()

/obj/structure/xeno/ex_act(severity)
	take_damage(severity * 0.8, BRUTE, BOMB)

/obj/structure/xeno/attack_hand(mob/living/user)
	balloon_alert(user, "You only scrape at it")
	return TRUE

/obj/structure/xeno/flamer_fire_act(burnlevel)
	take_damage(burnlevel / 3, BURN, FIRE)

/obj/structure/xeno/fire_act()
	take_damage(10, BURN, FIRE)

/// Destroy the xeno structure when the weed it was on is destroyed
/obj/structure/xeno/proc/weed_removed()
	SIGNAL_HANDLER
	var/obj/alien/weeds/found_weed = locate(/obj/alien/weeds) in loc
	if(found_weed.obj_integrity <= 0)
		obj_destruction(damage_flag = MELEE)
	else
		obj_destruction()

/obj/structure/xeno/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount, damage_type, damage_flag, effects, armor_penetration, isrightclick)
	if(!(HAS_TRAIT(xeno_attacker, TRAIT_VALHALLA_XENO) && xeno_attacker.a_intent == INTENT_HARM && (tgui_alert(xeno_attacker, "Are you sure you want to tear down [src]?", "Tear down [src]?", list("Yes","No"))) == "Yes"))
		return ..()
	if(!do_after(xeno_attacker, 3 SECONDS, NONE, src))
		return
	xeno_attacker.do_attack_animation(src, ATTACK_EFFECT_CLAW)
	balloon_alert_to_viewers("\The [xeno_attacker] tears down \the [src]!", "We tear down \the [src].")
	playsound(src, "alien_resin_break", 25)
	take_damage(max_integrity) // Ensure its destroyed
