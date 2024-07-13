/obj/machinery/ex_act(severity)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return FALSE
	if(prob(severity / 3))
		deconstruct(FALSE)
