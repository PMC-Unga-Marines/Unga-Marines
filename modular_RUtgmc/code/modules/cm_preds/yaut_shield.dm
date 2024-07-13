/obj/item/weapon/shield/riot/yautja
	name = "clan shield"
	desc = "A large tribal shield made of a strange metal alloy. The face of the shield bears three skulls, two human, one alien."
	icon = 'modular_RUtgmc/icons/obj/hunter/pred_gear.dmi'
	icon_state = "shield"
	item_icons = list(
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/hunter/items_lefthand.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/hunter/items_righthand.dmi',
		slot_back_str = 'modular_RUtgmc/icons/mob/hunter/pred_gear.dmi'
	)
	item_state = "shield"
	flags_item = ITEM_PREDATOR
	flags_equip_slot = ITEM_SLOT_BACK
	resistance_flags = UNACIDABLE

	base_icon_state = "shield"

	var/passive_block = 15
	var/readied_block = 45

	var/readied_slowdown = 0.5 // Walking around in a readied shield stance slows you! The armor defs are a useful existing reference point.
	var/shield_readied = FALSE
	var/blocks_on_back = TRUE

	max_integrity = 400
	integrity_failure = 0

	var/last_attack = 0
	var/last_lowered = 0
	var/cooldown_time = 2.5 SECONDS

/obj/item/weapon/shield/riot/yautja/set_shield()
	return

/obj/item/weapon/shield/riot/yautja/AltClick(mob/user)
	if(!can_interact(user))
		return ..()
	if(!ishuman(user))
		return ..()
	if(!(user.l_hand == src || user.r_hand == src))
		return ..()
	if(!HAS_TRAIT(src, TRAIT_NODROP))
		ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
		to_chat(user, span_warning("You tighten the strap of [src] around your hand!"))
	else
		REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
		to_chat(user, span_notice("You loosen the strap of [src] around your hand!"))

/obj/item/weapon/shield/riot/yautja/proc/raise_shield(mob/user as mob) // Prepare for an attack. Slows you down slightly, but increases chance to block.
	if(world.time < last_lowered + cooldown_time)
		to_chat(user, span_warning("You need wait a little bit more before raise shield again!"))
		return

	user.visible_message(span_blue("\The [user] raises \the [src]."))
	shield_readied = TRUE
	icon_state = "[base_icon_state]_ready"
	item_state = "[base_icon_state]_ready"
	user.shield_slowdown = max(readied_slowdown, user.shield_slowdown)

	if(user.r_hand == src)
		user.update_inv_r_hand()
	if(user.l_hand == src)
		user.update_inv_l_hand()

/obj/item/weapon/shield/riot/yautja/proc/lower_shield(mob/user as mob)
	user.visible_message(span_blue("\The [user] lowers \the [src]."))
	shield_readied = FALSE
	icon_state = base_icon_state
	item_state = base_icon_state

	var/mob/living/carbon/human/H = user
	var/set_shield_slowdown = 0
	var/obj/item/weapon/shield/riot/yautja/offhand_shield
	if(H.l_hand == src && istype(H.r_hand, /obj/item/weapon/shield/riot/yautja))
		offhand_shield = H.r_hand
	else if(H.r_hand == src && istype(H.l_hand, /obj/item/weapon/shield/riot/yautja))
		offhand_shield = H.l_hand
	if(offhand_shield?.shield_readied)
		set_shield_slowdown = offhand_shield.readied_slowdown
	H.shield_slowdown = set_shield_slowdown

	last_lowered = world.time

	if(user.r_hand == src)
		user.update_inv_r_hand()
	if(user.l_hand == src)
		user.update_inv_l_hand()

/obj/item/weapon/shield/riot/yautja/proc/toggle_shield(mob/user as mob)
	if(shield_readied)
		lower_shield(user)
	else
		raise_shield(user)

// Making sure that debuffs don't stay
/obj/item/weapon/shield/riot/yautja/dropped(mob/user as mob)
	if(shield_readied)
		lower_shield(user)
	..()

/obj/item/weapon/shield/riot/yautja/equipped(mob/user, slot)
	if(shield_readied)
		lower_shield(user)
	..()

/obj/item/weapon/shield/riot/yautja/attack_self(mob/user)
	..()
	toggle_shield(user)

/obj/item/weapon/shield/riot/yautja/attack(mob/living/M, mob/living/user)
	. = ..()
	if(. && (world.time > last_attack + cooldown_time))
		last_attack = world.time
		M.throw_at(get_step(M, user.dir), 1, 5, user, FALSE)
		M.apply_effect(3, EYE_BLUR)
		M.apply_effect(5, WEAKEN)

/obj/item/weapon/shield/riot/yautja/attackby(obj/item/I, mob/user)
	if(cooldown < world.time - 25)
		if(istype(I, /obj/item/weapon) && (I.flags_item & ITEM_PREDATOR))
			user.visible_message(span_warning("[user] bashes \the [src] with \the [I]!"))
			playsound(user.loc, 'sound/effects/shieldbash.ogg', 25, 1)
			cooldown = world.time
	else
		..()
