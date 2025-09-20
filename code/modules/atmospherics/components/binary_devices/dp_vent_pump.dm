//Acts like a normal vent, but has an input AND output.
/obj/machinery/atmospherics/components/binary/dp_vent_pump
	name = "dual-port air vent"
	desc = "Has a valve and pump attached to it. There are two ports."
	icon = 'icons/obj/atmospherics/components/unary_devices.dmi' //We reuse the normal vent icons!
	icon_state = "dpvent_map-2"
	level = 1
	var/pump_direction = 1 //0 = siphoning, 1 = releasing

/obj/machinery/atmospherics/components/binary/dp_vent_pump/update_icon_nopipes()
	cut_overlays()
	if(showpipe)
		var/image/cap = get_pipe_image(icon, "dpvent_cap", dir, piping_layer = piping_layer)
		add_overlay(cap)

	if(!on || !is_operational())
		icon_state = "vent_off"
	else
		icon_state = pump_direction ? "vent_out" : "vent_in"

/obj/machinery/atmospherics/components/binary/dp_vent_pump/high_volume
	name = "large dual-port air vent"

// Mapping

/obj/machinery/atmospherics/components/binary/dp_vent_pump/layer1
	piping_layer = 1
	icon_state = "dpvent_map-1"

/obj/machinery/atmospherics/components/binary/dp_vent_pump/layer3
	piping_layer = 3
	icon_state = "dpvent_map-3"

/obj/machinery/atmospherics/components/binary/dp_vent_pump/on
	on = TRUE
	icon_state = "dpvent_map_on-2"

/obj/machinery/atmospherics/components/binary/dp_vent_pump/on/layer1
	piping_layer = 1
	icon_state = "dpvent_map_on-1"

/obj/machinery/atmospherics/components/binary/dp_vent_pump/on/layer3
	piping_layer = 3
	icon_state = "dpvent_map_on-3"

/obj/machinery/atmospherics/components/binary/dp_vent_pump/high_volume/layer1
	piping_layer = 1
	icon_state = "dpvent_map-1"

/obj/machinery/atmospherics/components/binary/dp_vent_pump/high_volume/layer3
	piping_layer = 3
	icon_state = "dpvent_map-3"

/obj/machinery/atmospherics/components/binary/dp_vent_pump/high_volume/on
	on = TRUE
	icon_state = "dpvent_map_on-2"

/obj/machinery/atmospherics/components/binary/dp_vent_pump/high_volume/on/layer1
	piping_layer = 1
	icon_state = "dpvent_map_on-1"

/obj/machinery/atmospherics/components/binary/dp_vent_pump/high_volume/on/layer3
	piping_layer = 3
	icon_state = "dpvent_map_on-3"
