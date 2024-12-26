/mob/living/proc/adjust_bodytemperature(amount, min_temp = 0, max_temp = INFINITY)
	if(bodytemperature < min_temp || bodytemperature > max_temp)
		return
	. = bodytemperature
	bodytemperature = clamp(bodytemperature + amount, min_temp, max_temp)

/mob/living/carbon/human/adjust_bodytemperature(amount, min_temp = 0, max_temp = INFINITY)
	. = ..()
	adjust_bodytemperature_speed_mod(.)

/mob/living/carbon/human/proc/adjust_bodytemperature_speed_mod(old_temperature)
	if(bodytemperature < species.cold_level_1)
		if(old_temperature < species.cold_level_1)
			return
		add_movespeed_modifier(MOVESPEED_ID_COLD, TRUE, 0, NONE, TRUE, 2)
	else if(old_temperature < species.cold_level_1)
		remove_movespeed_modifier(MOVESPEED_ID_COLD)
