/obj/structure/surface/table/get_explosion_resistance(direction)
	if(flags_atom & ON_BORDER)
		if(direction == turn(dir, 90) || direction == turn(dir, -90))
			return 0
		else
			return min(obj_integrity, 40)
	return 0
