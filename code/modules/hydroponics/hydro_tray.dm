/obj/prop/hydroponics
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

/obj/prop/hydroponics/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_OBJ_TRY_ALLOW_THROUGH = PROC_REF(can_climb_over),
		COMSIG_FIND_FOOTSTEP_SOUND = TYPE_PROC_REF(/atom/movable, footstep_override),
		COMSIG_TURF_CHECK_COVERED = TYPE_PROC_REF(/atom/movable, turf_cover_check),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/prop/hydroponics/soil
	name = "soil"
	icon = 'icons/obj/machines/hydroponics.dmi'
	icon_state = "soil"
	density = FALSE

/obj/prop/hydroponics/slashable
	resistance_flags = XENO_DAMAGEABLE
	max_integrity = 80
