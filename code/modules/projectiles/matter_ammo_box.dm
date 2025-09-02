/obj/item/matter_ammo_box
	name = "medium matter ammo box"
	desc = "A large matter storage box that can convert stored matter into various types of ammunition. It comes with a leather strap for easy carrying."
	w_class = WEIGHT_CLASS_HUGE
	icon = 'icons/obj/items/ammo/box.dmi'
	icon_state = "matter_ammo_box"
	worn_icon_state = "matter_ammo_box"
	worn_icon_state_worn = "matter_ammo_box"
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

	// Check if box needs to be on ground
	if(requires_ground && !isturf(loc))
		to_chat(user, span_warning("[src] must be on the ground to be used."))
		return

	if(!matter_amount)
		to_chat(user, span_warning("[src] is empty."))
		return

	if(istype(I, /obj/item/ammo_magazine))
		var/obj/item/ammo_magazine/ammo_magazine = I

		if(!ammo_magazine.default_ammo || ammo_magazine.default_ammo.matter_cost <= 0)
			to_chat(user, span_warning("This ammunition type cannot be converted to matter."))
			return

		if(ammo_magazine.magazine_flags & MAGAZINE_REFILLABLE)
			if(ammo_magazine.current_rounds == ammo_magazine.max_rounds)
				to_chat(user, span_warning("[ammo_magazine] is already full."))
				return

			// Add use delay if configured
			if(use_delay && !do_after(user, use_delay, NONE, src, BUSY_ICON_GENERIC))
				return

			playsound(loc, 'sound/weapons/guns/interact/revolver_load.ogg', 25, 1)
			var/rounds_to_add = min(matter_amount / ammo_magazine.default_ammo.matter_cost, ammo_magazine.max_rounds - ammo_magazine.current_rounds)
			var/matter_used = rounds_to_add * ammo_magazine.default_ammo.matter_cost

			ammo_magazine.current_rounds += rounds_to_add
			matter_amount -= matter_used
			ammo_magazine.update_icon()
			update_icon()

			if(ammo_magazine.current_rounds == ammo_magazine.max_rounds)
				to_chat(user, span_notice("You refill [ammo_magazine] using [matter_used] matter units."))
			else
				to_chat(user, span_notice("You add [rounds_to_add] rounds to [ammo_magazine] using [matter_used] matter units."))

		else if(ammo_magazine.magazine_flags & MAGAZINE_HANDFUL)
			if(matter_amount == max_matter_amount)
				to_chat(user, span_warning("[src] is full!"))
				return

			playsound(loc, 'sound/weapons/guns/interact/revolver_load.ogg', 25, 1)
			var/rounds_to_remove = min(ammo_magazine.current_rounds, trunc((max_matter_amount - matter_amount) / ammo_magazine.default_ammo.matter_cost))
			var/matter_gained = rounds_to_remove * ammo_magazine.default_ammo.matter_cost

			ammo_magazine.current_rounds -= rounds_to_remove
			matter_amount += matter_gained
			ammo_magazine.update_icon()
			update_icon()

			to_chat(user, span_notice("You convert [ammo_magazine] into [matter_gained] matter units."))

			if(ammo_magazine.current_rounds <= 0)
				user.temporarilyRemoveItemFromInventory(ammo_magazine)
				qdel(ammo_magazine)

	else if(istype(I, /obj/item/matter_ammo_box))
		var/obj/item/matter_ammo_box/other_box = I

		if(other_box.matter_amount >= other_box.max_matter_amount)
			to_chat(user, span_warning("[other_box] is full."))
			return

		if(!do_after(user, 5 SECONDS, NONE, src, BUSY_ICON_GENERIC))
			return

		var/transfer_amount = min(matter_amount, other_box.max_matter_amount - other_box.matter_amount)
		other_box.matter_amount += transfer_amount
		matter_amount -= transfer_amount
		playsound(loc, 'sound/weapons/guns/interact/revolver_load.ogg', 25, 1)
		to_chat(user, span_notice("You transfer [transfer_amount] matter units from [src] to [other_box]."))
		other_box.update_icon()
		update_icon()

/obj/item/matter_ammo_box/examine(mob/user, distance, infix, suffix)
	. = ..()
	. += span_notice("Left click [src] [requires_ground ? "on the ground" : ""] with ammo box or packet, magazine, matter box to restore ammo.")

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
	matter_amount = 3000
	max_matter_amount = 3000
	requires_ground = FALSE
	use_delay = 0

/obj/item/matter_ammo_box/big
	name = "big matter ammo box"
	desc = "A massive matter storage box that can convert stored matter into various types of ammunition."
	icon_state = "big_matter_ammo_box"
	base_icon_state = "big_matter_ammo_box"
	equip_slot_flags = NONE // Cannot be carried on the back
	matter_amount = 12000
	max_matter_amount = 12000
	use_delay = 0.5 SECONDS

/obj/item/matter_ammo_box/giant
	name = "giant matter ammo box"
	desc = "A massive matter storage box that can convert stored matter into various types of ammunition. It's too large to be carried on one's back and must be deployed in place."
	icon_state = "giant_matter_ammo_box"
	base_icon_state = "giant_matter_ammo_box"
	equip_slot_flags = NONE // Cannot be carried on the back
	matter_amount = 64000
	max_matter_amount = 64000
	use_delay = 0

/obj/item/matter_ammo_box/giant/on_vend(mob/user, faction, fill_container = FALSE, auto_equip = FALSE)
	return

//just grab it
/obj/item/matter_ammo_box/giant/attack_hand(mob/user)
	if(isliving(user))
		to_chat(user, span_warning("[src] is too heavy to carry! You need to drag it."))
		return
	return ..()
