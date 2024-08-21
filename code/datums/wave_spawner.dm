/datum/wave_spawner
	var/min_time = 0
	var/max_time = -1

/datum/wave_spawner/proc/spawn_wave(points)
	if(points <= 0)
		return FALSE
	return TRUE

/datum/wave_spawner/minions

/datum/wave_spawner/minions/spawn_wave(points)
	. = ..()
	if(!.)
		return

	for(var/i in 1 to points * 2)
		var/spawntype = pick(GLOB.xeno_ai_spawnable)
		new spawntype(GLOB.waves_spawner_loc)

	return TRUE

/datum/wave_spawner/t1
	min_time = 10 MINUTES

/datum/wave_spawner/t1/spawn_wave(points)
	. = ..()
	if(!.)
		return

	for(var/i in 1 to points)
		var/spawntype = pick(GLOB.xeno_t1_ai_spawnable)
		new spawntype(GLOB.waves_spawner_loc)

	return TRUE

/datum/wave_spawner/t2
	min_time = 15 MINUTES

/datum/wave_spawner/t2/spawn_wave(points)
	. = ..()
	if(!.)
		return

	for(var/i in 1 to points * 0.7)
		var/spawntype = pick(GLOB.xeno_t2_ai_spawnable)
		new spawntype(GLOB.waves_spawner_loc)

	return TRUE

/datum/wave_spawner/t3
	min_time = 20 MINUTES

/datum/wave_spawner/t3/spawn_wave(points)
	. = ..()
	if(!.)
		return

	for(var/i in 1 to points * 0.4)
		var/spawntype = pick(GLOB.xeno_t3_ai_spawnable)
		new spawntype(GLOB.waves_spawner_loc)

	return TRUE

/datum/wave_spawner/random
	min_time = 20 MINUTES

/datum/wave_spawner/random/spawn_wave(points)
	. = ..()
	if(!.)
		return

	for(var/i in 1 to points * 0.8)
		var/list/xenos = GLOB.xeno_ai_spawnable + GLOB.xeno_t1_ai_spawnable + GLOB.xeno_t2_ai_spawnable + GLOB.xeno_t3_ai_spawnable
		var/spawntype = pick(xenos)
		new spawntype(GLOB.waves_spawner_loc)

	return TRUE

/datum/wave_spawner/queen
	//min_time = 25 MINUTES

/datum/wave_spawner/queen/spawn_wave(points)
	. = ..()
	if(!.)
		return

	for(var/i in 1 to points * 0.4)
		new /mob/living/carbon/xenomorph/queen/ai(GLOB.waves_spawner_loc)

	return TRUE
