/mob/living/silicon/ai/Life(seconds_per_tick, times_fired)

	if(notransform) //If we're dead or set to notransform don't bother processing life
		return

	if(stat == DEAD)
		SSmobs.stop_processing(src)
		return

	update_health()

	interactee?.check_eye(src)


/mob/living/silicon/ai/update_stat()
	. = ..()

	if(status_flags & GODMODE)
		return

	if(stat != DEAD)
		if(health <= get_death_threshold())
			death()
		else if(stat == UNCONSCIOUS)
			set_stat(CONSCIOUS)


/mob/living/silicon/ai/update_health()
	if(status_flags & GODMODE)
		return

	health = 100 - get_oxy_loss() - get_tox_loss() - get_fire_loss() - get_brute_loss()

	update_stat()

// for adminbus
/mob/living/silicon/ai/revive()
	. = ..()
	icon_state = "ai" // if someone figures out how to set it based on icon_state_dead, while also checking for it in icon_states() do we don't break anything, good luck
	set_eyeobj_visible(TRUE)
	update_minimap_icon()
