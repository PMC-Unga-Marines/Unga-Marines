/obj/item/matter_ammo_box
	name = "medium matter ammo box"
	desc = "A large matter storage box that can convert stored matter into various types of ammunition. It comes with a leather strap for easy carrying."
	w_class = WEIGHT_CLASS_HUGE
	icon = 'icons/obj/items/ammo/box.dmi'
	icon_state = "matter_ammo_box"
	worn_icon_state = "matter_ammo_box"
	equip_slot_flags = ITEM_SLOT_BACK
	base_icon_state = "matter_ammo_box"
	///Current stored matter
	var/matter_amount = 8000
	///Maximum stored matter
	var/max_matter_amount = 8000
	///Whether the box requires being on the ground to use
	var/requires_ground = TRUE
	///Whether using the box has a delay
	var/use_delay = 1 SECONDS

/obj/item/matter_ammo_box/update_icon_state()
	. = ..()
	if(matter_amount)
		icon_state = base_icon_state
		return
	icon_state = "[base_icon_state]_e"

/obj/item/matter_ammo_box/examine(mob/user)
	. = ..()
	if(matter_amount)
		. += "It contains [matter_amount] unit\s of matter."
	else
		. += "It's empty."

/obj/item/matter_ammo_box/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/ammo_magazine))
		var/obj/item/ammo_magazine/AM = I
		// Check if box needs to be on ground
		if(requires_ground && !isturf(loc))
			to_chat(user, span_warning("[src] must be on the ground to be used."))
			return

		if(!AM.default_ammo || AM.default_ammo.matter_cost <= 0)
			to_chat(user, span_warning("This ammunition type cannot be converted to matter."))
			return

		if(AM.magazine_flags & MAGAZINE_REFILLABLE)
			if(AM.current_rounds == AM.max_rounds)
				to_chat(user, span_warning("[AM] is already full."))
				return

			// Add use delay if configured
			if(use_delay && !do_after(user, use_delay, NONE, src, BUSY_ICON_GENERIC))
				return

			playsound(loc, 'sound/weapons/guns/interact/revolver_load.ogg', 25, 1)
			var/rounds_to_add = min(matter_amount / AM.default_ammo.matter_cost, AM.max_rounds - AM.current_rounds)
			var/matter_used = rounds_to_add * AM.default_ammo.matter_cost

			AM.current_rounds += rounds_to_add
			matter_amount -= matter_used
			AM.update_icon()
			update_icon()

			if(AM.current_rounds == AM.max_rounds)
				to_chat(user, span_notice("You refill [AM] using [matter_used] matter units."))
			else
				to_chat(user, span_notice("You add [rounds_to_add] rounds to [AM] using [matter_used] matter units."))

		else if(AM.magazine_flags & MAGAZINE_HANDFUL)
			if(matter_amount == max_matter_amount)
				to_chat(user, span_warning("[src] is full!"))
				return

			playsound(loc, 'sound/weapons/guns/interact/revolver_load.ogg', 25, 1)
			var/rounds_to_remove = min(AM.current_rounds, (max_matter_amount - matter_amount) / AM.default_ammo.matter_cost)
			var/matter_gained = rounds_to_remove * AM.default_ammo.matter_cost

			AM.current_rounds -= rounds_to_remove
			matter_amount += matter_gained
			AM.update_icon()
			update_icon()

			to_chat(user, span_notice("You convert [AM] into [matter_gained] matter units."))

			if(AM.current_rounds <= 0)
				user.temporarilyRemoveItemFromInventory(AM)
				qdel(AM)

//explosion when using flamer procs.
/obj/item/matter_ammo_box/fire_act(burn_level, flame_color)
	if(QDELETED(src))
		return
	if(!matter_amount)
		return
	var/turf/explosion_loc = loc // we keep it so we don't runtime on src deletion
	var/power = 5
	for(var/obj/item/matter_ammo_box/box in explosion_loc)
		if(!box.matter_amount)
			continue
		power++
		qdel(box)
	cell_explosion(explosion_loc, power, power)

/obj/item/matter_ammo_box/attack_self(mob/user)
	user.dropItemToGround(src)

/obj/item/matter_ammo_box/light
	name = "lightweight matter ammo box"
	desc = "A compact matter storage box that can convert stored matter into various types of ammunition. It's designed for quick field use. It comes with a leather strap for easy carrying."
	icon_state = "light_matter_ammo_box"
	base_icon_state = "light_matter_ammo_box"
	matter_amount = 4000
	max_matter_amount = 4000
	requires_ground = FALSE
	use_delay = 0

/obj/item/matter_ammo_box/big
	name = "big matter ammo box"
	desc = "A massive matter storage box that can convert stored matter into various types of ammunition."
	icon_state = "big_matter_ammo_box"
	base_icon_state = "big_matter_ammo_box"
	equip_slot_flags = NONE // Cannot be carried on the back
	matter_amount = 16000
	max_matter_amount = 16000
	requires_ground = TRUE
	use_delay = 0.5 SECONDS

/obj/item/matter_ammo_box/giant
	name = "giant matter ammo box"
	desc = "A massive matter storage box that can convert stored matter into various types of ammunition. It's too large to be carried on one's back and must be deployed in place."
	icon_state = "giant_matter_ammo_box"
	base_icon_state = "giant_matter_ammo_box"
	w_class = WEIGHT_CLASS_GIGANTIC
	equip_slot_flags = NONE // Cannot be carried on the back
	matter_amount = 32000
	max_matter_amount = 32000
	use_delay = 0 SECONDS

//just grab it
/obj/item/matter_ammo_box/giant/attack_hand(mob/user)
	if(isliving(user))
		to_chat(user, span_warning("[src] is too heavy to carry! You need to drag it."))
		return
	return ..()

//Deployable shotgun ammo box
/obj/item/shotgunbox
	name = "Slug Ammo Box"
	desc = "A large, deployable ammo box."
	icon = 'icons/obj/items/ammo/box.dmi'
	icon_state = "ammoboxslug"
	worn_icon_state = "ammoboxslug"
	base_icon_state = "ammoboxslug"
	w_class = WEIGHT_CLASS_HUGE
	equip_slot_flags = ITEM_SLOT_BACK
	///Current stored rounds
	var/current_rounds = 200
	///Maximum stored rounds
	var/max_rounds = 200
	///Ammunition type
	var/datum/ammo/ammo_type = /datum/ammo/bullet/shotgun/slug
	///Whether the box is deployed or not.
	var/deployed = FALSE
	///Caliber of the rounds stored.
	var/caliber = CALIBER_12G

/obj/item/shotgunbox/update_icon_state()
	. = ..()
	if(!deployed)
		icon_state = "[initial(icon_state)]"
	else if(current_rounds > 0)
		icon_state = "[initial(icon_state)]_deployed"
	else
		icon_state = "[initial(icon_state)]_empty"

/obj/item/shotgunbox/attack_self(mob/user)
	deployed = TRUE
	update_icon()
	user.dropItemToGround(src)

/obj/item/shotgunbox/MouseDrop(atom/over_object)
	if(!deployed)
		return

	if(!ishuman(over_object))
		return

	var/mob/living/carbon/human/H = over_object
	if(H == usr && !H.incapacitated() && Adjacent(H) && H.put_in_hands(src))
		deployed = FALSE
		update_icon()

/obj/item/shotgunbox/examine(mob/user)
	. = ..()
	. += "It contains [current_rounds] out of [max_rounds] shotgun shells."

/obj/item/shotgunbox/attack_hand(mob/living/user)
	if(loc == user)
		return ..()

	if(!deployed)
		user.put_in_hands(src)
		return

	if(current_rounds < 1)
		to_chat(user, ("The [src] is empty."))
		return

	var/obj/item/ammo_magazine/handful/H = new
	var/rounds = min(current_rounds, 5)

	H.generate_handful(ammo_type, caliber, rounds, initial(ammo_type.handful_amount))
	current_rounds -= rounds

	user.put_in_hands(H)
	to_chat(user, span_notice("You grab <b>[rounds]</b> round\s from [src]."))
	update_icon()

/obj/item/shotgunbox/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(!istype(I, /obj/item/ammo_magazine/handful))
		return

	var/obj/item/ammo_magazine/handful/H = I

	if(!deployed)
		to_chat(user, span_warning("[src] must be deployed on the ground to be refilled."))
		return

	if(H.default_ammo != ammo_type)
		to_chat(user, span_warning("That's not the right kind of ammo."))
		return

	if(current_rounds == max_rounds)
		to_chat(user, span_warning("The [src] is already full."))
		return

	current_rounds = min(current_rounds + H.current_rounds, max_rounds)
	qdel(H)
	update_icon()

/obj/item/shotgunbox/buckshot
	name = "Buckshot Ammo Box"
	icon_state = "ammoboxbuckshot"
	worn_icon_state = "ammoboxbuckshot"
	base_icon_state = "ammoboxbuckshot"
	ammo_type = /datum/ammo/bullet/shotgun/buckshot

/obj/item/shotgunbox/flechette
	name = "Flechette Ammo Box"
	icon_state = "ammoboxflechette"
	worn_icon_state = "ammoboxflechette"
	base_icon_state = "ammoboxflechette"
	ammo_type = /datum/ammo/bullet/shotgun/flechette

/obj/item/shotgunbox/clf_heavyrifle
	name = "big ammo box (14.5mm API)"
	caliber = CALIBER_14X5
	icon_state = "ammobox_145"
	worn_icon_state = "ammobox_145"
	base_icon_state = "ammobox_145"
	ammo_type = /datum/ammo/bullet/sniper/clf_heavyrifle

/obj/item/shotgunbox/tracker
	name = "Tracking Ammo Box"
	icon_state = "ammoboxtracking"
	worn_icon_state = "ammoboxtracking"
	base_icon_state = "ammoboxtracking"
	ammo_type = /datum/ammo/bullet/shotgun/tracker

/obj/item/shotgunbox/blank
	name = "blank ammo box"
	icon_state = "ammoboxblank"
	worn_icon_state = "ammoboxblank"
	base_icon_state = "ammoboxblank"
	ammo_type = /datum/ammo/bullet/shotgun/blank
