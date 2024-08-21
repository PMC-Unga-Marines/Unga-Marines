/datum/ai_behavior/xeno/illusion
	target_distance = 3 //We attack only nearby
	base_action = ESCORTING_ATOM
	is_offered_on_creation = FALSE
	/// How close a human has to be in order for illusions to react
	var/illusion_react_range = 5

/datum/ai_behavior/xeno/illusion/New(loc, parent_to_assign, escorted_atom)
	if(!escorted_atom)
		base_action = MOVING_TO_NODE
	..()

/// We want a separate look_for_new_state in order to make illusions behave as we wish
/datum/ai_behavior/xeno/illusion/look_for_new_state()
	switch(current_action)
		if(ESCORTING_ATOM)
			for(var/mob/living/carbon/human/victim in view(illusion_react_range, mob_parent))
				if(victim.stat == DEAD)
					continue
				attack_target(src, victim)
				set_escorted_atom(src, victim)
				return

/datum/ai_behavior/xeno/illusion/attack_target(datum/soure, atom/attacked)
	if(world.time < mob_parent.next_move)
		return
	if(!attacked)
		attacked = atom_to_walk_to
	if(get_dist(attacked, mob_parent) > 1)
		return
	var/mob/illusion/illusion_parent = mob_parent
	var/mob/living/carbon/xenomorph/original_xeno = illusion_parent.original_mob
	illusion_parent.changeNext_move(original_xeno.xeno_caste.attack_delay + rand(0, 5))
	illusion_parent.face_atom(attacked)
	if(ismob(attacked))
		illusion_parent.do_attack_animation(attacked, ATTACK_EFFECT_REDSLASH)
		playsound(illusion_parent.loc, "alien_claw_flesh", 25, 1)
		return
	illusion_parent.do_attack_animation(attacked, ATTACK_EFFECT_CLAW)
	playsound(illusion_parent.loc, "alien_claw_metal", 25, 1)

/mob/illusion
	density = FALSE
	status_flags = GODMODE
	layer = BELOW_MOB_LAYER
	///The parent mob the illusion is a copy of
	var/mob/original_mob
	/// Timer to remove the hit effect
	var/timer_effect

/mob/illusion/Initialize(mapload, mob/original_mob, atom/escorted_atom, life_time)
	. = ..()
	if(!original_mob)
		return INITIALIZE_HINT_QDEL
	src.original_mob = original_mob
	appearance = original_mob.appearance
	setDir(original_mob.dir)
	desc = original_mob.desc
	name = original_mob.name
	RegisterSignals(original_mob, list(COMSIG_QDELETING, COMSIG_MOB_DEATH), PROC_REF(destroy_illusion))
	GLOB.mob_illusions_list += src
	QDEL_IN(src, life_time)

/mob/illusion/Destroy()
	. = ..()
	GLOB.mob_illusions_list -= src

///Delete this illusion when the original xeno is ded
/mob/illusion/proc/destroy_illusion()
	SIGNAL_HANDLER
	GLOB.mob_illusions_list -= src
	qdel(src)

/// Remove the filter effect added when it was hit
/mob/illusion/proc/remove_hit_filter()
	remove_filter("illusion_hit")

/mob/illusion/projectile_hit()
	remove_filter("illusion_hit")
	deltimer(timer_effect)
	add_filter("illusion_hit", 2, ripple_filter(10, 5))
	timer_effect = addtimer(CALLBACK(src, PROC_REF(remove_hit_filter)), 0.5 SECONDS, TIMER_STOPPABLE)
	return FALSE

/mob/illusion/xeno/Initialize(mapload, mob/living/carbon/xenomorph/original_mob, atom/escorted_atom, life_time)
	. = ..()
	if(.)
		return INITIALIZE_HINT_QDEL
	add_movespeed_modifier(MOVESPEED_ID_XENO_CASTE_SPEED, TRUE, 0, NONE, TRUE, MOB_RUN_MOVE_MOD + original_mob.xeno_caste.speed * pick(0.9, 1, 1.1, 1.2, 1.3)) // rand doesn't work here because it's decimals
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno/illusion, escorted_atom)
