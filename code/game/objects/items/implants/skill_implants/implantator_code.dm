/obj/item/implantator
	name = "skill" //teeeeest.
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
	var/obj/item/implant/internal_implant = /obj/item/implant/skill
	var/allowed_limbs
	var/spented = FALSE
	var/max_skills

/obj/item/implantator/Initialize(mapload, ...)
	. = ..()
	name = name + " implanter"
	desc = internal_implant.desc
	if(internal_implant)
		internal_implant = new internal_implant(src)
	if(!allowed_limbs)
		allowed_limbs = GLOB.human_body_parts

/obj/item/implantator/Destroy()
	QDEL_NULL(internal_implant)
	return ..()

/obj/item/implantator/examine(mob/user, distance, infix, suffix)
	. = ..()
	. += "it contains [internal_implant ? "a [internal_implant.name]" : "no implant"]!"

/obj/item/implantator/attack(mob/target, mob/user)
	. = ..()
	if(spented == TRUE)
		return FALSE
	if(!ishuman(target))
		return FALSE
	if(!internal_implant)
		to_chat(user, span_warning("There is no implant in the [src]!"))
		return FALSE
	if(!(user.zone_selected in allowed_limbs))
		balloon_alert(user, "wrong limb!")
		return FALSE
	for(var/skill in max_skills)
		if(user.skills.getRating(skill) >= max_skills[skill])
			to_chat(user, span_warning("You already know [skill]!"))
			return FALSE
	user.visible_message(span_warning("[user] is attemping to implant [target]."), span_notice("You're attemping to implant [target]."))
	if(!do_after(user, 5 SECONDS, NONE, target, BUSY_ICON_GENERIC))
		to_chat(user, span_notice("You failed to implant [target]."))
		return FALSE
	if(internal_implant.try_implant(target, user))
		target.visible_message(span_warning("[target] has been implanted by [user]."))
		log_combat(user, target, "implanted", src)
		internal_implant = null
		name = name + "used"
		desc = desc + "It's spent."
		icon_state = empty_icon + "_s"
		spented = TRUE
		return TRUE
	to_chat(user, span_notice("You fail to implant [target]."))
	return

/obj/item/implantator/combat
	allowed_limbs = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
	internal_implant = /obj/item/implant/skill/combat

/obj/item/implantator/codex
	allowed_limbs = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)
	internal_implant = /obj/item/implant/skill/codex

/obj/item/implantator/oper_system
	allowed_limbs = list(BODY_ZONE_HEAD)
	internal_implant = /obj/item/implant/skill/oper_system
