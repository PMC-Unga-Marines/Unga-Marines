/obj/item/implanter/skill
	name = "skill implanter"
	desc = "A sterile implant injector, that is usually used to implant skill increasing implants."
	icon_state = "skill"
	///Empty icon state
	var/empty_icon = "skill_s"

/obj/item/implanter/skill/examine(mob/user, distance, infix, suffix)
	. = ..()
	if(isnull(internal_implant))
		return
	var/obj/item/implant/skill/implant = internal_implant
	for(var/skill AS in implant.max_skills)
		. += span_notice("It will increase your skills only up to the [implant.max_skills[skill]] level.")

/obj/item/implanter/skill/update_icon_state()
	icon_state = internal_implant ? icon_state : empty_icon

/obj/item/implanter/skill/can_implant(mob/target, mob/user)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/human = target
	if(!(user.zone_selected in internal_implant.allowed_limbs))
		balloon_alert(user, "Wrong limb!")
		return FALSE
	var/datum/limb/targetlimb = human.get_limb(user.zone_selected)
	for(var/obj/item/implant/skill/implant in targetlimb.implants)
		if(!istype(implant, /obj/item/implant/skill))
			balloon_alert(user, "Limb already implanted!")
			return FALSE
	return TRUE

/obj/item/implanter/skill/cargo
	name = "cargo skill implanter"
	desc = "A sterile implant injector. This one is used for implanting rogue skill implants and can be used only once."
	icon_state = "cargo"
	empty_icon = "cargo_full_s"
	/// Was implanter already spent?
	var/spent = FALSE
