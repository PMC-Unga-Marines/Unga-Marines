SUBSYSTEM_DEF(icon_smooth)
	name = "Icon Smoothing"
	init_order = INIT_ORDER_ICON_SMOOTHING
	wait = 1
	priority = FIRE_PRIORITY_SMOOTHING
	flags = SS_TICKER

	///Blueprints assemble an image of what pipes/manifolds/wires look like on initialization, and thus should be taken after everything's been smoothed
	var/list/blueprint_queue = list()
	var/list/smooth_queue = list()
	var/list/deferred = list()
	var/list/deferred_by_source = list()

/datum/controller/subsystem/icon_smooth/Initialize()
	smooth_zlevel(1, TRUE)
	smooth_zlevel(2, TRUE)

	var/list/queue = smooth_queue
	smooth_queue = list()

	while(length(queue))
		var/atom/smoothing_atom = queue[length(queue)]
		queue.len--
		if(QDELETED(smoothing_atom) || !(smoothing_atom.smoothing_flags & SMOOTH_QUEUED) || smoothing_atom.z <= 2)
			continue
		smoothing_atom.smooth_icon()
		CHECK_TICK

	queue = blueprint_queue
	blueprint_queue = list()

	for(var/item in queue)
		var/atom/movable/movable_item = item
		if(!isturf(movable_item.loc))
			continue

	return SS_INIT_SUCCESS

/datum/controller/subsystem/icon_smooth/fire()
	var/list/cached = smooth_queue
	while(length(cached))
		var/atom/smoothing_atom = cached[length(cached)]
		cached.len--
		if(QDELETED(smoothing_atom) || !(smoothing_atom.smoothing_flags & SMOOTH_QUEUED))
			continue
		if(smoothing_atom.atom_flags & INITIALIZED)
			smoothing_atom.smooth_icon()
		else
			deferred += smoothing_atom
		if (MC_TICK_CHECK)
			return

	if (!length(cached))
		if (length(deferred))
			smooth_queue = deferred
			deferred = cached
		else
			can_fire = FALSE

/// Releases a pool of delayed smooth attempts from a particular source
/datum/controller/subsystem/icon_smooth/proc/free_deferred(source_to_free)
	smooth_queue += deferred_by_source[source_to_free]
	deferred_by_source -= source_to_free
	if(!can_fire)
		can_fire = TRUE

/datum/controller/subsystem/icon_smooth/proc/add_to_queue(atom/thing)
	if(thing.smoothing_flags & SMOOTH_QUEUED)
		return
	thing.smoothing_flags |= SMOOTH_QUEUED
	// If we're currently locked into mapload BY something
	// Then put us in a deferred list that we release when this mapload run is finished
	if(initialized && length(SSatoms.initialized_state) && SSatoms.initialized == INITIALIZATION_INNEW_MAPLOAD)
		var/source = SSatoms.get_initialized_source()
		LAZYADD(deferred_by_source[source], thing)
		return
	smooth_queue += thing
	if(!can_fire)
		can_fire = TRUE

/datum/controller/subsystem/icon_smooth/proc/remove_from_queues(atom/thing)
	// Lack of removal from deferred_by_source is safe because the lack of SMOOTH_QUEUED will just free it anyway
	// Hopefully this'll never cause a harddel (dies)
	thing.smoothing_flags &= ~SMOOTH_QUEUED
	smooth_queue -= thing
	blueprint_queue -= thing
	deferred -= thing
