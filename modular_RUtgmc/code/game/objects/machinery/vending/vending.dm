/obj/machinery/vending/ex_act(severity)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return FALSE

	switch(severity)
		if(0 to EXPLODE_LIGHT)
			if(prob(25))
				tip_over()
		if(EXPLODE_LIGHT to EXPLODE_HEAVY)
			if(prob(50))
				tip_over()
				malfunction()
		if(EXPLODE_HEAVY to INFINITY)
			qdel(src)
