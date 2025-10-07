/datum/game_mode/infestation/distress/extermination
	name = "Extermination"
	config_tag = "Extermination"

	silo_scaling = 0 //ha ha
	max_silo_ammount = 1

	round_type_flags = MODE_INFESTATION|MODE_LATE_OPENING_SHUTTER_TIMER|MODE_XENO_RULER|MODE_PSY_POINTS|MODE_PSY_POINTS_ADVANCED|MODE_DEAD_GRAB_FORBIDDEN|MODE_HIJACK_POSSIBLE|MODE_SILO_RESPAWN|MODE_SILOS_SPAWN_MINIONS|MODE_ALLOW_XENO_QUICKBUILD|MODE_SILO_NO_LARVA|MODE_HAS_EXCAVATION|MODE_HAS_MINERS

	///How long between two larva check, 2 minutes for crush
	var/larva_check_interval = 4 MINUTES
	///Last time larva balance was checked
	var/last_larva_check
	///Multiplier for xenos, increases over time
	var/xeno_factor = 1
	///How much xeno_factor you get for progress on discs
	var/xeno_factor_per_progress_on_disk = 0.1

/datum/game_mode/infestation/distress/extermination/post_setup()
	. = ..()
	for(var/i in GLOB.nuke_spawn_locs)
		new /obj/machinery/nuclearbomb(i)
	generate_nuke_disk_spawners()
	RegisterSignal(SSdcs, COMSIG_GLOB_DISK_PROGRESS, PROC_REF(increase_xeno_factor))
	RegisterSignal(SSdcs, COMSIG_GLOB_NUKE_EXPLODED, PROC_REF(on_nuclear_explosion))
	RegisterSignal(SSdcs, COMSIG_GLOB_NUKE_DIFFUSED, PROC_REF(on_nuclear_diffuse))
	RegisterSignal(SSdcs, COMSIG_GLOB_NUKE_START, PROC_REF(on_nuke_started))

///Receive notifications about disks generation progress
/datum/game_mode/infestation/distress/extermination/proc/increase_xeno_factor(datum/source, obj/machinery/computer/nuke_disk_generator/generatingcomputer)
	SIGNAL_HANDLER
	xeno_factor += xeno_factor_per_progress_on_disk
	SSpoints.supply_points[FACTION_TERRAGOV] += 1000

/datum/game_mode/infestation/distress/extermination/check_finished()
	if(round_finished)
		return TRUE

	if(world.time < (SSticker.round_start_time + 5 SECONDS))
		return FALSE

	var/list/living_player_list = count_humans_and_xenos(count_flags = COUNT_IGNORE_ALIVE_SSD|COUNT_IGNORE_XENO_SPECIAL_AREA)
	var/num_humans = living_player_list[1]
	var/num_xenos = living_player_list[2]
	var/num_humans_ship = living_player_list[3]

	if(SSevacuation.dest_status == NUKE_EXPLOSION_FINISHED)
		message_admins("Round finished: [MODE_GENERIC_DRAW_NUKE]") //ship blows, no one wins
		round_finished = MODE_GENERIC_DRAW_NUKE
		return TRUE

	if(round_stage == INFESTATION_DROPSHIP_CAPTURED_XENOS)
		message_admins("Round finished: [MODE_INFESTATION_X_MINOR]")
		round_finished = MODE_INFESTATION_X_MINOR
		return TRUE

	if(planet_nuked == INFESTATION_NUKE_COMPLETED)
		message_admins("Round finished: [MODE_INFESTATION_M_MAJOR]") //marines managed to nuke the colony
		round_finished = MODE_INFESTATION_M_MAJOR
		return TRUE

	if(!num_humans)
		if(!num_xenos)
			message_admins("Round finished: [MODE_INFESTATION_DRAW_DEATH]") //everyone died at the same time, no one wins
			round_finished = MODE_INFESTATION_DRAW_DEATH
			return TRUE
		message_admins("Round finished: [MODE_INFESTATION_X_MAJOR]") //xenos wiped out ALL the marines without hijacking, xeno major victory
		round_finished = MODE_INFESTATION_X_MAJOR
		return TRUE
	if(!num_xenos)
		if(round_stage == INFESTATION_MARINE_CRASHING)
			message_admins("Round finished: [MODE_INFESTATION_M_MINOR]") //marines lost the ground operation but managed to wipe out Xenos on the ship at a greater cost, minor victory
			round_finished = MODE_INFESTATION_M_MINOR
			return TRUE
		message_admins("Round finished: [MODE_INFESTATION_M_MAJOR]") //marines win big
		round_finished = MODE_INFESTATION_M_MAJOR
		return TRUE
	if(round_stage == INFESTATION_MARINE_CRASHING && !num_humans_ship)
		if(SSevacuation.human_escaped > SSevacuation.initial_human_on_ship * 0.5)
			message_admins("Round finished: [MODE_INFESTATION_X_MINOR]") //xenos have control of the ship, but most marines managed to flee
			round_finished = MODE_INFESTATION_X_MINOR
			return
		message_admins("Round finished: [MODE_INFESTATION_X_MAJOR]") //xenos wiped our marines, xeno major victory
		round_finished = MODE_INFESTATION_X_MAJOR
		return TRUE
	return FALSE

/datum/game_mode/infestation/distress/extermination/process()
	. = ..()

	if(world.time > last_larva_check + larva_check_interval)
		balance_scales()
		last_larva_check = world.time

/datum/game_mode/infestation/distress/extermination/proc/balance_scales()
	var/datum/hive_status/normal/xeno_hive = GLOB.hive_datums[XENO_HIVE_NORMAL]
	var/datum/job/xeno_job = SSjob.GetJobType(/datum/job/xenomorph)
	var/active_xenos = xeno_job.total_positions - xeno_job.current_positions //burrowed
	for(var/mob/living/carbon/xenomorph/xeno AS in GLOB.alive_xeno_list_hive[XENO_HIVE_NORMAL])
		if(xeno.xeno_caste.caste_flags & CASTE_IS_A_MINION)
			continue
		active_xenos++
	var/estimated_joblarvaworth = get_total_joblarvaworth() * xeno_factor
	var/larva_surplus = (estimated_joblarvaworth - (active_xenos * xeno_job.job_points_needed )) / xeno_job.job_points_needed
	var/real_larva_surplus
	if(!active_xenos)
		real_larva_surplus = max(1, round(larva_surplus, 1))
		xeno_job.add_job_positions(real_larva_surplus)
		GLOB.round_statistics.larva_from_silo += real_larva_surplus
		xeno_hive.update_tier_limits()
		return
	if(larva_surplus < 1)
		return //Things are balanced, no burrowed needed
	real_larva_surplus = round(larva_surplus, 1)
	xeno_job.add_job_positions(real_larva_surplus)
	GLOB.round_statistics.larva_from_silo += real_larva_surplus
	xeno_hive.update_tier_limits()
