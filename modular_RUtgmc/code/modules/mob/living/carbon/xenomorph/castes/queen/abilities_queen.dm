/datum/action/ability/xeno_action/watch_xeno
	use_state_flags = ABILITY_USE_LYING

/datum/action/ability/activable/xeno/screech
	cooldown_duration = 90 SECONDS

/datum/action/ability/activable/xeno/screech/use_ability(atom/A)
	. = ..()
	var/mob/living/carbon/xenomorph/queen/X = owner

	var/datum/action/ability/xeno_action/plasma_screech = X.actions_by_path[/datum/action/ability/activable/xeno/plasma_screech]
	if(plasma_screech)
		plasma_screech.add_cooldown(15 SECONDS)
	var/datum/action/ability/xeno_action/frenzy_screech = X.actions_by_path[/datum/action/ability/activable/xeno/frenzy_screech]
	if(frenzy_screech)
		frenzy_screech.add_cooldown(15 SECONDS)

/datum/action/ability/activable/xeno/plasma_screech
	name = "Plasma Screech"
	action_icon_state = "plasma_screech"
	desc = "Screech that increases plasma regeneration for nearby xenos."
	ability_cost = 300
	cooldown_duration = 45 SECONDS
	var/screech_range = 5
	var/bonus_regen = 0.5
	var/duration = 20 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PLASMA_SCREECH,
	)

/datum/action/ability/activable/xeno/plasma_screech/use_ability(atom/A)
	var/mob/living/carbon/xenomorph/queen/X = owner

	for(var/mob/living/carbon/xenomorph/affected_xeno in cheap_get_xenos_near(X, screech_range))
		if(!(affected_xeno.xeno_caste.can_flags & CASTE_CAN_BE_GIVEN_PLASMA))
			continue
		affected_xeno.apply_status_effect(/datum/status_effect/plasma_surge, affected_xeno.xeno_caste.plasma_max / 3, bonus_regen, duration)

	playsound(X.loc, 'modular_RUtgmc/sound/voice/alien_plasma_screech.ogg', 75, 0)
	X.visible_message(span_xenohighdanger("\The [X] emits an ear-splitting guttural roar!"))

	succeed_activate()
	add_cooldown()

	var/datum/action/ability/xeno_action/screech = X.actions_by_path[/datum/action/ability/activable/xeno/screech]
	if(screech)
		screech.add_cooldown(10 SECONDS)
	var/datum/action/ability/xeno_action/frenzy_screech = X.actions_by_path[/datum/action/ability/activable/xeno/frenzy_screech]
	if(frenzy_screech)
		frenzy_screech.add_cooldown(5 SECONDS)

/datum/action/ability/activable/xeno/frenzy_screech
	name = "Frenzy Screech"
	action_icon_state = "frenzy_screech"
	desc = "Screech that increases damage for nearby xenos."
	ability_cost = 300
	cooldown_duration = 45 SECONDS
	var/screech_range = 5
	var/buff_duration = 20 SECONDS
	var/buff_damage_modifier = 0.1
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_FRENZY_SCREECH,
	)

/datum/action/ability/activable/xeno/frenzy_screech/use_ability(atom/A)
	var/mob/living/carbon/xenomorph/queen/X = owner

	for(var/mob/living/carbon/xenomorph/affected_xeno in cheap_get_xenos_near(X, screech_range))
		affected_xeno.apply_status_effect(/datum/status_effect/frenzy_screech, buff_duration, buff_damage_modifier)

	playsound(X.loc, 'modular_RUtgmc/sound/voice/alien_frenzy_screech.ogg', 75, 0)
	X.visible_message(span_xenohighdanger("\The [X] emits an ear-splitting guttural roar!"))

	succeed_activate()
	add_cooldown()

	var/datum/action/ability/xeno_action/screech = X.actions_by_path[/datum/action/ability/activable/xeno/screech]
	if(screech)
		screech.add_cooldown(10 SECONDS)
	var/datum/action/ability/xeno_action/plasma_screech = X.actions_by_path[/datum/action/ability/activable/xeno/plasma_screech]
	if(plasma_screech)
		plasma_screech.add_cooldown(5 SECONDS)

/// Promote the passed xeno to a hive leader, should not be called direct
/datum/action/ability/xeno_action/set_xeno_lead/proc/set_xeno_leader(mob/living/carbon/xenomorph/selected_xeno)
	var/mob/living/carbon/xenomorph/xeno_ruler = owner
	xeno_ruler.balloon_alert(xeno_ruler, "Xeno promoted")
	selected_xeno.balloon_alert(selected_xeno, "Promoted to leader")
	to_chat(selected_xeno, span_xenoannounce("[xeno_ruler] has selected us as a Hive Leader. The other Xenomorphs must listen to us. We will also act as a beacon for the Queen's pheromones."))

	xeno_ruler.hive.add_leader(selected_xeno)
	selected_xeno.hud_set_queen_overwatch()
	selected_xeno.handle_xeno_leader_pheromones(xeno_ruler)
	notify_ghosts("\ [xeno_ruler] has designated [selected_xeno] as a Hive Leader", source = selected_xeno, action = NOTIFY_ORBIT)

	selected_xeno.update_leader_icon(TRUE)
