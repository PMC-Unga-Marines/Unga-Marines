/datum/action/ability/xeno_action/ready_charge
	name = "Toggle Charging"
	desc = "Toggles the movement-based charge on and off."
	action_icon_state = "ready_charge"
	action_icon = 'icons/Xeno/actions/crusher.dmi'
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
	charge_ability_on = TRUE
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_MOVED, PROC_REF(update_charging), override = TRUE)
	RegisterSignal(xeno_owner, COMSIG_ATOM_DIR_CHANGE, PROC_REF(on_dir_change), override = TRUE)
	set_toggle(TRUE)
	if(verbose)
		to_chat(xeno_owner, span_xenonotice("We will charge when moving, now."))

/datum/action/ability/xeno_action/ready_charge/proc/charge_off(verbose = TRUE)
	if(xeno_owner.is_charging != CHARGE_OFF)
		do_stop_momentum()
	UnregisterSignal(xeno_owner, list(COMSIG_MOVABLE_MOVED, COMSIG_ATOM_DIR_CHANGE))
	if(verbose)
		to_chat(xeno_owner, span_xenonotice("We will no longer charge when moving."))
	set_toggle(FALSE)
	valid_steps_taken = 0
	charge_ability_on = FALSE

/datum/action/ability/xeno_action/ready_charge/proc/on_dir_change(datum/source, old_dir, new_dir)
	SIGNAL_HANDLER
	if(xeno_owner.is_charging == CHARGE_OFF)
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

	if(xeno_owner.throwing || oldloc == xeno_owner.loc)
		return

	if(xeno_owner.is_charging == CHARGE_OFF)
		if(xeno_owner.dir != direction) //It needs to move twice in the same direction, at least, to begin charging.
			return
		charge_dir = direction
		if(!check_momentum(direction))
			charge_dir = null
			return
		xeno_owner.is_charging = CHARGE_BUILDINGUP
		handle_momentum()
		return

	if(!check_momentum(direction))
		do_stop_momentum()
		return

	handle_momentum()

/datum/action/ability/xeno_action/ready_charge/proc/do_start_crushing()
	RegisterSignals(xeno_owner, list(COMSIG_MOVABLE_PREBUMP_TURF, COMSIG_MOVABLE_PREBUMP_MOVABLE, COMSIG_MOVABLE_PREBUMP_EXIT_MOVABLE), PROC_REF(do_crush))
	xeno_owner.is_charging = CHARGE_ON
	xeno_owner.update_icons()

/datum/action/ability/xeno_action/ready_charge/proc/do_stop_crushing()
	UnregisterSignal(xeno_owner, list(COMSIG_MOVABLE_PREBUMP_TURF, COMSIG_MOVABLE_PREBUMP_MOVABLE, COMSIG_MOVABLE_PREBUMP_EXIT_MOVABLE))
	if(valid_steps_taken > 0) //If this is false, then do_stop_momentum() should have it handled already.
		xeno_owner.is_charging = CHARGE_BUILDINGUP
		xeno_owner.update_icons()

/datum/action/ability/xeno_action/ready_charge/proc/do_stop_momentum(message = TRUE)
	if(message && valid_steps_taken >= steps_for_charge) //Message now happens without a stun condition
		xeno_owner.visible_message(span_danger("[xeno_owner] skids to a halt!"),
		span_xenowarning("We skid to a halt."), null, 5)
	valid_steps_taken = 0
	next_move_limit = 0
	lastturf = null
	charge_dir = null
	xeno_owner.remove_movespeed_modifier(MOVESPEED_ID_XENO_CHARGE)
	if(xeno_owner.is_charging >= CHARGE_ON)
		do_stop_crushing()
	xeno_owner.is_charging = CHARGE_OFF
	xeno_owner.update_icons()

/datum/action/ability/xeno_action/ready_charge/proc/check_momentum(newdir)
	if((newdir && ISDIAGONALDIR(newdir) || charge_dir != newdir) && !agile_charge) //Check for null direction from help shuffle signals
		return FALSE

	if(next_move_limit && world.time > next_move_limit)
		return FALSE

	if(xeno_owner.pulling)
		return FALSE

	if(xeno_owner.incapacitated())
		return FALSE

	if(charge_dir != xeno_owner.dir && !agile_charge)
		return FALSE

	if(xeno_owner.pulledby)
		return FALSE

	if(lastturf && (!isturf(lastturf) || isspaceturf(lastturf) || (xeno_owner.loc == lastturf))) //Check if the Crusher didn't move from his last turf, aka stopped
		return FALSE

	if(xeno_owner.plasma_stored < CHARGE_MAX_SPEED)
		return FALSE
	return TRUE

/datum/action/ability/xeno_action/ready_charge/proc/handle_momentum()
	if(xeno_owner.pulling && valid_steps_taken)
		xeno_owner.stop_pulling()

	next_move_limit = world.time + 0.5 SECONDS

	if(++valid_steps_taken <= max_steps_buildup)
		if(valid_steps_taken == steps_for_charge)
			do_start_crushing()
		else if(valid_steps_taken == max_steps_buildup)
			xeno_owner.is_charging = CHARGE_MAX
			xeno_owner.emote("roar")
		xeno_owner.add_movespeed_modifier(MOVESPEED_ID_XENO_CHARGE, TRUE, 100, NONE, TRUE, -CHARGE_SPEED(src))

	if(valid_steps_taken > steps_for_charge)
		xeno_owner.plasma_stored -= round(CHARGE_SPEED(src) * plasma_use_multiplier) //Eats up plasma the faster you go. //now uses a multiplier

		switch(charge_type)
			if(CHARGE_CRUSH) //Xeno Crusher
				if(MODULUS(valid_steps_taken, 4) == 0)
					playsound(xeno_owner, SFX_ALIEN_CHARGE, 50)
				var/shake_dist = min(round(CHARGE_SPEED(src) * 5), 8)
				for(var/mob/living/carbon/human/victim in range(shake_dist, xeno_owner))
					if(victim.stat == DEAD)
						continue
					if(victim.client)
						shake_camera(victim, 1, 1)
					if(victim.loc != xeno_owner.loc || !victim.lying_angle || isnestedhost(victim))
						continue
					if(victim.pass_flags & PASS_THROW) // if the mob is being thrown by us EXPLICITLY, we don't deal x2 damage
						continue
					xeno_owner.visible_message(span_danger("[xeno_owner] runs [victim] over!"),
						span_danger("We run [victim] over!"), null, 5)
					victim.apply_damage(CHARGE_SPEED(src) * 40, BRUTE, BODY_ZONE_CHEST, MELEE, updating_health = TRUE, penetration = 30)
					animation_flash_color(victim)
			if(CHARGE_BULL, CHARGE_BULL_HEADBUTT, CHARGE_BULL_GORE) //Xeno Bull
				if(MODULUS(valid_steps_taken, 4) == 0)
					playsound(xeno_owner, SFX_ALIEN_FOOTSTEP_LARGE, 50)
			if(CHARGE_BEHEMOTH)
				if(MODULUS(valid_steps_taken, 2) == 0)
					playsound(xeno_owner, SFX_BEHEMOTH_ROLLING, 30)

	lastturf = xeno_owner.loc

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
	if(xeno_owner.incapacitated() || xeno_owner.now_pushing)
		return NONE

	if(charge_type & (CHARGE_BULL|CHARGE_BULL_HEADBUTT|CHARGE_BULL_GORE|CHARGE_BEHEMOTH) && !isliving(crushed))
		do_stop_momentum()
		return COMPONENT_MOVABLE_PREBUMP_STOPPED

	var/precrush = crushed.pre_crush_act(xeno_owner, src) //Negative values are codes. Positive ones are damage to deal.
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
			log_combat(xeno_owner, crushed_living, "xeno charged")
			//There is a chance to do enough damage here to gib certain mobs. Better update immediately.
			crushed_living.apply_damage(precrush * 1.7, BRUTE, BODY_ZONE_CHEST, MELEE, updating_health = TRUE, penetration = 15)
			if(QDELETED(crushed_living))
				xeno_owner.visible_message(span_danger("[xeno_owner] annihilates [preserved_name]!"),
				span_xenodanger("We annihilate [preserved_name]!"))
				return COMPONENT_MOVABLE_PREBUMP_PLOWED

		return precrush2signal(crushed_living.post_crush_act(xeno_owner, src))

	if(isobj(crushed))
		var/obj/crushed_obj = crushed
		if(istype(crushed_obj, /obj/structure/xeno/silo) || istype(crushed_obj, /obj/structure/xeno/turret))
			return precrush2signal(crushed_obj.post_crush_act(xeno_owner, src))
		playsound(crushed_obj.loc, "punch", 25, 1)
		var/crushed_behavior = crushed_obj.crushed_special_behavior()
		var/obj_damage_mult = 1
		if(isarmoredvehicle(crushed) || ishitbox(crushed))
			obj_damage_mult = 5
		crushed_obj.take_damage(precrush * obj_damage_mult, BRUTE, MELEE)
		if(QDELETED(crushed_obj))
			xeno_owner.visible_message(span_danger("[xeno_owner] crushes [preserved_name]!"),
			span_xenodanger("We crush [preserved_name]!"))
			if(crushed_behavior & STOP_CRUSHER_ON_DEL)
				return COMPONENT_MOVABLE_PREBUMP_STOPPED
			else
				return COMPONENT_MOVABLE_PREBUMP_PLOWED

		return precrush2signal(crushed_obj.post_crush_act(xeno_owner, src))

	if(isturf(crushed))
		var/turf/crushed_turf = crushed
		if(iswallturf(crushed_turf))
			var/turf/closed/wall/crushed_wall = crushed_turf
			crushed_wall.take_damage(precrush, BRUTE, MELEE)
		else
			crushed_turf.ex_act(precrush * rand(50, 100))
		if(QDELETED(crushed_turf))
			xeno_owner.visible_message(span_danger("[xeno_owner] plows straight through [preserved_name]!"),
			span_xenowarning("We plow straight through [preserved_name]!"))
			return COMPONENT_MOVABLE_PREBUMP_PLOWED

		xeno_owner.visible_message(span_danger("[xeno_owner] rams into [crushed_turf] and skids to a halt!"),
		span_xenowarning("We ram into [crushed_turf] and skid to a halt!"))
		do_stop_momentum(FALSE)
		return COMPONENT_MOVABLE_PREBUMP_STOPPED

/datum/action/ability/xeno_action/ready_charge/bull_charge
	action_icon_state = "bull_ready_charge"
	action_icon = 'icons/Xeno/actions/bull.dmi'
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

	if(xeno_owner.is_charging >= CHARGE_ON)
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
			crush_sound = SFX_ALIEN_TAIL_ATTACK
			to_chat(owner, span_notice("Now goring on impact."))

/datum/action/ability/xeno_action/ready_charge/bull_charge/on_xeno_upgrade()
	agile_charge = (xeno_owner.upgrade == XENO_UPGRADE_PRIMO)

/datum/action/ability/xeno_action/ready_charge/queen_charge
	action_icon_state = "queen_ready_charge"
	action_icon = 'icons/Xeno/actions/queen.dmi'
