#define CHARGE_SPEED(charger) (min(charger.valid_steps_taken, charger.max_steps_buildup) * charger.speed_per_step)
#define CHARGE_MAX_SPEED (speed_per_step * max_steps_buildup)

#define STOP_CRUSHER_ON_DEL (1<<0)

#define PRECRUSH_STOPPED -1
#define PRECRUSH_PLOWED -2
#define PRECRUSH_ENTANGLED -3

/turf/closed/wall/pre_crush_act(mob/living/carbon/xenomorph/charger, datum/action/ability/xeno_action/ready_charge/charge_datum)
	if((resistance_flags & (INDESTRUCTIBLE|CRUSHER_IMMUNE)) || charger.is_charging < CHARGE_ON)
		charge_datum.do_stop_momentum()
		return PRECRUSH_STOPPED
	. = (CHARGE_SPEED(charge_datum) * 400)
	charge_datum.speed_down(1)

// Charge is divided into two acts: before and after the crushed thing taking damage, as that can cause it to be deleted.
/datum/action/ability/xeno_action/ready_charge/proc/do_crush(datum/source, atom/crushed)
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/charger = owner
	if(charger.incapacitated() || charger.now_pushing)
		return NONE

	if(charge_type & (CHARGE_BULL|CHARGE_BULL_HEADBUTT|CHARGE_BULL_GORE|CHARGE_BEHEMOTH) && !isliving(crushed))
		do_stop_momentum()
		return COMPONENT_MOVABLE_PREBUMP_STOPPED

	var/precrush = crushed.pre_crush_act(charger, src) //Negative values are codes. Positive ones are damage to deal.
	switch(precrush)
		if(null)
			CRASH("[crushed] returned null from do_crush()")
		if(PRECRUSH_STOPPED)
			return COMPONENT_MOVABLE_PREBUMP_STOPPED //Already handled, no need to continue.
		if(PRECRUSH_PLOWED)
			return COMPONENT_MOVABLE_PREBUMP_PLOWED
		if(PRECRUSH_ENTANGLED)
			. = COMPONENT_MOVABLE_PREBUMP_ENTANGLED

	var/preserved_name = crushed.name

	if(isliving(crushed))
		var/mob/living/crushed_living = crushed
		playsound(crushed_living.loc, crush_sound, 25, 1)
		if(crushed_living.buckled)
			crushed_living.buckled.unbuckle_mob(crushed_living)
		animation_flash_color(crushed_living)

		if(precrush > 0)
			log_combat(charger, crushed_living, "xeno charged")
			//There is a chance to do enough damage here to gib certain mobs. Better update immediately.
			crushed_living.apply_damage(precrush, BRUTE, BODY_ZONE_CHEST, MELEE, updating_health = TRUE)
			if(QDELETED(crushed_living))
				charger.visible_message(span_danger("[charger] anihilates [preserved_name]!"),
				span_xenodanger("We anihilate [preserved_name]!"))
				return COMPONENT_MOVABLE_PREBUMP_PLOWED

		return precrush2signal(crushed_living.post_crush_act(charger, src))

	if(isobj(crushed))
		var/obj/crushed_obj = crushed
		if(istype(crushed_obj, /obj/structure/xeno/silo) || istype(crushed_obj, /obj/structure/xeno/xeno_turret))
			return precrush2signal(crushed_obj.post_crush_act(charger, src))
		playsound(crushed_obj.loc, "punch", 25, 1)
		var/crushed_behavior = crushed_obj.crushed_special_behavior()
		crushed_obj.take_damage(precrush, BRUTE, MELEE)
		if(QDELETED(crushed_obj))
			charger.visible_message(span_danger("[charger] crushes [preserved_name]!"),
			span_xenodanger("We crush [preserved_name]!"))
			if(crushed_behavior & STOP_CRUSHER_ON_DEL)
				return COMPONENT_MOVABLE_PREBUMP_STOPPED
			else
				return COMPONENT_MOVABLE_PREBUMP_PLOWED

		return precrush2signal(crushed_obj.post_crush_act(charger, src))

	if(isturf(crushed))
		var/turf/crushed_turf = crushed
		if(iswallturf(crushed_turf))
			var/turf/closed/wall/crushed_wall = crushed_turf
			crushed_wall.take_damage(precrush, BRUTE, MELEE)
		else
			crushed_turf.ex_act(precrush * rand(50, 100))
		if(QDELETED(crushed_turf))
			charger.visible_message(span_danger("[charger] plows straight through [preserved_name]!"),
			span_xenowarning("We plow straight through [preserved_name]!"))
			return COMPONENT_MOVABLE_PREBUMP_PLOWED

		charger.visible_message(span_danger("[charger] rams into [crushed_turf] and skids to a halt!"),
		span_xenowarning("We ram into [crushed_turf] and skid to a halt!"))
		do_stop_momentum(FALSE)
		return COMPONENT_MOVABLE_PREBUMP_STOPPED

#undef CHARGE_SPEED
#undef CHARGE_MAX_SPEED

#undef STOP_CRUSHER_ON_DEL

#undef PRECRUSH_STOPPED
#undef PRECRUSH_PLOWED
#undef PRECRUSH_ENTANGLED
