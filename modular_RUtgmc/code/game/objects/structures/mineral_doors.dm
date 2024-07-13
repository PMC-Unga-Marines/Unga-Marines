/obj/structure/mineral_door/get_explosion_resistance()
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return EXPLOSION_MAX_POWER
	return density ? obj_integrity : 0
