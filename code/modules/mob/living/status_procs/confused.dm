///Returns if confused
/mob/living/proc/IsConfused()
	return has_status_effect(STATUS_EFFECT_CONFUSED)

///Returns remaining confused duration
/mob/living/proc/AmountConfused()
	var/datum/status_effect/incapacitating/confused/current_confused = IsConfused()
	return current_confused ? current_confused.duration - world.time : 0

///Applies confused from current world time unless existing duration is higher
/mob/living/proc/Confused(amount, ignore_canstun = FALSE)
	if(status_flags & GODMODE)
		return
	if((!(status_flags & CANCONFUSE) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)) && !ignore_canstun)
		return
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_CONFUSED, amount, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(absorb_stun(amount, ignore_canstun))
		return

	var/datum/status_effect/incapacitating/confused/current_confused = IsConfused()
	if(current_confused)
		current_confused.duration = max(world.time + amount, current_confused.duration)
	else if(amount > 0)
		current_confused = apply_status_effect(STATUS_EFFECT_CONFUSED, amount)

	return current_confused

///Used to set confused to a set amount, commonly to remove it
/mob/living/proc/SetConfused(amount, ignore_canstun = FALSE)
	var/datum/status_effect/incapacitating/confused/current_confused = IsConfused()
	if(amount <= 0)
		if(current_confused)
			qdel(current_confused)
		return
	if(status_flags & GODMODE)
		return
	if((!(status_flags & CANCONFUSE) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)) && !ignore_canstun)
		return
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_CONFUSED, amount, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(absorb_stun(amount, ignore_canstun))
		return

	if(current_confused)
		current_confused.duration = world.time + amount
	else
		current_confused = apply_status_effect(STATUS_EFFECT_CONFUSED, amount)

	return current_confused

///Applies confused or adds to existing duration
/mob/living/proc/AdjustConfused(amount, ignore_canstun = FALSE)
	if(status_flags & GODMODE)
		return
	if((!(status_flags & CANCONFUSE) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)) && !ignore_canstun)
		return
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_CONFUSED, amount, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(absorb_stun(amount, ignore_canstun))
		return

	var/datum/status_effect/incapacitating/confused/current_confused = IsConfused()
	if(current_confused)
		current_confused.duration += amount
	else if(amount > 0)
		current_confused = apply_status_effect(STATUS_EFFECT_CONFUSED, amount)

	return current_confused
