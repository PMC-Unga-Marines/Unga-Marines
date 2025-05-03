#define MAXIMUM_DEFAULT_SPAWN 120

SUBSYSTEM_DEF(spawning)
	name = "Spawning"
	priority = FIRE_PRIORITY_SPAWNING
	flags = SS_NO_INIT
	wait = 40
	///Maximum amount of spawnable mobs
	var/mob_cap = MAXIMUM_DEFAULT_SPAWN
	///total number of spawned mobs
	var/total_spawned = 0
	///Assoc list of spawners and their assosicated data
	var/list/datum/spawnerdata/spawnerdata = list()
	///Assoc list [mob] = removalcb
	var/list/datum/callback/death_callbacks_by_mob = list()

/datum/controller/subsystem/spawning/Recover()
	spawnerdata = SSspawning.spawnerdata
	death_callbacks_by_mob = SSspawning.death_callbacks_by_mob

///Admin proc to unregister and reregister AI node spawners for example for varedits on WO
/datum/controller/subsystem/spawning/proc/reset_ai()
	for(var/obj/effect/ai_node/spawner/spawner AS in spawnerdata)
		unregisterspawner(spawner)
		registerspawner(spawner, spawner.spawn_delay, spawner.spawn_types, spawner.max_amount, spawner.spawn_amount, spawner.use_post_spawn ? CALLBACK(spawner, TYPE_PROC_REF(/obj/effect/ai_node/spawner, post_spawn)) : null)

/**
 * Registers an atom with the subsystem
 * Arguments:
 * * spawner: atom to be registered
 * * spawn_delay: time in byond ticks between respawns dont make this lower than SS wait or perish
 * * spawn_types: can be both a list as well as a specific type for the spawner to spawn
 * * max_amount: the maximum amount of mobs this spawner can spawn
 * * spawn_amount: the amount of mobs which we spawn for one respawn tick
 * * post_spawn: Callback to be invoked on the spawned squad, use for equipping and such
 */
/datum/controller/subsystem/spawning/proc/registerspawner(atom/spawner, spawn_delay = 30 SECONDS, spawn_types, max_amount = 10, spawn_amount = 1, datum/callback/post_spawn, list/mob_decrement_signals)
	spawnerdata[spawner] = new /datum/spawnerdata(spawn_delay/wait, spawn_types, max_amount, spawn_amount, post_spawn, mob_decrement_signals)
	RegisterSignal(spawner, COMSIG_QDELETING, PROC_REF(unregisterspawner))

/**
 * Unregisters an atom with the subsystem
 * Arguments:
 * * spawner: atom to be unregistered
 */
/datum/controller/subsystem/spawning/proc/unregisterspawner(atom/spawner)
	SIGNAL_HANDLER
	death_callbacks_by_mob -= spawnerdata[spawner].spawned_mobs
	spawnerdata -= spawner
	UnregisterSignal(spawner, COMSIG_QDELETING)

///Essentially a wrapper for accessing a dying/delting mobs callback to remove it
/datum/controller/subsystem/spawning/proc/remove_mob(mob/source)
	SIGNAL_HANDLER
	if(source in death_callbacks_by_mob) //due to signals being async we might've been removed from the list already in unregisterspawner()
		death_callbacks_by_mob[source].Invoke()

/**
 * Removes a mob from a spawners mobs spawned list
 * Arguments:
 * * remover: The mob that died/whatever to decrement the amount
 * * spawner: atom that spawned the mob that died
 */
/datum/controller/subsystem/spawning/proc/decrement_spawned_mobs(mob/remover, atom/spawner)
	spawnerdata[spawner].spawned_mobs -= remover
	death_callbacks_by_mob -= remover
	total_spawned--
	UnregisterSignal(remover, spawnerdata[spawner].mob_decrement_signals)

/datum/controller/subsystem/spawning/fire(resumed)
	if(total_spawned >= mob_cap)
		return

	for(var/spawner in spawnerdata)
		if(++spawnerdata[spawner].fire_increment <= spawnerdata[spawner].required_increment)
			continue
		spawnerdata[spawner].fire_increment = 0
		var/turf/spawnpoint = get_turf(spawner)
		var/list/new_mob_list = list()
		for(var/b = 1 to spawnerdata[spawner].spawn_amount)
			if(length(spawnerdata[spawner].spawned_mobs) >= spawnerdata[spawner].max_allowed_mobs)
				break
			var/spawntype = pickweight(spawnerdata[spawner].spawn_types)
			var/mob/new_mob = new spawntype(spawnpoint)

			var/datum/callback/on_death_cb = CALLBACK(src, PROC_REF(decrement_spawned_mobs), new_mob, spawner)
			death_callbacks_by_mob[new_mob] = on_death_cb
			RegisterSignals(new_mob, spawnerdata[spawner].mob_decrement_signals, PROC_REF(remove_mob))
			spawnerdata[spawner].spawned_mobs += new_mob
			new_mob_list += new_mob
			total_spawned++
		spawnerdata[spawner].post_spawn_cb?.Invoke(new_mob_list)
		if(TICK_CHECK)
			return

/// Holder datum for various data relating to individual spawners
/datum/spawnerdata
	///Fire incrementor
	var/fire_increment = 0
	///Required fire increment
	var/required_increment
	///Spawn types
	var/spawn_types
	///Spawn amount
	var/spawn_amount
	///Max allowed mobs
	var/max_allowed_mobs
	///Spawned mobs
	var/list/spawned_mobs = list()
	///Post spawn callback
	var/datum/callback/post_spawn_cb
	///List of signals on which we remove mob from spawned_mobs
	var/list/mob_decrement_signals = list()

/datum/spawnerdata/New(required_increment, spawn_types, max_allowed_mobs, spawn_amount, datum/callback/post_spawn_cb, list/mob_decrement_signals)
	src.required_increment = required_increment
	src.spawn_types = spawn_types
	src.max_allowed_mobs = max_allowed_mobs
	src.spawn_amount = spawn_amount
	src.post_spawn_cb = post_spawn_cb
	src.mob_decrement_signals = mob_decrement_signals

#undef MAXIMUM_DEFAULT_SPAWN
