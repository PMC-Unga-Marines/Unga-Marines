/obj/machinery/atmospherics/pipe/heat_exchanging/junction
	name = "junction"
	desc = "A one meter junction that connects regular and heat-exchanging pipe."
	icon = 'icons/obj/atmospherics/pipes/he-junction.dmi'
	icon_state = "pipe11-2"
	dir = SOUTH
	device_type = BINARY
	construction_type = /obj/item/pipe/directional
	pipe_state = "junction"

/obj/machinery/atmospherics/pipe/heat_exchanging/junction/set_init_directions(init_dir)
	switch(dir)
		if(NORTH, SOUTH)
			initialize_directions = SOUTH|NORTH
		if(EAST, WEST)
			initialize_directions = WEST|EAST

/obj/machinery/atmospherics/pipe/heat_exchanging/junction/get_node_connects()
	return list(REVERSE_DIR(dir), dir)

/obj/machinery/atmospherics/pipe/heat_exchanging/junction/is_connectable(obj/machinery/atmospherics/target, given_layer, he_type_check)
	if(dir == get_dir(target, src))
		return ..(target, given_layer, FALSE) //we want a normal pipe instead
	return ..(target, given_layer, TRUE)

/obj/machinery/atmospherics/pipe/heat_exchanging/junction/update_icon_state()
	. = ..()
	icon_state = "pipe[nodes[1] ? "1" : "0"][nodes[2] ? "1" : "0"]-[piping_layer]"
	update_layer()
	update_alpha()

/obj/machinery/atmospherics/pipe/heat_exchanging/junction/layer1
	piping_layer = 1
	icon_state = "pipe11-1"

/obj/machinery/atmospherics/pipe/heat_exchanging/junction/layer3
	piping_layer = 3
	icon_state = "pipe11-3"
