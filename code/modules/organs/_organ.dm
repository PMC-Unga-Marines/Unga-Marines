/datum/internal_organ
	var/name = "organ"
	/// Reference to the mob owning the organs
	var/mob/living/carbon/human/owner = null
	/// Reference to the limb we're inside of
	var/datum/limb/parent_limb = BODY_ZONE_CHEST
	/// amount of damage to the organ
	var/damage = 0
	/// amount of damage after which the organ gets bruised flag
	var/min_bruised_damage = 10
	/// amount of damage after which the organ gets broken flag
	var/min_broken_damage = 30
	/// State of the organ
	var/organ_status = ORGAN_HEALTHY
	/// What slot does it go in?
	var/slot
	/// Will peri affect this organ? Thus ignores eyes, ears and brain
	var/peri_effect = FALSE
	///The effects when this limb is damaged. Used by health analyzers.
	var/damage_description

//This is used in the create_organs() which transfers human datums to organs
/datum/internal_organ/New(mob/living/carbon/carbon_mob)
	. = ..()
	if(!istype(carbon_mob))
		return

	carbon_mob.internal_organs |= src
	owner = carbon_mob
	RegisterSignal(owner, COMSIG_QDELETING, PROC_REF(clean_owner))

	if(!ishuman(carbon_mob))
		return
	var/mob/living/carbon/human/human = carbon_mob
	var/datum/limb/limb = human.get_limb(parent_limb)
	LAZYOR(limb.internal_organs, src)

/datum/internal_organ/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	return ..()

///Signal handler to prevent hard del
/datum/internal_organ/proc/clean_owner()
	SIGNAL_HANDLER
	owner = null

/datum/internal_organ/proc/take_damage(amount, silent = FALSE)
	if(amount <= 0)
		heal_organ_damage(-amount)
		return
	damage += amount

	var/datum/limb/parent = owner.get_limb(parent_limb)
	if(!silent)
		owner.custom_pain("Something inside your [parent.display_name] hurts a lot.", 1)
	set_organ_status()

/datum/internal_organ/proc/heal_organ_damage(amount)
	damage = max(damage - amount, 0)
	set_organ_status()

/// Set the correct organ state
/datum/internal_organ/proc/set_organ_status()
	if(owner.reagents.get_reagent_amount(/datum/reagent/medicine/peridaxon) >= 0.1 && peri_effect) //0.1 just in case
		if(organ_status != ORGAN_HEALTHY)
			organ_status = ORGAN_HEALTHY
			return TRUE
		return FALSE
	else if(damage > min_broken_damage)
		if(organ_status != ORGAN_BROKEN)
			organ_status = ORGAN_BROKEN
			return TRUE
		return FALSE
	else if(damage > min_bruised_damage)
		if(organ_status != ORGAN_BRUISED)
			organ_status = ORGAN_BRUISED
			return TRUE
		return FALSE
	else if(organ_status != ORGAN_HEALTHY)
		organ_status = ORGAN_HEALTHY
		return TRUE
