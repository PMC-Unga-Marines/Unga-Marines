/obj/machinery/atmospherics
	var/covered_by_shuttle = FALSE

/obj/machinery/atmospherics/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_SHUTTLE_CRUSH, PROC_REF(shuttle_crush))

/obj/machinery/atmospherics/proc/shuttle_crush()
	covered_by_shuttle = TRUE

/obj/machinery/atmospherics/climb_out(mob/living/user, turf/T)
	if(TIMER_COOLDOWN_CHECK(user, COOLDOWN_VENTCRAWL))
		return FALSE
	var/vent_crawl_exit_time = 2 SECONDS
	TIMER_COOLDOWN_START(user, COOLDOWN_VENTCRAWL, vent_crawl_exit_time)

	if(T.density || covered_by_shuttle)
		to_chat(user, span_notice("You cannot climb out, the exit is blocked!"))
		return

	var/silent_crawl = FALSE
	if(isxeno(user))
		var/mob/living/carbon/xenomorph/X = user
		silent_crawl = X.xeno_caste.silent_vent_crawl
		vent_crawl_exit_time = X.xeno_caste.vent_exit_speed
	if(!silent_crawl) //Xenos with silent crawl can silently enter/exit/move through vents.
		visible_message(span_warning("You hear something squeezing through the ducts."))
	to_chat(user, span_notice("You begin to climb out of the ventilation system."))
	if(!do_after(user, vent_crawl_exit_time, IGNORE_HELD_ITEM, user.loc))
		return FALSE
	user.remove_ventcrawl()
	user.forceMove(T)
	user.visible_message(span_warning("[user] climbs out of the ventilation ducts."), \
	span_notice("You climb out of the ventilation ducts."))
	if(!silent_crawl)
		playsound(src, get_sfx("alien_ventpass"), 35, TRUE)

/obj/machinery/atmospherics/relaymove(mob/living/user, direction)
	direction &= initialize_directions
	if(!direction || !(direction in GLOB.cardinals))
		if(is_type_in_typecache(src, GLOB.ventcrawl_machinery) && can_crawl_through()) // If we try to move somewhere besides existing pipes while in the vent, we try to leave
			climb_out(user, loc)
		return

	var/obj/machinery/atmospherics/target_move = findConnecting(direction, user.ventcrawl_layer)
	if(!target_move)
		if(direction & initialize_directions)
			climb_out(user, loc)
		return

	user.forceMove(target_move)
	user.update_pipe_vision()
	user.client.eye = target_move  //Byond only updates the eye every tick, This smooths out the movement

	var/silent_crawl = FALSE //Some creatures can move through the vents silently
	if(isxeno(user))
		var/mob/living/carbon/xenomorph/our_xenomorph = user
		silent_crawl = our_xenomorph.xeno_caste.silent_vent_crawl
	if(TIMER_COOLDOWN_CHECK(user, COOLDOWN_VENTSOUND) || silent_crawl)
		return
	TIMER_COOLDOWN_START(user, COOLDOWN_VENTSOUND, 3 SECONDS)
	playsound(src, pick('sound/effects/alien_ventcrawl1.ogg','sound/effects/alien_ventcrawl2.ogg'), 50, TRUE, -3)
