/obj/item/detpack/do_detonate()
	detonation_pending = null
	if(plant_target == null || !plant_target.loc) //need a target to be attached to
		if(timer < DETPACK_TIMER_MIN) //reset to minimum 5 seconds; no 'cooking' with aborted detonations.
			timer = DETPACK_TIMER_MIN
		deltimer(sound_timer)
		sound_timer = null
		nullvars()
		return
	if(!on) //need to be active and armed.
		armed = FALSE
		if(timer < DETPACK_TIMER_MIN) //reset to minimum 5 seconds; no 'cooking' with aborted detonations.
			timer = DETPACK_TIMER_MIN
		deltimer(sound_timer)
		sound_timer = null
		update_icon()
		return
	if(!armed)
		disarm()

	//Time to go boom
	playsound(src.loc, 'sound/weapons/ring.ogg', 200, FALSE)
	boom = TRUE
	if(det_mode == TRUE) //If we're on demolition mode, big boom.
		cell_explosion(plant_target, 315, 55)
	else //if we're not, focused boom.
		cell_explosion(plant_target, 450, 200, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL)
	plant_target.plastique_act()
	qdel(src)
