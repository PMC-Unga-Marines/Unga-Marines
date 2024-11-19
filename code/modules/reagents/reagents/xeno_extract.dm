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
	L.adjustStaminaLoss(effect_str * 0.5)
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
