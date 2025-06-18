/obj/item/implant/skill/combat
	name = "Combat implant"
	desc = "An implant from a line of implants that enhances combat skills"
	icon_state = "combat_implant"
	allowed_limbs = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)

/obj/item/implant/skill/combat/firearms
	name = "aiming support implant system"
	desc = "Integrated aiming support system! Update weapons skills!"
	firearms = 1
	max_skills = list(SKILL_FIREARMS = SKILL_FIREARMS_TRAINED)

/obj/item/implant/skill/combat/melee
	name = "close combat codex implant system"
	desc = "Integrated hit support system! Update melee skills!"
	melee_weapons = 1
	max_skills = list(SKILL_MELEE_WEAPONS = SKILL_MELEE_TRAINED)

/obj/item/implant/skill/codex
	name = "CODEX implant"
	desc = "Implant from a line of implants that increases basic knowledge"
	icon_state = "support_implant"
	allowed_limbs = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)

/obj/item/implant/skill/codex/medical
	name = "medtech implant system"
	desc = "A compact device that electro-shakes you every time you apply bandages counterclockwise, right next to your heart! Update medical skills!"
	medical = 1
	max_skills = list(SKILL_MEDICAL = SKILL_MEDICAL_COMPETENT)

/obj/item/implant/skill/codex/surgery
	name = "surgery assisting system"
	desc = "Compensates for hand trembling from Parkinson's syndrome, thanks to the reliable suspension of the shoulder joints! Update surgery skills!"
	surgery = 1
	max_skills = list(SKILL_SURGERY = SKILL_SURGERY_PROFESSIONAL)

/obj/item/implant/skill/codex/engineer
	name = "engineering implants system"
	desc = "Working with welding has become much easier! Update engineering skills!"
	engineer = 1
	max_skills = list(SKILL_ENGINEER = SKILL_ENGINEER_EXPERT)

/obj/item/implant/skill/codex/construct
	name = "construct implants system"
	desc = "Working with welding has become much easier! Update construct skills!"
	construction = 1
	max_skills = list(SKILL_CONSTRUCTION = SKILL_CONSTRUCTION_EXPERT)

/obj/item/implant/skill/tactical
	name = "Tactics implant"
	desc = "An implant from the line of implants that increases knowledge of battle tactics"
	icon_state = "skill_implant"
	allowed_limbs = list(BODY_ZONE_HEAD)

/obj/item/implant/skill/tactical/leadership
	name = "command protocols 'Graiyor' codex"
	desc = "Uploading knowledge of advanced mnemonics of inspiration and persuasion to the brain so that people around go under bullets even more willingly! Update leadership skills!"
	icon_state = "leadership_implant"
	leadership = 1
	max_skills = list(SKILL_LEADERSHIP = SKILL_LEAD_SUPER)
