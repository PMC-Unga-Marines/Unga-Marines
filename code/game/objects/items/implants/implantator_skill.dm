/obj/item/implantator
	name = "skill" //teeeeest.
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
	w_class = WEIGHT_CLASS_TINY
	var/obj/item/implant/internal_implant = /obj/item/implant/skill
	var/allowed_limbs

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
	if(!ishuman(target))
		return FALSE
	if(!internal_implant)
		to_chat(user, span_warning("There is no implant in the [src]! НЕТ ИМПЛАНТА"))
		return FALSE
	if(!(user.zone_selected in allowed_limbs))
		return FALSE
	user.visible_message(span_warning("[user] is attemping to implant [target]."), span_notice("You're attemping to implant [target]."))
	if(!do_after(user, 5 SECONDS, NONE, target, BUSY_ICON_GENERIC) || !internal_implant)
		to_chat(user, span_notice("You failed to implant [target]."))
		return FALSE
	if(internal_implant.try_implant(target, user))
		target.visible_message(span_warning("[target] has been implanted by [user]."))
		log_combat(user, target, "implanted", src)
		internal_implant = null
		icon_state = "skill0"
		return TRUE
	to_chat(user, span_notice("You fail to implant [target]. НИЧЕГО НЕ ПРОИЗОШЛО"))
	return

//////////////////////////////[IMPLANTERS]//////////////////////////////

//////////////////////////////[COMBAT]//////////////////////////////

/obj/item/implantator/combat
	allowed_limbs = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
	internal_implant = /obj/item/implant/skill/combat

/obj/item/implantator/combat/firearms
	name = "aiming support"
	icon_state = "weapon1"
	internal_implant = /obj/item/implant/skill/combat/firearms

/obj/item/implantator/combat/melee
	name = "close combat codex"
	icon_state = "melee1"
	internal_implant = /obj/item/implant/skill/combat/melee

//////////////////////////////[SUPPORT]//////////////////////////////

/obj/item/implantator/codex
	allowed_limbs = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)
	internal_implant = /obj/item/implant/skill/codex

/obj/item/implantator/codex/medical
	name = "medtech"
	icon_state = "medical1"
	internal_implant = /obj/item/implant/skill/codex/medical

/obj/item/implantator/codex/surgery
	name = "surgery assisting system"
	icon_state = "surgery1"
	internal_implant = /obj/item/implant/skill/codex/surgery

/obj/item/implantator/codex/engineer
	name = "construction support system"
	icon_state = "enginering1"
	internal_implant = /obj/item/implant/skill/codex/engineer

//////////////////////////////[SPECIAL]//////////////////////////////

/obj/item/implantator/oper_system
	allowed_limbs = list(BODY_ZONE_HEAD)
	internal_implant = /obj/item/implant/skill/oper_system

/obj/item/implantator/leadership
	name = "command protocols 'Graiyor' codex"
	icon_state = "leadership1"
	internal_implant = /obj/item/implant/skill/oper_system/leadership
