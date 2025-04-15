/// Sets the direction of the mecha and all of its occcupents, required for FOV. Alternatively one could make a recursive contents registration and register topmost direction changes in the fov component
/obj/vehicle/sealed/mecha/setDir(newdir)
	. = ..()
	for(var/mob/living/occupant AS in occupants)
		occupant.setDir(newdir)

///Plays the mech step sound effect. Split from movement procs so that other mechs (HONK) can override this one specific part.
/obj/vehicle/sealed/mecha/proc/play_stepsound()
	SIGNAL_HANDLER
	playsound(src, stepsound, 40, TRUE)

/obj/vehicle/sealed/mecha/relaymove(mob/living/user, direction)
	. = TRUE
	if(!canmove || !(user in return_drivers()))
		return
	vehicle_move(user, direction)

/obj/vehicle/sealed/mecha/vehicle_move(mob/living/user, direction, forcerotate = FALSE)
	. = ..()
	if(!.)
		return
	if(completely_disabled)
		return FALSE
	if(!direction)
		return FALSE
	if(construction_state)
		if(!TIMER_COOLDOWN_CHECK(src, COOLDOWN_MECHA_MESSAGE))
			to_chat(occupants, "[icon2html(src, occupants)][span_danger("Maintenance protocols in effect.")]")
			TIMER_COOLDOWN_START(src, COOLDOWN_MECHA_MESSAGE, 2 SECONDS)
		return FALSE

	if(zoom_mode)
		if(!TIMER_COOLDOWN_CHECK(src, COOLDOWN_MECHA_MESSAGE))
			to_chat(occupants, "[icon2html(src, occupants)][span_warning("Unable to move while in zoom mode!")]")
			TIMER_COOLDOWN_START(src, COOLDOWN_MECHA_MESSAGE, 2 SECONDS)
		return FALSE
	if(!cell)
		if(!TIMER_COOLDOWN_CHECK(src, COOLDOWN_MECHA_MESSAGE))
			to_chat(occupants, "[icon2html(src, occupants)][span_warning("Missing power cell.")]")
			TIMER_COOLDOWN_START(src, COOLDOWN_MECHA_MESSAGE, 2 SECONDS)
		return FALSE
	if(!use_power(step_energy_drain))
		if(!TIMER_COOLDOWN_CHECK(src, COOLDOWN_MECHA_MESSAGE))
			to_chat(occupants, "[icon2html(src, occupants)][span_warning("Insufficient power to move!")]")
			TIMER_COOLDOWN_START(src, COOLDOWN_MECHA_MESSAGE, 2 SECONDS)
		return FALSE

	var/olddir = dir

	if(internal_damage & MECHA_INT_CONTROL_LOST)
		direction = pick(GLOB.alldirs)

	var/keyheld = FALSE
	if(strafe)
		for(var/mob/driver AS in return_drivers())
			if(driver.client?.keys_held["Alt"])
				keyheld = TRUE
				break

	//if we're not facing the way we're going rotate us
	if(dir != direction && !strafe || forcerotate || keyheld)
		//tgmc start
		if(direction == REVERSE_DIR(dir) && !forcerotate)
			direction = turn(direction, pick(90, -90))
		//tgmc end
		if(dir != direction)
			playsound(src, turnsound, 40, TRUE)
		setDir(direction)
		return TRUE

	set_glide_size(DELAY_TO_GLIDE_SIZE(move_delay))
	//Otherwise just walk normally
	. = step(src, direction, dir)
	if(strafe)
		setDir(olddir)
		
/obj/vehicle/sealed/mecha/set_submerge_level(turf/new_loc, turf/old_loc, submerge_icon = 'icons/turf/alpha_128.dmi', submerge_icon_state = "liquid_alpha", duration = move_delay)
	return ..()
