/datum/action/ability/xeno_action/ready_charge
	name = "Toggle Charging"
	action_icon_state = "ready_charge"
	desc = "Toggles the movement-based charge on and off."
	keybinding_signals = list(KEYBINDING_NORMAL = COMSIG_XENOABILITY_TOGGLE_CHARGE)
	action_type = ACTION_TOGGLE
	use_state_flags = ABILITY_USE_LYING
	///Type of charging
	var/charge_type = CHARGE_CRUSH
	var/next_move_limit = 0
	var/turf/lastturf = null
	///The dir we are charging in
	var/charge_dir = null
	///Is our ability unactive?
	var/charge_ability_on = FALSE
	///The amount of steps we took
	var/valid_steps_taken = 0
	///The sound we play upon charging into someone
	var/crush_sound = "punch"
	///The speed we gain per step of charging
	var/speed_per_step = 0.15
	///Minimum amount of steps before we start charging
	var/steps_for_charge = 7
	///The cap of damage we can build up based on steps
	var/max_steps_buildup = 14
	///How much damage will we deal upon running into mob
	var/crush_living_damage = 20
	///Little var to keep track on special attack timers.
	var/next_special_attack = 0
	///Multiplier for decreasing your plasma on charging
	var/plasma_use_multiplier = 1
	///If this charge should keep momentum on dir change and if it can charge diagonally
	var/agile_charge = FALSE
	/// Whether this ability should be activated when given.
	var/should_start_on = TRUE

/datum/action/ability/xeno_action/ready_charge/give_action(mob/living/L)
	. = ..()
	if(should_start_on)
		action_activate()

/datum/action/ability/xeno_action/ready_charge/Destroy()
	if(charge_ability_on)
		charge_off()
	return ..()

/datum/action/ability/xeno_action/ready_charge/remove_action(mob/living/L)
	if(charge_ability_on)
		charge_off()
	return ..()

/datum/action/ability/xeno_action/ready_charge/action_activate()
	if(charge_ability_on)
		charge_off()
		return
	charge_on()

/datum/action/ability/xeno_action/ready_charge/proc/charge_on(verbose = TRUE)
	var/mob/living/carbon/xenomorph/charger = owner
	charge_ability_on = TRUE
	RegisterSignal(charger, COMSIG_MOVABLE_MOVED, PROC_REF(update_charging), override = TRUE)
	RegisterSignal(charger, COMSIG_ATOM_DIR_CHANGE, PROC_REF(on_dir_change), override = TRUE)
	set_toggle(TRUE)
	if(verbose)
		to_chat(charger, span_xenonotice("We will charge when moving, now."))

/datum/action/ability/xeno_action/ready_charge/proc/charge_off(verbose = TRUE)
	var/mob/living/carbon/xenomorph/charger = owner
	if(charger.is_charging != CHARGE_OFF)
		do_stop_momentum()
	UnregisterSignal(charger, list(COMSIG_MOVABLE_MOVED, COMSIG_ATOM_DIR_CHANGE))
	if(verbose)
		to_chat(charger, span_xenonotice("We will no longer charge when moving."))
	set_toggle(FALSE)
	valid_steps_taken = 0
	charge_ability_on = FALSE

/datum/action/ability/xeno_action/ready_charge/proc/on_dir_change(datum/source, old_dir, new_dir)
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/charger = owner
	if(charger.is_charging == CHARGE_OFF)
		return
	if(!old_dir || !new_dir || old_dir == new_dir) //Check for null direction from help shuffle signals
		return
	if(agile_charge)
		speed_down(8)
		return
	do_stop_momentum()

/datum/action/ability/xeno_action/ready_charge/proc/update_charging(datum/source, atom/oldloc, direction, Forced, old_locs)
	SIGNAL_HANDLER_DOES_SLEEP
	if(Forced)
		return

	var/mob/living/carbon/xenomorph/charger = owner
	if(charger.throwing || oldloc == charger.loc)
		return

	if(charger.is_charging == CHARGE_OFF)
		if(charger.dir != direction) //It needs to move twice in the same direction, at least, to begin charging.
			return
		charge_dir = direction
		if(!check_momentum(direction))
			charge_dir = null
			return
		charger.is_charging = CHARGE_BUILDINGUP
		handle_momentum()
		return

	if(!check_momentum(direction))
		do_stop_momentum()
		return

	handle_momentum()

/datum/action/ability/xeno_action/ready_charge/proc/do_start_crushing()
	var/mob/living/carbon/xenomorph/charger = owner
	RegisterSignals(charger, list(COMSIG_MOVABLE_PREBUMP_TURF, COMSIG_MOVABLE_PREBUMP_MOVABLE, COMSIG_MOVABLE_PREBUMP_EXIT_MOVABLE), PROC_REF(do_crush))
	charger.is_charging = CHARGE_ON
	charger.update_icons()

/datum/action/ability/xeno_action/ready_charge/proc/do_stop_crushing()
	var/mob/living/carbon/xenomorph/charger = owner
	UnregisterSignal(charger, list(COMSIG_MOVABLE_PREBUMP_TURF, COMSIG_MOVABLE_PREBUMP_MOVABLE, COMSIG_MOVABLE_PREBUMP_EXIT_MOVABLE))
	if(valid_steps_taken > 0) //If this is false, then do_stop_momentum() should have it handled already.
		charger.is_charging = CHARGE_BUILDINGUP
		charger.update_icons()

/datum/action/ability/xeno_action/ready_charge/proc/do_stop_momentum(message = TRUE)
	var/mob/living/carbon/xenomorph/charger = owner
	if(message && valid_steps_taken >= steps_for_charge) //Message now happens without a stun condition
		charger.visible_message(span_danger("[charger] skids to a halt!"),
		span_xenowarning("We skid to a halt."), null, 5)
	valid_steps_taken = 0
	next_move_limit = 0
	lastturf = null
	charge_dir = null
	charger.remove_movespeed_modifier(MOVESPEED_ID_XENO_CHARGE)
	if(charger.is_charging >= CHARGE_ON)
		do_stop_crushing()
	charger.is_charging = CHARGE_OFF
	charger.update_icons()

/datum/action/ability/xeno_action/ready_charge/proc/check_momentum(newdir)
	var/mob/living/carbon/xenomorph/charger = owner
	if((newdir && ISDIAGONALDIR(newdir) || charge_dir != newdir) && !agile_charge) //Check for null direction from help shuffle signals
		return FALSE

	if(next_move_limit && world.time > next_move_limit)
		return FALSE

	if(charger.pulling)
		return FALSE

	if(charger.incapacitated())
		return FALSE

	if(charge_dir != charger.dir && !agile_charge)
		return FALSE

	if(charger.pulledby)
		return FALSE

	if(lastturf && (!isturf(lastturf) || isspaceturf(lastturf) || (charger.loc == lastturf))) //Check if the Crusher didn't move from his last turf, aka stopped
		return FALSE

	if(charger.plasma_stored < CHARGE_MAX_SPEED)
		return FALSE
	return TRUE

/datum/action/ability/xeno_action/ready_charge/proc/handle_momentum()
	var/mob/living/carbon/xenomorph/charger = owner

	if(charger.pulling && valid_steps_taken)
		charger.stop_pulling()

	next_move_limit = world.time + 0.5 SECONDS

	if(++valid_steps_taken <= max_steps_buildup)
		if(valid_steps_taken == steps_for_charge)
			do_start_crushing()
		else if(valid_steps_taken == max_steps_buildup)
			charger.is_charging = CHARGE_MAX
			charger.emote("roar")
		charger.add_movespeed_modifier(MOVESPEED_ID_XENO_CHARGE, TRUE, 100, NONE, TRUE, -CHARGE_SPEED(src))

	if(valid_steps_taken > steps_for_charge)
		charger.plasma_stored -= round(CHARGE_SPEED(src) * plasma_use_multiplier) //Eats up plasma the faster you go. //now uses a multiplier

		switch(charge_type)
			if(CHARGE_CRUSH) //Xeno Crusher
				if(MODULUS(valid_steps_taken, 4) == 0)
					playsound(charger, "alien_charge", 50)
				var/shake_dist = min(round(CHARGE_SPEED(src) * 5), 8)
				for(var/mob/living/carbon/human/victim in range(shake_dist, charger))
					if(victim.stat == DEAD)
						continue
					if(victim.client)
						shake_camera(victim, 1, 1)
					if(victim.loc != charger.loc || !victim.lying_angle || isnestedhost(victim))
						continue
					if(victim.pass_flags & PASS_THROW) // if the mob is being thrown by us EXPLICITLY, we don't deal x2 damage
						continue
					charger.visible_message(span_danger("[charger] runs [victim] over!"),
						span_danger("We run [victim] over!"), null, 5)
					victim.apply_damage(CHARGE_SPEED(src) * 40, BRUTE, BODY_ZONE_CHEST, MELEE, updating_health = TRUE, penetration = 30)
					animation_flash_color(victim)
			if(CHARGE_BULL, CHARGE_BULL_HEADBUTT, CHARGE_BULL_GORE) //Xeno Bull
				if(MODULUS(valid_steps_taken, 4) == 0)
					playsound(charger, "alien_footstep_large", 50)
			if(CHARGE_BEHEMOTH)
				if(MODULUS(valid_steps_taken, 2) == 0)
					playsound(charger, "behemoth_rolling", 30)

	lastturf = charger.loc

/datum/action/ability/xeno_action/ready_charge/proc/speed_down(amt)
	if(valid_steps_taken == 0)
		return
	valid_steps_taken -= amt
	if(valid_steps_taken <= 0)
		valid_steps_taken = 0
		do_stop_momentum()
	else if(valid_steps_taken < steps_for_charge)
		do_stop_crushing()

/datum/action/ability/xeno_action/ready_charge/proc/precrush2signal(precrush)
	switch(precrush)
		if(PRECRUSH_STOPPED)
			return COMPONENT_MOVABLE_PREBUMP_STOPPED
		if(PRECRUSH_PLOWED)
			return COMPONENT_MOVABLE_PREBUMP_PLOWED
		if(PRECRUSH_ENTANGLED)
			return COMPONENT_MOVABLE_PREBUMP_ENTANGLED
		else
			return NONE

// Charge is divided into two acts: before and after the crushed thing taking damage, as that can cause it to be deleted.
/datum/action/ability/xeno_action/ready_charge/proc/do_crush(datum/source, atom/crushed)
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/charger = owner
	if(charger.incapacitated() || charger.now_pushing)
		return NONE

	if(charge_type & (CHARGE_BULL|CHARGE_BULL_HEADBUTT|CHARGE_BULL_GORE|CHARGE_BEHEMOTH) && !isliving(crushed))
		do_stop_momentum()
		return COMPONENT_MOVABLE_PREBUMP_STOPPED

	var/precrush = crushed.pre_crush_act(charger, src) //Negative values are codes. Positive ones are damage to deal.
	switch(precrush)
		if(null)
			CRASH("[crushed] returned null from do_crush()")
		if(PRECRUSH_STOPPED)
			return COMPONENT_MOVABLE_PREBUMP_STOPPED //Already handled, no need to continue.
		if(PRECRUSH_PLOWED)
			return COMPONENT_MOVABLE_PREBUMP_PLOWED
		if(PRECRUSH_ENTANGLED)
			. = COMPONENT_MOVABLE_PREBUMP_ENTANGLED

	var/preserved_name = crushed.name

	if(isliving(crushed))
		var/mob/living/crushed_living = crushed
		playsound(crushed_living.loc, crush_sound, 25, 1)
		if(crushed_living.buckled)
			crushed_living.buckled.unbuckle_mob(crushed_living)
		animation_flash_color(crushed_living)

		if(precrush > 0)
			log_combat(charger, crushed_living, "xeno charged")
			//There is a chance to do enough damage here to gib certain mobs. Better update immediately.
			crushed_living.apply_damage(precrush * 1.7, BRUTE, BODY_ZONE_CHEST, MELEE, updating_health = TRUE, penetration = 15)
			if(QDELETED(crushed_living))
				charger.visible_message(span_danger("[charger] anihilates [preserved_name]!"),
				span_xenodanger("We anihilate [preserved_name]!"))
				return COMPONENT_MOVABLE_PREBUMP_PLOWED

		return precrush2signal(crushed_living.post_crush_act(charger, src))

	if(isobj(crushed))
		var/obj/crushed_obj = crushed
		if(istype(crushed_obj, /obj/structure/xeno/silo) || istype(crushed_obj, /obj/structure/xeno/turret))
			return precrush2signal(crushed_obj.post_crush_act(charger, src))
		playsound(crushed_obj.loc, "punch", 25, 1)
		var/crushed_behavior = crushed_obj.crushed_special_behavior()
		crushed_obj.take_damage(precrush, BRUTE, MELEE)
		if(QDELETED(crushed_obj))
			charger.visible_message(span_danger("[charger] crushes [preserved_name]!"),
			span_xenodanger("We crush [preserved_name]!"))
			if(crushed_behavior & STOP_CRUSHER_ON_DEL)
				return COMPONENT_MOVABLE_PREBUMP_STOPPED
			else
				return COMPONENT_MOVABLE_PREBUMP_PLOWED

		return precrush2signal(crushed_obj.post_crush_act(charger, src))

	if(isturf(crushed))
		var/turf/crushed_turf = crushed
		if(iswallturf(crushed_turf))
			var/turf/closed/wall/crushed_wall = crushed_turf
			crushed_wall.take_damage(precrush, BRUTE, MELEE)
		else
			crushed_turf.ex_act(precrush * rand(50, 100))
		if(QDELETED(crushed_turf))
			charger.visible_message(span_danger("[charger] plows straight through [preserved_name]!"),
			span_xenowarning("We plow straight through [preserved_name]!"))
			return COMPONENT_MOVABLE_PREBUMP_PLOWED

		charger.visible_message(span_danger("[charger] rams into [crushed_turf] and skids to a halt!"),
		span_xenowarning("We ram into [crushed_turf] and skid to a halt!"))
		do_stop_momentum(FALSE)
		return COMPONENT_MOVABLE_PREBUMP_STOPPED

/datum/action/ability/xeno_action/ready_charge/bull_charge
	action_icon_state = "bull_ready_charge"
	charge_type = CHARGE_BULL
	speed_per_step = 0.15
	steps_for_charge = 5
	max_steps_buildup = 10
	crush_living_damage = 15
	plasma_use_multiplier = 2

/datum/action/ability/xeno_action/ready_charge/bull_charge/give_action(mob/living/L)
	. = ..()
	RegisterSignal(L, COMSIG_XENOACTION_TOGGLECHARGETYPE, PROC_REF(toggle_charge_type))

/datum/action/ability/xeno_action/ready_charge/bull_charge/remove_action(mob/living/L)
	UnregisterSignal(L, COMSIG_XENOACTION_TOGGLECHARGETYPE)
	return ..()

/datum/action/ability/xeno_action/ready_charge/bull_charge/proc/toggle_charge_type(datum/source, new_charge_type = CHARGE_BULL)
	SIGNAL_HANDLER
	if(charge_type == new_charge_type)
		return

	var/mob/living/carbon/xenomorph/charger = owner
	if(charger.is_charging >= CHARGE_ON)
		do_stop_momentum()

	switch(new_charge_type)
		if(CHARGE_BULL)
			charge_type = CHARGE_BULL
			crush_sound = initial(crush_sound)
			to_chat(owner, span_notice("Now charging normally."))
		if(CHARGE_BULL_HEADBUTT)
			charge_type = CHARGE_BULL_HEADBUTT
			to_chat(owner, span_notice("Now headbutting on impact."))
		if(CHARGE_BULL_GORE)
			charge_type = CHARGE_BULL_GORE
			crush_sound = "alien_tail_attack"
			to_chat(owner, span_notice("Now goring on impact."))

/datum/action/ability/xeno_action/ready_charge/bull_charge/on_xeno_upgrade()
	var/mob/living/carbon/xenomorph/X = owner
	agile_charge = (X.upgrade == XENO_UPGRADE_PRIMO)

/datum/action/ability/xeno_action/ready_charge/queen_charge
	action_icon_state = "queen_ready_charge"
