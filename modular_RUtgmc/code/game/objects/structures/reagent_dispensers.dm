/obj/structure/reagent_dispensers/fueltank/pred
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'
	icon_state = "weldtank"

/obj/structure/reagent_dispensers/watertank/pred
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'
	icon_state = "watertank"

/obj/structure/reagent_dispensers/ex_act(severity)
	if(prob(severity / 4))
		new /obj/effect/particle_effect/water(loc)
		qdel(src)
