/obj/machinery/disposal
	resistance_flags = XENO_DAMAGEABLE
	max_integrity = 150

/obj/machinery/disposal/ex_act(severity)
	if(prob(severity / 4))
		qdel(src)

/obj/structure/disposalpipe/ex_act(severity)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return
	take_damage(severity / 15, BRUTE, BOMB)
