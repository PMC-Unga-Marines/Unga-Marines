/datum/reagent/thwei //OP yautja chem
	name = "Thwei"
	description = "A strange, alien liquid."
	reagent_state = LIQUID
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL
	taste_description = "cherry milkshake"
	color = "#C8A5DC" // rgb: 200, 165, 220
	purge_list = list(/datum/reagent/medicine, /datum/reagent/toxin, /datum/reagent/zombium)
	purge_rate = 5
	trait_flags = TACHYCARDIC

/datum/reagent/thwei/on_mob_add(mob/living/L, metabolism)
	if(isyautja(L))
		to_chat(L, span_userdanger("You feel revitalized!"))
	else
		to_chat(L, span_userdanger("Something feels off!"))
		L.AdjustParalyzed(20)

/datum/reagent/thwei/on_mob_life(mob/living/L, metabolism)
	. = ..()
	if(isyautja(L))
		L.blood_volume += 3
		L.hallucination = 0
		L.dizziness = 0
		L.adjustStaminaLoss(-15)
		L.adjustToxLoss(-3)
		L.adjustOxyLoss(-3)
		L.adjustCloneLoss(-3)
		L.adjustBrainLoss(-3)
		L.adjustDrowsyness(-10)
		L.AdjustUnconscious(-40)
		L.AdjustStun(-40)
		L.AdjustParalyzed(-40)
		var/mob/living/carbon/human/species/yautja/Y = L
		for(var/datum/limb/X in Y.limbs)
			for(var/datum/wound/internal_bleeding/W in X.wounds)
				W.damage = max(0, W.damage - (effect_str))
			if(X.limb_status & (LIMB_BROKEN | LIMB_SPLINTED))
				X.add_limb_flags(LIMB_STABILIZED)
	else
		L.vomit()
		L.adjustToxLoss(0.1)
		L.adjustFireLoss(0.1)
		L.hallucination += 20
		L.jitter(8)
		L.dizzy(8)
		L.reagent_shock_modifier -= PAIN_REDUCTION_HEAVY
	return ..()

/datum/reagent/thwei/on_mob_delete(mob/living/L, metabolism)
	if(isyautja(L))
		to_chat(L, span_userdanger("You feel thwei powers wearing off!"))
	else
		to_chat(L, span_userdanger("Toxins are wearing off!"))

/datum/reagent/thwei/overdose_process(mob/living/L, metabolism)
	L.take_limb_damage(2*effect_str, 0)

/datum/reagent/thwei/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(2*effect_str, 3*effect_str)
	L.adjustBrainLoss(1.5*effect_str, TRUE)

