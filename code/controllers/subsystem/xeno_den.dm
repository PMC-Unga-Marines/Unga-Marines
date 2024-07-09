#define XENO_DEN_LEVEL_PATH "_maps/map_files/Xeno_den/Xeno_den.dmm"

SUBSYSTEM_DEF(Xenoden)
	name   = "Xenoden"
	init_order = INIT_ORDER_XENODEN
	flags  = SS_NO_FIRE

	// Current template in use
	var/datum/map_template/xenoden_template

	///The actual z-level the den is played on
	var/datum/space_level/xenoden_z_level

//Может карту можно как то по другому подгружать и не загружать когда не нужно
/datum/controller/subsystem/Xenoden/Initialize(timeofday)
	xenoden_z_level = load_new_z_level(XENO_DEN_LEVEL_PATH, "Xenoden", TRUE, list(ZTRAIT_GROUND = TRUE, ZTRAIT_XENO = TRUE)) // надеюсь ZTRAIT_GROUND будет работать корректно, в противном случает сделать новый трейт

