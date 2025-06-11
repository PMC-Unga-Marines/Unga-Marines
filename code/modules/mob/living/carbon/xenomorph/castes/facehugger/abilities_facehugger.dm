#define HUG_RANGE 2
#define HUGGER_POUNCE_RANGE 6
#define HUGGER_POUNCE_PARALYZE_DURATION 1 SECONDS
#define HUGGER_POUNCE_STANDBY_DURATION 1 SECONDS
#define HUGGER_POUNCE_WINDUP_DURATION 1 SECONDS
#define HUGGER_POUNCE_SPEED 2
#define HUGGER_POUNCE_SHIELD_STUN_DURATION 6 SECONDS

// ***************************************
// *********** Hug
// ***************************************

/datum/action/ability/activable/xeno/pounce_hugger
	name = "Pounce"
	desc = "Leap at your target and knock them down, if you jump close you will hug the target."
	action_icon_state = "pounce"
	action_icon = 'icons/Xeno/actions/runner.dmi'
	ability_cost = 25
	cooldown_duration = 5 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSING_XENOABILITY_HUGGER_POUNCE,
	)
	use_state_flags = ABILITY_USE_BUCKLED
	///Where do we start the leap from
	var/start_turf

// TODO: merge this ability into runner pounce (can't do it right now - the runner's pounce has too many unnecessary sounds/messages)
/datum/action/ability/activable/xeno/pounce_hugger/proc/pounce_complete()
	SIGNAL_HANDLER
	xeno_owner.pass_flags = initial(xeno_owner.pass_flags)
	xeno_owner.icon_state = "[xeno_owner.xeno_caste.caste_name] Walking"
	xeno_owner.set_throwing(FALSE)
	UnregisterSignal(owner, list(COMSIG_XENO_OBJ_THROW_HIT, COMSIG_MOVABLE_POST_THROW, COMSIG_XENO_LIVING_THROW_HIT))

/datum/action/ability/activable/xeno/pounce_hugger/proc/obj_hit(datum/source, obj/target, speed)
	SIGNAL_HANDLER
	target.hitby(owner, speed)
	pounce_complete()

/datum/action/ability/activable/xeno/pounce_hugger/proc/mob_hit(datum/source, mob/living/living_target)
	SIGNAL_HANDLER
	if(living_target.stat || isxeno(living_target))
		return

	xeno_owner.visible_message(span_danger("[xeno_owner] leaps on [living_target]!"), span_xenodanger("We leap on [living_target]!"), null, 5)
	playsound(xeno_owner.loc, 'sound/voice/alien/larva/roar3.ogg', 25, TRUE) //TODO: I NEED ACTUAL HUGGERS SOUND DAMMED

	if(ishuman(living_target) && (angle_to_dir(Get_Angle(xeno_owner.throw_source, living_target)) in reverse_nearby_direction(living_target.dir)))
		var/mob/living/carbon/human/human_target = living_target
		if(!human_target.check_shields(COMBAT_TOUCH_ATTACK, 30, MELEE))
			xeno_owner.Paralyze(HUGGER_POUNCE_SHIELD_STUN_DURATION)
			xeno_owner.set_throwing(FALSE) //Reset throwing manually.
			playsound(xeno_owner, 'sound/machines/bonk.ogg', 50, FALSE)
			return

	xeno_owner.forceMove(get_turf(living_target))
	if(ishuman(living_target))
		var/mob/living/carbon/human/human_target = living_target
		if(get_dist(start_turf, human_target) <= HUG_RANGE) //Check whether we hugged the target or just knocked it down
			var/mob/living/carbon/xenomorph/facehugger/facehugger_owner = xeno_owner
			facehugger_owner.try_attach(human_target)
		else
			human_target.Paralyze(HUGGER_POUNCE_PARALYZE_DURATION)
			xeno_owner.Immobilize(HUGGER_POUNCE_STANDBY_DURATION)

	pounce_complete()

/datum/action/ability/activable/xeno/pounce_hugger/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE

	if(!target || target.layer >= FLY_LAYER)
		return FALSE

/datum/action/ability/activable/xeno/pounce_hugger/on_cooldown_finish()
	xeno_owner.xeno_flags |= XENO_LEAPING
	return ..()

/datum/action/ability/activable/xeno/pounce_hugger/use_ability(atom/target)
	if(owner.buckled)
		owner.buckled.unbuckle_mob(owner)
	if(!do_after(xeno_owner, HUGGER_POUNCE_WINDUP_DURATION, IGNORE_HELD_ITEM, xeno_owner, BUSY_ICON_DANGER, extra_checks = CALLBACK(src, PROC_REF(can_use_ability), target, FALSE, ABILITY_USE_BUSY)))
		return fail_activate()

	xeno_owner.icon_state = "[xeno_owner.xeno_caste.caste_name] Thrown"

	xeno_owner.visible_message(span_xenowarning("\The [xeno_owner] leaps at [target]!"), \
	span_xenowarning("We leap at [target]!"))

	RegisterSignal(xeno_owner, COMSIG_XENO_OBJ_THROW_HIT, PROC_REF(obj_hit))
	RegisterSignal(xeno_owner, COMSIG_XENOMORPH_LEAP_BUMP, PROC_REF(mob_hit))
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_POST_THROW, PROC_REF(pounce_complete))

	succeed_activate()
	add_cooldown()
	xeno_owner.xeno_flags |= XENO_LEAPING // this is needed for throwing code
	xeno_owner.pass_flags |= PASS_LOW_STRUCTURE|PASS_FIRE
	xeno_owner.pass_flags ^= PASS_MOB

	start_turf = get_turf(xeno_owner)
	if(ishuman(target) && get_turf(target) == start_turf)
		mob_hit(xeno_owner, target)
	xeno_owner.throw_at(target, HUGGER_POUNCE_RANGE, HUGGER_POUNCE_SPEED, xeno_owner)
	return TRUE

	//AI stuff
/datum/action/ability/activable/xeno/pounce_hugger/ai_should_start_consider()
	return TRUE

/datum/action/ability/activable/xeno/pounce_hugger/ai_should_use(atom/target)
	if(!ishuman(target))
		return FALSE
	if(!line_of_sight(xeno_owner, target, HUG_RANGE))
		return FALSE
	if(!can_use_action(override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(target.get_xeno_hivenumber() == xeno_owner.get_xeno_hivenumber())
		return FALSE
	action_activate()
	LAZYINCREMENT(xeno_owner.do_actions, target)
	addtimer(CALLBACK(src, PROC_REF(decrease_do_action), target), HUGGER_POUNCE_WINDUP_DURATION)
	return TRUE

///Decrease the do_actions of the owner
/datum/action/ability/activable/xeno/pounce_hugger/proc/decrease_do_action(atom/target)
	LAZYDECREMENT(xeno_owner.do_actions, target)

#undef HUG_RANGE
#undef HUGGER_POUNCE_RANGE
#undef HUGGER_POUNCE_PARALYZE_DURATION
#undef HUGGER_POUNCE_STANDBY_DURATION
#undef HUGGER_POUNCE_WINDUP_DURATION
