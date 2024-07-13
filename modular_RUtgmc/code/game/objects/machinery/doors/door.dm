/obj/machinery/door/ex_act(severity)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return
	if(!prob(severity / 4))
		var/datum/effect_system/spark_spread/our_sparks = new /datum/effect_system/spark_spread
		our_sparks.set_up(2, 1, src)
		our_sparks.start()
	else
		qdel(src)

