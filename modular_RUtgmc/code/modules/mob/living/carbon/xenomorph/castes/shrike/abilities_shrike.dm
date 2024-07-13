// ***************************************
// *********** Psychic Grab
// ***************************************
/datum/action/ability/activable/xeno/psychic_grab
	name = "Psychic Grab"
	action_icon_state = "grab"
	desc = "Attracts the target to the owner of the ability."
	cooldown_duration = 12 SECONDS
	ability_cost = 100
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PSYCHIC_GRAB,
	)
	target_flags = ABILITY_MOB_TARGET


/datum/action/ability/activable/xeno/psychic_grab/on_cooldown_finish()
	to_chat(owner, span_notice("We gather enough mental strength to grab something again."))
	return ..()


/datum/action/ability/activable/xeno/psychic_grab/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(QDELETED(target))
		return FALSE
	if(!isitem(target) && !ishuman(target) && !isdroid(target))	//only items, droids, and mobs can be flung.
		return FALSE
	var/max_dist = 5
	if(!line_of_sight(owner, target, max_dist))
		if(!silent)
			to_chat(owner, span_warning("We must get closer to grab, our mind cannot reach this far."))
		return FALSE
	if(ishuman(target))
		var/mob/living/carbon/human/victim = target
		if(isnestedhost(victim))
			return FALSE
		if(!CHECK_BITFIELD(use_state_flags|override_flags, ABILITY_IGNORE_DEAD_TARGET) && victim.stat == DEAD)
			return FALSE


/datum/action/ability/activable/xeno/psychic_grab/use_ability(atom/target)
	var/mob/living/victim = target

	owner.visible_message(span_xenowarning("A strange and violent psychic aura is suddenly emitted from \the [owner]!"), \
	span_xenowarning("We are rapidly attracting [victim] with the power of our mind!"))
	victim.visible_message(span_xenowarning("[victim] is rapidly attracting away by an unseen force!"), \
	span_xenowarning("You are rapidly attracting to the side by an unseen force!"))
	playsound(owner,'sound/effects/magic.ogg', 75, 1)
	playsound(victim,'sound/weapons/alien_claw_block.ogg', 75, 1)
	succeed_activate()
	add_cooldown()
	if(ishuman(victim))
		victim.apply_effects(0.4, 0.1) 	// The fling stuns you enough to remove your gun, otherwise the marine effectively isn't stunned for long.
		shake_camera(victim, 2, 1)

	var/grab_distance = (isitem(victim)) ? 5 : 4 //Objects get flung further away.

	victim.throw_at(owner, grab_distance, 1, owner, TRUE)

// ***************************************
// *********** Unrelenting Force
// ***************************************
/datum/action/ability/activable/xeno/unrelenting_force
	cooldown_duration = 20 SECONDS

/datum/action/ability/activable/xeno/unrelenting_force/use_ability(atom/target)
	succeed_activate()
	add_cooldown()
	addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob, update_icons)), 1 SECONDS)
	var/mob/living/carbon/xenomorph/xeno = owner
	owner.icon_state = "[xeno.xeno_caste.caste_name][xeno.is_a_rouny ? " rouny" : ""] Screeching"
	if(target) // Keybind use doesn't have a target
		owner.face_atom(target)

	var/turf/lower_left
	var/turf/upper_right
	switch(owner.dir)
		if(NORTH)
			lower_left = locate(owner.x - 1, owner.y + 1, owner.z)
			upper_right = locate(owner.x + 1, owner.y + 3, owner.z)
		if(SOUTH)
			lower_left = locate(owner.x - 1, owner.y - 3, owner.z)
			upper_right = locate(owner.x + 1, owner.y - 1, owner.z)
		if(WEST)
			lower_left = locate(owner.x - 3, owner.y - 1, owner.z)
			upper_right = locate(owner.x - 1, owner.y + 1, owner.z)
		if(EAST)
			lower_left = locate(owner.x + 1, owner.y - 1, owner.z)
			upper_right = locate(owner.x + 3, owner.y + 1, owner.z)

	for(var/turf/affected_tile in block(lower_left, upper_right)) //everything in the 2x3 block is found.
		affected_tile.Shake(duration = 0.5 SECONDS)
		for(var/i in affected_tile)
			var/atom/movable/affected = i
			if(!ishuman(affected) && !istype(affected, /obj/item) && !isdroid(affected))
				affected.Shake(duration = 0.5 SECONDS)
				continue
			if(ishuman(affected)) //if they're human, they also should get knocked off their feet from the blast.
				var/mob/living/carbon/human/H = affected
				if(H.stat == DEAD) //unless they are dead, then the blast mysteriously ignores them.
					continue
				H.apply_effects(2 SECONDS, 2 SECONDS) 	// Stun
				shake_camera(H, 2, 1)
			var/throwlocation = affected.loc //first we get the target's location
			for(var/x in 1 to 6)
				throwlocation = get_step(throwlocation, owner.dir) //then we find where they're being thrown to, checking tile by tile.
			affected.throw_at(throwlocation, 6, 1, owner, TRUE)

	owner.visible_message(span_xenowarning("[owner] sends out a huge blast of psychic energy!"), \
	span_xenowarning("We send out a huge blast of psychic energy!"))

	playsound(owner,'sound/effects/bamf.ogg', 75, TRUE)
	playsound(owner, "alien_roar", 50)

// ***************************************
// *********** Construct Acid Well
// ***************************************
/datum/action/ability/xeno_action/place_acidwell
	ability_cost = 200
