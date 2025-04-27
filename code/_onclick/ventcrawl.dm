// TODO transfer this code into handle_ventcrawl
/mob/proc/start_ventcrawl()
	var/atom/pipe
	var/list/pipes = list()
	for(var/obj/machinery/atmospherics/components/unary/U in range(1))
		if(U.vent_movement & VENTCRAWL_ENTRANCE_ALLOWED && Adjacent(U))
			pipes |= U
	if(!pipes || !length(pipes))
		balloon_alert(src, "No pipes in range!")
		return
	if(length(pipes) == 1)
		pipe = pipes[1]
	else
		pipe = tgui_input_list(usr, "Crawl Through Vent", "Pick a pipe",  pipes)
	if(!incapacitated() && pipe)
		return pipe

// VENTCRAWLING
// Handles the entrance and exit on ventcrawling
/mob/living/proc/ventcrawl_checks(obj/machinery/atmospherics/ventcrawl_target)
	if(!HAS_TRAIT(src, TRAIT_CAN_VENTCRAWL))
		return FALSE
	if(!Adjacent(ventcrawl_target))
		return FALSE
	if(stat)
		to_chat(src, span_warning("You must be conscious to do this!"))
		return FALSE
	if(buckled)
		to_chat(src, span_warning("You can't vent crawl while buckled!"))
		return FALSE
	if(istype(ventcrawl_target, /obj/machinery/atmospherics/components))
		var/obj/machinery/atmospherics/components/ventcrawl_component = ventcrawl_target
		if(ventcrawl_component.welded)
			to_chat(src, span_warning("You can't crawl around a welded vent!"))
			return FALSE
	if(ventcrawl_target.loc.density || ventcrawl_target.covered_by_shuttle)
		to_chat(src, span_notice("You cannot climb out, the exit is blocked!"))
		return FALSE
	return TRUE

/mob/living/proc/handle_pipe_exit(obj/machinery/atmospherics/components/ventcrawl_target, crawl_time = 4.5 SECONDS, stealthy = FALSE)
	if(!ventcrawl_checks(ventcrawl_target))
		return

	if(!is_ventcrawling)
		return
	if(!istype(loc,/obj/machinery/atmospherics))
		return
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_VENTCRAWL))
		return
	TIMER_COOLDOWN_START(src, COOLDOWN_VENTCRAWL,  crawl_time)
	visible_message(span_notice("[src] begins climbing out from the ventilation system..."), span_notice("You begin climbing out from the ventilation system..."))
	if(!do_after(src, crawl_time, target = ventcrawl_target))
		TIMER_COOLDOWN_END(src, COOLDOWN_VENTCRAWL)
		return
	if(!client)
		return
	if(!stealthy) //Xenos with stealth vent crawling can silently enter/exit vents.
		playsound(src, get_sfx(SFX_ALIEN_VENTPASS), 35, TRUE)
	visible_message(span_notice("[src] scrambles out from the ventilation ducts!"), span_notice("You scramble out from the ventilation ducts."))
	forceMove(ventcrawl_target.loc)
	is_ventcrawling = FALSE
	update_pipe_vision()

// VENTCRAWLING
// Handles the entrance and exit on ventcrawling
/mob/living/proc/handle_ventcrawl(obj/machinery/atmospherics/components/ventcrawl_target, crawl_time = 4.5 SECONDS, stealthy = FALSE)

	// Cache the vent_movement bitflag var from atmos machineries
	var/vent_movement = ventcrawl_target.vent_movement

	if(!ventcrawl_checks(ventcrawl_target))
		return

	if(vent_movement & VENTCRAWL_ENTRANCE_ALLOWED)
		//Handle the exit here
		if(is_ventcrawling && istype(loc, /obj/machinery/atmospherics))
			visible_message(span_notice("[src] begins climbing out from the ventilation system..."), span_notice("You begin climbing out from the ventilation system..."))
			if(!do_after(src, crawl_time, target = ventcrawl_target))
				return
			if(!client)
				return
			if(!stealthy) //Xenos with stealth vent crawling can silently enter/exit vents.
				playsound(src, get_sfx(SFX_ALIEN_VENTPASS), 35, TRUE)
			visible_message(span_notice("[src] scrambles out from the ventilation ducts!"), span_notice("You scramble out from the ventilation ducts."))
			forceMove(ventcrawl_target.loc)
			is_ventcrawling = FALSE
			update_pipe_vision()

		//Entrance here
		else
			var/datum/pipeline/vent_parent = ventcrawl_target.parents[1]
			if(vent_parent && (vent_parent.members.len || vent_parent.other_atmosmch))
				visible_message(span_notice("[src] begins climbing into the ventilation system...") ,span_notice("You begin climbing into the ventilation system..."))
				if(!do_after(src, crawl_time, target = ventcrawl_target))
					return
				if(!client)
					return
				if(!stealthy) //Xenos with stealth vent crawling can silently enter/exit vents.
					playsound(src, get_sfx(SFX_ALIEN_VENTPASS), 35, TRUE)
				visible_message(span_notice("[src] scrambles into the ventilation ducts!"),span_notice("You climb into the ventilation ducts."))
				move_into_vent(ventcrawl_target)
			else
				to_chat(src, span_warning("This ventilation duct is not connected to anything!"))

/**
 * Moves living mob directly into the vent as a ventcrawler
 *
 * Arguments:
 * * ventcrawl_target - The vent into which we are moving the mob
 */
/mob/living/proc/move_into_vent(obj/machinery/atmospherics/components/ventcrawl_target)
	forceMove(ventcrawl_target)
	is_ventcrawling = TRUE
	update_pipe_vision()

/mob/living/proc/update_pipe_vision(full_refresh = FALSE)
	// We're gonna color the lighting plane to make it darker while ventcrawling, so things look nicer
	var/atom/movable/screen/plane_master/lighting
	if(hud_used)
		lighting = hud_used?.plane_masters["[LIGHTING_PLANE]"]

	// Take away all the pipe images if we're not doing anything with em
	if(isnull(client) || !is_ventcrawling || !istype(loc, /obj/machinery/atmospherics))
		for(var/image/current_image in pipes_shown)
			client.images -= current_image
		pipes_shown.len = 0
		pipetracker = null
		lighting?.remove_atom_colour(TEMPORARY_COLOR_PRIORITY, "#4d4d4d")
		return

	// This is a bit hacky but it makes the background darker, which has a nice effect
	lighting?.add_atom_colour("#4d4d4d", TEMPORARY_COLOR_PRIORITY)

	var/obj/machinery/atmospherics/current_location = loc
	var/list/our_pipenets = current_location.returnPipenets()

	// We on occasion want to do a full rebuild. this lets us do that
	if(full_refresh)
		for(var/image/current_image in pipes_shown)
			client.images -= current_image
		pipes_shown.len = 0
		pipetracker = null

	if(!pipetracker)
		pipetracker = new()

	var/turf/our_turf = get_turf(src)
	// We're getting the smallest "range" arg we can pass to the spatial grid and still get all the stuff we need
	// We preload a bit more then we need so movement looks ok
	var/list/view_range = getviewsize(client.view)
	pipetracker.set_bounds(view_range[1] + 1, view_range[2] + 1)

	var/list/entered_exited_pipes = pipetracker.recalculate_type_members(our_turf, SPATIAL_GRID_CONTENTS_TYPE_ATMOS)
	var/list/pipes_gained = entered_exited_pipes[1]
	var/list/pipes_lost = entered_exited_pipes[2]

	for(var/obj/machinery/atmospherics/pipenet_part as anything in pipes_lost)
		if(!pipenet_part.pipe_vision_img)
			continue
		client.images -= pipenet_part.pipe_vision_img
		pipes_shown -= pipenet_part.pipe_vision_img

	for(var/obj/machinery/atmospherics/pipenet_part as anything in pipes_gained)
		// If the machinery is not part of our net or is not meant to be seen, continue
		var/list/thier_pipenets = pipenet_part.returnPipenets()
		if(!length(thier_pipenets & our_pipenets))
			continue
		if(!(pipenet_part.vent_movement & VENTCRAWL_CAN_SEE))
			continue

		if(!pipenet_part.pipe_vision_img)
			pipenet_part.pipe_vision_img = image(pipenet_part, pipenet_part.loc, dir = pipenet_part.dir)
			pipenet_part.pipe_vision_img.plane = ABOVE_HUD_LAYER
		client.images += pipenet_part.pipe_vision_img
		pipes_shown += pipenet_part.pipe_vision_img
