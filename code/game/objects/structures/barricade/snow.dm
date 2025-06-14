/obj/structure/barricade/snow
	name = "snow barricade"
	desc = "A mound of snow shaped into a sloped wall. Statistically better than thin air as cover."
	icon_state = "snow_0"
	icon = 'icons/obj/structures/barricades/sandbag.dmi'
	barricade_type = "snow"
	max_integrity = 75
	stack_type = /obj/item/stack/snow
	stack_amount = 5
	destroyed_stack_amount = 0
	can_wire = FALSE

/obj/structure/barricade/snow/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	//Removing the barricades
	if(!istype(I, /obj/item/tool/shovel) || user.a_intent == INTENT_HARM)
		return
	var/obj/item/tool/shovel/ET = I

	if(ET.folded)
		return

	if(LAZYACCESS(user.do_actions, src))
		balloon_alert(user, "Already shoveling")
		return

	user.visible_message("[user] starts clearing out \the [src].", "You start removing \the [src].")

	if(!do_after(user, ET.shovelspeed, NONE, src, BUSY_ICON_BUILD))
		return

	if(ET.folded)
		return
	deconstruct(!get_self_acid())
