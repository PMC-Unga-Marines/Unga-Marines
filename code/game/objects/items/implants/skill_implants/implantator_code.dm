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
	var/list/implants

/obj/item/implanter/implantator/Initialize(mapload, ...)
	. = ..()

/obj/item/implanter/implantator/Destroy()
	return ..()

/obj/item/implanter/update_icon_state()
	return

/obj/item/implanter/implantator/attack(mob/living/target, mob/living/user, list/implants, datum/limb/targetlimb, var/obj/item/implant/skill/i)
	. = ..()

/obj/item/implanter/implantator/combat
	internal_implant = /obj/item/implant/skill/combat

/obj/item/implanter/implantator/codex
	internal_implant = /obj/item/implant/skill/codex

/obj/item/implanter/implantator/oper_system
	internal_implant = /obj/item/implant/skill/oper_system
