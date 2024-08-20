/datum/game_mode/last_stand
	name = "Last Stand"
	config_tag = "Last Stand"
	flags_xeno_abilities = ABILITY_CRASH
	valid_job_types = list(
		/datum/job/terragov/command/captain = 1,
		/datum/job/terragov/command/fieldcommander = 1,
		/datum/job/terragov/command/staffofficer = 4,
		/datum/job/terragov/command/pilot = 1,
		/datum/job/terragov/command/transportofficer = 1,
		/datum/job/terragov/command/mech_pilot = 0,
		/datum/job/terragov/command/assault_crewman = 2,
		/datum/job/terragov/command/transport_crewman = 1,
		/datum/job/terragov/requisitions/tech = 1,
		/datum/job/terragov/requisitions/officer = 1,
		/datum/job/terragov/medical/professor = 1,
		/datum/job/terragov/medical/medicalofficer = 6,
		/datum/job/terragov/medical/researcher = 2,
		/datum/job/terragov/civilian/liaison = 1,
		/datum/job/terragov/silicon/synthetic = 1,
		/datum/job/terragov/silicon/ai = 1,
		/datum/job/terragov/squad/engineer = 8,
		/datum/job/terragov/squad/corpsman = 8,
		/datum/job/terragov/squad/smartgunner = 4,
		/datum/job/terragov/squad/leader = 4,
		/datum/job/terragov/squad/standard = -1,
		/datum/job/terragov/squad/combat_robot = -1,
	)
	xenorespawn_time = 1 MINUTES

/datum/game_mode/extended/announce()
	to_chat(world, "<b>The current game mode is - Last Stand!</b>")

/datum/game_mode/last_stand/pre_setup()
	. = ..()

	for(var/job_type in GLOB.spawns_by_job)
		for(var/atom/loc in GLOB.spawns_by_job[job_type])
			if(is_ground_level(loc.z))
				continue
			GLOB.spawns_by_job[job_type] -= loc

	for(var/latejoin in GLOB.latejoin)
		var/atom/loc = latejoin
		if(is_ground_level(loc.z))
			continue
		GLOB.latejoin -= loc

	for(var/latejoin_cryo in GLOB.latejoin_cryo)
		var/atom/loc = latejoin_cryo
		if(is_ground_level(loc.z))
			continue
		GLOB.latejoin_cryo -= loc

	for(var/latejoin_gateway in GLOB.latejoin_gateway)
		var/atom/loc = latejoin_gateway
		if(is_ground_level(loc.z))
			continue
		GLOB.latejoin_gateway -= loc

/datum/game_mode/extended/check_finished()
	if(!round_finished)
		return FALSE
	return TRUE

/datum/game_mode/extended/declare_completion()
	. = ..()
	to_chat(world, span_round_header("|[round_finished]|"))
	var/sound/S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)
	SEND_SOUND(world, S)

	log_game("[round_finished]\nGame mode: [name]\nRound time: [duration2text()]\nEnd round player population: [length(GLOB.clients)]\nTotal xenos spawned: [GLOB.round_statistics.total_xenos_created]\nTotal humans spawned: [GLOB.round_statistics.total_humans_created]")
