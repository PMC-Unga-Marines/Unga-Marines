/turf/closed/wall/ex_act(severity, explosion_direction)
	if(resistance_flags & INDESTRUCTIBLE)
		return

	var/location = get_step(get_turf(src), explosion_direction) // shrapnel will just collide with the wall otherwise
	if(wall_integrity + severity > max_integrity * 2)
		dismantle_wall(FALSE, TRUE)
		create_shrapnel(location, rand(2, 5), explosion_direction, shrapnel_type = /datum/ammo/bullet/shrapnel/light)
	else
		if(prob(25))
			create_shrapnel(location, rand(2, 5), explosion_direction, shrapnel_type = /datum/ammo/bullet/shrapnel/spall)
			if(prob(50)) // prevents spam in close corridors etc
				src.visible_message(span_warning("The explosion causes shards to spall off of [src]!"))
		take_damage(severity * EXPLOSION_DAMAGE_MULTIPLIER_WALL, BRUTE, BOMB)

/turf/closed/wall/get_explosion_resistance()
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return EXPLOSION_MAX_POWER
	return (max_integrity - (max_integrity - wall_integrity)) / EXPLOSION_DAMAGE_MULTIPLIER_WALL

/turf/closed/wall/plastique_act()
	ex_act(5000)
