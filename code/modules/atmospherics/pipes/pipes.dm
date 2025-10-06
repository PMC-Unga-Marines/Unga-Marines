/obj/machinery/atmospherics/pipe
	level = 1
	use_power = NO_POWER_USE
	can_unwrench = FALSE
	atom_flags = SHUTTLE_IMMUNE
	buckle_lying = -1
	layer = BELOW_CATWALK_LAYER
	plane = FLOOR_PLANE
	var/datum/pipeline/parent = null

/obj/machinery/atmospherics/pipe/Initialize(mapload, process, setdir)
	. = ..()
	add_atom_colour(pipe_color, FIXED_COLOR_PRIORITY)

/obj/machinery/atmospherics/pipe/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/undertile, TRAIT_T_RAY_VISIBLE)

/obj/machinery/atmospherics/pipe/Destroy()
	QDEL_NULL(parent)
	return ..()

/obj/machinery/atmospherics/pipe/nullify_node(i)
	var/obj/machinery/atmospherics/oldN = nodes[i]
	. = ..()
	if(oldN)
		oldN.build_network()

/obj/machinery/atmospherics/pipe/destroy_network()
	QDEL_NULL(parent)

/obj/machinery/atmospherics/pipe/build_network()
	if(!QDELETED(parent))
		return
	parent = new
	parent.build_pipeline(src)

/obj/machinery/atmospherics/pipe/atmos_init()
	var/turf/T = loc			// hide if turf is not intact
	hide(T.intact_tile)
	return ..()

/obj/machinery/atmospherics/pipe/hide(i)
	if(level == 1 && isturf(loc))
		invisibility = i ? INVISIBILITY_MAXIMUM : 0
	update_icon()

/obj/machinery/atmospherics/pipe/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(istype(I, /obj/item/pipe_meter))
		var/obj/item/pipe_meter/meter = I
		user.dropItemToGround(meter)
		meter.setAttachLayer(piping_layer)

/obj/machinery/atmospherics/pipe/return_pipenet()
	return parent

/obj/machinery/atmospherics/pipe/set_pipenet(datum/pipeline/P)
	parent = P

/obj/machinery/atmospherics/pipe/update_icon()
	. = ..()
	update_alpha()

/obj/machinery/atmospherics/pipe/proc/update_alpha()
	alpha = 255

/obj/machinery/atmospherics/pipe/return_pipenets()
	. = list(parent)

/obj/machinery/atmospherics/pipe/update_layer()
	layer = initial(layer) + get_pipe_layer_offset()
