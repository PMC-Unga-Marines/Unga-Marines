/datum/ai_behavior/xeno/illusion
	target_distance = 3 //We attack only nearby
	base_action = ESCORTING_ATOM
	is_offered_on_creation = FALSE
	/// How close a human has to be in order for illusions to react
	var/illusion_react_range = 5

/datum/ai_behavior/xeno/illusion/New(loc, parent_to_assign, escorted_atom)
	if(!escorted_atom)
		base_action = MOVING_TO_NODE
	return ..()

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

/datum/ai_behavior/xeno/illusion/attack_target(datum/source, atom/attacked)
	if(world.time < mob_parent.next_move)
		return
	if(!attacked)
		attacked = atom_to_walk_to
	if(get_dist(attacked, mob_parent) > 1)
		return
	var/mob/illusion/illusion_parent = mob_parent
	var/mob/living/carbon/xenomorph/original_xeno = illusion_parent.original_mob
	illusion_parent.changeNext_move(original_xeno.xeno_caste.attack_delay + rand(0, 10))
	illusion_parent.face_atom(attacked)
	if(ismob(attacked))
		illusion_parent.do_attack_animation(attacked, ATTACK_EFFECT_REDSLASH)
		playsound(illusion_parent.loc, SFX_ALIEN_CLAW_FLESH, 25, 1)
		return
	illusion_parent.do_attack_animation(attacked, ATTACK_EFFECT_CLAW)
	playsound(illusion_parent.loc, SFX_ALIEN_CLAW_METAL, 25, 1)
