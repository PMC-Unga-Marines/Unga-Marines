/*
All shuttle_rotate procs go here

If ever any of these procs are useful for non-shuttles, rename it to proc/rotate and move it to be a generic atom proc
*/

/************************************Base proc************************************/

/atom/proc/shuttle_rotate(rotation, params=ROTATE_DIR|ROTATE_SMOOTH|ROTATE_OFFSET)
	if(params & ROTATE_DIR)
		//rotate our direction
		setDir(angle2dir(rotation+dir2angle(dir)))
		QUEUE_SMOOTH(src) //resmooth if need be.

	//rotate the pixel offsets too.
	if((pixel_x || pixel_y) && (params & ROTATE_OFFSET))
		if(rotation < 0)
			rotation += 360
		for(var/turntimes = rotation / 90; turntimes > 0; turntimes--)
			var/oldPX = pixel_x
			var/oldPY = pixel_y
			pixel_x = oldPY
			pixel_y = (oldPX*(-1))

/************************************Turf rotate procs************************************/

/turf/open/shuttle_rotate(rotation, params)
	return

/turf/closed/mineral/shuttle_rotate(rotation, params)
	params &= ~ROTATE_OFFSET
	return ..()

/************************************Mob rotate procs************************************/

//override to avoid rotating pixel_xy on mobs
/mob/shuttle_rotate(rotation, params)
	params = NONE
	. = ..()
	if(!buckled)
		setDir(angle2dir(rotation+dir2angle(dir)))

/mob/dead/observer/shuttle_rotate(rotation, params)
	. = ..()
	update_icons()

/************************************Structure rotate procs************************************/

//Fixes dpdir on shuttle rotation
/obj/structure/disposalpipe/shuttle_rotate(rotation, params)
	. = ..()
	var/new_dpdir = 0
	for(var/D in GLOB.cardinals)
		if(dpdir & D)
			new_dpdir = new_dpdir | angle2dir(rotation+dir2angle(D))
	dpdir = new_dpdir

/obj/structure/window/framed/shuttle_rotate(rotation, params)
	. = ..()
	update_icon()

/obj/structure/alien/weeds/shuttle_rotate(rotation, params)
	params &= ~ROTATE_OFFSET
	return ..()

/************************************Machine rotate procs************************************/

//override to avoid rotating multitile vehicles
/obj/vehicle/shuttle_rotate(rotation, params)
	if(hitbox)
		params = NONE
	return ..()

/obj/machinery/atmospherics/shuttle_rotate(rotation, params)
	var/list/real_node_connect = get_node_connects()
	for(var/i in 1 to device_type)
		real_node_connect[i] = angle2dir(rotation+dir2angle(real_node_connect[i]))

	. = ..()
	set_init_directions()
	var/list/supposed_node_connect = get_node_connects()
	var/list/nodes_copy = nodes.Copy()

	for(var/i in 1 to device_type)
		var/new_pos = supposed_node_connect.Find(real_node_connect[i])
		nodes[new_pos] = nodes_copy[i]
