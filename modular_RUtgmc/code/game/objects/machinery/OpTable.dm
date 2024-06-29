/obj/machinery/optable/yautja
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'
	icon_state = "table2-idle"

/obj/machinery/optable/ex_act(severity)
	if(prob(severity / 3))
		qdel(src)
