// ***************************************
// *********** Regenerate Skin
// ***************************************
/datum/action/ability/xeno_action/regenerate_skin/crusher
	name = "Regenerate Armor"
	action_icon_state = "regenerate_skin"
	desc = "Regenerate your hard exoskeleton armor, removing all sunder."
	use_state_flags = ABILITY_TARGET_SELF|ABILITY_IGNORE_SELECTED_ABILITY
	ability_cost = 400
	cooldown_duration = 90 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_REGENERATE_SKIN,
	)

/datum/action/ability/xeno_action/regenerate_skin/crusher/on_cooldown_finish()
	var/mob/living/carbon/xenomorph/X = owner
	to_chat(X, span_notice("We feel we are ready to shred our armor and grow another."))
	return ..()

/datum/action/ability/xeno_action/regenerate_skin/crusher/action_activate()
	var/mob/living/carbon/xenomorph/crusher/X = owner

	if(!can_use_action(TRUE))
		return fail_activate()

	if(X.on_fire)
		to_chat(X, span_xenowarning("We can't use that while on fire."))
		return fail_activate()

	X.emote("roar")
	X.visible_message(span_warning("The armor on \the [X] shreds and a new layer can be seen in it's place!"),
		span_notice("We shed our armor, showing the fresh new layer underneath!"))

	X.do_jitter_animation(1000)
	X.adjust_sunder(-50)
	add_cooldown()
	return succeed_activate()

/datum/action/ability/activable/xeno/cresttoss
	name = "Crest Toss Away"
	action_icon_state = "cresttoss_away"
	desc = "Fling an adjacent target away from you. Shares the cooldown with the Crest Toss Behind!"
	var/tossing_away = TRUE
	var/ability_for_cooldown = /datum/action/ability/activable/xeno/cresttoss/behind

/datum/action/ability/activable/xeno/cresttoss/use_ability(atom/movable/A)
	var/mob/living/carbon/xenomorph/X = owner
	var/toss_distance = X.xeno_caste.crest_toss_distance
	var/toss_direction
	var/turf/throw_origin = get_turf(X)
	var/turf/target_turf = throw_origin //throw distance is measured from the xeno itself
	var/big_mob_message

	X.face_atom(A) //Face towards the target so we don't look silly

	if(!X.issamexenohive(A)) //xenos should be able to fling xenos into xeno passable areas!
		for(var/obj/effect/forcefield/fog/fog in throw_origin)
			A.balloon_alert(X, "Cannot, fog")
			return fail_activate()
	if(isliving(A))
		var/mob/living/L = A
		if(L.mob_size >= MOB_SIZE_BIG) //Penalize toss distance for big creatures
			toss_distance = FLOOR(toss_distance * 0.5, 1)
			big_mob_message = ", struggling mightily to heft its bulk"
	else if(ismecha(A))
		toss_distance = FLOOR(toss_distance * 0.5, 1)
		big_mob_message = ", struggling mightily to heft its bulk"

	if(!tossing_away)
		toss_direction = get_dir(A, X)
	else
		toss_direction = get_dir(X, A)

	var/turf/temp
	for(var/x in 1 to toss_distance)
		temp = get_step(target_turf, toss_direction)
		if(!temp)
			break
		target_turf = temp

	X.icon_state = "Crusher Charging" //Momentarily lower the crest for visual effect

	X.visible_message(span_xenowarning("\The [X] flings [A] away with its crest[big_mob_message]!"), \
	span_xenowarning("We fling [A] away with our crest[big_mob_message]!"))

	succeed_activate()

	A.forceMove(throw_origin)
	A.throw_at(target_turf, toss_distance, 1, X, TRUE, TRUE)

	//Handle the damage
	if(!X.issamexenohive(A) && isliving(A)) //Friendly xenos don't take damage.
		var/damage = toss_distance * 6
		var/mob/living/L = A
		L.take_overall_damage(damage, BRUTE, MELEE, updating_health = TRUE)
		shake_camera(L, 2, 2)
		playsound(A, pick('sound/weapons/alien_claw_block.ogg','sound/weapons/alien_bite2.ogg'), 50, 1)

	add_cooldown()
	addtimer(CALLBACK(X, TYPE_PROC_REF(/mob, update_icons)), 3)

	var/datum/action/ability/xeno_action/toss = X.actions_by_path[ability_for_cooldown]
	if(toss)
		toss.add_cooldown()

/datum/action/ability/activable/xeno/cresttoss/behind
	name = "Crest Toss Behind"
	action_icon_state = "cresttoss_behind"
	desc = "Fling an adjacent target behind you. Also works over barricades. Shares the cooldown with the Crest Toss Away!"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CRESTTOSS_BEHIND,
	)
	tossing_away = FALSE
	ability_for_cooldown = /datum/action/ability/activable/xeno/cresttoss
