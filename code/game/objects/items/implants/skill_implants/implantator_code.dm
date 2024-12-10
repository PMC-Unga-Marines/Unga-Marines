/obj/item/implanter/implantator
	name = "skill"
	desc = "Used to implant occupants with skill implants."
	icon = 'icons/obj/items/implants.dmi'
	icon_state = "skill"
	var/empty_icon = "skill"
	item_state = "syringe_0"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_right.dmi',
	)
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	var/max_skills
	var/allowed_limbs

/obj/item/implanter/implantator/Initialize(mapload, ...)
	. = ..()
	name = name + " implanter"

/obj/item/implanter/Destroy()
	return ..()

/obj/item/implanter/update_icon_state()
	return

/obj/item/implanter/implantator/attack(mob/target, mob/living/user)
	. = ..()
	if(.)
		name += " used"
		icon_state = empty_icon + "_s"
		return TRUE
	return

/obj/item/implanter/implantator/can_implant(mob/target, mob/user)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/human = target
	if(!(user.zone_selected in allowed_limbs))
		balloon_alert(user, "Wrong limb!")
		return FALSE
	var/datum/limb/targetlimb = human.get_limb(user.zone_selected)
	for (var/obj/item/implant/skill/implant in targetlimb.implants)
		if(!is_type_in_list(implant, /obj/item/implant/skill))
			balloon_alert(user, "Limb already implanted!")
			return FALSE
	return TRUE

/obj/item/implanter/implantator/combat
	allowed_limbs = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
	internal_implant = /obj/item/implant/skill/combat

/obj/item/implanter/implantator/codex
	allowed_limbs = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)
	internal_implant = /obj/item/implant/skill/codex

/obj/item/implanter/implantator/oper_system
	allowed_limbs = list(BODY_ZONE_HEAD)
	internal_implant = /obj/item/implant/skill/oper_system
