/obj/machinery/landinglight/alamo
	id = SHUTTLE_NORMANDY

/obj/machinery/light/ex_act(severity)
	if(severity >= EXPLODE_HEAVY)
		qdel(src)
	else if(prob(severity / 2))
		broken()
