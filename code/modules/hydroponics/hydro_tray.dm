#define HYDRO_SPEED_MULTIPLIER 1
/obj/machinery/hydroponics
	name = "hydroponics tray"
	icon = 'icons/obj/machines/hydroponics.dmi'
	icon_state = "hydrotray3"
	density = TRUE
	anchored = TRUE
	coverage = 40
	layer = BELOW_OBJ_LAYER
	resistance_flags = XENO_DAMAGEABLE
	allow_pass_flags = PASS_LOW_STRUCTURE|PASSABLE|PASS_WALKOVER
	max_integrity = 40
	soft_armor = list(MELEE = 0, BULLET = 80, LASER = 80, ENERGY = 80, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)

/obj/machinery/hydroponics/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_OBJ_TRY_ALLOW_THROUGH = PROC_REF(can_climb_over),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/machinery/hydroponics/verb/close_lid()
	set name = "Toggle Tray Lid"
	set category = "Object"
	set src in view(1)

	if(!usr || usr.stat || usr.restrained())
		return

	closed_system = !closed_system
	to_chat(usr, "You [closed_system ? "close" : "open"] the tray's lid.")
	update_icon()

/obj/machinery/hydroponics/soil
	name = "soil"
	icon = 'icons/obj/machines/hydroponics.dmi'
	icon_state = "soil"
	density = FALSE
	use_power = 0

/obj/machinery/hydroponics/soil/attackby(obj/item/I, mob/user, params)
	. = ..()

	if(istype(I, /obj/item/tool/shovel))
		to_chat(user, "You clear up [src]!")
		qdel(src)

/obj/machinery/hydroponics/soil/Initialize(mapload)
	. = ..()
	verbs -= /obj/machinery/hydroponics/verb/close_lid

/obj/machinery/hydroponics/slashable
	resistance_flags = XENO_DAMAGEABLE
	max_integrity = 80

#undef HYDRO_SPEED_MULTIPLIER
