/datum/action/ability/xeno_action/toggle_agility/action_activate()
	. = ..()
	var/mob/living/carbon/xenomorph/X = owner
	if(X.agility)
		owner.drop_all_held_items() // drop items (hugger/jelly)



// ***************************************
// *********** Jab
// ***************************************
/datum/action/ability/activable/xeno/warrior/punch/jab
	name = "Jab"
	action_icon_state = "jab"
	desc = "Precisely strike your target from further away, heavily slowing them."
	ability_cost = 10
	range = 2
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_JAB,
	)

/datum/action/ability/activable/xeno/warrior/punch/jab/use_ability(atom/A)
	var/mob/living/carbon/xenomorph/xeno_owner = owner
	var/mob/living/carbon/human/target = A
	var/jab_damage = xeno_owner.xeno_caste.melee_damage * xeno_owner.xeno_melee_damage_modifier
	var/datum/action/ability/xeno_action/empower/empower_action = xeno_owner.actions_by_path[/datum/action/ability/xeno_action/empower]
	if(!A.punch_act(xeno_owner, jab_damage))
		return fail_activate()
	if(empower_action?.check_empower(A))
		jab_damage *= WARRIOR_PUNCH_EMPOWER_MULTIPLIER
		to_chat(target, span_highdanger("The concussion from the [xeno_owner]'s blow blinds us!"))
		target.apply_status_effect(STATUS_EFFECT_CONFUSED, 3 SECONDS)
		target.Paralyze(0.5 SECONDS)
	GLOB.round_statistics.warrior_punches++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "warrior_punches")
	succeed_activate()
	add_cooldown()

/datum/action/ability/activable/xeno/warrior/punch/jab/on_cooldown_finish()
	var/mob/living/carbon/xenomorph/xeno_owner = owner
	xeno_owner.balloon_alert(xeno_owner, "Jab ready")
	owner.playsound_local(owner, 'sound/effects/xeno_newlarva.ogg', 25, 0, 1)
	return ..()

// ***************************************
// *********** Empower
// ***************************************
/datum/action/ability/xeno_action/empower
	empowerable_actions = list(
		/datum/action/ability/activable/xeno/warrior/fling,
		/datum/action/ability/activable/xeno/warrior/grapple_toss,
		/datum/action/ability/activable/xeno/warrior/punch,
		/datum/action/ability/activable/xeno/warrior/punch/jab,
		/datum/action/ability/activable/xeno/warrior/punch/flurry,
	)

// ***************************************
// *********** Flurry
// ***************************************
/datum/action/ability/activable/xeno/warrior/punch/flurry
	range = 2

