/obj/structure/sign/prop1/Initialize(mapload)
	. = ..()
	icon = 'modular_RUtgmc/icons/obj/decals.dmi'

/obj/structure/sign/ex_act(severity)
	if(severity >= EXPLODE_WEAK)
		qdel(src)
