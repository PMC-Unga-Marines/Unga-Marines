/obj/item/implantcase
	name = "glass case"
	desc = "A case containing an implant."
	icon = 'icons/obj/items/implants.dmi'
	icon_state = "implantcase-0"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_right.dmi',
	)
	worn_icon_state = "implantcase"
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	var/obj/item/implant/internal_implant

/obj/item/implantcase/Initialize(mapload, internal_implant)
	. = ..()
	if(internal_implant)
		internal_implant = new internal_implant(src)
		update_icon()

/obj/item/implantcase/Destroy()
	QDEL_NULL(internal_implant)
	return ..()

/obj/item/implantcase/update_icon_state()
	. = ..()
	if(internal_implant)
		icon_state = "implantcase-[internal_implant.implant_color]"
	else
		icon_state = "implantcase-0"

/obj/item/implantcase/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/tool/pen))
		var/label = stripped_input(user, "What would you like the label to be?", "[name]", null)
		if(user.get_active_held_item() != I)
			return
		if((!in_range(src, usr) && loc != user))
			return
		if(label)
			name = initial(name) + " - [label]"
		else
			name = initial(name)

	else if(istype(I, /obj/item/reagent_containers/syringe))
		if(!internal_implant?.allow_reagents)
			return

		if(internal_implant.reagents.total_volume >= internal_implant.reagents.maximum_volume)
			to_chat(user, span_warning("[src] is full."))
			return

		I.reagents.trans_to(internal_implant, 5)
		to_chat(user, span_notice("You inject 5 units of the solution. The syringe now contains [I.reagents.total_volume] units."))

	else if(istype(I, /obj/item/implanter))
		var/obj/item/implanter/M = I
		if(M.internal_implant)
			if((internal_implant || M.internal_implant.implanted))
				return
			M.internal_implant.forceMove(src)
			internal_implant = M.internal_implant
			M.internal_implant = null

		else if(internal_implant)
			if(M.internal_implant)
				return
			internal_implant.forceMove(M)
			M.internal_implant = internal_implant
			internal_implant = null

		update_icon()
		M.update_icon()

	else if(istype(I, /obj/item/implant))
		user.temporarilyRemoveItemFromInventory(I)
		I.forceMove(src)
		internal_implant = I
		update_icon()
