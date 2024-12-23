///Returns remaining immobilize duration
/mob/living/proc/AmountImmobilized()
	var/datum/status_effect/incapacitating/immobilized/current_immobilized = has_status_effect(STATUS_EFFECT_IMMOBILIZED)
	return current_immobilized ? current_immobilized.duration - world.time : 0

///Applies immobilize only if not currently applied
/mob/living/proc/ImmobilizeNoChain(amount, ignore_canstun = FALSE)
	if(status_flags & GODMODE)
		return
	if(has_status_effect(STATUS_EFFECT_IMMOBILIZED))
		return 0
	return Immobilize(amount, ignore_canstun)

///Applies immobilize from current world time unless existing duration is higher
/mob/living/proc/Immobilize(amount, ignore_canstun = FALSE)
	if(status_flags & GODMODE)
		return
	if((!(status_flags & CANKNOCKDOWN) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)) && !ignore_canstun)
		return
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_IMMOBILIZE, amount, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(absorb_stun(amount, ignore_canstun))
		return

	var/datum/status_effect/incapacitating/immobilized/current_immobilized = has_status_effect(STATUS_EFFECT_IMMOBILIZED)
	if(current_immobilized)
		current_immobilized.duration = max(world.time + amount, current_immobilized.duration)
	else if(amount > 0)
		current_immobilized = apply_status_effect(STATUS_EFFECT_IMMOBILIZED, amount)

	return current_immobilized

///Used to set immobilize to a set amount, commonly to remove it
/mob/living/proc/SetImmobilized(amount, ignore_canstun = FALSE)
	var/datum/status_effect/incapacitating/immobilized/current_immobilized = has_status_effect(STATUS_EFFECT_IMMOBILIZED)
	if(amount <= 0)
		if(current_immobilized)
			qdel(current_immobilized)
		return
	if(status_flags & GODMODE)
		return
	if((!(status_flags & CANKNOCKDOWN) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)) && !ignore_canstun)
		return
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_IMMOBILIZE, amount, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(absorb_stun(amount, ignore_canstun))
		return

	if(current_immobilized)
		current_immobilized.duration = world.time + amount
	else
		current_immobilized = apply_status_effect(STATUS_EFFECT_IMMOBILIZED, amount)

	return current_immobilized

///Applies immobilized or adds to existing duration
/mob/living/proc/AdjustImmobilized(amount, ignore_canstun = FALSE)
	if(status_flags & GODMODE)
		return
	if((!(status_flags & CANKNOCKDOWN) || HAS_TRAIT(src, TRAIT_STUNIMMUNE)) && !ignore_canstun)
		return
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_IMMOBILIZE, amount, ignore_canstun) & COMPONENT_NO_STUN)
		return
	if(absorb_stun(amount, ignore_canstun))
		return

	var/datum/status_effect/incapacitating/immobilized/current_immobilized = has_status_effect(STATUS_EFFECT_IMMOBILIZED)
	if(current_immobilized)
		current_immobilized.duration += amount
	else if(amount > 0)
		current_immobilized = apply_status_effect(STATUS_EFFECT_IMMOBILIZED, amount)

	return current_immobilized
