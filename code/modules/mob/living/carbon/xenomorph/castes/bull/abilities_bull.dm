/datum/action/ability/xeno_action/proc/acid_puddle(atom/A, atom/OldLoc, Dir, Forced)
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/X = owner
	new/obj/effect/temp_visual/xenomorph/afterimage(get_turf(X), X)
	new /obj/effect/xenomorph/spray(get_turf(X), 5 SECONDS, XENO_ACID_CHARGE_DAMAGE)
	for(var/obj/O in get_turf(X))
		O.acid_spray_act(X)
		playsound(X, "alien_footstep_large", 50)

/datum/action/ability/xeno_action/proc/afterimage(atom/A, atom/OldLoc, Dir, Forced)
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/X = owner
	new/obj/effect/temp_visual/xenomorph/afterimage(get_turf(X), X)
	playsound(X, "alien_footstep_large", 50)

// ***************************************
// *********** Acid Charge
// ***************************************
/datum/action/ability/xeno_action/acid_charge
	name = "Acid Charge"
	action_icon_state = "bull_charge"
	desc = "The acid charge, deal small damage to yourself and start leaving acid puddles after your steps."
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_ACIDCHARGE,
	)
	cooldown_duration = 30 SECONDS
	ability_cost = 40
	var/charge_duration
	var/obj/effect/abstract/particle_holder/particle_holder

/particles/bull_selfslash
	icon = 'icons/effects/effects.dmi'
	icon_state = "redslash"
	scale = 1.3
	count = 1
	spawning = 1
	lifespan = 4
	fade = 4
	rotation = -160
	friction = 0.6

/datum/action/ability/xeno_action/acid_charge/can_use_action()
	var/mob/living/carbon/xenomorph/bull/X = owner
	if(X.bull_charging)
		return FALSE
	return ..()

/datum/action/ability/xeno_action/acid_charge/action_activate()
	var/mob/living/carbon/xenomorph/X = owner
	if(!do_after(X, 1 SECONDS, NONE, X, BUSY_ICON_DANGER))
		if(!X.stat)
			X.set_canmove(TRUE)
		return fail_activate()
	X.apply_damage(40, BRUTE, TRUE, updating_health = TRUE)
	particle_holder = new(X, /particles/bull_selfslash)
	particle_holder.pixel_y = 12
	particle_holder.pixel_x = 18
	START_PROCESSING(SSprocessing, src)
	QDEL_NULL_IN(src, particle_holder, 5)
	playsound(X,'sound/weapons/alien_bite1.ogg', 75, 1)
	X.emote("hiss")
	X.set_canmove(TRUE)
	X.bull_charging = TRUE
	X.add_movespeed_modifier(MOVESPEED_ID_BULL_ACID_CHARGE, TRUE, 0, NONE, TRUE, X.xeno_caste.speed * 1.2)
	charge_duration = addtimer(CALLBACK(src, PROC_REF(acid_charge_deactivate)), 2 SECONDS,  TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE)
	RegisterSignals(X, list(COMSIG_LIVING_STATUS_PARALYZE, COMSIG_LIVING_STATUS_STAGGER), PROC_REF(acid_charge_deactivate))
	RegisterSignal(X, COMSIG_MOVABLE_MOVED, PROC_REF(acid_puddle))
	X.icon_state = "[X.xeno_caste.caste_name][X.is_a_rouny ? " rouny" : ""] Charging"

	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/acid_charge/proc/acid_charge_deactivate()
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/X = owner
	X.remove_movespeed_modifier(MOVESPEED_ID_BULL_ACID_CHARGE)
	X.update_icons()
	X.bull_charging = FALSE

	UnregisterSignal(owner, list(
		COMSIG_MOVABLE_MOVED,
		COMSIG_LIVING_STATUS_PARALYZE,
		COMSIG_LIVING_STATUS_STAGGER,))

// ***************************************
// *********** Headbutt Charge
// ***************************************
/datum/action/ability/xeno_action/headbutt
	name = "Headbutt Charge"
	action_icon_state = "bull_headbutt"
	desc = "The headbutt charge, when it hits a host, stops your charge while push them away."
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_BULLHEADBUTT,
	)
	var/turf/last_turf
	cooldown_duration = 15 SECONDS
	ability_cost = 40
	var/charge_duration

/datum/action/ability/xeno_action/headbutt/can_use_action()
	var/mob/living/carbon/xenomorph/bull/X = owner
	if(X.bull_charging)
		return FALSE
	return ..()

/datum/action/ability/xeno_action/headbutt/action_activate()
	var/mob/living/carbon/xenomorph/X = owner
	if(!do_after(X, 1 SECONDS, NONE, X, BUSY_ICON_DANGER))
		if(!X.stat)
			X.set_canmove(TRUE)
		return fail_activate()
	X.emote("roar")
	X.set_canmove(TRUE)
	X.bull_charging = TRUE
	X.add_movespeed_modifier(MOVESPEED_ID_BULL_HEADBUTT_CHARGE, TRUE, 0, NONE, TRUE, X.xeno_caste.speed * 1.2)
	charge_duration = addtimer(CALLBACK(src, PROC_REF(headbutt_charge_deactivate)), 3 SECONDS, TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE)
	RegisterSignals(X, list(COMSIG_LIVING_STATUS_PARALYZE, COMSIG_LIVING_STATUS_STAGGER), PROC_REF(headbutt_charge_deactivate))
	RegisterSignal(X, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(bull_charge_slash))
	RegisterSignal(X, COMSIG_MOVABLE_MOVED, PROC_REF(afterimage))
	X.icon_state = "[X.xeno_caste.caste_name][X.is_a_rouny ? " rouny" : ""] Charging"
	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/headbutt/proc/bull_charge_slash(datum/source, mob/living/target, damage, list/damage_mod)
	var/mob/living/carbon/xenomorph/X = owner
	var/headbutt_throw_range = 6

	if(target.stat == DEAD)
		return

	target.knockback(X, headbutt_throw_range, 1)
	target.Paralyze(1 SECONDS)

	playsound(target,'sound/weapons/alien_knockdown.ogg', 75, 1)
	X.visible_message(span_danger("[X] pushed away [target]!"),
		span_xenowarning("We push away [target] and skid to a halt!"))
	headbutt_charge_deactivate()

/datum/action/ability/xeno_action/headbutt/proc/headbutt_charge_deactivate()
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/X = owner
	X.remove_movespeed_modifier(MOVESPEED_ID_BULL_HEADBUTT_CHARGE)
	X.update_icons()
	X.bull_charging = FALSE

	UnregisterSignal(owner, list(
		COMSIG_MOVABLE_MOVED,
		COMSIG_XENOMORPH_ATTACK_LIVING,
		COMSIG_LIVING_STATUS_PARALYZE,
		COMSIG_LIVING_STATUS_STAGGER,))

// ***************************************
// *********** Gore Charge
// ***************************************
/datum/action/ability/xeno_action/gore
	name = "Gore Charge"
	action_icon_state = "bull_gore"
	desc = "The gore charge, when it hits a host, stops your charge while dealing a large amount of damage."
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_BULLGORE,
	)
	var/turf/last_turf
	cooldown_duration = 4 SECONDS
	ability_cost = 40
	var/charge_duration

/datum/action/ability/xeno_action/gore/can_use_action()
	var/mob/living/carbon/xenomorph/bull/X = owner
	if(X.bull_charging)
		return FALSE
	return ..()

/datum/action/ability/xeno_action/gore/action_activate()
	var/mob/living/carbon/xenomorph/X = owner
	if(!do_after(X, 0.5 SECONDS, NONE, X, BUSY_ICON_DANGER))
		if(!X.stat)
			X.set_canmove(TRUE)
		return fail_activate()
	X.emote("roar")
	X.set_canmove(TRUE)
	X.bull_charging = TRUE
	X.add_movespeed_modifier(MOVESPEED_ID_BULL_GORE_CHARGE, TRUE, 0, NONE, TRUE, X.xeno_caste.speed * 1.2)
	charge_duration = addtimer(CALLBACK(src, PROC_REF(gore_charge_deactivate)), 2 SECONDS, TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE)
	RegisterSignals(X, list(COMSIG_LIVING_STATUS_PARALYZE, COMSIG_LIVING_STATUS_STAGGER), PROC_REF(gore_charge_deactivate))
	RegisterSignal(X, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(bull_charge_slash))
	RegisterSignal(X, COMSIG_MOVABLE_MOVED, PROC_REF(afterimage))
	X.icon_state = "[X.xeno_caste.caste_name][X.is_a_rouny ? " rouny" : ""] Charging"

	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/gore/proc/bull_charge_slash(datum/source, mob/living/target, damage, list/damage_mod)
	var/mob/living/carbon/xenomorph/X = owner

	if(target.stat == DEAD)
		return

	damage = X.xeno_caste.melee_damage * X.xeno_melee_damage_modifier * 2.6
	target.apply_damage(damage, BRUTE, X.zone_selected, MELEE)
	playsound(target,'sound/weapons/alien_tail_attack.ogg', 75, 1)
	target.emote_gored()
	X.visible_message(span_danger("[X] gores [target]!"),
		span_xenowarning("We gore [target] and skid to a halt!"))
	gore_charge_deactivate()

/datum/action/ability/xeno_action/gore/proc/gore_charge_deactivate()
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/X = owner
	X.remove_movespeed_modifier(MOVESPEED_ID_BULL_GORE_CHARGE)
	X.update_icons()
	X.bull_charging = FALSE

	UnregisterSignal(owner, list(
		COMSIG_MOVABLE_MOVED,
		COMSIG_XENOMORPH_ATTACK_LIVING,
		COMSIG_LIVING_STATUS_PARALYZE,
		COMSIG_LIVING_STATUS_STAGGER,))

// ***************************************
// *********** Tolerate
// ***************************************

/datum/action/ability/xeno_action/tolerate
	name = "Tolerate"
	action_icon_state = "bull_ready_charge"
	desc = "For the next few seconds, you will become resistant to slowdown, stagger and stuns."
	use_state_flags = ABILITY_USE_STAGGERED
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TOLERATE,
	)
	cooldown_duration = 60 SECONDS
	ability_cost = 40

/datum/action/ability/xeno_action/tolerate/action_activate()
	var/mob/living/carbon/xenomorph/X = owner

	addtimer(CALLBACK(src, PROC_REF(tolerate_deactivate)), 20 SECONDS, TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE)
	X.set_stagger(0)
	X.set_slowdown(0)
	X.add_filter("bull_tolerate_outline", 4, outline_filter(1, COLOR_RED))
	ADD_TRAIT(X, TRAIT_STAGGERIMMUNE, XENO_TRAIT)
	ADD_TRAIT(X, TRAIT_SLOWDOWNIMMUNE, XENO_TRAIT)
	ADD_TRAIT(X, TRAIT_STUNIMMUNE, XENO_TRAIT)

	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/tolerate/proc/tolerate_deactivate()
	var/mob/living/carbon/xenomorph/X = owner
	X.remove_filter("bull_tolerate_outline")
	REMOVE_TRAIT(X, TRAIT_STAGGERIMMUNE, XENO_TRAIT)
	REMOVE_TRAIT(X, TRAIT_SLOWDOWNIMMUNE, XENO_TRAIT)
	REMOVE_TRAIT(X, TRAIT_STUNIMMUNE, XENO_TRAIT)
	X.update_icons()


