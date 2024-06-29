
// ***************************************
// *********** Inject Egg Neurogas
// ***************************************
/datum/action/ability/activable/xeno/inject_egg_neurogas
	ability_cost = 80
	keybind_flags = null

///Called when we slash while reagent slash is active
/datum/action/ability/xeno_action/reagent_slash/reagent_slash(datum/source, mob/living/target, damage, list/damage_mod, list/armor_mod)
	var/mob/living/carbon/xenomorph/xeno_owner = owner
	if(xeno_owner.selected_reagent == /datum/reagent/toxin/acid)

		if(!target?.can_sting()) //We only care about targets that we can actually sting
			return

		var/mob/living/carbon/xeno_target = target

		if(HAS_TRAIT(xeno_target, TRAIT_INTOXICATION_IMMUNE))
			xeno_target.balloon_alert(xeno_owner, "Immune to Intoxication")
			return

		playsound(xeno_target, 'sound/effects/spray3.ogg', 20, TRUE)
		if(xeno_target.has_status_effect(STATUS_EFFECT_INTOXICATED))
			var/datum/status_effect/stacking/intoxicated/debuff = xeno_target.has_status_effect(STATUS_EFFECT_INTOXICATED)
			debuff.add_stacks(SENTINEL_TOXIC_SLASH_STACKS_PER + xeno_owner.xeno_caste.additional_stacks)
		else
			xeno_target.apply_status_effect(STATUS_EFFECT_INTOXICATED, SENTINEL_TOXIC_SLASH_STACKS_PER + xeno_owner.xeno_caste.additional_stacks)

		GLOB.round_statistics.defiler_reagent_slashes++ //Statistics
		SSblackbox.record_feedback("tally", "round_statistics", 1, "defiler_reagent_slashes")

		reagent_slash_count-- //Decrement the toxic slash count

		if(!reagent_slash_count) //Deactivate if we have no reagent slashes remaining
			reagent_slash_deactivate(xeno_owner)

		return

	return ..()

