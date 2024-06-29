
/obj/machinery/prop/computer/ex_act(severity)
	if(severity >= EXPLODE_LIGHT && prob(severity /= 2))
		if(prob(severity))
			set_broken()
		else
			qdel(src)
	else if(prob(severity / 3))
		set_broken()
