//4-Way Manifold

/obj/machinery/atmospherics/pipe/manifold4w
	icon = 'icons/obj/atmospherics/pipes/manifold.dmi'
	icon_state = "manifold4w-2"

	name = "4-way pipe manifold"
	desc = "A manifold composed of regular pipes."

	initialize_directions = NORTH|SOUTH|EAST|WEST

	device_type = QUATERNARY

	construction_type = /obj/item/pipe/quaternary
	pipe_state = "manifold4w"

/obj/machinery/atmospherics/pipe/manifold4w/set_init_directions(init_dir)
	initialize_directions = initial(initialize_directions)
