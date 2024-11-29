/datum/internal_organ/heart
	name = "heart"
	slot = ORGAN_SLOT_HEART
	peri_effect = TRUE

/datum/internal_organ/heart/process()
	if(organ_status == ORGAN_BRUISED && prob(5))
		owner.emote("me", 1, "grabs at [owner.p_their()] chest!")
	else if(organ_status == ORGAN_BROKEN && prob(20))
		owner.emote("me", 1, "clutches [owner.p_their()] chest!")

/datum/internal_organ/heart/set_organ_status()
	var/old_organ_status = organ_status
	. = ..()
	if(!.)
		return
	owner.max_stamina_buffer += (old_organ_status - organ_status) * 25
	owner.maxHealth += (old_organ_status - organ_status) * 20

/datum/internal_organ/lungs
	name = "lungs"
	slot = ORGAN_SLOT_LUNGS
	peri_effect = TRUE

/datum/internal_organ/lungs/process()
	if((organ_status == ORGAN_BRUISED && prob(5)) || (organ_status == ORGAN_BROKEN && prob(20)))
		owner.emote("me", 1, "gasps for air!")

/datum/internal_organ/lungs/set_organ_status()
	. = ..()
	if(!.)
		return
	// For example, bruised lungs will reduce stamina regen by 40%, broken by 80%
	owner.add_stamina_regen_modifier(name, organ_status * -0.40)
	// Slowdown added when the heart is damaged
	owner.add_movespeed_modifier(name, override = TRUE, multiplicative_slowdown = organ_status)

//Hits of 1 damage or less won't do anything due to how losebreath works, but any stronger and we'll get the wind knocked out of us for a bit. Mostly just flavor.
/datum/internal_organ/lungs/take_damage(amount, silent = FALSE)
	owner.adjust_Losebreath(amount)
	return ..()

/datum/internal_organ/kidneys
	name = "kidneys"
	slot = ORGAN_SLOT_KIDNEYS
	parent_limb = BODY_ZONE_PRECISE_GROIN
	peri_effect = TRUE

/datum/internal_organ/liver
	name = "liver"
	slot = ORGAN_SLOT_LIVER
	peri_effect = TRUE
	///lower value, higher resistance.
	var/alcohol_tolerance = 0.005
	///How fast we clean out toxins/toxloss. Adjusts based on organ damage.
	var/filter_rate = 3

/datum/internal_organ/liver/process()
	//High toxins levels are dangerous if you aren't actively treating them. 100 seconds to hit bruised from this alone
	if(owner.getToxLoss() >= (80 - 20 * organ_status))
		//Healthy liver suffers on its own
		if(organ_status != ORGAN_BROKEN)
			take_damage(0.2, TRUE)
		//Damaged one shares the fun
		else
			var/datum/internal_organ/O = pick(owner.internal_organs)
			O?.take_damage(0.2, TRUE)

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

/datum/internal_organ/liver/set_organ_status()
	. = ..()
	if(!.)
		return
	filter_rate = initial(filter_rate) - organ_status

/datum/internal_organ/appendix
	name = "appendix"
	slot = ORGAN_SLOT_APPENDIX
	parent_limb = BODY_ZONE_PRECISE_GROIN
	peri_effect = TRUE

/datum/internal_organ/stomach
	name = "stomach"
	slot = ORGAN_SLOT_STOMACH
	peri_effect = TRUE
	///The rate that the stomach will transfer reagents to the body
	var/metabolism_efficiency = 0.05 // the lowest we should go is 0.025
	/// Our reagents
	var/datum/reagents/reagents = new /datum/reagents(1000)

/datum/internal_organ/stomach/process()
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
		to_chat(body, span_warning("Your stomach reels in pain as you're incapable of holding down it's contents!"))
		return

/datum/internal_organ/eyes
	name = "eyeballs"
	slot = ORGAN_SLOT_EYES
	parent_limb = BODY_ZONE_HEAD
	///stores which stage of the eye surgery the eye is at
	var/eye_surgery_stage = 0

/datum/internal_organ/eyes/process()
	if(organ_status == ORGAN_BRUISED)
		owner.set_blurriness(20)
	if(organ_status == ORGAN_BROKEN)
		owner.set_blindness(20)

/datum/internal_organ/brain
	name = "brain"
	parent_limb = BODY_ZONE_HEAD
	var/mob/living/brain/brainmob = null

/datum/internal_organ/brain/set_organ_status()
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
/datum/internal_organ/brain/proc/transfer_identity(mob/living/carbon/H)
	name = "[H]'s brain"
	brainmob = new(src)
	brainmob.name = H.real_name
	brainmob.real_name = H.real_name
	brainmob.timeofhostdeath = H.timeofdeath
	if(H.mind)
		H.mind.transfer_to(brainmob)

	to_chat(brainmob, span_notice("You feel slightly disoriented. That's normal when you're just a brain."))
