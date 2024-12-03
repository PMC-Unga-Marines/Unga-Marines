/obj/item/implant/skill/combat/firearms
	name = "aiming support"
	desc = "integrated aiming support system! Update weapons skills!"
	firearms = 1
	max_skills = list(SKILL_FIREARMS = SKILL_FIREARMS_TRAINED)

/obj/item/implant/skill/combat/melee
	name = "close combat codex"
	desc = "integrated hit support system! Update melee skills!"
	melee_weapons = 2
	max_skills = list(SKILL_MELEE_WEAPONS = SKILL_MELEE_SUPER)

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

/obj/item/implant/skill/oper_system/leadership
	name = "command protocols 'Graiyor' codex"
	desc = "uploading knowledge of advanced mnemonics of inspiration and persuasion to the brain so that people around go under bullets even more willingly! Update leadership skills!"
	icon_state = "leadership_implant"
	leadership = 1
	max_skills = list(SKILL_LEAD = SKILL_LEAD_MASTER)

/obj/item/implant/skill/oper_system/leadership/delux
	name = "delux command protocols 'Graiyor' codex"
	desc = "uploading advanced knowledge of futuristic mnemonics of inspiration and persuasion to the brain so that people around go under bullets even more willingly! Update leadership skills even more!"
	icon_state = "deluxleadership_implant"
	leadership = 2
	max_skills = list(SKILL_LEAD = SKILL_LEAD_SUPER)
