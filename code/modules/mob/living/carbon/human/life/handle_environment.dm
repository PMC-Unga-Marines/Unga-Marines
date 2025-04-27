//Refer to life.dm for caller
/mob/living/carbon/human/proc/handle_environment()
	if(!loc)
		return

	//+/- 50 degrees from 310.15K is the 'safe' zone, where no damage is dealt.
	if(bodytemperature > species.heat_level_1)
		//Body temperature is too hot.
		var/heat_severity
		if(bodytemperature > species.heat_level_1)
			heat_severity = 1
		if(bodytemperature > species.heat_level_2)
			heat_severity = 2
		if(bodytemperature > species.heat_level_3)
			heat_severity = 3
		throw_alert(ALERT_TEMPERATURE, /atom/movable/screen/alert/hot, heat_severity)
		if(status_flags & GODMODE)
			return 1 //Godmode

		if(bodytemperature > species.heat_level_3)
			take_overall_damage(HEAT_DAMAGE_LEVEL_3, BURN)
		else if(bodytemperature > species.heat_level_2)
			take_overall_damage(HEAT_DAMAGE_LEVEL_2, BURN)
		else if(bodytemperature > species.heat_level_1)
			take_overall_damage(HEAT_DAMAGE_LEVEL_1, BURN)
	else if(bodytemperature < species.cold_level_1)
		//Body temperature is too cold.
		var/cold_severity
		if(bodytemperature < species.cold_level_1)
			cold_severity = 1
		if(bodytemperature < species.cold_level_2)
			cold_severity = 2
		if(bodytemperature < species.cold_level_3)
			cold_severity = 3
		throw_alert(ALERT_TEMPERATURE, /atom/movable/screen/alert/cold, cold_severity)

		if(status_flags & GODMODE)
			return 1 //Godmode

		if(!istype(loc, /obj/machinery/atmospherics/components/unary/cryo_cell))

			if(bodytemperature < species.cold_level_3)
				take_overall_damage(COLD_DAMAGE_LEVEL_3, BURN)
			else if(bodytemperature < species.cold_level_2)
				take_overall_damage(COLD_DAMAGE_LEVEL_2, BURN)
			else if(bodytemperature < species.cold_level_1)
				take_overall_damage(COLD_DAMAGE_LEVEL_1, BURN)
