/obj/machinery/computer/ex_act(severity)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return FALSE
	if(severity >= EXPLODE_MEDIUM && prob(severity / 3))
		qdel(src)
		return
	if(prob(severity / 3))
		for(var/x in verbs)
			verbs -= x
		set_broken()
