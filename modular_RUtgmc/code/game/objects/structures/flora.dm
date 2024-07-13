/obj/structure/flora/ex_act(severity)
	if(prob(severity / 4))
		qdel(src)

/obj/structure/flora/tree/ex_act(severity)
	take_damage(severity, BRUTE, BOMB)
	START_PROCESSING(SSobj, src)
