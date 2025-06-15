/datum/game_mode/infestation/crash/distro
	name = "Distro Crash"
	config_tag = "Distro Crash"
	shutters_drop_time = 10 MINUTES
	whitelist_ground_maps = list(MAP_BIG_RED)
	round_type_flags = MODE_INFESTATION|MODE_DISALLOW_RAILGUN|MODE_LATE_OPENING_SHUTTER_TIMER|MODE_PSY_POINTS|MODE_PSY_POINTS_ADVANCED|MODE_SILOS_SPAWN_MINIONS|MODE_ALLOW_XENO_QUICKBUILD|MODE_HAS_EXCAVATION
	respawn_time = 5 MINUTES
	xenorespawn_time = 10 SECONDS
	larva_check_interval = 15 SECONDS
	tier_three_penalty = 0
	restricted_castes = list()

	var/siloless_hive_timer

/datum/game_mode/infestation/crash/distro/post_setup()
	. = ..()
	predator_round()
	SSpoints.add_psy_points(XENO_HIVE_NORMAL, 2 * SILO_PRICE + 4 * XENO_TURRET_PRICE)

/datum/game_mode/infestation/crash/distro/scale_roles(initial_players_assigned)
	. = ..()
	if(!.)
		return
	var/datum/job/scaled_job = SSjob.GetJobType(/datum/job/xenomorph) //Xenos
	scaled_job.job_points_needed = NUCLEAR_WAR_LARVA_POINTS_NEEDED //actaully DISTRESS_LARVA_POINTS_NEEDED

	var/datum/hive_status/normal/HN = GLOB.hive_datums[XENO_HIVE_NORMAL]
	HN.RegisterSignals(SSdcs, list(COMSIG_GLOB_OPEN_TIMED_SHUTTERS_LATE, COMSIG_GLOB_OPEN_SHUTTERS_EARLY), TYPE_PROC_REF(/datum/hive_status/normal, set_siloless_collapse_timer))

/datum/game_mode/infestation/crash/distro/orphan_hivemind_collapse()
	if(round_finished)
		return
	if(round_stage == INFESTATION_MARINE_CRASHING)
		round_finished = MODE_INFESTATION_M_MINOR
		return
	round_finished = MODE_INFESTATION_M_MAJOR


/datum/game_mode/infestation/crash/distro/get_hivemind_collapse_countdown()
	var/eta = timeleft(orphan_hive_timer) MILLISECONDS
	return !isnull(eta) ? round(eta) : 0

/datum/game_mode/infestation/crash/distro/update_silo_death_timer(datum/hive_status/silo_owner)
	if(!(silo_owner.hive_flags & HIVE_CAN_COLLAPSE_FROM_SILO))
		return

	//handle potential stopping
	if(round_stage != INFESTATION_MARINE_DEPLOYMENT)
		if(siloless_hive_timer)
			deltimer(siloless_hive_timer)
			siloless_hive_timer = null
		return
	if(length(GLOB.xeno_resin_silos_by_hive[XENO_HIVE_NORMAL]))
		if(siloless_hive_timer)
			deltimer(siloless_hive_timer)
			siloless_hive_timer = null
		return

	//handle starting
	if(siloless_hive_timer)
		return

	silo_owner.xeno_message("We don't have any silos! The hive will collapse if nothing is done", "xenoannounce", 6, TRUE)
	siloless_hive_timer = addtimer(CALLBACK(src, PROC_REF(siloless_hive_collapse)), DISTRESS_SILO_COLLAPSE, TIMER_STOPPABLE)

///called by [/proc/update_silo_death_timer] after [DISTRESS_SILO_COLLAPSE] elapses to end the round
/datum/game_mode/infestation/crash/distro/proc/siloless_hive_collapse()
	if(!(round_type_flags & MODE_INFESTATION))
		return
	if(round_finished)
		return
	if(round_stage == INFESTATION_MARINE_CRASHING)
		return
	round_finished = MODE_INFESTATION_M_MAJOR


/datum/game_mode/infestation/crash/distro/get_siloless_collapse_countdown()
	var/eta = timeleft(siloless_hive_timer) MILLISECONDS
	return !isnull(eta) ? round(eta) : 0
