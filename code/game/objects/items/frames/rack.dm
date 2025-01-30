/obj/item/frame/rack
	name = "rack parts"
	desc = "A kit for a storage rack with multiple metal shelves. Relatively cheap, useful for mass storage. Some assembly required."
	icon = 'icons/obj/items/items.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/engineering_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/engineering_right.dmi',
	)
	icon_state = "rack_parts"
	flags_atom = CONDUCT

/obj/item/frame/rack/attackby(obj/item/I, mob/user, params)
	. = ..()

	if(iswrench(I))
		new /obj/item/stack/sheet/metal(loc)
		qdel(src)

/obj/item/frame/rack/attack_self(mob/user as mob)
	if(locate(/obj/structure/table) in user.loc || locate(/obj/structure/barricade) in user.loc)
		to_chat(user, span_warning("There is already a structure here."))
		return

	if(locate(/obj/structure/rack) in user.loc)
		to_chat(user, span_warning("There already is a rack here."))
		return

	new /obj/structure/rack(user.loc)
	user.drop_held_item()
	qdel(src)
