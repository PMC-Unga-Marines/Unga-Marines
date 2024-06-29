
/obj/structure/inflatable/ex_act(severity)
	if(severity >= EXPLODE_HEAVY)
		qdel(src)
	else if(prob(severity / 2))
		deflate(TRUE)

