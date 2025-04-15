/obj/item/big_ammo_box
	name = "big ammo box (10x24mm)"
	desc = "A large ammo box. It comes with a leather strap."
	w_class = WEIGHT_CLASS_HUGE
	icon = 'icons/obj/items/ammo/box.dmi'
	icon_state = "big_ammo_box"
	worn_icon_state = "big_ammo_box"
	equip_slot_flags = ITEM_SLOT_BACK
	base_icon_state = "big_ammo_box"
	///Ammunition type
	var/default_ammo = /datum/ammo/bullet/rifle
	///Current stored rounds
	var/bullet_amount = 2400
	///Maximum stored rounds
	var/max_bullet_amount = 2400
	///Caliber of the rounds stored.
	var/caliber = CALIBER_10X24_CASELESS

/obj/item/big_ammo_box/update_icon_state()
	. = ..()
	if(bullet_amount)
		icon_state = base_icon_state
		return
	icon_state = "[base_icon_state]_e"

/obj/item/big_ammo_box/examine(mob/user)
	. = ..()
	if(bullet_amount)
		. += "It contains [bullet_amount] round\s."
	else
		. += "It's empty."

/obj/item/big_ammo_box/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/ammo_magazine))
		var/obj/item/ammo_magazine/AM = I
		if(!isturf(loc))
			to_chat(user, span_warning("[src] must be on the ground to be used."))
			return
		if(AM.magazine_flags & MAGAZINE_REFILLABLE)
			if(default_ammo != AM.default_ammo)
				to_chat(user, span_warning("Those aren't the same rounds. Better not mix them up."))
				return
			if(caliber != AM.caliber)
				to_chat(user, span_warning("The rounds don't match up. Better not mix them up."))
				return
			if(AM.current_rounds == AM.max_rounds)
				to_chat(user, span_warning("[AM] is already full."))
				return

			if(!do_after(user, 15, NONE, src, BUSY_ICON_GENERIC))
				return

			playsound(loc, 'sound/weapons/guns/interact/revolver_load.ogg', 25, 1)
			var/S = min(bullet_amount, AM.max_rounds - AM.current_rounds)
			AM.current_rounds += S
			bullet_amount -= S
			AM.update_icon()
			update_icon()
			if(AM.current_rounds == AM.max_rounds)
				to_chat(user, span_notice("You refill [AM]."))
			else
				to_chat(user, span_notice("You put [S] rounds in [AM]."))
		else if(AM.magazine_flags & MAGAZINE_HANDFUL)
			if(caliber != AM.caliber)
				to_chat(user, span_warning("The rounds don't match up. Better not mix them up."))
				return
			if(bullet_amount == max_bullet_amount)
				to_chat(user, span_warning("[src] is full!"))
				return
			playsound(loc, 'sound/weapons/guns/interact/revolver_load.ogg', 25, 1)
			var/S = min(AM.current_rounds, max_bullet_amount - bullet_amount)
			AM.current_rounds -= S
			bullet_amount += S
			AM.update_icon()
			to_chat(user, span_notice("You put [S] rounds in [src]."))
			if(AM.current_rounds <= 0)
				user.temporarilyRemoveItemFromInventory(AM)
				qdel(AM)

//explosion when using flamer procs.
/obj/item/big_ammo_box/fire_act(burn_level, flame_color)
	if(QDELETED(src))
		return
	if(!bullet_amount)
		return
	var/turf/explosion_loc = loc // we keep it so we don't runtime on src deletion
	var/power = 5
	for(var/obj/item/big_ammo_box/box in explosion_loc)
		if(!box.bullet_amount)
			continue
		power++
		qdel(box)
	cell_explosion(explosion_loc, power, power)

/obj/item/big_ammo_box/ap
	name = "big ammo box (10x24mm AP)"
	icon_state = "big_ammo_box_ap"
	base_icon_state = "big_ammo_box_ap"
	default_ammo = /datum/ammo/bullet/rifle/ap
	bullet_amount = 400 //AP is OP
	max_bullet_amount = 400

/obj/item/big_ammo_box/smg
	name = "big ammo box (10x20mm)"
	caliber = CALIBER_10X20
	icon_state = "big_ammo_box_m25"
	base_icon_state = "big_ammo_box_m25"
	default_ammo = /datum/ammo/bullet/smg
	bullet_amount = 4500
	max_bullet_amount = 4500
	caliber = CALIBER_10X20_CASELESS

/obj/item/big_ammo_box/mg
	name = "big ammo box (10x26mm)"
	default_ammo = /datum/ammo/bullet/rifle/machinegun
	caliber = CALIBER_10X26_CASELESS
	bullet_amount = 3200 //a backpack holds 8 MG-60 box mags, which is 1600 rounds
	max_bullet_amount = 3200

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
