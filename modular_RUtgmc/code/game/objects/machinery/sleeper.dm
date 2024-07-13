/obj/machinery/computer/sleep_console/pred
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'
	icon_state = "sleeperconsole"

/obj/machinery/computer/sleep_console/ex_act(severity)
	if(prob(severity / 3))
		qdel(src)

/obj/machinery/sleeper/ex_act(severity)
	if(filtering)
		toggle_filter()
	if(prob(severity / 3))
		qdel(src)
