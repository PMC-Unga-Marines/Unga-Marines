/datum/reagent/xeno_extract
	name = "Mucus"
	taste_description = "sour"
	scannable = TRUE
	reagent_state = LIQUID

/datum/reagent/xeno_extract/red_mucus
	name = "Red mucus"
	description = "A bunch of red slime"
	color = COLOR_REAGENT_REDMUCUS
	custom_metabolism = REAGENTS_METABOLISM * 0.25

/datum/reagent/xeno_extract/red_mucus/on_mob_life(mob/living/L, metabolism)
	L.adjustStaminaLoss(effect_str * 0.5)
	L.adjustDrowsyness(-1 SECONDS)
	L.AdjustUnconscious(-2 SECONDS)
	return ..()

/datum/reagent/xeno_extract/red_mucus/on_mob_add(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You feel like you should stay near medical help until this shot settles in."))
	L.add_movespeed_modifier(type, TRUE, 0, NONE, TRUE, -0.6)

/datum/reagent/xeno_extract/red_mucus/on_mob_delete(mob/living/L, metabolism)
	to_chat(L, span_userdanger("Your nanites have been fully purged! They no longer affect you."))
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

#define green_mucus_brute_heal 4
#define green_mucus_tox_damage 1
#define green_mucus_fire_damage 2

/datum/reagent/xeno_extract/green_mucus/on_mob_life(mob/living/L, metabolism)
	var/brute_loss = L.getBruteLoss(TRUE)
	if(brute_loss < 4)
		return ..()

	if(prob(10))
		to_chat(L, span_warning("You notice your wounds crusting over with disgusting green ichor.") )

	L.heal_limb_damage(brute = green_mucus_brute_heal, updating_health = TRUE)
	L.adjustToxLoss(green_mucus_tox_damage)
	L.adjustFireLoss(green_mucus_fire_damage)

	return ..()

#undef green_mucus_brute_heal
#undef green_mucus_tox_damage
#undef green_mucus_fire_damage
