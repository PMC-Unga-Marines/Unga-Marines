/turf/closed/wall/resin
	icon = 'modular_RUtgmc/icons/obj/smooth_objects/resin-wall.dmi'

/turf/closed/wall/resin/is_weedable()
	return TRUE

/turf/closed/wall/resin/ex_act(severity)
	take_damage(severity * RESIN_EXPLOSIVE_MULTIPLIER, BRUTE, BOMB)

/turf/closed/wall/resin/attack_alien(mob/living/carbon/xenomorph/X, damage_amount = X.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = "", effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(X.status_flags & INCORPOREAL)
		return
	if(X.a_intent != INTENT_DISARM)
		return
	if(CHECK_BITFIELD(SSticker.mode?.flags_round_type, MODE_ALLOW_XENO_QUICKBUILD) && SSresinshaping.should_refund(src, X))
		SSresinshaping.decrement_build_counter(X)
		take_damage(max_integrity)
		return
	X.visible_message(span_xenonotice("\The [X] starts tearing down \the [src]!"), \
	span_xenonotice("We start to tear down \the [src]."))
	if(!do_after(X, 1 SECONDS, NONE, X, BUSY_ICON_GENERIC))
		return
	if(!istype(src))
		return
	X.do_attack_animation(src, ATTACK_EFFECT_CLAW)
	X.visible_message(span_xenonotice("\The [X] tears down \the [src]!"), \
	span_xenonotice("We tear down \the [src]."))
	playsound(src, "alien_resin_break", 25)
	take_damage(max_integrity)
