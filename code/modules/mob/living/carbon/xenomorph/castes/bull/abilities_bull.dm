/// Produce after_image and loud footsteps for bull charges
/datum/action/ability/xeno_action/proc/afterimage(atom/A, atom/OldLoc, Dir, Forced)
	SIGNAL_HANDLER
	new/obj/effect/temp_visual/after_image(get_turf(xeno_owner), xeno_owner)
	playsound(xeno_owner, SFX_ALIEN_FOOTSTEP_LARGE, 50)

// ***************************************
// *********** Acid Charge
// ***************************************
/datum/action/ability/xeno_action/acid_charge
	name = "Acid Charge"
	desc = "The acid charge, deal small damage to yourself and start leaving acid puddles after your steps."
	action_icon_state = "bull_charge"
	action_icon = 'icons/Xeno/actions/bull.dmi'
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
	if(xeno_owner.bull_charging)
		return FALSE
	return ..()

/datum/action/ability/xeno_action/acid_charge/action_activate()
	if(!do_after(xeno_owner, 0.5 SECONDS, IGNORE_LOC_CHANGE, xeno_owner, BUSY_ICON_DANGER))
		if(!xeno_owner.stat)
			xeno_owner.set_canmove(TRUE)
		return fail_activate()
	particle_holder = new(xeno_owner, /particles/bull_selfslash)
	particle_holder.pixel_y = 12
	particle_holder.pixel_x = 18
	START_PROCESSING(SSprocessing, src)
	QDEL_NULL_IN(src, particle_holder, 5)
	playsound(xeno_owner,'sound/weapons/alien_bite1.ogg', 75, 1)
	xeno_owner.emote("hiss")
	xeno_owner.set_canmove(TRUE)
	xeno_owner.bull_charging = TRUE
	xeno_owner.add_movespeed_modifier(MOVESPEED_ID_BULL_ACID_CHARGE, TRUE, 0, NONE, TRUE, xeno_owner.xeno_caste.speed * 1.2)
	charge_duration = addtimer(CALLBACK(src, PROC_REF(acid_charge_deactivate)), 2 SECONDS,  TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE)
	RegisterSignals(xeno_owner, list(COMSIG_LIVING_STATUS_PARALYZE, COMSIG_LIVING_STATUS_STAGGER), PROC_REF(acid_charge_deactivate))
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_MOVED, PROC_REF(acid_puddle))
	xeno_owner.icon_state = "[xeno_owner.xeno_caste.caste_name] Charging"

	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/acid_charge/proc/acid_charge_deactivate()
	SIGNAL_HANDLER
	xeno_owner.remove_movespeed_modifier(MOVESPEED_ID_BULL_ACID_CHARGE)
	xeno_owner.update_icons()
	xeno_owner.bull_charging = FALSE

	UnregisterSignal(owner, list(
		COMSIG_MOVABLE_MOVED,
		COMSIG_LIVING_STATUS_PARALYZE,
		COMSIG_LIVING_STATUS_STAGGER,))

/datum/action/ability/xeno_action/acid_charge/proc/acid_puddle(atom/A, atom/OldLoc, Dir, Forced)
	SIGNAL_HANDLER
	new/obj/effect/temp_visual/after_image(get_turf(xeno_owner), xeno_owner)
	new /obj/effect/xenomorph/spray(get_turf(xeno_owner), 5 SECONDS, XENO_ACID_CHARGE_DAMAGE)
	for(var/obj/O in get_turf(xeno_owner))
		O.acid_spray_act(xeno_owner)
		playsound(xeno_owner, SFX_ALIEN_FOOTSTEP_LARGE, 50)

// ***************************************
// *********** Headbutt Charge
// ***************************************
/datum/action/ability/xeno_action/headbutt
	name = "Headbutt Charge"
	desc = "The headbutt charge, when it hits a host, stops your charge while push them away."
	action_icon_state = "bull_headbutt"
	action_icon = 'icons/Xeno/actions/bull.dmi'
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_BULLHEADBUTT,
	)
	cooldown_duration = 15 SECONDS
	ability_cost = 40
	var/turf/last_turf
	var/charge_duration

/datum/action/ability/xeno_action/headbutt/can_use_action()
	if(xeno_owner.bull_charging)
		return FALSE
	return ..()

/datum/action/ability/xeno_action/headbutt/action_activate()
	if(!do_after(xeno_owner, 0.5 SECONDS, IGNORE_LOC_CHANGE, xeno_owner, BUSY_ICON_DANGER))
		if(!xeno_owner.stat)
			xeno_owner.set_canmove(TRUE)
		return fail_activate()
	xeno_owner.emote("roar")
	xeno_owner.set_canmove(TRUE)
	xeno_owner.bull_charging = TRUE
	xeno_owner.add_movespeed_modifier(MOVESPEED_ID_BULL_HEADBUTT_CHARGE, TRUE, 0, NONE, TRUE, xeno_owner.xeno_caste.speed * 1.2)
	charge_duration = addtimer(CALLBACK(src, PROC_REF(headbutt_charge_deactivate)), 3 SECONDS, TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE)
	RegisterSignals(xeno_owner, list(COMSIG_LIVING_STATUS_PARALYZE, COMSIG_LIVING_STATUS_STAGGER), PROC_REF(headbutt_charge_deactivate))
	RegisterSignal(xeno_owner, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(bull_charge_slash))
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_MOVED, PROC_REF(afterimage))
	xeno_owner.icon_state = "[xeno_owner.xeno_caste.caste_name] Charging"
	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/headbutt/proc/bull_charge_slash(datum/source, mob/living/target, damage, list/damage_mod)
	var/headbutt_throw_range = 6

	if(target.stat == DEAD)
		return

	target.knockback(xeno_owner, headbutt_throw_range, 1)
	target.Paralyze(1 SECONDS)

	playsound(target,'sound/weapons/alien_knockdown.ogg', 75, 1)
	xeno_owner.visible_message(span_danger("[xeno_owner] pushed away [target]!"),
		span_xenowarning("We push away [target] and skid to a halt!"))
	headbutt_charge_deactivate()

/datum/action/ability/xeno_action/headbutt/proc/headbutt_charge_deactivate()
	SIGNAL_HANDLER
	xeno_owner.remove_movespeed_modifier(MOVESPEED_ID_BULL_HEADBUTT_CHARGE)
	xeno_owner.update_icons()
	xeno_owner.bull_charging = FALSE

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
	desc = "The gore charge, when it hits a host, stops your charge while dealing a large amount of damage."
	action_icon_state = "bull_gore"
	action_icon = 'icons/Xeno/actions/bull.dmi'
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_BULLGORE,
	)
	cooldown_duration = 4 SECONDS
	ability_cost = 40
	var/turf/last_turf
	var/charge_duration

/datum/action/ability/xeno_action/gore/can_use_action()
	if(xeno_owner.bull_charging)
		return FALSE
	return ..()

/datum/action/ability/xeno_action/gore/action_activate()
	if(!do_after(xeno_owner, 0.5 SECONDS, IGNORE_LOC_CHANGE, xeno_owner, BUSY_ICON_DANGER))
		if(!xeno_owner.stat)
			xeno_owner.set_canmove(TRUE)
		return fail_activate()
	xeno_owner.emote("roar")
	xeno_owner.set_canmove(TRUE)
	xeno_owner.bull_charging = TRUE
	xeno_owner.add_movespeed_modifier(MOVESPEED_ID_BULL_GORE_CHARGE, TRUE, 0, NONE, TRUE, xeno_owner.xeno_caste.speed * 1.2)
	charge_duration = addtimer(CALLBACK(src, PROC_REF(gore_charge_deactivate)), 2 SECONDS, TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE)
	RegisterSignals(xeno_owner, list(COMSIG_LIVING_STATUS_PARALYZE, COMSIG_LIVING_STATUS_STAGGER), PROC_REF(gore_charge_deactivate))
	RegisterSignal(xeno_owner, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(bull_charge_slash))
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_MOVED, PROC_REF(afterimage))
	xeno_owner.icon_state = "[xeno_owner.xeno_caste.caste_name] Charging"

	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/gore/proc/bull_charge_slash(datum/source, mob/living/target, damage, list/damage_mod)
	if(target.stat == DEAD)
		return

	damage = xeno_owner.xeno_caste.melee_damage * xeno_owner.xeno_melee_damage_modifier * 2.6
	target.apply_damage(damage, BRUTE, xeno_owner.zone_selected, MELEE)
	playsound(target,'sound/weapons/alien_tail_attack.ogg', 75, 1)
	target.emote_gored()
	xeno_owner.visible_message(span_danger("[xeno_owner] gores [target]!"),
		span_xenowarning("We gore [target] and skid to a halt!"))
	gore_charge_deactivate()

/datum/action/ability/xeno_action/gore/proc/gore_charge_deactivate()
	SIGNAL_HANDLER
	xeno_owner.remove_movespeed_modifier(MOVESPEED_ID_BULL_GORE_CHARGE)
	xeno_owner.update_icons()
	xeno_owner.bull_charging = FALSE

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
	desc = "For the next few seconds, you will become resistant to slowdown, stagger and stuns."
	action_icon_state = "bull_ready_charge"
	action_icon = 'icons/Xeno/actions/bull.dmi'
	use_state_flags = ABILITY_USE_STAGGERED
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TOLERATE,
	)
	cooldown_duration = 60 SECONDS
	ability_cost = 40

/datum/action/ability/xeno_action/tolerate/action_activate()
	addtimer(CALLBACK(src, PROC_REF(tolerate_deactivate)), 20 SECONDS, TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE)
	xeno_owner.set_stagger(0)
	xeno_owner.set_slowdown(0)
	xeno_owner.add_filter("bull_tolerate_outline", 4, outline_filter(1, COLOR_RED))
	ADD_TRAIT(xeno_owner, TRAIT_STAGGERIMMUNE, XENO_TRAIT)
	ADD_TRAIT(xeno_owner, TRAIT_SLOWDOWNIMMUNE, XENO_TRAIT)
	ADD_TRAIT(xeno_owner, TRAIT_STUNIMMUNE, XENO_TRAIT)

	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/tolerate/proc/tolerate_deactivate()
	xeno_owner.remove_filter("bull_tolerate_outline")
	REMOVE_TRAIT(xeno_owner, TRAIT_STAGGERIMMUNE, XENO_TRAIT)
	REMOVE_TRAIT(xeno_owner, TRAIT_SLOWDOWNIMMUNE, XENO_TRAIT)
	REMOVE_TRAIT(xeno_owner, TRAIT_STUNIMMUNE, XENO_TRAIT)
	xeno_owner.update_icons()
