// This is not set to vital because death immediately occurs in blood.dm if it is removed. Also, all damage effects are handled there.
/obj/item/organ/heart
	name = "heart"
	icon_state = "heart-on"
	slot = ORGAN_SLOT_HEART
	peri_effect = TRUE

/obj/item/organ/heart/process()
	if(organ_status == ORGAN_BRUISED && prob(5))
		owner.emote("me", 1, "grabs at [owner.p_their()] chest!")
	else if(organ_status == ORGAN_BROKEN && prob(20))
		owner.emote("me", 1, "clutches [owner.p_their()] chest!")

/obj/item/organ/heart/set_organ_status()
	var/old_organ_status = organ_status
	. = ..()
	if(!.)
		return
	owner.max_stamina_buffer += (old_organ_status - organ_status) * 25
	owner.maxHealth += (old_organ_status - organ_status) * 20

/obj/item/organ/lungs
	name = "lungs"
	icon_state = "lungs"
	gender = PLURAL
	slot = ORGAN_SLOT_LUNGS
	peri_effect = TRUE

/obj/item/organ/lungs/process()
	if((organ_status == ORGAN_BRUISED && prob(5)) || (organ_status == ORGAN_BROKEN && prob(20)))
		owner.emote("me", 1, "gasps for air!")

/obj/item/organ/lungs/set_organ_status()
	. = ..()
	if(!.)
		return
	// For example, bruised lungs will reduce stamina regen by 40%, broken by 80%
	owner.add_stamina_regen_modifier(name, organ_status * -0.40)
	// Slowdown added when the heart is damaged
	owner.add_movespeed_modifier(name, override = TRUE, multiplicative_slowdown = organ_status)

//Hits of 1 damage or less won't do anything due to how losebreath works, but any stronger and we'll get the wind knocked out of us for a bit. Mostly just flavor.
/obj/item/organ/lungs/get_damage(amount, silent = FALSE)
	owner.adjust_Losebreath(amount)
	return ..()

/obj/item/organ/kidneys
	name = "kidneys"
	icon_state = "kidneys"
	gender = PLURAL
	slot = ORGAN_SLOT_KIDNEYS
	parent_limb = BODY_ZONE_PRECISE_GROIN
	peri_effect = TRUE
	///Tracks the number of reagent/medicine datums we currently have
	var/current_medicine_count = 0
	///How many drugs we can take before they overwhelm us. Decreases with damage
	var/current_medicine_cap = 5
	///Whether we were over cap the last time we checked.
	var/old_overflow = FALSE
	///Total medicines added since last tick
	var/new_medicines = 0
	///Total medicines removed since last tick
	var/removed_medicines = 0

/obj/item/organ/kidneys/New(mob/living/carbon/carbon_mob)
	. = ..()
	if(!owner)
		return
	RegisterSignal(owner.reagents, COMSIG_NEW_REAGENT_ADD, PROC_REF(owner_added_reagent))
	RegisterSignal(owner.reagents, COMSIG_REAGENT_DELETING, PROC_REF(owner_removed_reagent))

/obj/item/organ/kidneys/clean_owner()
	if(owner?.reagents)
		UnregisterSignal(owner.reagents, list(COMSIG_NEW_REAGENT_ADD, COMSIG_REAGENT_DELETING))
	return ..()

///Signaled proc. Check if the added reagent was under reagent/medicine. If so, increment medicine counter and potentially notify owner.
/obj/item/organ/kidneys/proc/owner_added_reagent(datum/source, reagent_type, amount)
	SIGNAL_HANDLER
	if(!ispath(reagent_type, /datum/reagent/medicine))
		return
	new_medicines++

///Signaled proc. Check if the removed reagent was under reagent/medicine. If so, decrement medicine counter and potentially notify owner.
/obj/item/organ/kidneys/proc/owner_removed_reagent(datum/source, reagent_type)
	SIGNAL_HANDLER
	if(!ispath(reagent_type, /datum/reagent/medicine))
		return
	removed_medicines++

/obj/item/organ/kidneys/set_organ_status()
	. = ..()
	if(!.)
		return
	current_medicine_cap = initial(current_medicine_cap) - 2 * organ_status

/obj/item/organ/kidneys/process()
	var/bypass = FALSE

	if(owner.bodytemperature <= 170) //No sense worrying about a chem cap if we're in cryo anyway. Still need to clear tick counts.
		bypass = TRUE

	current_medicine_count += new_medicines //We want to include medicines that were individually both added and removed this tick
	var/overflow = current_medicine_count - current_medicine_cap //This catches any case where a reagent was added with volume below its metabolism
	current_medicine_count -= removed_medicines //Otherwise, you can microdose infinite chems without kidneys complaining

	new_medicines = 0
	removed_medicines = 0

	if(overflow < 1 || bypass)
		if(old_overflow)
			to_chat(owner, span_notice("You don't feel as overwhelmed by all the drugs any more."))
			old_overflow = FALSE
		return

	if(!old_overflow)
		to_chat(owner, span_warning("All the different drugs in you are starting to make you feel off..."))
		old_overflow = TRUE

	owner.set_drugginess(3)
	if(prob(overflow * (organ_status + 1) * 10))
		owner.Confused(2 SECONDS * (organ_status + 1))

/obj/item/organ/liver
	name = "liver"
	icon_state = "liver"
	slot = ORGAN_SLOT_LIVER
	peri_effect = TRUE
	///lower value, higher resistance.
	var/alcohol_tolerance = 0.005
	///How fast we clean out toxins/toxloss. Adjusts based on organ damage.
	var/filter_rate = 3

/obj/item/organ/liver/process()
	//High toxins levels are dangerous if you aren't actively treating them. 100 seconds to hit bruised from this alone
	if(owner.getToxLoss() >= (80 - 20 * organ_status))
		//Healthy liver suffers on its own
		if(organ_status != ORGAN_BROKEN)
			get_damage(0.2, TRUE)
		//Damaged one shares the fun
		else
			var/obj/item/organ/O = pick(owner.internal_organs)
			O?.get_damage(0.2, TRUE)

	// Heal a bit if needed and we're not busy. This allows recovery from low amounts of toxins.
	if(!owner.drunkenness && owner.getToxLoss() <= 15 && organ_status == ORGAN_HEALTHY)
		heal_organ_damage(0.04)

	// Do some reagent filtering/processing.
	for(var/datum/reagent/potential_toxin AS in owner.reagents.reagent_list)
		//Liver helps clear out any toxins but with drawbacks if damaged
		if(istype(potential_toxin, /datum/reagent/consumable/ethanol) || istype(potential_toxin, /datum/reagent/toxin))
			if(organ_status != ORGAN_HEALTHY)
				owner.adjustToxLoss(0.3 * organ_status)
			owner.reagents.remove_reagent(potential_toxin.type, potential_toxin.custom_metabolism * filter_rate * 0.1)

	//Heal toxin damage slowly if not damaged. If broken, increase it instead.
	owner.adjustToxLoss((2 - filter_rate) * 0.1)
	if(prob(organ_status)) //Just under once every three minutes while bruised, twice as often while broken.
		owner.vomit() //No stomach, so the liver can cause vomiting instead. Stagger and slowdown plus feedback that something's wrong.

/obj/item/organ/liver/set_organ_status()
	. = ..()
	if(!.)
		return
	filter_rate = initial(filter_rate) - organ_status

/obj/item/organ/appendix
	name = "appendix"
	icon_state = "appendix"
	slot = ORGAN_SLOT_APPENDIX
	parent_limb = BODY_ZONE_PRECISE_GROIN
	peri_effect = TRUE

/obj/item/organ/stomach
	name = "stomach"
	icon_state = "stomach"
	slot = ORGAN_SLOT_STOMACH
	peri_effect = TRUE
	///This is a reagent user and needs more then the 10u from edible component
	var/reagent_vol = 1000
	///The rate that the stomach will transfer reagents to the body
	var/metabolism_efficiency = 0.05 // the lowest we should go is 0.025

/obj/item/organ/stomach/New(mob/living/carbon/carbon_mob)
	. = ..()
	create_reagents(reagent_vol)

/obj/item/organ/stomach/process()
	var/mob/living/carbon/human/body = owner

	// digest food, send all reagents that can be metabolized to the body
	for(var/datum/reagent/bit AS in reagents?.reagent_list)
		//Do not transfer over more then we have
		var/amount_max = bit.volume

		// Transfer the amount of reagents based on volume with a min amount of 1u
		var/rate_minimum = max(bit.custom_metabolism, 0.25)
		var/amount = min((round(metabolism_efficiency * amount_max, 0.05) + rate_minimum), amount_max)

		if(amount <= 0)
			continue

		// transfer the reagents over to the body at the rate of the stomach metabolim
		// this way the body is where all reagents that are processed and react
		// the stomach manages how fast they are feed in a drip style
		reagents.trans_to(body, amount)

	//If the stomach is not damage exit out
	if(damage < min_bruised_damage)
		return

	if(prob(0.0125 * damage) || damage > min_broken_damage && prob(0.05 * damage))
		body.vomit()
		to_chat(body, span_warning("Your stomach reels in pain as you're incapable of holding down all that food!"))
		return

/obj/item/organ/eyes
	name = "eyeballs"
	icon_state = "eyes"
	gender = PLURAL
	slot = ORGAN_SLOT_EYES
	parent_limb = BODY_ZONE_HEAD
	///stores which stage of the eye surgery the eye is at
	var/eye_surgery_stage = 0

/obj/item/organ/eyes/process()
	if(organ_status == ORGAN_BRUISED)
		owner.set_blurriness(20)
	if(organ_status == ORGAN_BROKEN)
		owner.set_blindness(20)

/obj/item/organ/brain
	name = "brain"
	icon_state = "brain2"
	parent_limb = BODY_ZONE_HEAD
	var/mob/living/brain/brainmob = null

/obj/item/organ/brain/set_organ_status()
	var/old_organ_status = organ_status
	. = ..()
	if(!.)
		return
	owner.set_skills(owner.skills.modifyAllRatings(old_organ_status - organ_status))
	if(organ_status >= ORGAN_BRUISED)
		ADD_TRAIT(owner, TRAIT_DROOLING, BRAIN_TRAIT)
	else
		REMOVE_TRAIT(owner, TRAIT_DROOLING, BRAIN_TRAIT)

// I'm not sure if this proc is even used
/obj/item/organ/brain/proc/transfer_identity(mob/living/carbon/H)
	name = "[H]'s brain"
	brainmob = new(src)
	brainmob.name = H.real_name
	brainmob.real_name = H.real_name
	brainmob.timeofhostdeath = H.timeofdeath
	if(H.mind)
		H.mind.transfer_to(brainmob)

	to_chat(brainmob, span_notice("You feel slightly disoriented. That's normal when you're just a brain."))
