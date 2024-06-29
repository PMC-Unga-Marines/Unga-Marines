/// runner abilities
/datum/action/ability/activable/xeno/psydrain/panther
	ability_cost = 10

/datum/action/ability/activable/xeno/pounce/panther
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PANTHER_POUNCE,
	)
	cooldown_duration = 13 SECONDS
	ability_cost = 20
	var/pantherplasmaheal = 45

/datum/action/ability/activable/xeno/pounce/panther/mob_hit(datum/source, mob/living/M)
	. = ..()
	var/mob/living/carbon/xenomorph/xenomorph_owner = owner
	xenomorph_owner.plasma_stored += pantherplasmaheal

///////////////////////////////////
// ***************************************
// *********** Tearing tail
// ***************************************

/datum/action/ability/xeno_action/tearingtail
	name = "Tearing tail"
	action_icon_state = "tearing_tail"
	desc = "Hit all nearby enemies around you, poisoning them with selected toxin and healing you for each target hit."
	ability_cost = 50
	cooldown_duration = 15 SECONDS
	var/tearing_tail_reagent
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TEARING_TAIL,
	)

/datum/action/ability/xeno_action/tearingtail/action_activate()
	var/mob/living/carbon/xenomorph/xenomorph_owner = owner

	xenomorph_owner.add_filter("defender_tail_sweep", 2, gauss_blur_filter(1)) //Add cool SFX
	xenomorph_owner.spin(4, 1)
	xenomorph_owner.enable_throw_parry(0.6 SECONDS)
	playsound(xenomorph_owner,pick('sound/effects/alien_tail_swipe1.ogg','sound/effects/alien_tail_swipe2.ogg','sound/effects/alien_tail_swipe3.ogg'), 25, 1) //Sound effects

	var/sweep_range = 1
	var/list/L = orange(sweep_range, xenomorph_owner) // Not actually the fruit

	for(var/mob/living/carbon/human/human_target in L)
		step_away(human_target, src, sweep_range, 2)
		if(human_target.stat != DEAD && !isnestedhost(human_target) ) //No bullying
			var/damage = xenomorph_owner.xeno_caste.melee_damage
			var/affecting = human_target.get_limb(ran_zone(null, 0))
			if(!affecting) //Still nothing??
				affecting = human_target.get_limb("chest") //Gotta have a torso?!
			human_target.apply_damage(damage, BRUTE, affecting, MELEE)
			xenomorph_owner.plasma_stored += 25
			xenomorph_owner.heal_overall_damage(25, 25, updating_health = TRUE)
			if(human_target.can_sting())
				tearing_tail_reagent = xenomorph_owner.selected_reagent
				var/reagent_amount = (xenomorph_owner.selected_reagent == /datum/reagent/toxin/xeno_ozelomelyn) ? PANTHER_TEARING_TAIL_REAGENT_AMOUNT * 0.5 : PANTHER_TEARING_TAIL_REAGENT_AMOUNT
				human_target.reagents.add_reagent(tearing_tail_reagent, reagent_amount)
				playsound(human_target, 'sound/effects/spray3.ogg', 15, TRUE)
			shake_camera(human_target, 2, 1)
			to_chat(human_target, span_xenowarning("We are hit by \the [xenomorph_owner]'s tail sweep!"))
			playsound(human_target,'sound/weapons/alien_tail_attack.ogg', 50, 1)

	addtimer(CALLBACK(xenomorph_owner, TYPE_PROC_REF(/atom, remove_filter), "defender_tail_sweep"), 0.5 SECONDS) //Remove cool SFX
	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/tearingtail/on_cooldown_finish()
	var/mob/living/carbon/xenomorph/xenomorph_owner = owner
	to_chat(xenomorph_owner, span_notice("We gather enough strength to tear the skin again."))
	owner.playsound_local(owner, 'sound/effects/xeno_newlarva.ogg', 25, 0, 1)
	return ..()

///////////////////////////////////
// ***************************************
// *********** Adrenaline Jump
// ***************************************
// lunge+fling idk

/datum/action/ability/activable/xeno/adrenalinejump
	name = "Adrenaline Jump"
	action_icon_state = "adrenaline_jump"
	desc = "Jump from some distance to target, knocking them down and pulling them to you, only works if you are at least from 3 to 8 meters away from the target, this ability sends Pounce on cooldown."
	ability_cost = 15
	cooldown_duration = 12 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_ADRENALINE_JUMP,
	)
	target_flags = ABILITY_MOB_TARGET
	/// The target of our lunge, we keep it to check if we are adjacent everytime we move
	var/atom/lunge_target

/datum/action/ability/activable/xeno/adrenalinejump/on_cooldown_finish()
	to_chat(owner, span_xenodanger("We ready ourselves to jump again."))
	owner.playsound_local(owner, 'sound/effects/xeno_newlarva.ogg', 25, 0, 1)
	return ..()

/datum/action/ability/activable/xeno/adrenalinejump/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE

	if(get_dist_euclidean_square(A, owner) > 64) //8 tiles range
		if(!silent)
			to_chat(owner, span_xenonotice("You are too far!"))
		return FALSE

	if(!line_of_sight(A, owner))
		if(!silent)
			owner.balloon_alert(owner, "We need clear jump line!")
		return FALSE

	if(!isliving(A))
		if(!silent)
			to_chat(owner, span_xenodanger("We can't jump at that!"))
		return FALSE

	var/mob/living/living_target = A
	if(living_target.stat == DEAD)
		if(!silent)
			to_chat(owner, span_xenodanger("We can't jump at that!"))
		return FALSE

/datum/action/ability/activable/xeno/adrenalinejump/use_ability(atom/targeted_atom)
	var/mob/living/carbon/xenomorph/xenomorph_owner = owner

	xenomorph_owner.visible_message(span_xenowarning("\The [xenomorph_owner] jump towards [targeted_atom]!"), \
	span_xenowarning("We jump at [targeted_atom]!"))

	lunge_target = targeted_atom

	RegisterSignal(lunge_target, COMSIG_QDELETING, PROC_REF(clean_lunge_target))
	RegisterSignal(xenomorph_owner, COMSIG_MOVABLE_MOVED, PROC_REF(check_if_lunge_possible))
	RegisterSignal(xenomorph_owner, COMSIG_MOVABLE_POST_THROW, PROC_REF(clean_lunge_target))

	if(lunge_target.Adjacent(xenomorph_owner)) //They're already in range, pat their head, we messed up.
		to_chat(xenomorph_owner, span_xenodanger("We lost some of the adrenaline due to failed jump!."))
		playsound(xenomorph_owner,'sound/weapons/thudswoosh.ogg', 75, 1)
		xenomorph_owner.plasma_stored -= 50
		clean_lunge_target()
	else
		xenomorph_owner.throw_at(get_step_towards(targeted_atom, xenomorph_owner), 6, 2, xenomorph_owner)

	succeed_activate()
	add_cooldown()
	var/datum/action/ability/xeno_action/pounce = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/pounce/panther]
	if(pounce)
		pounce.add_cooldown()

	return TRUE

///Check if we are close enough to lunge, and if yes, fling them
/datum/action/ability/activable/xeno/adrenalinejump/proc/check_if_lunge_possible(datum/source)
	SIGNAL_HANDLER
	if(!lunge_target.Adjacent(source))
		return
	INVOKE_ASYNC(src, PROC_REF(pantherfling), lunge_target)

/// Null lunge target and reset throw vars
/datum/action/ability/activable/xeno/adrenalinejump/proc/clean_lunge_target()
	SIGNAL_HANDLER
	UnregisterSignal(lunge_target, COMSIG_QDELETING)
	UnregisterSignal(owner, COMSIG_MOVABLE_POST_THROW)
	lunge_target = null
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	owner.stop_throw()

/datum/action/ability/activable/xeno/adrenalinejump/proc/pantherfling(atom/targeted_atom)
	var/mob/living/carbon/xenomorph/xenomorph_owner = owner
	var/mob/living/lunge_target = targeted_atom
	var/fling_distance = 1

	xenomorph_owner.face_atom(lunge_target) //Face towards the victim

	xenomorph_owner.visible_message(span_xenowarning("\The [xenomorph_owner] effortlessly trips [lunge_target]!"), \
	span_xenowarning("We effortlessly trip [lunge_target]!"))
	playsound(lunge_target,'sound/weapons/alien_claw_block.ogg', 75, 1)

	xenomorph_owner.do_attack_animation(lunge_target, ATTACK_EFFECT_DISARM2)
	xenomorph_owner.plasma_stored += 50 //reward for our smart little panther

	if(isxeno(lunge_target))
		var/mob/living/carbon/xenomorph/xeno_lunge_target = lunge_target
		if(xenomorph_owner.issamexenohive(xeno_lunge_target)) //We don't fuck up friendlies
			return

	lunge_target.ParalyzeNoChain(1 SECONDS)
	lunge_target.throw_at(xenomorph_owner, fling_distance, 1, xenomorph_owner) //go under us


///////////////////////////////////
// ***************************************
// *********** Adrenaline rush
// ***************************************

/datum/action/ability/xeno_action/adrenaline_rush
	name = "Adrenaline rush"
	action_icon_state = "adrenaline_rush"
	desc = "Move faster."
	ability_cost = 10
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_ADRENALINE_RUSH,
	)
	use_state_flags = ABILITY_USE_LYING
	action_type = ACTION_TOGGLE
	var/speed_activated = FALSE
	var/speed_bonus_active = FALSE

/datum/action/ability/xeno_action/adrenaline_rush/remove_action()
	rush_off(TRUE) // Ensure we remove the movespeed
	return ..()

/datum/action/ability/xeno_action/adrenaline_rush/can_use_action(silent = FALSE, override_flags)
	. = ..()
	if(speed_activated)
		return TRUE

/datum/action/ability/xeno_action/adrenaline_rush/action_activate()
	if(speed_activated)
		rush_off()
		return fail_activate()
	rush_on()
	succeed_activate()


/datum/action/ability/xeno_action/adrenaline_rush/proc/rush_on(silent = FALSE)
	var/mob/living/carbon/xenomorph/walker = owner
	speed_activated = TRUE
	if(!silent)
		owner.balloon_alert(owner, "It's time to run")
	if(walker.loc_weeds_type)
		speed_bonus_active = TRUE
		walker.add_movespeed_modifier(type, TRUE, 0, NONE, TRUE, -1.5)
	set_toggle(TRUE)
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(rush_on_moved))


/datum/action/ability/xeno_action/adrenaline_rush/proc/rush_off(silent = FALSE)
	var/mob/living/carbon/xenomorph/walker = owner
	if(!silent)
		owner.balloon_alert(owner, "Adrenaline rush is over")
	if(speed_bonus_active)
		walker.remove_movespeed_modifier(type)
		speed_bonus_active = FALSE
	speed_activated = FALSE
	set_toggle(FALSE)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)


/datum/action/ability/xeno_action/adrenaline_rush/proc/rush_on_moved(datum/source, atom/oldloc, direction, Forced = FALSE)
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/walker = owner
	if(!isturf(walker.loc) || walker.plasma_stored < 3)
		owner.balloon_alert(owner, "We are too tired to run so fast")
		rush_off(TRUE)
		return
	if(owner.m_intent == MOVE_INTENT_RUN)
		if(!speed_bonus_active)
			speed_bonus_active = TRUE
			walker.add_movespeed_modifier(type, TRUE, 0, NONE, TRUE, -1.5)
		walker.use_plasma(3)
		return
	if(!speed_bonus_active)
		return
	speed_bonus_active = FALSE
	walker.remove_movespeed_modifier(type)

// ***************************************
// *********** Evasive maneuvers
// ***************************************
/datum/action/ability/xeno_action/evasive_maneuvers
	name = "Toggle evasive maneuvers"
	action_icon_state = "evasive_maneuvers"
	desc = "Toggle evasive action, forcing non-friendly projectiles that would hit you to miss."
	ability_cost = 35
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_EVASIVE_MANEUVERS,
	)
	cooldown_duration = PANTHER_EVASION_COOLDOWN
	///Whether evasion is currently active
	var/evade_active = FALSE
	///Number of successful cooldown clears in a row
	action_type = ACTION_TOGGLE

/datum/action/ability/xeno_action/evasive_maneuvers/remove_action(mob/living/L)
	if(evade_active)
		evasion_deactivate()
	return ..()

/datum/action/ability/xeno_action/evasive_maneuvers/can_use_action(silent = FALSE, override_flags)
	. = ..()
	var/mob/living/carbon/xenomorph/panther/R = owner

	if(!.)
		return FALSE
	if(R.on_fire)
		if(!silent)
			owner.balloon_alert(owner, "Can't while on fire!")
		return FALSE
	return TRUE

/datum/action/ability/xeno_action/evasive_maneuvers/action_activate()
	var/mob/living/carbon/xenomorph/panther/R = owner

	if(evade_active)
		evasion_deactivate()
		return TRUE
	R.balloon_alert(R, "Begin evasion.")
	to_chat(R, span_highdanger("We take evasive action, making us impossible to hit with projectiles."))
	succeed_activate()


	RegisterSignals(R, list(COMSIG_LIVING_STATUS_STUN,
		COMSIG_LIVING_STATUS_KNOCKDOWN,
		COMSIG_LIVING_STATUS_PARALYZE,
		COMSIG_LIVING_STATUS_IMMOBILIZE,
		COMSIG_LIVING_STATUS_UNCONSCIOUS,
		COMSIG_LIVING_STATUS_SLEEP,
		COMSIG_LIVING_STATUS_STAGGER,
		COMSIG_LIVING_IGNITED), PROC_REF(evasion_debuff_check))

	RegisterSignal(R, COMSIG_MOVABLE_MOVED, PROC_REF(handle_evasion))
	RegisterSignal(R, COMSIG_XENO_PROJECTILE_HIT, PROC_REF(evasion_dodge)) //This is where we actually check to see if we dodge the projectile.
	RegisterSignal(R, COMSIG_ATOM_BULLET_ACT, PROC_REF(evasion_flamer_hit)) //Register status effects and fire which impact evasion.
	RegisterSignal(R, COMSIG_LIVING_PRE_THROW_IMPACT, PROC_REF(evasion_throw_dodge)) //Register status effects and fire which impact evasion.
	RegisterSignal(R, COMSIG_LIVING_ADD_VENTCRAWL, PROC_REF(evasion_deactivate))

	set_toggle(TRUE)
	evade_active = TRUE //evasion is currently active

	GLOB.round_statistics.runner_evasions++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "runner_evasions") //Statistics

	handle_evasion()
	START_PROCESSING(SSprocessing, src)

/datum/action/ability/xeno_action/evasive_maneuvers/proc/handle_evasion()
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/xenoowner = owner
	if(owner.m_intent == MOVE_INTENT_RUN)
		xenoowner.use_plasma(PANTHER_EVASION_PLASMADRAIN)
	if(owner.m_intent == MOVE_INTENT_WALK)
		xenoowner.use_plasma(PANTHER_EVASION_LOW_PLASMADRAIN)
	//If we have 0 plasma after expending evasion upkeep plasma, end evasion.
	if(!xenoowner.plasma_stored)
		to_chat(xenoowner, span_xenodanger("We lack sufficient plasma to keep evading."))
		evasion_deactivate()

///Called when the owner is hit by a flamethrower projectile
/datum/action/ability/xeno_action/evasive_maneuvers/proc/evasion_flamer_hit(datum/source, obj/projectile/proj)
	SIGNAL_HANDLER

	if((proj.ammo.flags_ammo_behavior & AMMO_FLAME)) //If it's not from a flamethrower, we don't care
		to_chat(owner, span_danger("The searing fire compromises our ability to dodge!"))
		evasion_deactivate()

///After getting hit with an Evasion disabling debuff, this is where we check to see if evasion is active, and if we actually have debuff stacks
/datum/action/ability/xeno_action/evasive_maneuvers/proc/evasion_debuff_check(datum/source, amount)
	SIGNAL_HANDLER

	var/mob/living/carbon/xenomorph/xenomorph_owner = owner

	if(!(amount > 0) || !evade_active) //If evasion isn't active we don't care
		return
	to_chat(owner, span_highdanger("Our movements have been interrupted!"))
	xenomorph_owner.plasma_stored -= 65

///Where we deactivate evasion and unregister the signals/zero out vars, etc.
/datum/action/ability/xeno_action/evasive_maneuvers/proc/evasion_deactivate()
	SIGNAL_HANDLER
	add_cooldown()
	to_chat(owner, span_xenodanger("We stop evading."))

	UnregisterSignal(owner, list(
		COMSIG_MOVABLE_MOVED,
		COMSIG_LIVING_STATUS_STUN,
		COMSIG_LIVING_STATUS_KNOCKDOWN,
		COMSIG_LIVING_STATUS_PARALYZE,
		COMSIG_LIVING_STATUS_IMMOBILIZE,
		COMSIG_LIVING_STATUS_UNCONSCIOUS,
		COMSIG_LIVING_STATUS_SLEEP,
		COMSIG_LIVING_STATUS_STAGGER,
		COMSIG_XENO_PROJECTILE_HIT,
		COMSIG_LIVING_IGNITED,
		COMSIG_LIVING_PRE_THROW_IMPACT,
		COMSIG_LIVING_ADD_VENTCRAWL,
		COMSIG_ATOM_BULLET_ACT,))

	set_toggle(FALSE)
	evade_active = FALSE //Evasion is no longer active

	owner.balloon_alert(owner, "Evasion ended")
	owner.playsound_local(owner, 'sound/voice/hiss5.ogg', 50)


/datum/action/ability/xeno_action/evasive_maneuvers/on_cooldown_finish()
	to_chat(owner, span_xenodanger("We are able to take evasive action again."))
	owner.playsound_local(owner, 'sound/effects/xeno_newlarva.ogg', 25, 0, 1)

	return ..()

/datum/action/ability/xeno_action/evasive_maneuvers/process()
	if(!evade_active)
		return PROCESS_KILL
	handle_evasion()

///Determines whether or not a thrown projectile is dodged while the Evasion ability is active
/datum/action/ability/xeno_action/evasive_maneuvers/proc/evasion_throw_dodge(datum/source, atom/movable/proj)
	SIGNAL_HANDLER

	var/mob/living/carbon/xenomorph/xenomorph_owner = owner
	if(!evade_active) //If evasion is not active we don't dodge
		return NONE

	if((xenomorph_owner.last_move_time < (world.time - RUNNER_EVASION_RUN_DELAY))) //Gotta keep moving to benefit from evasion!
		return NONE

	evasion_dodge_sfx(proj)

	return COMPONENT_PRE_THROW_IMPACT_HIT

///This is where the dodgy magic happens
/datum/action/ability/xeno_action/evasive_maneuvers/proc/evasion_dodge(datum/source, obj/projectile/proj, cardinal_move, uncrossing)
	SIGNAL_HANDLER

	var/mob/living/carbon/xenomorph/panther/R = owner
	if(!evade_active) //If evasion is not active we don't dodge
		return FALSE

	if((R.last_move_time < (world.time - RUNNER_EVASION_RUN_DELAY))) //Gotta keep moving to benefit from evasion!
		return FALSE

	if(R.issamexenohive(proj.firer)) //We automatically dodge allied projectiles at no cost, and no benefit to our evasion stacks
		return COMPONENT_PROJECTILE_DODGE

	if(proj.ammo.flags_ammo_behavior & AMMO_FLAME) //We can't dodge literal fire
		return FALSE

	evasion_dodge_sfx(proj)

	return COMPONENT_PROJECTILE_DODGE

///Handles dodge effects and visuals for the Evasion ability.
/datum/action/ability/xeno_action/evasive_maneuvers/proc/evasion_dodge_sfx(atom/movable/proj)

	var/mob/living/carbon/xenomorph/xenomorph_owner = owner

	xenomorph_owner.visible_message(span_warning("[xenomorph_owner] effortlessly dodges the [proj.name]!"), \
	span_xenodanger("We effortlessly dodge the [proj.name]!"))

	xenomorph_owner.add_filter("runner_evasion", 2, gauss_blur_filter(5))
	addtimer(CALLBACK(xenomorph_owner, TYPE_PROC_REF(/atom, remove_filter), "runner_evasion"), 0.5 SECONDS)
	xenomorph_owner.do_jitter_animation(4000)

	var/turf/our_turf = get_turf(xenomorph_owner) //location of after image SFX
	playsound(our_turf, pick('sound/effects/throw.ogg','sound/effects/alien_tail_swipe1.ogg', 'sound/effects/alien_tail_swipe2.ogg'), 25, 1) //sound effects
	var/obj/effect/temp_visual/xenomorph/afterimage/our_afterimage
	for(var/i = 0 to 2) //number of after images
		our_afterimage = new /obj/effect/temp_visual/xenomorph/afterimage(our_turf, owner) //Create the after image.
		our_afterimage.pixel_x = pick(rand(xenomorph_owner.pixel_x * 3, xenomorph_owner.pixel_x * 1.5), rand(0, xenomorph_owner.pixel_x * -1)) //Variation on the xenomorph_owner position

// ***************************************
// *********** Select reagent (panther)
// ***************************************
/datum/action/ability/xeno_action/select_reagent/panther
	name = "Select Reagent"
	action_icon_state = "select_reagent0"
	desc = "Selects which reagent to use for tearing tail. Hemodile slows by 25%, increased to 50% with neurotoxin present, and deals 20% of damage received as stamina damage. Transvitox converts brute/burn damage to toxin based on 40% of damage received up to 45 toxin on target, upon reaching which causes a stun. Neurotoxin deals increasing stamina damage the longer it remains in the victim's system and prevents stamina regeneration. Ozelomelyn purges medical chemicals from humans, while also causing slight intoxication. Sanguinal does damage depending on presence and amount of all previously mentioned reagents, also causes light brute damage and bleeding."
	use_state_flags = ABILITY_USE_BUSY|ABILITY_USE_LYING
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PANTHER_SELECT_REAGENT,
		KEYBINDING_ALTERNATE = COMSIG_XENOABILITY_RADIAL_SELECT_REAGENT,
	)

/datum/action/ability/xeno_action/select_reagent/panther/give_action(mob/living/L)
	. = ..()
	var/mob/living/carbon/xenomorph/xenomorph_owner = owner
	xenomorph_owner.selected_reagent = GLOB.panther_toxin_type_list[1] //Set our default
	update_button_icon() //Update immediately to get our default

/datum/action/ability/xeno_action/select_reagent/panther/action_activate()
	var/mob/living/carbon/xenomorph/xenomorph_owner = owner
	var/i = GLOB.panther_toxin_type_list.Find(xenomorph_owner.selected_reagent)
	if(length_char(GLOB.panther_toxin_type_list) == i)
		xenomorph_owner.selected_reagent = GLOB.panther_toxin_type_list[1]
	else
		xenomorph_owner.selected_reagent = GLOB.panther_toxin_type_list[i+1]

	var/atom/A = xenomorph_owner.selected_reagent
	xenomorph_owner.balloon_alert(xenomorph_owner, "[initial(A.name)]")
	update_button_icon()
	return succeed_activate()

/datum/action/ability/xeno_action/select_reagent/panther/select_reagent_radial()
	//List of toxin images
	// This is cursed, don't copy this code its the WRONG way to do this.
	// TODO: generate this from GLOB.panther_toxin_type_list (or wait while offtgmc reworks the defiler code and then copy it )
	var/static/list/panther_toxin_images_list = list(
			PANTHER_HEMODILE = image('modular_RUtgmc/icons/Xeno/actions.dmi', icon_state = PANTHER_HEMODILE),
			PANTHER_TRANSVITOX = image('modular_RUtgmc/icons/Xeno/actions.dmi', icon_state = PANTHER_TRANSVITOX),
			PANTHER_OZELOMELYN = image('modular_RUtgmc/icons/Xeno/actions.dmi', icon_state = PANTHER_OZELOMELYN),
			PANTHER_SANGUINAL = image('modular_RUtgmc/icons/Xeno/actions.dmi', icon_state = PANTHER_SANGUINAL),
			)
	var/toxin_choice = show_radial_menu(owner, owner, panther_toxin_images_list, radius = 48)
	if(!toxin_choice)
		return
	var/mob/living/carbon/xenomorph/xenomorph_owner = owner
	for(var/toxin in GLOB.panther_toxin_type_list)
		var/datum/reagent/our_reagent = GLOB.chemical_reagents_list[toxin]
		if(our_reagent.name == toxin_choice)
			xenomorph_owner.selected_reagent = our_reagent.type
			break
	xenomorph_owner.balloon_alert(xenomorph_owner, "[toxin_choice]")
	update_button_icon()
	return succeed_activate()

#undef PANTHER_HEMODILE
#undef PANTHER_TRANSVITOX
#undef PANTHER_OZELOMELYN
#undef PANTHER_SANGUINAL
