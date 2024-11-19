/obj/item/implant/skill
	name = "skill" //teeeeeest.
	desc = "Hey! You dont see it!"
	icon = 'icons/obj/items/implants.dmi'
	icon_state = "implant"
	w_class = WEIGHT_CLASS_TINY
	var/list/max_skills
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

/obj/item/implant/skill/on_initialize()
	. = ..()
	name = name + " implant"

/obj/item/implant/skill/try_implant(mob/living/carbon/human/target, mob/living/user)
	if(!ishuman(target))
		return
	for(var/skill in max_skills)
		if(user.skills.getRating(skill) >= max_skills[skill])
			balloon_alert(user, "You already know it!")
			to_chat(user, span_warning("You already know it!"))
			return FALSE
		return FALSE
	if(!(user.zone_selected in allowed_limbs))
		to_chat(user, span_warning("You cannot implant this into that limb! НЕ В СПИСКЕ КОНЕЧНОСТЕЙ"))
		return FALSE
	implanted = TRUE
	return implant(target, user)

/obj/item/implant/skill/implant(mob/living/carbon/human/target, mob/living/user)
	forceMove(target)
	implant_owner = target
	implanted = TRUE
	var/limb_targeting = (user ? user.zone_selected : BODY_ZONE_CHEST)
	var/datum/limb/affected = target.get_limb(limb_targeting)
	if(!affected)
		CRASH("[src] implanted into [target] [user ? "by [user]" : ""] but had no limb, despite being set to implant in [limb_targeting].")
	affected.implants += src
	part = affected
	activation_action?.give_action(target)
	embed_into(target, limb_targeting, TRUE)
	target.set_skills(target.skills.modifyRating(cqc, melee_weapons, firearms, pistols, shotguns, rifles, smgs, heavy_weapons, swordplay, smartgun,\
	engineer, construction, leadership, medical, surgery, pilot, police, powerloader, large_vehicle, stamina))
	return TRUE

/obj/item/implant/skill/unembed_ourself()
	. = ..()
	unimplant()

/obj/item/implant/skill/unimplant()
	implanted = FALSE
	part.implants -= src
	part = null
	forceMove(get_turf(implant_owner))
	implant_owner = null

/obj/item/implant/skill/Destroy(force)
	unimplant()
	QDEL_NULL(activation_action)
	part?.implants -= src
	return ..()

//////////////////////////////[IMPLANTS]//////////////////////////////

/obj/item/implant/skill/combat
	name = "combat implants"
	desc = "Non-game"
	icon_state = "combat_implant"
	allowed_limbs = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)

/obj/item/implant/skill/combat/firearms
	name = "aiming support"
	desc = "integrated aiming support system! Update weapons skills!"
	firearms = 1
	max_skills = list(SKILL_FIREARMS = SKILL_FIREARMS_TRAINED)

/obj/item/implant/skill/combat/melee
	name = "close combat codex"
	desc = "integrated hit support system! Update melee skills!"
	melee_weapons = 1
	max_skills = list(SKILL_MELEE_WEAPONS = SKILL_MELEE_TRAINED)

/obj/item/implant/skill/codex
	name = "CODEX"
	desc = "A support skill update-shit."
	icon_state = "skill_implant"
	allowed_limbs = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)

/obj/item/implant/skill/codex/medical
	name = "medtech"
	desc = "A compact device that electro-shakes you every time you apply bandages counterclockwise, right next to your heart! Update medical skills!"
	medical = 1
	max_skills = list(SKILL_MEDICAL = SKILL_MEDICAL_COMPETENT)

/obj/item/implant/skill/codex/surgery
	name = "surgery assisting system"
	desc = "compensates for hand trembling from Parkinson's syndrome, thanks to the reliable suspension of the shoulder joints! Update surgery skills!"
	surgery = 1
	max_skills = list(SKILL_SURGERY = SKILL_SURGERY_PROFESSIONAL)

/obj/item/implant/skill/codex/engineer
	name = "construction support system"
	desc = "laying brickwork has never been easier than with this corrective endoskeleton! Update engineering skills!"
	engineer = 1
	max_skills = list(SKILL_ENGINEER = SKILL_ENGINEER_MASTER)

/obj/item/implant/skill/oper_system
	name = "HEAD SLOT!"
	desc = "All non-sorted special shit (leadership, probaly SG and more)"
	icon_state = "skill_implant"
	allowed_limbs = list(BODY_ZONE_HEAD)

/obj/item/implant/skill/oper_system/leadership
	name = "command protocols 'Graiyor' codex"
	desc = "uploading knowledge of advanced mnemonics of inspiration and persuasion to the brain so that people around go under bullets even more willingly! Update leadership skills!"
	leadership = 1
	max_skills = list(SKILL_LEAD = SKILL_LEAD_SUPER)
