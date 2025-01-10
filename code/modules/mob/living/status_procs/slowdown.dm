///Returns number of slowdown stacks if any
/mob/living/proc/IsSlowed() //If we're slowed
	return slowdown

///Where the magic happens. Actually applies slow stacks.
/mob/living/proc/set_slowdown(amount)
	if(slowdown == amount)
		return
	if(amount > 0 && HAS_TRAIT(src, TRAIT_SLOWDOWNIMMUNE)) //We're immune to slowdown
		return
	SEND_SIGNAL(src, COMSIG_LIVING_STATUS_SLOWDOWN, amount)
	slowdown = amount
	if(slowdown)
		add_movespeed_modifier(MOVESPEED_ID_STAGGERSTUN, TRUE, 0, NONE, TRUE, slowdown)
		return
	remove_movespeed_modifier(MOVESPEED_ID_STAGGERSTUN)

///This is where we normalize the set_slowdown input to be at least 0
/mob/living/proc/adjust_slowdown(amount)
	if(amount > 0)
		if(HAS_TRAIT(src, TRAIT_SLOWDOWNIMMUNE))
			return slowdown
		set_slowdown(max(slowdown, amount)) //Slowdown overlaps rather than stacking.
	else
		set_slowdown(max(slowdown + amount, 0))
	return slowdown

/mob/living/proc/add_slowdown(amount, capped = 0)
	if(HAS_TRAIT(src, TRAIT_SLOWDOWNIMMUNE))
		return
	adjust_slowdown(amount * STANDARD_SLOWDOWN_REGEN)

///Standard slowdown regen called by life.dm
/mob/living/proc/handle_slowdown()
	if(slowdown)
		adjust_slowdown(-STANDARD_SLOWDOWN_REGEN)
	return slowdown

/mob/living/carbon/xenomorph/add_slowdown(amount)
	if(HAS_TRAIT(src, TRAIT_SLOWDOWNIMMUNE) || is_charging >= CHARGE_ON)
		return
	adjust_slowdown(amount * XENO_SLOWDOWN_REGEN)
