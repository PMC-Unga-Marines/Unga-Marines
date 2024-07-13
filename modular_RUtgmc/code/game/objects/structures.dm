/obj/structure/ex_act(severity, direction)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return
	take_damage(severity, BRUTE, BOMB, attack_dir = direction)
