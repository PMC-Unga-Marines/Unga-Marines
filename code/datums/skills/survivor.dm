/datum/skills/civilian
	name = "Civilian"
	cqc = SKILL_CQC_WEAK
	firearms = SKILL_FIREARMS_UNTRAINED
	melee_weapons = SKILL_MELEE_WEAK

/datum/skills/civilian/survivor
	name = "Survivor"
	cqc = SKILL_CQC_DEFAULT
	melee_weapons = SKILL_MELEE_DEFAULT
	engineer = SKILL_ENGINEER_ENGI //to hack airlocks so they're never stuck in a room.
	firearms = SKILL_FIREARMS_DEFAULT
	construction = SKILL_CONSTRUCTION_METAL
	medical = SKILL_MEDICAL_NOVICE

/datum/skills/civilian/survivor/master
	name = "Survivor"
	firearms = SKILL_FIREARMS_DEFAULT
	medical = SKILL_MEDICAL_PRACTICED
	construction = SKILL_CONSTRUCTION_ADVANCED
	engineer = SKILL_ENGINEER_ENGI
	powerloader = SKILL_POWERLOADER_MASTER
	rifles = SKILL_RIFLES_TRAINED
	melee_weapons = SKILL_MELEE_TRAINED
	stamina = SKILL_STAMINA_TRAINED

/datum/skills/civilian/survivor/doctor
	name = "Survivor Doctor"
	medical = SKILL_MEDICAL_COMPETENT
	surgery = SKILL_SURGERY_EXPERT
	firearms = SKILL_FIREARMS_UNTRAINED

/datum/skills/civilian/survivor/scientist
	name = "Survivor Scientist"
	medical = SKILL_MEDICAL_PRACTICED
	surgery = SKILL_SURGERY_PROFESSIONAL
	firearms = SKILL_FIREARMS_UNTRAINED

/datum/skills/civilian/survivor/chef
	name = "Survivor Chef"
	melee_weapons = SKILL_MELEE_TRAINED
	firearms = SKILL_FIREARMS_UNTRAINED

/datum/skills/civilian/survivor/miner
	name = "Survivor Miner"
	powerloader = SKILL_POWERLOADER_TRAINED
	melee_weapons = SKILL_MELEE_TRAINED

/datum/skills/civilian/survivor/atmos
	name = "Survivor Atmos Tech"
	engineer = SKILL_ENGINEER_EXPERT
	construction = SKILL_CONSTRUCTION_EXPERT

/datum/skills/civilian/survivor/marshal
	name = "Survivor Marshal"
	cqc = SKILL_CQC_TRAINED
	firearms = SKILL_FIREARMS_DEFAULT
	melee_weapons = SKILL_MELEE_DEFAULT
	pistols = SKILL_PISTOLS_TRAINED
	police = SKILL_POLICE_MP
