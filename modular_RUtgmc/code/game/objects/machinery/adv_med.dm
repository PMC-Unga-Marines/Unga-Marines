/obj/machinery/computer/body_scanconsole/pred
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'
	icon_state = "sleeperconsole"
	base_icon_state = "sleeperconsole"

/obj/machinery/bodyscanner/ex_act(severity)
	if(!prob(severity / 3))
		return

	for(var/atom/movable/our_atom as mob|obj in src)
		our_atom.loc = src.loc
		ex_act(severity)
	qdel(src)

/obj/machinery/computer/body_scanconsole/ex_act(severity)
	if(prob(severity / 3))
		qdel(src)
