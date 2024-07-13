// ***************************************
// *********** Universal abilities
// ***************************************
// Resting
/datum/action/ability/xeno_action/xeno_resting
	use_state_flags = ABILITY_USE_LYING|ABILITY_USE_CRESTED|ABILITY_USE_CLOSEDTURF|ABILITY_USE_STAGGERED|ABILITY_USE_INCAP

// Secrete Resin
/datum/action/ability/activable/xeno/secrete_resin
	buildable_structures = list(
		/turf/closed/wall/resin/regenerating,
		/obj/alien/resin/sticky,
		/obj/structure/mineral_door/resin,
		/obj/structure/bed/nest,
		)

/// Extra handling for adding the action for draggin functionality (for instant building)
/datum/action/ability/activable/xeno/secrete_resin/give_action(mob/living/L)
	. = ..()
	if(!(CHECK_BITFIELD(SSticker?.mode?.flags_round_type, MODE_ALLOW_XENO_QUICKBUILD) || !SSresinshaping.active))
		return

	var/mutable_appearance/build_maptext = mutable_appearance(icon = null,icon_state = null, layer = ACTION_LAYER_MAPTEXT)
	build_maptext.pixel_x = 12
	build_maptext.pixel_y = -5
	build_maptext.maptext = MAPTEXT(SSresinshaping.get_building_points(owner))
	visual_references[VREF_MUTABLE_BUILDING_COUNTER] = build_maptext

	RegisterSignal(owner, COMSIG_MOB_MOUSEDOWN, PROC_REF(start_resin_drag))
	RegisterSignal(owner, COMSIG_MOB_MOUSEDRAG, PROC_REF(preshutter_resin_drag))
	RegisterSignal(owner, COMSIG_MOB_MOUSEUP, PROC_REF(stop_resin_drag))
	RegisterSignals(SSdcs, list(COMSIG_GLOB_OPEN_SHUTTERS_EARLY, COMSIG_GLOB_OPEN_TIMED_SHUTTERS_LATE,COMSIG_GLOB_OPEN_TIMED_SHUTTERS_XENO_HIVEMIND,COMSIG_GLOB_TADPOLE_LAUNCHED,COMSIG_GLOB_DROPPOD_LANDED), PROC_REF(end_resin_drag))

/datum/action/ability/activable/xeno/secrete_resin/update_button_icon()
	var/mob/living/carbon/xenomorph/X = owner
	var/atom/A = X.selected_resin
	action_icon_state = initial(A.name)
	if(SSmonitor.gamestate == SHUTTERS_CLOSED && CHECK_BITFIELD(SSticker.mode?.flags_round_type, MODE_ALLOW_XENO_QUICKBUILD) && SSresinshaping.active)
		button.cut_overlay(visual_references[VREF_MUTABLE_BUILDING_COUNTER])
		var/mutable_appearance/number = visual_references[VREF_MUTABLE_BUILDING_COUNTER]
		number.maptext = MAPTEXT("[SSresinshaping.get_building_points(owner)]")
		visual_references[VREF_MUTABLE_BUILDING_COUNTER] = number
		button.add_overlay(visual_references[VREF_MUTABLE_BUILDING_COUNTER])
	else if(visual_references[VREF_MUTABLE_BUILDING_COUNTER])
		button.cut_overlay(visual_references[VREF_MUTABLE_BUILDING_COUNTER])
		visual_references[VREF_MUTABLE_BUILDING_COUNTER] = null
	return ..()

/datum/action/ability/activable/xeno/secrete_resin/use_ability(atom/A)
	var/mob/living/carbon/xenomorph/xowner = owner
	if(get_dist(owner, A) > xowner.xeno_caste.resin_max_range) //Maximum range is defined in the castedatum with resin_max_range, defaults to 0
		build_resin(get_turf(owner))
	else
		build_resin(get_turf(A))

/datum/action/ability/activable/xeno/secrete_resin/build_resin(turf/T)
	var/mob/living/carbon/xenomorph/X = owner
	if(X.selected_resin == /obj/structure/bed/nest)
		for(var/obj/structure/bed/nest/xeno_nest in range (2,T))
			owner.balloon_alert(owner, span_notice("Another nest is too close!"))
			return

	return ..()

/// A version of build_resin with the plasma drain and distance checks removed.
/datum/action/ability/activable/xeno/secrete_resin/proc/preshutter_build_resin(turf/T)
	if(!SSresinshaping.active)
		stack_trace("[owner] ([key_name(owner)]) didn't have their quickbuild signals unregistered properly and tried using quickbuild after the subsystem was off!")
		end_resin_drag()
		return

	if(SSticker.mode?.flags_round_type & MODE_PERSONAL_QUICKBUILD_POINTS && !SSresinshaping.get_building_points(owner))
		owner.balloon_alert(owner, "You have used all your quick-build points! Wait until the marines have landed!")
		return
	if(SSticker.mode?.flags_round_type & MODE_GENERAL_QUICKBUILD_POINTS && !SSresinshaping.quickbuild_points_by_hive[owner.get_xeno_hivenumber()])
		owner.balloon_alert(owner, "The hive has ran out of quickbuilding points! Wait until more sisters awaken or the marines land!")
		return

	var/mob/living/carbon/xenomorph/X = owner
	switch(is_valid_for_resin_structure(T, X.selected_resin == /obj/structure/mineral_door/resin))
		if(ERROR_CANT_WEED)
			owner.balloon_alert(owner, span_notice("This spot cannot support a garden!"))
			return
		if(ERROR_NO_WEED)
			owner.balloon_alert(owner, span_notice("This spot has no weeds to serve as support!"))
			return
		if(ERROR_NO_SUPPORT)
			owner.balloon_alert(owner, span_notice("This spot has no adjaecent support for the structure!"))
			return
		if(ERROR_NOT_ALLOWED)
			owner.balloon_alert(owner, span_notice("The queen mother prohibits us from building here."))
			return
		if(ERROR_BLOCKER)
			owner.balloon_alert(owner, span_notice("There's another xenomorph blocking the spot!"))
			return
		if(ERROR_FOG)
			owner.balloon_alert(owner, span_notice("The fog will prevent the resin from ever taking shape!"))
			return
		// it fails a lot here when dragging , so its to prevent spam
		if(ERROR_CONSTRUCT)
			return
		if(ERROR_JUST_NO)
			return

	for(var/mob/living/carbon/human AS in cheap_get_humans_near(T, 7))
		if(human.client && human.stat != DEAD)
			owner.balloon_alert(owner, "Somebody humanlike is alive nearby!")
			return

	if(X.selected_resin == /obj/structure/bed/nest)
		for(var/obj/structure/bed/nest/xeno_nest in range (2,T))
			owner.balloon_alert(owner, span_notice("Another nest is too close!"))
			return

	var/atom/new_resin
	if(ispath(X.selected_resin, /turf)) // We should change turfs, not spawn them in directly
		var/list/baseturfs = islist(T.baseturfs) ? T.baseturfs : list(T.baseturfs)
		baseturfs |= T.type
		T.ChangeTurf(X.selected_resin, baseturfs)
		new_resin = T
	else
		new_resin = new X.selected_resin(T)
	if(new_resin)
		SSresinshaping.increment_build_counter(owner)

/datum/action/ability/activable/xeno/pounce/hellhound
	cooldown_duration = 5 SECONDS

