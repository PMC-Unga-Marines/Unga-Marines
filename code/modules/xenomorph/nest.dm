/obj/structure/bed/nest
	var/force_nest = FALSE

/obj/structure/bed/nest/structure
	name = "thick alien nest"
	desc = "A very thick nest, oozing with a thick sticky substance."
	force_nest = TRUE
	var/obj/structure/xeno/thick_nest/linked_structure

/obj/structure/bed/nest/structure/Initialize(mapload, hive, obj/structure/xeno/thick_nest/to_link)
	. = ..()
	if(to_link)
		linked_structure = to_link
		max_integrity = linked_structure.max_integrity

/obj/structure/bed/nest/structure/Destroy()
	. = ..()
	if(linked_structure)
		linked_structure.pred_nest = null
		QDEL_NULL(linked_structure)

/obj/structure/bed/nest/structure/attack_hand(mob/user)
	if(!isxeno(user))
		to_chat(user, span_notice("The sticky resin is too strong for you to do anything to this nest"))
		return FALSE
	. = ..()

/obj/structure/xeno/thick_nest
	name = "thick resin nest"
	desc = "A very thick nest, oozing with a thick sticky substance."
	pixel_x = -8
	pixel_y = -8
	max_integrity = 400
	mouse_opacity = MOUSE_OPACITY_ICON
	icon = 'icons/Xeno/nest.dmi'
	icon_state = "reinforced_nest"
	layer = 2.5
	var/obj/structure/bed/nest/structure/pred_nest

/obj/structure/xeno/thick_nest/examine(mob/user)
	. = ..()
	if((isxeno(user) || isobserver(user)) && hivenumber)
		. += "Used to secure formidable hosts."

/obj/structure/xeno/thick_nest/Initialize(mapload, new_hivenumber)
	. = ..()
	if(new_hivenumber)
		hivenumber = new_hivenumber

	var/datum/hive_status/hive_ref = GLOB.hive_datums[hivenumber]
	if(hive_ref)
		hive_ref.thick_nests += src

	pred_nest = new /obj/structure/bed/nest/structure(loc, hive_ref, src) // Nest cannot be destroyed unless the structure itself is destroyed

/obj/structure/xeno/thick_nest/Destroy()
	. = ..()

	if(hivenumber)
		GLOB.hive_datums[hivenumber].thick_nests -= src

	pred_nest?.linked_structure = null
	QDEL_NULL(pred_nest)
