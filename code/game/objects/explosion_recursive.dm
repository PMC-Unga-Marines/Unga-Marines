/atom/proc/get_explosion_resistance()
	return 0

/mob/living/get_explosion_resistance()
	if(!density)
		return 0
	switch(mob_size)
		if(MOB_SIZE_SMALL)
			return 0
		if(MOB_SIZE_HUMAN)
			return 25
		if(MOB_SIZE_XENO)
			return 30
		if(MOB_SIZE_BIG)
			return 50
		else
			return 0

/obj/proc/explosion_throw(severity, direction, scatter_multiplier = 1)
	if(anchored || !isturf(loc))
		return

	if(!direction)
		direction = pick(GLOB.alldirs)
	var/range = min(round(severity * 0.07, 1), 14)
	if(!direction)
		range = round(range * 0.5, 1)

	if(range < 1)
		return

	var/speed = max(range, 3)
	var/atom/target = get_ranged_target_turf(src, direction, range)

	if(range >= 2)
		var/scatter = range * 0.25 * scatter_multiplier
		var/scatter_x = rand(-scatter, scatter)
		var/scatter_y = rand(-scatter, scatter)
		target = locate(target.x + round(scatter_x, 1), target.y + round(scatter_y, 1), target.z) //Locate an adjacent turf.

	//time for the explosion to destroy windows, walls, etc which might be in the way
	INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, throw_at), target, range, speed, null, TRUE, targetted_throw = FALSE)

/mob/proc/explosion_throw(severity, direction)
	if(severity <= 0)
		return
	if(anchored || !isturf(loc))
		return

	var/weight = 1
	switch(mob_size)
		if(MOB_SIZE_SMALL)
			weight = 4
		if(MOB_SIZE_HUMAN)
			weight = 1
		if(MOB_SIZE_XENO)
			weight = 0.66
		if(MOB_SIZE_BIG)
			weight = 0.25
	var/range = round(severity * weight * 0.02, 1)
	if(!direction)
		range = round(range * 0.66, 1)
		direction = pick(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)

	if(range <= 0)
		return

	var/speed = max(range * 1.5, 4)
	var/atom/target = get_ranged_target_turf(src, direction, range)
	var/spin = FALSE

	if(range > 1)
		spin = TRUE
	if(range >= 2)
		var/scatter = range * 0.25
		var/scatter_x = rand(-scatter, scatter)
		var/scatter_y = rand(-scatter, scatter)
		target = locate(target.x + round(scatter_x, 1),target.y + round(scatter_y, 1), target.z) //Locate an adjacent turf.

	//time for the explosion to destroy windows, walls, etc which might be in the way
	INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, throw_at), target, range, speed, null, spin, targetted_throw = FALSE)
