/obj/item/implant/skill
	name = "skill" //teeeeeest.
	desc = "Hey! You dont see it!"
	icon = 'icons/obj/items/implants.dmi'
	icon_state = "implant"
	w_class = WEIGHT_CLASS_TINY
	var/list/max_skills
	var/storage_skill = null
//pamplet copy-past. :clueless:
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
	var/stamina

/obj/item/implant/skill/Initialize()
	. = ..()
	name = name + " implant"

/obj/item/implant/Destroy(force)
	unimplant()
	QDEL_NULL(activation_action)
	part?.implants -= src
	return ..()

/obj/item/implant/skill/try_implant(mob/living/carbon/human/target, mob/living/user)
	. = ..()

/obj/item/implant/skill/implant(mob/living/carbon/human/target, mob/living/user)
	for(var/skill in max_skills)
		if(user.skills.getRating(skill) >= max_skills[skill])
			balloon_alert(user, "Nothing to learn!")
			return
	. = ..()
	if(!.)
		return
	target.set_skills(target.skills.modifyRating(cqc, melee_weapons, firearms, pistols, shotguns, rifles, smgs, heavy_weapons, swordplay, smartgun,\
	engineer, construction, leadership, medical, surgery, pilot, police, powerloader, large_vehicle, stamina))
	return TRUE

/obj/item/implant/skill/unimplant()
	if(!implanted)
		return FALSE
	implant_owner.set_skills(implant_owner.skills.modifyRating(-cqc, -melee_weapons, -firearms, -pistols, -shotguns, -rifles, -smgs, -heavy_weapons, -swordplay, -smartgun,\
	-engineer, -construction, -leadership, -medical, -surgery, -pilot, -police, -powerloader, -large_vehicle, -stamina))
	. = ..()

/obj/item/implant/skill/combat
	name = "combat implants"
	desc = ""
	icon_state = "combat_implant"
	allowed_limbs = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)

/obj/item/implant/skill/codex
	name = "CODEX"
	desc = ""
	icon_state = "support_implant"
	allowed_limbs = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)

/obj/item/implant/skill/oper_system
	name = "HEAD SLOT!"
	desc = ""
	icon_state = "skill_implant"
	allowed_limbs = list(BODY_ZONE_HEAD)
