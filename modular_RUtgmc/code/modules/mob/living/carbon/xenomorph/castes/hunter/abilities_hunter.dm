#define DISGUISE_SLOWDOWN 2

/datum/action/ability/xeno_action/mirage/swap()
	. = ..()
	owner.drop_all_held_items() // drop items (hugger/jelly)

// ***************************************
// *********** Stealth
// ***************************************
/datum/action/ability/xeno_action/stealth
	name = "Toggle Stealth"
	action_icon_state = "hunter_invisibility"
	desc = "Become harder to see, almost invisible if you stand still, and ready a sneak attack. Uses plasma to move."
	ability_cost = 10
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TOGGLE_STEALTH,
	)
	cooldown_duration = HUNTER_STEALTH_COOLDOWN
	var/last_stealth = null
	var/stealth = FALSE
	var/can_sneak_attack = FALSE
	var/stealth_alpha_multiplier = 1

/datum/action/ability/xeno_action/stealth/remove_action(mob/living/L)
	if(stealth)
		cancel_stealth()
	return ..()

/datum/action/ability/xeno_action/stealth/can_use_action(silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/xenomorph/stealthy_beno = owner
	if(stealthy_beno.on_fire)
		owner.balloon_alert(stealthy_beno, "Cannot enter Stealth!")
		return FALSE
	return TRUE

/datum/action/ability/xeno_action/stealth/on_cooldown_finish()
	owner.balloon_alert(owner, "Stealth ready.")
	playsound(owner, "sound/effects/xeno_newlarva.ogg", 25, 0, 1)
	return ..()

/datum/action/ability/xeno_action/stealth/action_activate()
	if(stealth)
		cancel_stealth()
		return TRUE
	if(HAS_TRAIT_FROM(owner, TRAIT_TURRET_HIDDEN, STEALTH_TRAIT))   // stops stealth and disguise from stacking
		owner.balloon_alert(owner, "Already in a form of stealth!")
		return
	succeed_activate()
	owner.balloon_alert(owner, "We vanish into the shadows.")
	last_stealth = world.time
	stealth = TRUE

	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(handle_stealth))
	RegisterSignal(owner, COMSIG_XENOMORPH_POUNCE_END, PROC_REF(sneak_attack_pounce))
	RegisterSignal(owner, COMSIG_XENO_LIVING_THROW_HIT, PROC_REF(mob_hit))
	RegisterSignal(owner, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(sneak_attack_slash))
	RegisterSignal(owner, COMSIG_XENOMORPH_DISARM_HUMAN, PROC_REF(sneak_attack_slash))
	RegisterSignal(owner, COMSIG_XENOMORPH_ZONE_SELECT, PROC_REF(sneak_attack_zone))
	RegisterSignal(owner, COMSIG_XENOMORPH_PLASMA_REGEN, PROC_REF(plasma_regen))

	// TODO: attack_alien() overrides are a mess and need a lot of work to make them require parentcalling
	RegisterSignals(owner, list(
		COMSIG_XENOMORPH_GRAB,
		COMSIG_XENOMORPH_THROW_HIT,
		COMSIG_LIVING_IGNITED,
		COMSIG_LIVING_ADD_VENTCRAWL), PROC_REF(cancel_stealth))

	RegisterSignal(owner, COMSIG_XENOMORPH_ATTACK_OBJ, PROC_REF(on_obj_attack))

	RegisterSignals(owner, list(SIGNAL_ADDTRAIT(TRAIT_KNOCKEDOUT), SIGNAL_ADDTRAIT(TRAIT_FLOORED)), PROC_REF(cancel_stealth))

	RegisterSignal(owner, COMSIG_XENOMORPH_TAKING_DAMAGE, PROC_REF(damage_taken))

	ADD_TRAIT(owner, TRAIT_TURRET_HIDDEN, STEALTH_TRAIT)

	handle_stealth()
	addtimer(CALLBACK(src, PROC_REF(sneak_attack_cooldown)), HUNTER_POUNCE_SNEAKATTACK_DELAY) //Short delay before we can sneak attack.
	START_PROCESSING(SSprocessing, src)

/datum/action/ability/xeno_action/stealth/proc/cancel_stealth() //This happens if we take damage, attack, pounce, toggle stealth off, and do other such exciting stealth breaking activities.
	SIGNAL_HANDLER
	add_cooldown()
	owner.balloon_alert(owner, "We emerge from the shadows.")

	UnregisterSignal(owner, list(
		COMSIG_MOVABLE_MOVED,
		COMSIG_XENOMORPH_POUNCE_END,
		COMSIG_XENO_LIVING_THROW_HIT,
		COMSIG_XENOMORPH_ATTACK_LIVING,
		COMSIG_XENOMORPH_DISARM_HUMAN,
		COMSIG_XENOMORPH_GRAB,
		COMSIG_XENOMORPH_ATTACK_OBJ,
		COMSIG_XENOMORPH_THROW_HIT,
		COMSIG_LIVING_IGNITED,
		COMSIG_LIVING_ADD_VENTCRAWL,
		SIGNAL_ADDTRAIT(TRAIT_KNOCKEDOUT),
		SIGNAL_ADDTRAIT(TRAIT_FLOORED),
		COMSIG_XENOMORPH_ZONE_SELECT,
		COMSIG_XENOMORPH_PLASMA_REGEN,
		COMSIG_XENOMORPH_TAKING_DAMAGE,))

	stealth = FALSE
	can_sneak_attack = FALSE
	REMOVE_TRAIT(owner, TRAIT_TURRET_HIDDEN, STEALTH_TRAIT)
	animate(owner, 1 SECONDS, alpha = 255) //no transparency/translucency

///Signal wrapper to verify that an object is damageable before breaking stealth
/datum/action/ability/xeno_action/stealth/proc/on_obj_attack(datum/source, obj/attacked)
	SIGNAL_HANDLER
	if(attacked.resistance_flags & XENO_DAMAGEABLE)
		cancel_stealth()

/datum/action/ability/xeno_action/stealth/proc/sneak_attack_cooldown()
	if(!stealth || can_sneak_attack)
		return
	can_sneak_attack = TRUE
	owner.balloon_alert(owner, "Sneak Attack ready.")
	playsound(owner, "sound/effects/xeno_newlarva.ogg", 25, 0, 1)

/datum/action/ability/xeno_action/stealth/process()
	if(!stealth)
		return PROCESS_KILL
	handle_stealth()

/datum/action/ability/xeno_action/stealth/proc/handle_stealth()
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/xenoowner = owner
	//Initial stealth
	if(last_stealth > world.time - HUNTER_STEALTH_INITIAL_DELAY) //We don't start out at max invisibility
		animate(owner, 1.5 SECONDS, alpha = HUNTER_STEALTH_RUN_ALPHA * stealth_alpha_multiplier)
		return
	//Stationary stealth
	else if(owner.last_move_intent < world.time - HUNTER_STEALTH_STEALTH_DELAY) //If we're standing still for 4 seconds we become almost completely invisible
		animate(owner, 0.5 SECONDS, alpha = HUNTER_STEALTH_STILL_ALPHA * stealth_alpha_multiplier)
	//Walking stealth
	else if(owner.m_intent == MOVE_INTENT_WALK)
		handle_plasma_usage(xenoowner, HUNTER_STEALTH_WALK_PLASMADRAIN)
		animate(owner, 0.5 SECONDS, alpha = HUNTER_STEALTH_WALK_ALPHA * stealth_alpha_multiplier)
	//Running stealth
	else
		handle_plasma_usage(xenoowner, HUNTER_STEALTH_RUN_PLASMADRAIN)
		animate(owner, 0.5 SECONDS, alpha = HUNTER_STEALTH_RUN_ALPHA * stealth_alpha_multiplier)
	//If we have 0 plasma after expending stealth's upkeep plasma, end stealth.
	if(!xenoowner.plasma_stored)
		to_chat(xenoowner, span_xenodanger("We lack sufficient plasma to remain camouflaged."))
		cancel_stealth()

/datum/action/ability/xeno_action/stealth/proc/handle_plasma_usage(mob/user, amount)
	var/mob/living/carbon/xenomorph/xeno = user
	if(ispath(xeno.loc_weeds_type, /obj/alien/weeds))
		return
	else
		xeno.use_plasma(amount)

/// Callback listening for a xeno using the pounce ability
/datum/action/ability/xeno_action/stealth/proc/sneak_attack_pounce()
	SIGNAL_HANDLER
	if(owner.m_intent == MOVE_INTENT_WALK)
		owner.toggle_move_intent(MOVE_INTENT_RUN)
		if(owner.hud_used?.move_intent)
			owner.hud_used.move_intent.icon_state = "running"
		owner.update_icons()

	cancel_stealth()

/// Callback for when a mob gets hit as part of a pounce
/datum/action/ability/xeno_action/stealth/proc/mob_hit(datum/source, mob/living/M)
	SIGNAL_HANDLER
	if(M.stat || isxeno(M))
		return
	if(can_sneak_attack)
		M.adjust_stagger(3 SECONDS)
		M.add_slowdown(1)
		to_chat(owner, span_xenodanger("Pouncing from the shadows, we stagger our victim."))

/datum/action/ability/xeno_action/stealth/proc/sneak_attack_slash(datum/source, mob/living/target, damage, list/damage_mod, list/armor_mod)
	SIGNAL_HANDLER
	if(!can_sneak_attack)
		return

	var/mob/living/carbon/xenomorph/xeno = owner
	damage = xeno.xeno_caste.melee_damage * xeno.xeno_melee_damage_modifier

	owner.visible_message(span_danger("\The [owner] strikes [target] with vicious precision!"), \
	span_danger("We strike [target] with vicious precision!"))
	target.adjust_stagger(2 SECONDS)
	target.add_slowdown(1)
	target.ParalyzeNoChain(1 SECONDS)
	target.apply_damage(damage, BRUTE, xeno.zone_selected, MELEE) // additional damage

	cancel_stealth()

/datum/action/ability/xeno_action/stealth/proc/damage_taken(mob/living/carbon/xenomorph/X, damage_taken)
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/xenoowner = owner
	if(damage_taken > xenoowner.xeno_caste.stealth_break_threshold)
		cancel_stealth()

/datum/action/ability/xeno_action/stealth/proc/plasma_regen(datum/source, list/plasma_mod)
	SIGNAL_HANDLER
	if(owner.last_move_intent < world.time - 20) //Stealth halves the rate of plasma recovery on weeds, and eliminates it entirely while moving
		plasma_mod[1] *= 0.5
	else
		plasma_mod[1] = 0

/datum/action/ability/xeno_action/stealth/proc/sneak_attack_zone()
	SIGNAL_HANDLER
	if(!can_sneak_attack)
		return
	return COMSIG_ACCURATE_ZONE

/datum/action/ability/xeno_action/stealth/disguise
	name = "Disguise"
	action_icon_state = "xenohide"
	desc = "Disguise yourself as the enemy. Uses plasma to move. Select your disguise with Hunter's Mark."
	cooldown_duration = 15 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TOGGLE_DISGUISE,
	)
	///the regular appearance of the hunter
	var/old_appearance

/datum/action/ability/xeno_action/stealth/disguise/action_activate()
	if(stealth)
		cancel_stealth()
		return TRUE
	var/mob/living/carbon/xenomorph/xenoowner = owner
	var/datum/action/ability/activable/xeno/hunter_mark/mark = xenoowner.actions_by_path[/datum/action/ability/activable/xeno/hunter_mark]
	if(HAS_TRAIT_FROM(owner, TRAIT_TURRET_HIDDEN, STEALTH_TRAIT))   // stops stealth and disguise from stacking
		owner.balloon_alert(owner, "already in a form of stealth!")
		return
	if(!mark.marked_target)
		owner.balloon_alert(owner, "We have no target to disguise into!")
		return
	if(!isliving(mark.marked_target))
		owner.balloon_alert(owner, "You cannot turn into this object!")
		return
	if(!do_after(xenoowner, 1.5 SECONDS, IGNORE_LOC_CHANGE, xenoowner, BUSY_ICON_HOSTILE))
		return
	old_appearance = xenoowner.appearance
	ADD_TRAIT(xenoowner, TRAIT_MOB_ICON_UPDATE_BLOCKED, STEALTH_TRAIT)
	xenoowner.update_wounds()
	xenoowner.add_movespeed_modifier(MOVESPEED_ID_HUNTER_DISGUISE, TRUE, 0, NONE, TRUE, DISGUISE_SLOWDOWN)
	return ..()

/datum/action/ability/xeno_action/stealth/disguise/cancel_stealth()
	. = ..()
	owner.appearance = old_appearance
	REMOVE_TRAIT(owner, TRAIT_MOB_ICON_UPDATE_BLOCKED, STEALTH_TRAIT)
	var/mob/living/carbon/xenomorph/xenoowner = owner
	xenoowner.update_wounds()
	xenoowner.remove_movespeed_modifier(MOVESPEED_ID_HUNTER_DISGUISE, TRUE)

/datum/action/ability/xeno_action/stealth/disguise/handle_stealth()
	var/mob/living/carbon/xenomorph/xenoowner = owner
	var/datum/action/ability/activable/xeno/hunter_mark/mark = xenoowner.actions_by_path[/datum/action/ability/activable/xeno/hunter_mark]
	var/old_layer = xenoowner.layer
	xenoowner.appearance = mark.marked_target.appearance
	//Retaining old rendering layer to prevent rendering under objects.
	xenoowner.layer = old_layer
	xenoowner.underlays.Cut()
	if(owner.last_move_intent >= world.time - HUNTER_STEALTH_STEALTH_DELAY)
		xenoowner.use_plasma(owner.m_intent == MOVE_INTENT_WALK ? HUNTER_STEALTH_WALK_PLASMADRAIN : HUNTER_STEALTH_RUN_PLASMADRAIN)
	//If we have 0 plasma after expending stealth's upkeep plasma, end stealth.
	if(!xenoowner.plasma_stored)
		to_chat(xenoowner, span_xenodanger("We lack sufficient plasma to remain disguised."))
		cancel_stealth()

/datum/action/ability/xeno_action/stealth/disguise/sneak_attack_slash(datum/source, mob/living/target, damage, list/damage_mod, list/armor_mod)
	if(!can_sneak_attack)
		return

	var/mob/living/carbon/xenomorph/xeno = owner

	owner.visible_message(span_danger("\The [owner] strikes [target] with deadly precision!"), \
	span_danger("We strike [target] with deadly precision!"))
	target.ParalyzeNoChain(1 SECONDS)
	target.apply_damage(20, BRUTE, xeno.zone_selected) // additional damage

	cancel_stealth()

// ***************************************
// *********** Hunter's Mark
// ***************************************
/datum/action/ability/activable/xeno/hunter_mark
	cooldown_duration = 10 SECONDS

#undef DISGUISE_SLOWDOWN
