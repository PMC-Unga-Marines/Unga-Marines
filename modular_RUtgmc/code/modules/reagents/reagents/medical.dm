/datum/reagent/medicine/spaceacillin
	purge_list = list(/datum/reagent/medicine/xenojelly)
	purge_rate = 5

/datum/reagent/medicine/larvaway
	purge_list = list(/datum/reagent/medicine/xenojelly)
	purge_rate = 5

///RYETALYN
/datum/reagent/medicine/ryetalyn
	purge_rate = 3

///SYNAPTIZINE
/datum/reagent/medicine/synaptizine
	custom_metabolism = REAGENTS_METABOLISM * 1.5

/datum/reagent/medicine/synaptizine/overdose_process(mob/living/L, metabolism)
	L.apply_damage(2 * effect_str, TOX)

/datum/reagent/medicine/synaptizine/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(2 * effect_str, 2 * effect_str, 3 * effect_str)

///ADRENALINE, basically old synaptizine with buffs?
/datum/reagent/medicine/adrenaline
	name = "Adrenaline"
	description = "Gotta go fast!"
	color = "#f14a17"
	overdose_threshold = REAGENTS_OVERDOSE/5
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL/5
	scannable = TRUE
	custom_metabolism = REAGENTS_METABOLISM * 0.5
	purge_rate = 5

/datum/reagent/medicine/adrenaline/on_mob_add(mob/living/carbon/human/L, metabolism)
	if(TIMER_COOLDOWN_CHECK(L, name))
		return
	L.adjustStaminaLoss(-30 * effect_str)
	to_chat(L, span_userdanger("You feel a burst of energy as the adrenaline courses through you! Time to go fast!"))

	if(L.health < L.health_threshold_crit && volume >= 3)
		to_chat(L, span_userdanger("Heart explosion! Power flows through your veins!"))
		L.adjustBruteLoss(-L.getBruteLoss(TRUE) * 0.40)
		L.jitter(5)

/datum/reagent/medicine/adrenaline/on_mob_life(mob/living/L, metabolism)
	L.reagent_shock_modifier += PAIN_REDUCTION_MEDIUM
	L.adjustDrowsyness(-0.5 SECONDS)
	L.AdjustUnconscious(-2 SECONDS)
	L.AdjustStun(-2 SECONDS)
	L.AdjustParalyzed(-2 SECONDS)
	L.adjustToxLoss(0.8 * effect_str)
	L.hallucination = max(0, L.hallucination - 10)
	switch(current_cycle)
		if(1 to 10)
			L.adjustStaminaLoss(-7.5 * effect_str)
		if(11 to 40)
			L.adjustStaminaLoss((current_cycle*0.75 - 14)*effect_str)
		if(41 to INFINITY)
			L.adjustStaminaLoss(15 * effect_str)
	return ..()

/datum/reagent/medicine/adrenaline/overdose_process(mob/living/L, metabolism)
	L.apply_damage(effect_str, TOX)

/datum/reagent/medicine/adrenaline/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(effect_str, effect_str, effect_str)

/datum/reagent/medicine/adrenaline/on_mob_delete(mob/living/L, metabolism)
	to_chat(L, span_userdanger("The room spins as your adrenaline starts to wear off!"))
	TIMER_COOLDOWN_START(L, name, 60 SECONDS)

///PARACETAMOL

/datum/reagent/medicine/paracetamol/on_mob_life(mob/living/L, metabolism)
	L.reagent_pain_modifier += PAIN_REDUCTION_HEAVY
	L.heal_overall_damage(0.5*effect_str, 0.5*effect_str)
	L.adjustToxLoss(-0.1*effect_str)
	L.adjustStaminaLoss(-effect_str)
	return ..()

///DEXALIN

/datum/reagent/medicine/dexalin
	custom_metabolism = REAGENTS_METABOLISM * 2.5
	overdose_threshold = REAGENTS_OVERDOSE * 0.5 // 15
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.6 // 30
	purge_list = list(/datum/reagent/medicine/synaptizine)
	purge_rate = 1
	scannable = TRUE

/datum/reagent/medicine/dexalin/on_mob_life(mob/living/L,metabolism)
	L.adjustOxyLoss(-3*effect_str)
	L.adjustStaminaLoss(-2*effect_str)
	holder.remove_reagent("lexorin", effect_str)
	return ..()

/datum/reagent/medicine/dexalin/overdose_process(mob/living/L, metabolism)
	L.apply_damage(2 * effect_str, BURN)

///DEXALIN PLUS

/datum/reagent/medicine/dexalinplus/on_mob_add(mob/living/L, metabolism)
	if(TIMER_COOLDOWN_CHECK(L, name))
		return
	L.adjustStaminaLoss(-100*effect_str)
	to_chat(L, span_userdanger("You feel a complete lack of fatigue, so relaxing!"))

/datum/reagent/medicine/dexalinplus/on_mob_delete(mob/living/L, metabolism)
	TIMER_COOLDOWN_START(L, name, 180 SECONDS)

///MEDICAL NANITES

/datum/reagent/medicine/research/medicalnanites
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 1.7

/datum/reagent/medicine/research/medicalnanites/overdose_crit_process(mob/living/L, metabolism)
	L.adjustCloneLoss(1) //YUM!
