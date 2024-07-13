/obj/structure/cable/ex_act(severity, direction)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return

	if(prob(severity / 3))
		qdel(src)
	else
		take_damage(severity, BRUTE, BOMB)
