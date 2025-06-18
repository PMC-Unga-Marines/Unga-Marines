#define SKILLSID "skills-[cqc]-[melee_weapons]\
-[firearms]-[pistols]-[shotguns]-[rifles]-[smgs]-[heavy_weapons]-[smartgun]\
-[engineer]-[construction]-[leadership]-[medical]-[surgery]-[pilot]-[police]-[powerloader]-[large_vehicle]-[mech_pilot]-[stamina]"

#define SKILLSIDSRC(S) "skills-[S.cqc]-[S.melee_weapons]\
-[S.firearms]-[S.pistols]-[S.shotguns]-[S.rifles]-[S.smgs]-[S.heavy_weapons]-[S.smartgun]\
-[S.engineer]-[S.construction]-[S.leadership]-[S.medical]-[S.surgery]-[S.pilot]-[S.police]-[S.powerloader]-[S.large_vehicle]-[mech_pilot]-[S.stamina]"

/proc/getSkills(
	cqc = 0,
	melee_weapons = 0,
	firearms = 0,
	pistols = 0,
	shotguns = 0,
	rifles = 0,
	smgs = 0,
	heavy_weapons = 0,
	smartgun = 0,
	engineer = 0,
	construction = 0,
	leadership = 0,
	medical = 0,
	surgery = 0,
	pilot = 0,
	police = 0,
	powerloader = 0,
	large_vehicle = 0,
	mech_pilot = 0,
	stamina = 0,
)
	. = locate(SKILLSID)
	if(.)
		return
	. = new /datum/skills(
		cqc,
		melee_weapons,
		firearms,
		pistols,
		shotguns,
		rifles,
		smgs,
		heavy_weapons,
		smartgun,
		engineer,
		construction,
		leadership,
		medical,
		surgery,
		pilot,
		police,
		powerloader,
		large_vehicle,
		mech_pilot,
		stamina,
	)

/proc/getSkillsType(skills_type = /datum/skills)
	var/datum/skills/new_skill = skills_type
	var/cqc = initial(new_skill.cqc)
	var/melee_weapons = initial(new_skill.melee_weapons)
	var/firearms = initial(new_skill.firearms)
	var/pistols = initial(new_skill.pistols)
	var/shotguns = initial(new_skill.shotguns)
	var/rifles = initial(new_skill.rifles)
	var/smgs = initial(new_skill.smgs)
	var/heavy_weapons = initial(new_skill.heavy_weapons)
	var/smartgun = initial(new_skill.smartgun)
	var/engineer = initial(new_skill.engineer)
	var/construction = initial(new_skill.construction)
	var/leadership = initial(new_skill.leadership)
	var/medical = initial(new_skill.medical)
	var/surgery = initial(new_skill.surgery)
	var/pilot = initial(new_skill.pilot)
	var/police = initial(new_skill.police)
	var/powerloader = initial(new_skill.powerloader)
	var/large_vehicle = initial(new_skill.large_vehicle)
	var/mech_pilot = initial(new_skill.mech_pilot)
	var/stamina = initial(new_skill.stamina)
	. = locate(SKILLSID)
	if(!.)
		. = new skills_type

/datum/skills
	datum_flags = DF_USE_TAG
	var/name = "Default/Custom"
	var/cqc = SKILL_CQC_DEFAULT
	var/melee_weapons = SKILL_MELEE_DEFAULT

	var/firearms = SKILL_FIREARMS_DEFAULT
	var/pistols = SKILL_PISTOLS_DEFAULT
	var/shotguns = SKILL_SHOTGUNS_DEFAULT
	var/rifles = SKILL_RIFLES_DEFAULT
	var/smgs = SKILL_SMGS_DEFAULT
	var/heavy_weapons = SKILL_HEAVY_WEAPONS_DEFAULT
	var/smartgun = SKILL_SMART_DEFAULT

	var/engineer = SKILL_ENGINEER_DEFAULT
	var/construction = SKILL_CONSTRUCTION_DEFAULT
	var/leadership = SKILL_LEAD_NOVICE
	var/medical = SKILL_MEDICAL_UNTRAINED
	var/surgery = SKILL_SURGERY_DEFAULT
	var/pilot = SKILL_PILOT_DEFAULT
	var/police = SKILL_POLICE_DEFAULT
	var/powerloader = SKILL_POWERLOADER_DEFAULT
	var/large_vehicle = SKILL_LARGE_VEHICLE_DEFAULT
	/// Effects if you are able to pilot the mech
	var/mech_pilot = SKILL_MECH_PILOT_DEFAULT
	/// Effects stamina regen rate and regen delay
	var/stamina = SKILL_STAMINA_DEFAULT

/datum/skills/New(
	cqc,
	melee_weapons,
	firearms,
	pistols,
	shotguns,
	rifles,
	smgs,
	heavy_weapons,
	smartgun,
	engineer,
	construction,
	leadership,
	medical,
	surgery,
	pilot,
	police,
	powerloader,
	large_vehicle,
	mech_pilot,
	stamina,
)
	if(!isnull(cqc))
		src.cqc = cqc
	if(!isnull(melee_weapons))
		src.melee_weapons = melee_weapons
	if(!isnull(firearms))
		src.firearms = firearms
	if(!isnull(pistols))
		src.pistols = pistols
	if(!isnull(shotguns))
		src.shotguns = shotguns
	if(!isnull(rifles))
		src.rifles = rifles
	if(!isnull(smgs))
		src.smgs = smgs
	if(!isnull(heavy_weapons))
		src.heavy_weapons = heavy_weapons
	if(!isnull(smartgun))
		src.smartgun = smartgun
	if(!isnull(engineer))
		src.engineer = engineer
	if(!isnull(construction))
		src.construction = construction
	if(!isnull(leadership))
		src.leadership = leadership
	if(!isnull(medical))
		src.medical = medical
	if(!isnull(surgery))
		src.surgery = surgery
	if(!isnull(pilot))
		src.pilot = pilot
	if(!isnull(police))
		src.police = police
	if(!isnull(powerloader))
		src.powerloader = powerloader
	if(!isnull(large_vehicle))
		src.large_vehicle = large_vehicle
	if(!isnull(mech_pilot))
		src.mech_pilot = mech_pilot
	if(!isnull(stamina))
		src.stamina = stamina
	tag = SKILLSIDSRC(src)

/// returns/gets a new skills datum with values changed according to the args passed
/datum/skills/proc/modifyRating(
	cqc,
	melee_weapons,
	firearms,
	pistols,
	shotguns,
	rifles,
	smgs,
	heavy_weapons,
	smartgun,
	engineer,
	construction,
	leadership,
	medical,
	surgery,
	pilot,
	police,
	powerloader,
	large_vehicle,
	mech_pilot,
	stamina,
)
	return getSkills(
		src.cqc + cqc,
		src.melee_weapons + melee_weapons,
		src.firearms + firearms,
		src.pistols + pistols,
		src.shotguns + shotguns,
		src.rifles + rifles,
		src.smgs + smgs,
		src.heavy_weapons + heavy_weapons,
		src.smartgun + smartgun,
		src.engineer + engineer,
		src.construction + construction,
		src.leadership + leadership,
		src.medical + medical,
		src.surgery + surgery,
		src.pilot  +  pilot,
		src.police  +  police,
		src.powerloader+powerloader,
		src.large_vehicle + large_vehicle,
		src.mech_pilot + mech_pilot,
		src.stamina + stamina,
	)

/// acts as [/proc/modifyRating] but instead modifies all values rather than several specific ones
/datum/skills/proc/modifyAllRatings(difference)
	return getSkills(
		cqc + difference,
		melee_weapons + difference,
		firearms + difference,
		pistols + difference,
		shotguns + difference,
		rifles  +  difference,
		smgs + difference,
		heavy_weapons + difference,
		smartgun + difference,
		engineer + difference,
		construction + difference,
		leadership + difference,
		medical + difference,
		surgery + difference,
		pilot + difference,
		police + difference,
		powerloader + difference,
		large_vehicle + difference,
		mech_pilot + difference,
		stamina + difference,
	)

/// acts as [/proc/modifyRating] but sets the rating directly rather than modify it
/datum/skills/proc/setRating(
	cqc,
	melee_weapons,
	firearms,
	pistols,
	shotguns,
	rifles,
	smgs,
	heavy_weapons,
	smartgun,
	engineer,
	construction,
	leadership,
	medical,
	surgery,
	pilot,
	police,
	powerloader,
	large_vehicle,
	mech_pilot,
	stamina,
)
	return getSkills(
		(isnull(cqc) ? src.cqc : cqc),
		(isnull(melee_weapons) ? src.melee_weapons : melee_weapons),
		(isnull(firearms) ? src.firearms : firearms),
		(isnull(pistols) ? src.pistols : pistols),
		(isnull(shotguns) ? src.shotguns : shotguns),
		(isnull(rifles) ? src.rifles : rifles),
		(isnull(smgs) ? src.smgs : smgs),
		(isnull(heavy_weapons) ? src.heavy_weapons : heavy_weapons),
		(isnull(smartgun) ? src.smartgun : smartgun),
		(isnull(engineer) ? src.engineer : engineer),
		(isnull(construction) ? src.construction : construction),
		(isnull(leadership) ? src.leadership : leadership),
		(isnull(medical) ? src.medical : medical),
		(isnull(surgery) ? src.surgery : surgery),
		(isnull(pilot) ? src.pilot : pilot),
		(isnull(police) ? src.police : police),
		(isnull(powerloader) ? src.powerloader : powerloader),
		(isnull(large_vehicle) ? src.large_vehicle : large_vehicle),
		(isnull(mech_pilot) ? src.mech_pilot : mech_pilot),
		(isnull(stamina) ? src.stamina : stamina),
	)

/datum/skills/vv_edit_var(var_name, var_value)
	if(var_name == NAMEOF(src, tag))
		return FALSE
	. = ..()
	tag = SKILLSID

#undef SKILLSID
#undef SKILLSIDSRC

///returns how many % of skills the user has of max_rating. rating should be a SKILL_X define
/datum/skills/proc/getPercent(rating, max_rating)
	return CLAMP01(max(vars[rating], 0) * 100 / max_rating * 0.01)

/// returns number value of the skill rating. rating should be a SKILL_X define
/datum/skills/proc/getRating(rating)
	return vars[rating]

/// returns an assoc list (SKILL_X = VALUE) of all skills for this skill datum
/datum/skills/proc/getList()
	return list(
		SKILL_CQC = cqc,
		SKILL_MELEE_WEAPONS = melee_weapons,
		SKILL_FIREARMS = firearms,
		SKILL_PISTOLS = pistols,
		SKILL_SHOTGUNS = shotguns,
		SKILL_RIFLES = rifles,
		SKILL_SMGS = smgs,
		SKILL_HEAVY_WEAPONS = heavy_weapons,
		SKILL_SMARTGUN = smartgun,
		SKILL_ENGINEER = engineer,
		SKILL_CONSTRUCTION = construction,
		SKILL_LEADERSHIP = leadership,
		SKILL_MEDICAL = medical,
		SKILL_SURGERY = surgery,
		SKILL_PILOT = pilot,
		SKILL_POLICE = police,
		SKILL_POWERLOADER = powerloader,
		SKILL_LARGE_VEHICLE = large_vehicle,
		SKILL_MECH_PILOT = mech_pilot,
		SKILL_STAMINA = stamina,
	)
