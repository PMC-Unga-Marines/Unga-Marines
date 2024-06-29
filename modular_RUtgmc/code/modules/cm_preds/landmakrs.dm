/obj/effect/landmark/yautja_teleport
	name = "yautja_teleport"

/obj/effect/landmark/yautja_teleport/Initialize(mapload, ...)
	. = ..()
	var/turf/T = get_turf(src)
	if(is_mainship_level(z))
		GLOB.mainship_yautja_teleports += src
		GLOB.mainship_yautja_desc[T.loc.name + " ([T.x], [T.y], [T.z])"] = src
	else
		GLOB.yautja_teleports += src
		GLOB.yautja_teleport_descs[T.loc.name + " ([T.x], [T.y], [T.z])"] = src

/obj/effect/landmark/yautja_teleport/Destroy()
	var/turf/T = get_turf(src)
	GLOB.mainship_yautja_teleports -= src
	GLOB.yautja_teleports -= src
	GLOB.mainship_yautja_desc -= T.loc.name + " ([T.x], [T.y], [T.z])"
	GLOB.yautja_teleport_descs -= T.loc.name + " ([T.x], [T.y], [T.z])"
	return ..()
