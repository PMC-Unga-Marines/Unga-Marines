/obj/effect/decal
	name = "decal"
	plane = FLOOR_PLANE
	layer = ABOVE_TURF_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/turf_decal
	name = "turf decal"
	plane = FLOOR_PLANE
	layer = ABOVE_TURF_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'icons/turf/decals.dmi'

/obj/effect/turf_decal/ex_act(severity)
	if(prob(severity * 0.3))
		qdel(src)
