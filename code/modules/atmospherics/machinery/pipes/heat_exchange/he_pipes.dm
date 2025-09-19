/obj/machinery/atmospherics/pipe/heat_exchanging
	level = 2
	color = "#404040"
	buckle_lying = -1
	var/icon_temperature = T20C //stop small changes in temperature causing icon refresh

/obj/machinery/atmospherics/pipe/heat_exchanging/New(loc, process, setdir)
	. = ..()
	add_atom_colour("#404040", FIXED_COLOR_PRIORITY)

/obj/machinery/atmospherics/pipe/heat_exchanging/is_connectable(obj/machinery/atmospherics/pipe/heat_exchanging/target, given_layer, HE_type_check = TRUE)
	if(istype(target, /obj/machinery/atmospherics/pipe/heat_exchanging) != HE_type_check)
		return FALSE
	return ..()

/obj/machinery/atmospherics/pipe/heat_exchanging/hide()
	return
