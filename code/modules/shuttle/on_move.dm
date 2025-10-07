/// Called on every turf in the shuttle region, returns a bitflag for allowed movements of that turf.
/// Returns the new move_mode (based on the old)
/turf/proc/from_shuttle_move(turf/newT, move_mode)
	if(!(move_mode & MOVE_AREA) || !isshuttleturf(src))
		return move_mode
	return move_mode | MOVE_TURF | MOVE_CONTENTS

/// Called from the new turf before anything has been moved.
/// Only gets called if from_shuttle_move returns true first.
/// Returns the new move_mode (based on the old)
/turf/proc/to_shuttle_move(turf/oldT, move_mode, obj/docking_port/mobile/shuttle)
	. = move_mode
	if(!(. & (MOVE_TURF|MOVE_CONTENTS)))
		return

	for(var/atom/thing AS in contents)
		SEND_SIGNAL(thing, COMSIG_MOVABLE_SHUTTLE_CRUSH, shuttle)
		if(isliving(thing))
			var/mob/living/M = thing
			if(M.status_flags & INCORPOREAL)
				continue // Ghost things don't splat
			if(M.buckled)
				M.buckled.unbuckle_mob(M, TRUE)
			if(M.pulledby)
				M.pulledby.stop_pulling()
			M.stop_pulling()
			M.visible_message(span_warning("[shuttle] slams into [M]!"))
			M.gib()
		if(ismovable(thing))
			var/atom/movable/movable_thing = thing
			if(movable_thing.atom_flags & SHUTTLE_IMMUNE)
				var/old_dir = movable_thing.dir
				movable_thing.abstract_move(src)
				movable_thing.setDir(old_dir)
				movable_thing.invisibility = INVISIBILITY_ABSTRACT
				continue
			qdel(thing)

/turf/closed/to_shuttle_move(turf/oldT, move_mode, obj/docking_port/mobile/shuttle)
	. = move_mode
	if(!(. & (MOVE_TURF|MOVE_CONTENTS))) // copypaste from the parent proc
		return
	// scrape away all the walls we land on, so you can't hide nukes in mineral walls
	scrape_away()

/// Called on the old turf to move the turf data
/turf/proc/on_shuttle_move(turf/newT, list/movement_force, move_dir)
	if(newT == src) // In case of in place shuttle rotation shenanigans.
		return
	//Destination turf changes
	//Baseturfs is definitely a list or this proc wouldnt be called
	var/shuttle_depth = depth_to_find_baseturf(/turf/baseturf_skipover/shuttle)
	if(!shuttle_depth)
		CRASH("A turf queued to move via shuttle somehow had no skipover in baseturfs. [src]([type]):[loc]")
	newT.copy_on_top(src, 1, shuttle_depth, TRUE)
	return TRUE

/// Called on the new turf after everything has been moved
/turf/proc/after_shuttle_move(turf/oldT, rotation)
	//Dealing with the turf we left behind
	oldT.TransferComponents(src)

	var/shuttle_depth = depth_to_find_baseturf(/turf/baseturf_skipover/shuttle)
	if(shuttle_depth)
		oldT.scrape_away(shuttle_depth)

	if(rotation)
		shuttle_rotate(rotation) //see shuttle_rotate.dm

	return TRUE

/turf/proc/late_shuttle_move(turf/oldT)
	return

/// Called on every atom in shuttle turf contents before anything has been moved.
/// Returns the new move_mode (based on the old).
/// WARNING: Do not leave turf contents in before_shuttle_move() or dock() will runtime.
/atom/movable/proc/before_shuttle_move(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	return move_mode

/// Called on atoms to move the atom to the new location
/atom/movable/proc/on_shuttle_move(turf/newT, turf/oldT, list/movement_force, move_dir, obj/docking_port/stationary/old_dock, obj/docking_port/mobile/moving_dock)
	if(newT == oldT) // In case of in place shuttle rotation shenanigans.
		return

	if(loc != oldT) // This is for multi tile objects
		return

	if(atom_flags & SHUTTLE_IMMUNE)
		return

	abstract_move(newT)
	return TRUE

/// Called on atoms after everything has been moved
/atom/movable/proc/after_shuttle_move(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	var/turf/newT = get_turf(src)
	if(newT.z != oldT.z)
		var/same_z_layer = (GET_TURF_PLANE_OFFSET(oldT) == GET_TURF_PLANE_OFFSET(newT))
		on_changed_z_level(oldT, newT, same_z_layer)

	if(light)
		update_light()
	if(rotation)
		shuttle_rotate(rotation)
	return TRUE

/atom/movable/proc/late_shuttle_move(turf/oldT, list/movement_force, move_dir)
	if(!movement_force || anchored)
		return
	var/throw_force = movement_force["THROW"]
	if(!throw_force)
		return
	var/turf/target = get_edge_target_turf(src, move_dir)
	var/range = throw_force * 10
	range = CEILING(randfloat(range-(range * 0.1), range+(range * 0.1)), 10) * 0.1
	var/speed = range / 5
	safe_throw_at(target, range, speed, force = MOVE_FORCE_EXTREMELY_STRONG)

/// Called on areas before anything has been moved, returns the new move_mode (based on the old)
/area/proc/before_shuttle_move(list/shuttle_areas)
	if(!shuttle_areas[src])
		return NONE
	return MOVE_AREA

/// Called on areas to move their turf between areas
/area/proc/on_shuttle_move(turf/oldT, turf/newT, area/underlying_old_area)
	if(newT == oldT) // In case of in place shuttle rotation shenanigans.
		return TRUE

	contents -= oldT
	underlying_old_area.contents += oldT
	oldT.transfer_area_lighting(src, underlying_old_area) //lighting
	//The old turf has now been given back to the area that turf originaly belonged to

	var/area/old_dest_area = newT.loc
	parallax_movedir = old_dest_area.parallax_movedir

	old_dest_area.contents -= newT
	contents += newT
	newT.transfer_area_lighting(old_dest_area, src) //lighting
	return TRUE

/// Called on areas after everything has been moved
/area/proc/after_shuttle_move(new_parallax_dir)
	parallax_movedir = new_parallax_dir
	return TRUE

/area/proc/late_shuttle_move()
	return

/obj/machinery/door/airlock/before_shuttle_move(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	for(var/obj/machinery/door/airlock/A in range(1, src))  // includes src
		A.close()

/obj/machinery/camera/before_shuttle_move(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	if(. & MOVE_AREA)
		. |= MOVE_CONTENTS
		parent_cameranet.removeCamera(src)

/obj/machinery/camera/after_shuttle_move(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	parent_cameranet.addCamera(src)

/obj/machinery/atmospherics/after_shuttle_move(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	if(pipe_vision_img)
		pipe_vision_img.loc = loc
	var/missing_nodes = FALSE
	for(var/i in 1 to device_type)
		if(!nodes[i])
			missing_nodes = TRUE

	if(missing_nodes)
		atmos_init()
		for(var/obj/machinery/atmospherics/A in pipeline_expansion())
			A.atmos_init()
			if(A.return_pipenet())
				A.addMember(src)
		build_network()
	else
		// atmos_init() calls update_icon(), so we don't need to call it
		update_icon()
	covered_by_shuttle = FALSE

/obj/machinery/atmospherics/pipe/after_shuttle_move(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	var/turf/T = loc
	hide(T.intact_tile)

/obj/machinery/power/terminal/after_shuttle_move(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	var/turf/T = loc
	if(level == 1)
		hide(T.intact_tile)

/obj/machinery/atmospherics/components/unary/after_shuttle_move(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	invisibility = initial(invisibility)

/mob/on_shuttle_move(turf/newT, turf/oldT, list/movement_force, move_dir, obj/docking_port/stationary/old_dock, obj/docking_port/mobile/moving_dock)
	if(!move_on_shuttle)
		return
	return ..()

/mob/after_shuttle_move(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	if(!move_on_shuttle)
		return
	. = ..()
	if(client && movement_force)
		var/shake_force = max(movement_force["THROW"], movement_force["KNOCKDOWN"])
		if(buckled)
			shake_force *= 0.25
		shake_camera(src, shake_force, 1)

/mob/living/late_shuttle_move(turf/oldT, list/movement_force, move_dir)
	if(buckled)
		return

	. = ..()

	var/knockdown = movement_force["KNOCKDOWN"]
	if(knockdown)
		Paralyze(knockdown)

/obj/structure/grille/before_shuttle_move(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	if(. & MOVE_AREA)
		. |= MOVE_CONTENTS

/obj/structure/lattice/before_shuttle_move(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	if(. & MOVE_AREA)
		. |= MOVE_CONTENTS

/obj/structure/disposalpipe/after_shuttle_move(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	update()

/obj/structure/cable/after_shuttle_move(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	var/turf/T = loc
	if(level==1)
		hide(T.intact_tile)

/obj/structure/shuttle/before_shuttle_move(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	if(. & MOVE_AREA)
		. |= MOVE_CONTENTS

/obj/docking_port/mobile/before_shuttle_move(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	if(moving_dock == src)
		. |= MOVE_CONTENTS

/obj/docking_port/stationary/on_shuttle_move(turf/newT, turf/oldT, list/movement_force, move_dir, obj/docking_port/stationary/old_dock, obj/docking_port/mobile/moving_dock)
	if(!moving_dock.can_move_docking_ports || old_dock == src)
		return FALSE
	return ..()
