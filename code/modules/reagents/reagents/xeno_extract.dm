/datum/reagent/xeno_extract
	name = "Mucus"
	taste_description = "sour"
	scannable = TRUE
	reagent_state = LIQUID

/datum/reagent/xeno_extract/red_mucus
	name = "Red mucus"
	description = "A bunch of red slime."
	color = COLOR_REAGENT_REDMUCUS
	custom_metabolism = REAGENTS_METABOLISM * 0.25

/datum/reagent/xeno_extract/red_mucus/on_mob_life(mob/living/L, metabolism)
	L.adjustStaminaLoss(effect_str * -0.5)
	L.adjustDrowsyness(-1 SECONDS)
	L.AdjustUnconscious(-2 SECONDS)
	return ..()

/datum/reagent/xeno_extract/red_mucus/on_mob_add(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You feel like you're being pumped full of jelly."))
	L.add_movespeed_modifier(type, TRUE, 0, NONE, TRUE, -0.6)

/datum/reagent/xeno_extract/red_mucus/on_mob_delete(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You feel the mucus leaving."))
	L.remove_movespeed_modifier(type)

/datum/reagent/xeno_extract/red_mucus/overdose_process(mob/living/L, metabolism)
	L.adjustToxLoss(effect_str * 2)

/datum/reagent/xeno_extract/red_mucus/overdose_crit_process(mob/living/L, metabolism)
	L.adjustToxLoss(effect_str * 4)

/datum/reagent/xeno_extract/green_mucus
	name = "Green mucus"
	description = "A bunch of green slime"
	color = COLOR_REAGENT_GREENMUCUS
	custom_metabolism = REAGENTS_METABOLISM * 0.1

#define GREEN_MUCUS_BRUTE_HEAL 4
#define GREEN_MUCUS_TOX_DAMAGE 1.5
#define GREEN_MUCUS_FIRE_DAMAGE 2

/datum/reagent/xeno_extract/green_mucus/on_mob_life(mob/living/L, metabolism)
	var/brute_loss = L.getBruteLoss(TRUE)
	if(brute_loss < 4)
		return ..()

	if(prob(10))
		to_chat(L, span_warning("You notice your wounds crusting over with disgusting green ichor.") )

	L.heal_limb_damage(brute = GREEN_MUCUS_BRUTE_HEAL, updating_health = TRUE)
	L.adjustToxLoss(GREEN_MUCUS_TOX_DAMAGE)
	L.adjustFireLoss(GREEN_MUCUS_FIRE_DAMAGE)

	return ..()

#undef GREEN_MUCUS_BRUTE_HEAL
#undef GREEN_MUCUS_TOX_DAMAGE
#undef GREEN_MUCUS_FIRE_DAMAGE

#define BLACK_MUCUS_PUNCH_BONUS 100

/datum/reagent/xeno_extract/black_mucus
	name = "Black mucus"
	description = "A bunch of black slime"
	color = COLOR_REAGENT_BLACKMUCUS
	custom_metabolism = REAGENTS_METABOLISM * 0.005

/datum/reagent/xeno_extract/black_mucus/on_mob_life(mob/living/L, metabolism)
	if(!ishuman(L) || L.bodytemperature <= 169)
		holder.remove_reagent(type, volume) //By default it slowly disappears.
		return
	return ..()

/datum/reagent/xeno_extract/black_mucus/on_mob_add(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You feel much stronger."))
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.melee_damage += BLACK_MUCUS_PUNCH_BONUS

/datum/reagent/xeno_extract/black_mucus/on_mob_delete(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You feel weak."))
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.melee_damage -= BLACK_MUCUS_PUNCH_BONUS

#undef BLACK_MUCUS_PUNCH_BONUS

/datum/reagent/xeno_extract/blood_mucus
	name = "Bloody mucus"
	description = "A bunch of bloody slime."
	color = COLOR_REAGENT_REDMUCUS
	custom_metabolism = REAGENTS_METABOLISM * 5
	overdose_threshold = REAGENTS_OVERDOSE / 3
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL / 3

/datum/reagent/medicine/russian_red/on_mob_add(mob/living/L, metabolism)
	var/mob/living/carbon/human/H = L
	if(TIMER_COOLDOWN_CHECK(L, name) || L.stat == DEAD)
		return
	if(L.health < H.health_threshold_crit && volume >= 5)
		to_chat(L, span_userdanger("You feel flame of love course through your veins!"))
		L.adjustBruteLoss(-L.getBruteLoss(TRUE) * 0.50)
		L.adjustFireLoss(-L.getFireLoss(TRUE) * 0.50)
		TIMER_COOLDOWN_START(L, name, 300 SECONDS)

/datum/reagent/xeno_extract/blood_mucus/on_mob_life(mob/living/L, metabolism)
	L.heal_overall_damage(10*effect_str, 10*effect_str)
	L.adjustToxLoss(0.5*effect_str)
	L.reagent_pain_modifier -= PAIN_REDUCTION_LIGHT
	if(prob(5))
		to_chat(L, span_notice("you feel like you're in cotton"))
	return ..()

/datum/reagent/xeno_extract/blood_mucus/overdose_process(mob/living/L, metabolism)
	L.adjustToxLoss(3*effect_str)

/datum/reagent/xeno_extract/blood_mucus/overdose_crit_process(mob/living/L, metabolism)
	if(!ishuman(L))
		return

	var/mob/living/carbon/human/H = L
	var/affected_organ = pick(ORGAN_SLOT_HEART, ORGAN_SLOT_LIVER, ORGAN_SLOT_KIDNEYS)
	var/datum/internal_organ/Organrand = H.get_organ_slot(affected_organ)
	Organrand.take_damage(8 * effect_str)
