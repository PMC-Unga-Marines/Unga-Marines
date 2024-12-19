/obj/item/implant/skill
	flags_implant = BENEFICIAL_IMPLANT|HIGHLANDER_IMPLANT
	w_class = WEIGHT_CLASS_TINY
//  Maximum skill a user can possess
	var/list/max_skills
//vars for update skills
	var/cqc
	var/melee_weapons
	var/firearms
	var/pistols
	var/shotguns
	var/rifles
	var/smgs
	var/heavy_weapons
	var/swordplay
	var/smartgun
	var/engineer
	var/construction
	var/leadership
	var/medical
	var/surgery
	var/pilot
	var/police
	var/powerloader
	var/large_vehicle
	var/mech_pilot
	var/stamina

/obj/item/implant/skill/try_implant(mob/living/carbon/human/target, mob/living/user)
	. = ..()
	if(!.)
		return
	for(var/skill in max_skills)
		if(user.skills.getRating(skill) >= max_skills[skill])
			balloon_alert(user, "Nothing to learn!")
			return FALSE
	return TRUE

/obj/item/implant/skill/implant(mob/living/carbon/human/target, mob/living/user)
	. = ..()
	if(!.)
		return
	target.set_skills(target.skills.modifyRating(cqc, melee_weapons, firearms, pistols, shotguns, rifles, smgs, heavy_weapons, swordplay, smartgun,\
	engineer, construction, leadership, medical, surgery, pilot, police, powerloader, large_vehicle, mech_pilot, stamina))
	return TRUE

/obj/item/implant/skill/unimplant()
	if(!implanted)
		return FALSE
	implant_owner.set_skills(implant_owner.skills.modifyRating(-cqc, -melee_weapons, -firearms, -pistols, -shotguns, -rifles, -smgs, -heavy_weapons, -swordplay, -smartgun,\
	-engineer, -construction, -leadership, -medical, -surgery, -pilot, -police, -powerloader, -large_vehicle, -mech_pilot, -stamina))
	return ..()

/obj/item/implant/skill/combat
	name = "Сombat implants"
	desc = "An implant from a line of implants that enhances combat skills"
	icon_state = "combat_implant"
	allowed_limbs = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)

/obj/item/implant/skill/codex
	name = "CODEX implants"
	desc = "Implant from a line of implants that increases basic knowledge"
	icon_state = "support_implant"
	allowed_limbs = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)

/obj/item/implant/skill/oper_system
	name = "Tactics implants"
	desc = "An implant from the line of implants that increases knowledge of battle tactics"
	icon_state = "skill_implant"
	allowed_limbs = list(BODY_ZONE_HEAD)

/obj/item/implant/skill/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/implanter/implantator/cargo))
		var/obj/item/implanter/implantator/cargo/cargo = I
		if(cargo.icon_state == "cargo_full_s")
			balloon_alert(user, "Implantator already used!")
			return
		cargo.allowed_limbs = allowed_limbs
		cargo.internal_implant = src
		src.forceMove(cargo)
		cargo.icon_state = "cargo_full"
