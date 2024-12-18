/obj/item/implanter/implantator
	name = "Skill"
	desc = "Used to implant occupants with skill implants."
	icon = 'icons/obj/items/implants.dmi'
	icon_state = "skill"
	item_state = "syringe_0"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_right.dmi',
	)
	throw_speed = 1
	throw_range = 5
	var/empty_icon = "skill"
	var/max_skills
	var/allowed_limbs

/obj/item/implanter/implantator/Initialize(mapload, ...)
	. = ..()
	name += " implanter"

/obj/item/implanter/implantator/examine(mob/user, distance, infix, suffix)
	. = ..()
	if(isnull(internal_implant))
		return
	var/obj/item/implant/skill/implant = internal_implant
	for(var/skill in implant.max_skills)
		if(user.skills.getRating(skill) < implant.max_skills[skill])
			. += "You can increase your knowleadge to [implant.max_skills[skill]] level"
		else
			. += "You know everything about this, you can't learn more... But you can gift it..."

/obj/item/implanter/implantator/update_icon_state()
	icon_state = "[internal_implant ? "[icon_state]" : "[empty_icon]_s"]"

/obj/item/implanter/implantator/can_implant(mob/target, mob/user)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/human = target
	if(!(user.zone_selected in allowed_limbs))
		balloon_alert(user, "Wrong limb!")
		return FALSE
	var/datum/limb/targetlimb = human.get_limb(user.zone_selected)
	for(var/obj/item/implant/skill/implant in targetlimb.implants)
		if(!istype(implant, /obj/item/implant/skill))
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

/obj/item/implanter/implantator/cargo/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/implant/skill))
		var/obj/item/implant/skill/skill = I
		if(icon_state == "cargo_full_s")
			balloon_alert(user, "Implantator already used!")
			return
		allowed_limbs = skill.allowed_limbs
		internal_implant = skill
		skill.forceMove(src)
		icon_state = "cargo_full"
		return

/obj/item/implanter/implantator/cargo
	icon_state = "cargo"
	empty_icon = "cargo_full"
	internal_implant = null
