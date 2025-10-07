/obj/structure/mineral_door/resin
	name = RESIN_DOOR
	icon = 'icons/obj/smooth_objects/resin-door.dmi'
	icon_state = "resin-door-1"
	base_icon_state = "resin-door"
	resistance_flags = NONE
	layer = BELOW_OBJ_LAYER
	max_integrity = 100
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_XENO_STRUCTURES)
	canSmoothWith = list(
		SMOOTH_GROUP_XENO_STRUCTURES,
		SMOOTH_GROUP_SURVIVAL_TITANIUM_WALLS,
		SMOOTH_GROUP_MINERAL_STRUCTURES,
	)
	soft_armor = list(MELEE = 33, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 65, BIO = 0, FIRE = 0, ACID = 0)
	trigger_sound = SFX_ALIEN_RESIN_MOVE
	hit_sound = SFX_ALIEN_RESIN_MOVE
	destroy_sound = SFX_ALIEN_RESIN_MOVE
	///The delay before the door closes automatically after being open
	var/close_delay = 10 SECONDS
	///The timer that tracks the delay above
	var/closetimer

/obj/structure/mineral_door/resin/get_explosion_resistance()
	return density ? obj_integrity : 0

/obj/structure/mineral_door/resin/smooth_icon()
	. = ..()
	update_icon()

/obj/structure/mineral_door/resin/Initialize(mapload)
	. = ..()
	if(!locate(/obj/alien/weeds) in loc)
		new /obj/alien/weeds(loc)

/obj/structure/mineral_door/resin/Cross(atom/movable/mover, turf/target)
	. = ..()
	if(!. && isxeno(mover) && !open)
		toggle_state()
		return TRUE

/obj/structure/mineral_door/resin/attack_larva(mob/living/carbon/xenomorph/larva/M)
	var/turf/cur_loc = M.loc
	if(!istype(cur_loc))
		return FALSE
	try_toggle_state(M)
	return TRUE

/obj/structure/mineral_door/resin/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	var/turf/cur_loc = xeno_attacker.loc
	if(!istype(cur_loc))
		return FALSE
	if(xeno_attacker.a_intent != INTENT_HARM)
		try_toggle_state(xeno_attacker)
		return TRUE
	if(CHECK_BITFIELD(SSticker.mode?.round_type_flags, MODE_ALLOW_XENO_QUICKBUILD) && SSresinshaping.should_refund(src, xeno_attacker))
		SSresinshaping.decrement_build_counter(xeno_attacker)
		qdel(src)
		return TRUE

	src.balloon_alert(xeno_attacker, "Destroying...")
	playsound(src, SFX_ALIEN_RESIN_BREAK, 25)
	if(do_after(xeno_attacker, 1 SECONDS, IGNORE_HELD_ITEM, src, BUSY_ICON_HOSTILE))
		src.balloon_alert(xeno_attacker, "Destroyed")
		qdel(src)

/obj/structure/mineral_door/resin/fire_act(burn_level, flame_color)
	take_damage(burn_level * 2, BURN, FIRE)

/obj/structure/mineral_door/resin/try_toggle_state(atom/user)
	if(!isxeno(user))
		return
	return ..()

/obj/structure/mineral_door/resin/toggle_state()
	. = ..()
	if(open)
		closetimer = addtimer(CALLBACK(src, PROC_REF(do_close)), close_delay, TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_STOPPABLE)
	else
		deltimer(closetimer)
		closetimer = null

/// Toggle(close) the door. Used for the timer's callback.
/obj/structure/mineral_door/resin/proc/do_close()
	if(locate(/mob/living) in loc) //there is a mob in the door, abort and reschedule the close
		closetimer = addtimer(CALLBACK(src, PROC_REF(do_close)), close_delay, TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_STOPPABLE)
		return
	if(!open) //we got closed in the meantime
		return
	flick("[icon_state]-closing", src)
	toggle_state()

/obj/structure/mineral_door/resin/Destroy()
	var/turf/T
	for(var/i in GLOB.cardinals)
		T = get_step(loc, i)
		if(!istype(T))
			continue
		for(var/obj/structure/mineral_door/resin/R in T)
			INVOKE_NEXT_TICK(R, PROC_REF(check_resin_support))
	return ..()

//do we still have something next to us to support us?
/obj/structure/mineral_door/resin/proc/check_resin_support()
	var/turf/T
	for(var/i in GLOB.cardinals)
		T = get_step(src, i)
		if(T.density)
			. = TRUE
			break
		if(locate(/obj/structure/mineral_door/resin) in T)
			. = TRUE
			break
	if(!.)
		src.balloon_alert_to_viewers("Collapsed")
		qdel(src)

/obj/structure/mineral_door/resin/thick
	max_integrity = 160
