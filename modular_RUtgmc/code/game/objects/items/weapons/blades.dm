/obj/item/weapon/combat_knife
	icon = 'modular_RUtgmc/icons/obj/items/weapons.dmi'
	item_icons = list(
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/inhands/weapons/melee_right.dmi',
	)

/obj/item/weapon/combat_knife/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/shrapnel_removal, 12 SECONDS, 12 SECONDS, 10)

/obj/item/weapon/combat_knife/nkvd
	name = "\improper Finka NKVD"
	icon_state = "upp_knife"
	item_state = "combat_knife"
	desc = "Legendary Finka NKVD model 1934 with a 10-year warranty and delivery within 2 days."
	force = 40
	throwforce = 50
	throw_speed = 2
	throw_range = 8

/obj/item/weapon/claymore/mercsword/machete
	force = 90
	penetration = 15
	icon = 'modular_RUtgmc/icons/obj/items/weapons.dmi'
	item_icons = list(
		slot_back_str = 'modular_RUtgmc/icons/mob/clothing/back.dmi',
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/inhands/weapons/melee_right.dmi',
		slot_belt_str = 'modular_RUtgmc/icons/mob/suit_slot.dmi'
	)
	flags_equip_slot = ITEM_SLOT_BELT|ITEM_SLOT_BACK

/obj/item/weapon/claymore/mercsword/officersword
	icon_state = "officer_sword"
	item_state = "officer_sword"
	force = 80
	attack_speed = 5
	sharp = IS_SHARP_ITEM_ACCURATE
	resistance_flags = UNACIDABLE
	hitsound = 'modular_RUtgmc/sound/weapons/rapierhit.ogg'
	attack_verb = list("slash", "cut")
	w_class = WEIGHT_CLASS_BULKY

/obj/item/weapon/claymore/mercsword/officersword/attack(mob/living/carbon/M, mob/living/user)
	. = ..()
	if(user.skills.getRating("swordplay") == SKILL_SWORDPLAY_DEFAULT)
		attack_speed = 20
		force = 35
		to_chat(user, span_warning("You try to figure out how to wield [src]..."))
		if(prob(40))
			if(HAS_TRAIT_FROM(src, TRAIT_NODROP, STRAPPABLE_ITEM_TRAIT))
				REMOVE_TRAIT(src, TRAIT_NODROP, STRAPPABLE_ITEM_TRAIT)
			user.drop_held_item(src)
			to_chat(user, span_warning("[src] slipped out of your hands!"))
			playsound(src.loc, 'sound/misc/slip.ogg', 25, 1)
	if(user.skills.getRating("swordplay") == SKILL_SWORDPLAY_TRAINED)
		attack_speed = initial(attack_speed)
		force = initial(force)

/obj/item/weapon/claymore/mercsword/officersword/equipped(mob/user, slot)
	. = ..()
	toggle_item_bump_attack(user, TRUE)

/obj/item/weapon/claymore/mercsword/officersword/dropped(mob/user)
	. = ..()
	toggle_item_bump_attack(user, FALSE)

/obj/item/weapon/claymore/mercsword/officersword/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/strappable)

/obj/item/weapon/claymore/mercsword/officersword/sabre
	name = "\improper ceremonial officer sabre"
	desc = "Gold plated, smoked dark wood handle, your name on it, what else do you need?"
	icon = 'modular_RUtgmc/icons/obj/items/weapons.dmi'
	item_icons = list(
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/inhands/weapons/melee_right.dmi',
	)
	icon_state = "saber"
	item_state = "saber"

/obj/item/stack/throwing_knife/melee_attack_chain(mob/user, atom/target, params, rightclick)
	if(target == user && !user.do_self_harm)
		return
	return ..()

/*
				TOMAHAWK
*/

/obj/item/weapon/claymore/tomahawk
	name = "Tomahawk H23"
	desc = "A specialist tactical weapon, ancient and beloved by many. Issued to TGMC by CAU."
	icon = 'modular_RUtgmc/icons/obj/items/weapons.dmi'
	icon_state = "tomahawk_tactic"
	item_state = "tomahawk_tactic"
	item_icons = list(
		slot_back_str = 'modular_RUtgmc/icons/mob/clothing/back.dmi',
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/items_lefthand_64.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/items_righthand_64.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	flags_atom = CONDUCT
	flags_equip_slot = ITEM_SLOT_BELT|ITEM_SLOT_BACK
	force = 70
	attack_speed = 8
	throwforce = 130 //throw_dmg = throwforce * (throw_speed * 0.2)
	throw_range = 9
	throw_speed = 5
	sharp = IS_SHARP_ITEM_BIG
	edge = 1
	w_class = WEIGHT_CLASS_BULKY

	///The person throwing tomahawk
	var/mob/living/living_user

/obj/item/weapon/claymore/tomahawk/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/strappable)

/obj/item/weapon/claymore/tomahawk/equipped(mob/user, slot)
	. = ..()
	toggle_item_bump_attack(user, TRUE)
	if(!living_user)
		living_user = user
		RegisterSignal(user, COMSIG_MOB_MOUSEDOWN, PROC_REF(try_throw))

/obj/item/weapon/claymore/tomahawk/dropped(mob/user)
	. = ..()
	toggle_item_bump_attack(user, FALSE)
	if(living_user)
		living_user = null
		UnregisterSignal(user, COMSIG_MOB_MOUSEDOWN)

/obj/item/weapon/claymore/tomahawk/proc/try_throw(datum/source, atom/object, turf/location, control, params, bypass_checks = FALSE)
	SIGNAL_HANDLER

	var/list/modifiers = params2list(params)
	if(modifiers["shift"])
		return

	if(modifiers["middle"])
		return

	if(living_user.get_active_held_item() != src) // If the object in our active hand is not atomahawk, abort
		return

	if(modifiers["right"])
		//handle strapping
		if(HAS_TRAIT_FROM(src, TRAIT_NODROP, STRAPPABLE_ITEM_TRAIT))
			REMOVE_TRAIT(src, TRAIT_NODROP, STRAPPABLE_ITEM_TRAIT)
		living_user.throw_item(get_turf_on_clickcatcher(object, living_user, params))
		return

