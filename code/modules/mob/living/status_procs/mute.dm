///Checks the duration left on our mute status effect
/mob/living/proc/AmountMute()
	var/datum/status_effect/mute/M = has_status_effect(STATUS_EFFECT_MUTED)
	if(M)
		return M.duration - world.time
	return 0

///Mutes the target for the stated duration
/mob/living/proc/Mute(amount) //Can't go below remaining duration
	if(status_flags & GODMODE)
		return
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_MUTE, amount) & COMPONENT_NO_MUTE)
		return
	var/datum/status_effect/mute/M = has_status_effect(STATUS_EFFECT_MUTED)
	if(M)
		M.duration = max(world.time + amount, M.duration)
	else if(amount > 0)
		M = apply_status_effect(STATUS_EFFECT_MUTED, amount)
	return M

//Sets remaining mute duration
/mob/living/proc/SetMute(amount)
	if(status_flags & GODMODE)
		return
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_MUTE, amount) & COMPONENT_NO_MUTE)
		return
	var/datum/status_effect/mute/M = has_status_effect(STATUS_EFFECT_MUTED)

	if(M)
		if(amount <= 0)
			qdel(M)
			return

		M.duration = world.time + amount
		return

	M = apply_status_effect(STATUS_EFFECT_MUTED, amount)
	return M

///Adds to remaining mute duration
/mob/living/proc/AdjustMute(amount)
	if(!amount)
		return
	if(status_flags & GODMODE)
		return
	if(SEND_SIGNAL(src, COMSIG_LIVING_STATUS_MUTE, amount) & COMPONENT_NO_MUTE)
		return

	var/datum/status_effect/mute/M = has_status_effect(STATUS_EFFECT_MUTED)
	if(M)
		M.duration += amount
	else if(amount > 0)
		M = apply_status_effect(STATUS_EFFECT_MUTED, amount)
	return M
