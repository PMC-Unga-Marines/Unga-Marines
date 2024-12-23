///How many deciseconds remain in our irradiated status effect
/mob/living/proc/amount_irradiated()
	var/datum/status_effect/incapacitating/irradiated/irradiated = has_status_effect(STATUS_EFFECT_IRRADIATED)
	if(irradiated)
		return irradiated.duration - world.time
	return 0

///Applies irradiation from a source
/mob/living/proc/irradiate(amount, ignore_canstun = FALSE) //Can't go below remaining duration
	if(status_flags & GODMODE)
		return
	var/datum/status_effect/incapacitating/irradiated/irradiated = has_status_effect(STATUS_EFFECT_IRRADIATED)
	if(irradiated)
		irradiated.duration = max(world.time + amount, irradiated.duration)
	else if(amount > 0)
		irradiated = apply_status_effect(STATUS_EFFECT_IRRADIATED, amount)
	return irradiated

///Sets irradiation  duration
/mob/living/proc/set_radiation(amount, ignore_canstun = FALSE)
	if(status_flags & GODMODE)
		return
	var/datum/status_effect/incapacitating/irradiated/irradiated = has_status_effect(STATUS_EFFECT_IRRADIATED)
	if(amount <= 0)
		if(irradiated)
			qdel(irradiated)
	else
		if(irradiated)
			irradiated.duration = world.time + amount
		else
			irradiated = apply_status_effect(STATUS_EFFECT_IRRADIATED, amount)
	return irradiated

///Modifies irradiation duration
/mob/living/proc/adjust_radiation(amount, ignore_canstun = FALSE)
	if(status_flags & GODMODE)
		return
	var/datum/status_effect/incapacitating/irradiated/irradiated = has_status_effect(STATUS_EFFECT_IRRADIATED)
	if(irradiated)
		irradiated.duration += amount
	else if(amount > 0)
		irradiated = apply_status_effect(STATUS_EFFECT_IRRADIATED, amount)
	return irradiated
