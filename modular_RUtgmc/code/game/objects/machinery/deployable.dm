/obj/machinery/deployable/ex_act(severity)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return FALSE
	take_damage(severity, damage_flag = BOMB, effects = TRUE)
