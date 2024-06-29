//RUTGMC MESSY FIX
/obj/effect/landmark/start/job/survivor/Initialize(mapload)
	. = ..()
	new /obj/effect/landmark/yautja_teleport(loc)

/obj/effect/landmark/start/job/squadmarine/Initialize(mapload)
	. = ..()
	new /obj/effect/landmark/yautja_teleport(loc)
//END OF MESSY FIX TO DELETE

/* Predator Ship Teleporter - set in each individual gamemode */

/obj/effect/step_trigger/teleporter/yautja_ship/Trigger(atom/movable/A)
	var/turf/destination
	if(length(GLOB.yautja_teleports)) //We have some possible locations.
		var/pick = tgui_input_list(usr, "Where do you want to go today?", "Locations", GLOB.yautja_teleport_descs) //Pick one of them in the list.)
		destination = GLOB.yautja_teleport_descs[pick]
	if(!destination || (A.loc != loc))
		return
	teleport_x = destination.x //Configure the destination locations.
	teleport_y = destination.y
	teleport_z = destination.z
	..(A, 1) //Run the parent proc for teleportation. Tell it to play the animation.
