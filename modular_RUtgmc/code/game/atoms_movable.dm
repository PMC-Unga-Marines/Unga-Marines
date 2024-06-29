///Bounces the AM off hit_atom
/atom/movable/throw_bounce(atom/hit_atom, turf/old_throw_source)
	if(QDELETED(src))
		return
	if(!isturf(loc))
		return
	var/dir_to_proj = get_dir(hit_atom, old_throw_source)
	if(ISDIAGONALDIR(dir_to_proj))
		var/list/cardinals = list(turn(dir_to_proj, 45), turn(dir_to_proj, -45))
		for(var/direction in cardinals)
			var/turf/turf_to_check = get_step(hit_atom, direction)
			if(turf_to_check.density)
				cardinals -= direction
		dir_to_proj = pick(cardinals)

	var/perpendicular_angle = 0
	if(dir_to_proj != 0)
		perpendicular_angle = Get_Angle(hit_atom, get_step(hit_atom, dir_to_proj))
	var/new_angle = (perpendicular_angle + (perpendicular_angle - Get_Angle(old_throw_source, src) - 180) + rand(-10, 10))

	if(new_angle < -360)
		new_angle += 720 //north is 0 instead of 360
	else if(new_angle < 0)
		new_angle += 360
	else if(new_angle > 360)
		new_angle -= 360

	step(src, angle_to_dir(new_angle))
