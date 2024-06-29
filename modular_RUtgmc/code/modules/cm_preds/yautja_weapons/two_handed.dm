/*#########################################
########### Two Handed Weapons ############
#########################################*/
/obj/item/weapon/twohanded/yautja
	icon = 'modular_RUtgmc/icons/obj/hunter/pred_gear.dmi'
	item_icons = list(
		slot_back_str = 'modular_RUtgmc/icons/mob/hunter/pred_gear.dmi',
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/hunter/items_lefthand.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/hunter/items_righthand.dmi',
		slot_s_store_str = 'modular_RUtgmc/icons/mob/hunter/pred_gear.dmi'
	)

	flags_item = TWOHANDED|ITEM_PREDATOR
	resistance_flags = UNACIDABLE
	flags_equip_slot = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	throw_speed = 10
	edge = TRUE
	hitsound = 'sound/weapons/bladeslice.ogg'
	var/human_adapted = FALSE

/obj/item/weapon/twohanded/yautja/spear
	name = "hunter spear"
	desc = "A spear of exquisite design, used by an ancient civilisation."
	icon_state = "spearhunter"
	item_state = "spearhunter"
	flags_item = TWOHANDED
	force = 20
	force_wielded = 45
	penetration = 25
	throwforce = 40
	sharp = IS_SHARP_ITEM_SIMPLE
	attack_verb = list("attacked", "stabbed", "jabbed", "torn", "gored")

/obj/item/weapon/twohanded/yautja/glaive
	name = "war glaive"
	desc = "A huge, powerful blade on a metallic pole. Mysterious writing is carved into the weapon."
	icon_state = "glaive"
	item_state = "glaive"
	force = 20
	force_wielded = 45
	reach = 2
	penetration = 30
	throwforce = 20
	sharp = IS_SHARP_ITEM_BIG
	flags_atom = CONDUCT
	attack_verb = list("sliced", "slashed", "carved", "diced", "gored")
	attack_speed = 20 //Default is 7.

/obj/item/weapon/twohanded/yautja/glaive/attack(mob/living/target, mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	if((human_adapted || isyautja(user)) && isxeno(target))
		var/mob/living/carbon/xenomorph/xenomorph = target
		xenomorph.interference = 30

/obj/item/weapon/twohanded/yautja/glaive/AltClick(mob/user)
	if(!can_interact(user) || !ishuman(user) || !(user.l_hand == src || user.r_hand == src))
		return ..()
	if(!HAS_TRAIT(src, TRAIT_NODROP))
		ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
		to_chat(user, span_warning("You tighten the grip around [src]!"))
	else
		REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
		to_chat(user, span_notice("You loosen the grip around [src]!"))

/obj/item/weapon/twohanded/yautja/glaive/alt
	icon_state = "glaive_alt"
	item_state = "glaive_alt"

/obj/item/weapon/twohanded/yautja/glaive/damaged
	name = "ancient war glaive"
	desc = "A huge, powerful blade on a metallic pole. Mysterious writing is carved into the weapon. This one is ancient and has suffered serious acid damage, making it near-useless."
	force = 10
	force_wielded = 25
	penetration = 5
	throwforce = 10
	icon_state = "glaive_alt"
	item_state = "glaive_alt"
	flags_item = TWOHANDED

