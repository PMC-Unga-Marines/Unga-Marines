SUBSYSTEM_DEF(lighting)
	name = "Lighting"
	wait = 2
	init_order = INIT_ORDER_LIGHTING

	//debug var for tracking updates before init is complete
	var/duplicate_shadow_updates_in_init = 0
	///Total times shadows were updated, debug
	var/total_shadow_calculations = 0

	var/static/list/static_sources_queue = list() //! List of static lighting sources queued for update.
	var/static/list/corners_queue = list() //! List of lighting corners queued for update.
	var/static/list/objects_queue = list() //! List of lighting objects queued for update.

	var/static/list/mask_queue = list() //! List of hybrid lighting sources queued for update.

/datum/controller/subsystem/lighting/Initialize()
	if(!initialized)
		create_all_lighting_objects()
		initialized = TRUE

	fire(FALSE, TRUE)

	return SS_INIT_SUCCESS

///Handle static lightning
/datum/controller/subsystem/lighting/proc/create_all_lighting_objects()
	for(var/area/area as anything in GLOB.areas)
		if(!area.static_lighting)
			continue

		for(var/turf/our_turf in area)
			new /datum/static_lighting_object(our_turf)
			CHECK_TICK
		CHECK_TICK

/datum/controller/subsystem/lighting/stat_entry(msg)
	msg = "ShadowCalculations:[total_shadow_calculations]|Sources:[length(static_sources_queue)]|Corners:[length(corners_queue)]|Objects:[length(objects_queue)]|Masks:[length(mask_queue)]"
	return ..()

/datum/controller/subsystem/lighting/fire(resumed, init_tick_checks)
	MC_SPLIT_TICK_INIT(3)
	if(!init_tick_checks)
		MC_SPLIT_TICK

	var/updators_num = 0
	for(var/datum/static_light_source/L as anything in static_sources_queue)
		updators_num++
		L.update_corners()
		if(QDELETED(L))
			updators_num--

		L.needs_update = LIGHTING_NO_UPDATE
		if(init_tick_checks)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			break
	if(updators_num)
		static_sources_queue.Cut(1, ++updators_num)
		updators_num = 0
	if(!init_tick_checks)
		MC_SPLIT_TICK

	updators_num = 0
	for(var/datum/static_lighting_corner/C AS in corners_queue)
		updators_num++
		C.needs_update = FALSE //update_objects() can call qdel if the corner is storing no data
		C.update_objects()
		if(QDELETED(C))
			updators_num--
		if(init_tick_checks)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			break
	if(updators_num)
		corners_queue.Cut(1, ++updators_num)
		updators_num = 0
	if(!init_tick_checks)
		MC_SPLIT_TICK

	updators_num = 0
	for(var/datum/static_lighting_object/O AS in objects_queue)
		updators_num++
		if (QDELETED(O))
			updators_num--
			continue
		O.update()
		O.needs_update = FALSE
		if(init_tick_checks)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			break
	if(updators_num)
		objects_queue.Cut(1, ++updators_num)
		updators_num = 0
	if(!init_tick_checks)
		MC_SPLIT_TICK

	updators_num = 0
	for(var/atom/movable/lighting_mask/mask_to_update as anything in mask_queue)
		updators_num++

		mask_to_update.calculate_lighting_shadows()
		if(init_tick_checks)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			break
	if(updators_num)
		mask_queue.Cut(1, ++updators_num)

/datum/controller/subsystem/lighting/Recover()
	initialized = SSlighting.initialized
	return ..()
