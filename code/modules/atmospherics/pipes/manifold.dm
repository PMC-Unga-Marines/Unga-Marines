//3-Way Manifold

/obj/machinery/atmospherics/pipe/manifold
	icon = 'icons/obj/atmospherics/pipes/manifold.dmi'
	icon_state = "manifold-2"

	name = "pipe manifold"
	desc = "A manifold composed of regular pipes."

	dir = SOUTH
	initialize_directions = EAST|NORTH|WEST

	device_type = TRINARY

	construction_type = /obj/item/pipe/trinary
	pipe_state = "manifold"

/obj/machinery/atmospherics/pipe/manifold/set_init_directions(init_dir)
	initialize_directions = NORTH|SOUTH|EAST|WEST
	initialize_directions &= ~dir
