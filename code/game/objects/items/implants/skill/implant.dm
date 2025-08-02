/obj/item/implant/skill
	implant_flags = BENEFICIAL_IMPLANT|HIGHLANDER_IMPLANT
	w_class = WEIGHT_CLASS_TINY
	/// Maximum skill a user can possess
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
		if(target.skills.getRating(skill) >= max_skills[skill])
			balloon_alert(user, "Nothing to learn!")
			return FALSE
	return TRUE

/obj/item/implant/skill/implant(mob/living/carbon/human/target, mob/living/user)
	. = ..()
	if(!.)
		return
	target.set_skills(target.skills.modifyRating(cqc, melee_weapons, firearms, pistols, shotguns, rifles, smgs, heavy_weapons, smartgun,\
	engineer, construction, leadership, medical, surgery, pilot, police, powerloader, large_vehicle, mech_pilot, stamina))
	return TRUE

/obj/item/implant/skill/unimplant()
	if(!implanted)
		return FALSE
	implant_owner.set_skills(implant_owner.skills.modifyRating(-cqc, -melee_weapons, -firearms, -pistols, -shotguns, -rifles, -smgs, -heavy_weapons, -smartgun,\
	-engineer, -construction, -leadership, -medical, -surgery, -pilot, -police, -powerloader, -large_vehicle, -mech_pilot, -stamina))
	return ..()

/obj/item/implant/skill/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/implanter/skill/cargo))
		var/obj/item/implanter/skill/cargo/implanter = I
		if(implanter.spent)
			balloon_alert(user, "Already spent!")
			return
		forceMove(implanter)
		implanter.internal_implant = src
		implanter.icon_state = "cargo_full"
		implanter.spent = TRUE
