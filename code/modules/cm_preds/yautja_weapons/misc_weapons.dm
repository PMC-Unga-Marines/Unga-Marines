/*#########################################
############## Misc Weapons ###############
#########################################*/
/obj/item/weapon/harpoon/yautja
	name = "large harpoon"
	desc = "A huge metal spike with a hook at the end. It's carved with mysterious alien writing."

	icon = 'modular_RUtgmc/icons/obj/hunter/pred_gear.dmi'
	icon_state = "spike"
	item_icons = list(
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/hunter/items_lefthand.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/hunter/items_righthand.dmi'
	)
	item_state = "harpoon"

	attack_verb = list("jabbed","stabbed","ripped", "skewered")
	throw_range = 4
	resistance_flags = UNACIDABLE
	edge = 1
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharp = IS_SHARP_ITEM_BIG
	force = 10
	throwforce = 30

/obj/item/weapon/wristblades
	name = "\proper wrist blades"
	desc = "A pair of huge, serrated blades extending out from metal gauntlets."

	icon = 'modular_RUtgmc/icons/obj/hunter/pred_gear.dmi'
	icon_state = "wrist"
	item_state = "wristblade"
	item_icons = list(
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/hunter/items_lefthand.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/hunter/items_righthand.dmi'
	)

	w_class = WEIGHT_CLASS_GIGANTIC
	edge = TRUE
	sharp = IS_SHARP_ITEM_ACCURATE
	flags_item = ITEM_PREDATOR
	flags_equip_slot = NONE
	hitsound = 'sound/weapons/wristblades_hit.ogg'
	attack_speed = 6
	force = 25
	penetration = 10
	pry_capable = IS_PRY_CAPABLE_FORCE
	attack_verb = list("sliced", "slashed", "jabbed", "torn", "gored")

	var/obj/item/clothing/gloves/yautja/hunter/source
	var/has_speed_bonus = TRUE

/obj/item/weapon/wristblades/Initialize(mapload)
	. = ..()
	source = loc
	if(!istype(source))
		qdel(src)

/obj/item/weapon/wristblades/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_L_HAND || slot == SLOT_R_HAND)
		if(has_speed_bonus && istype(user.get_inactive_held_item(), /obj/item/weapon/wristblades))
			attack_speed = initial(attack_speed) - 2
	else
		forceMove(source)
		attack_speed = initial(attack_speed)
		playsound(user, 'sound/weapons/wristblades_off.ogg', 15, TRUE)
		if(source.left_wristblades.loc == source && source.right_wristblades.loc == source)
			source.wristblades_deployed = FALSE
			source.action_wristblades.set_toggle(FALSE)

/obj/item/weapon/wristblades/dropped(mob/user)
	if(source)
		forceMove(source)
		attack_speed = initial(attack_speed)
		playsound(user, 'sound/weapons/wristblades_off.ogg', 15, TRUE)
		if(source.left_wristblades.loc == source && source.right_wristblades.loc == source)
			source.wristblades_deployed = FALSE
			source.action_wristblades.set_toggle(FALSE)
		return
	..()

/obj/item/weapon/wristblades/afterattack(atom/attacked_target, mob/user, proximity)
	if(!proximity || !user)
		return FALSE

	if(istype(attacked_target, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/door = attacked_target
		if(!door.density || door.locked)
			return FALSE
		user.visible_message(span_danger("[user] jams their [name] into [door] and strains to rip it open..."), span_danger("You jam your [name] into [door] and strain to rip it open..."))
		playsound(loc, 'sound/effects/metal_creaking.ogg', 25, TRUE)
		if(do_after(user, 3 SECONDS, NONE, door, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE) && door.density)
			user.visible_message(span_danger("[user] forces [door] open with the [name]!"), span_danger("You force [door] open with the [name]."))
			door.open(TRUE)

	else if(istype(attacked_target, /obj/structure/mineral_door/resin))
		var/obj/structure/mineral_door/resin/door = attacked_target
		if(door.switching_states || user.a_intent == INTENT_HARM)
			return
		if(door.density)
			user.visible_message(span_danger("[user] jams their [name] into [door] and strains to rip it open..."), span_danger("You jam your [name] into [door] and strain to rip it open..."))
			playsound(loc, 'sound/weapons/wristblades_hit.ogg', 15, TRUE)
			if(do_after(user, 1.5 SECONDS, NONE, door, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE) && door.density)
				user.visible_message(span_danger("[user] forces [door] open using the [name]!"), span_danger("You force [door] open with your [name]."))
				door.toggle_state()
		else
			user.visible_message(span_danger("[user] pushes [door] with their [name] to force it closed..."), span_danger("You push [door] with your [name] to force it closed..."))
			playsound(loc, 'sound/weapons/wristblades_hit.ogg', 15, TRUE)
			if(do_after(user, 2 SECONDS, NONE, door, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE) && !door.density)
				user.visible_message(span_danger("[user] forces [door] closed using the [name]!"), span_danger("You force [door] closed with your [name]."))
				door.toggle_state()

/obj/item/weapon/wristblades/attack_self(mob/living/carbon/human/user)
	..()
	if(istype(user))
		var/obj/item/clothing/gloves/yautja/hunter/gloves = user.gloves
		gloves.wristblades_internal(user, TRUE) // unlikely that the yaut would have gloves without blades, so if they do, runtime logs here would be handy

/obj/item/weapon/wristblades/scimitar
	name = "\proper wrist scimitar"
	desc = "A huge, serrated blade extending from metal gauntlets."
	icon_state = "scim"
	item_state = "scim"
	attack_speed = 5
	penetration = 15
	attack_verb = list("sliced", "slashed", "jabbed", "torn", "gored")
	force = 32
