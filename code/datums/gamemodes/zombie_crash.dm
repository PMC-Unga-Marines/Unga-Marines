/datum/game_mode/infestation/crash/zombie
	name = "Zombie Crash"
	config_tag = "Zombie Crash"
	required_players = 1
	valid_job_types = list(
		/datum/job/terragov/squad/standard = -1,
		/datum/job/terragov/squad/robot = -1,
		/datum/job/terragov/squad/engineer = 1,
		/datum/job/terragov/squad/corpsman = 1,
		/datum/job/terragov/squad/smartgunner = 1,
		/datum/job/terragov/squad/leader = 1,
		/datum/job/terragov/medical/professor = 1,
		/datum/job/terragov/medical/medicalofficer = 1,
		/datum/job/terragov/silicon/synthetic = 1,
		/datum/job/terragov/command/fieldcommander = 1,
	)
	job_points_needed_by_job_type = list(
		/datum/job/terragov/squad/smartgunner = 20,
		/datum/job/terragov/squad/corpsman = 5,
		/datum/job/terragov/squad/engineer = 5,
	)
	blacklist_ground_maps = list(MAP_WHISKEY_OUTPOST, MAP_OSCAR_OUTPOST, MAP_LAST_STAND)

	round_type_flags = NONE

/datum/game_mode/infestation/crash/zombie/post_setup()
	. = ..()
	for(var/obj/effect/landmark/corpsespawner/corpse AS in GLOB.corpse_landmarks_list)
		corpse.create_zombie()

	for(var/i in GLOB.xeno_resin_silo_turfs)
		new /obj/effect/ai_node/spawner/zombie(i)

/datum/game_mode/infestation/crash/zombie/on_nuke_started(datum/source, obj/machinery/nuclearbomb/nuke)
	return

/datum/game_mode/infestation/crash/zombie/balance_scales()
	return

/datum/game_mode/infestation/crash/zombie/get_adjusted_jobworth_list(list/jobworth_list)
	return jobworth_list

/datum/game_mode/infestation/crash/zombie/check_finished(force_end)
	if(round_finished)
		return TRUE

	if(!shuttle_landed && !force_end)
		return FALSE

	var/list/living_player_list = count_humans_and_xenos(count_flags = COUNT_IGNORE_HUMAN_SSD)
	var/num_humans = living_player_list[1]

	if(num_humans && planet_nuked == INFESTATION_NUKE_NONE && marines_evac == CRASH_EVAC_NONE && !force_end)
		return FALSE

	switch(planet_nuked)

		if(INFESTATION_NUKE_NONE)
			if(!num_humans)
				message_admins("Round finished: [MODE_ZOMBIE_MAJOR]") //xenos wiped out ALL the marines
				round_finished = MODE_ZOMBIE_MAJOR
				return TRUE
			if(marines_evac == CRASH_EVAC_COMPLETED || (!length(GLOB.active_nuke_list) && marines_evac != CRASH_EVAC_NONE))
				message_admins("Round finished: [MODE_ZOMBIE_MINOR]") //marines evaced without a nuke
				round_finished = MODE_ZOMBIE_MINOR
				return TRUE

		if(INFESTATION_NUKE_COMPLETED)
			if(marines_evac == CRASH_EVAC_NONE)
				message_admins("Round finished: [MODE_ZOMBIE_MINOR]") //marines nuked the planet but didn't evac
				round_finished = MODE_ZOMBIE_MINOR
				return TRUE
			message_admins("Round finished: [MODE_INFESTATION_M_MAJOR]") //marines nuked the planet and managed to evac
			round_finished = MODE_INFESTATION_M_MAJOR
			return TRUE

		if(INFESTATION_NUKE_COMPLETED_SHIPSIDE, INFESTATION_NUKE_COMPLETED_OTHER)
			message_admins("Round finished: [MODE_ZOMBIE_MAJOR]") //marines nuked themselves somehow
			round_finished = MODE_ZOMBIE_MAJOR
			return TRUE
	return FALSE
