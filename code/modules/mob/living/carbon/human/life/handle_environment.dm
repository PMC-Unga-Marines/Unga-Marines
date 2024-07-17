//Refer to life.dm for caller
/mob/living/carbon/human/proc/handle_environment()
	if(!loc)
		return

	//+/- 50 degrees from 310.15K is the 'safe' zone, where no damage is dealt.
	if(bodytemperature > species.heat_level_1)
		//Body temperature is too hot.
		fire_alert = max(fire_alert, 2)
		if(status_flags & GODMODE)
			return 1 //Godmode

		if(bodytemperature > species.heat_level_3)
			take_overall_damage(HEAT_DAMAGE_LEVEL_3, BURN)
		else if(bodytemperature > species.heat_level_2)
			take_overall_damage(HEAT_DAMAGE_LEVEL_2, BURN)
		else if(bodytemperature > species.heat_level_1)
			take_overall_damage(HEAT_DAMAGE_LEVEL_1, BURN)

	else if(bodytemperature < species.cold_level_1)
		fire_alert = max(fire_alert, 1)

		if(status_flags & GODMODE)
			return 1 //Godmode

		if(!istype(loc, /obj/machinery/atmospherics/components/unary/cryo_cell))

			if(bodytemperature < species.cold_level_3)
				take_overall_damage(COLD_DAMAGE_LEVEL_3, BURN)
			else if(bodytemperature < species.cold_level_2)
				take_overall_damage(COLD_DAMAGE_LEVEL_2, BURN)
			else if(bodytemperature < species.cold_level_1)
				take_overall_damage(COLD_DAMAGE_LEVEL_1, BURN)
