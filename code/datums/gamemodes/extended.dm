/datum/game_mode/extended
	name = "Extended"
	config_tag = "Extended"
	flags_xeno_abilities = ABILITY_NUCLEARWAR
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
		/datum/job/terragov/civilian/clown = -1,
		/datum/job/terragov/silicon/synthetic = 1,
		/datum/job/terragov/silicon/ai = 1,
		/datum/job/terragov/squad/engineer = 8,
		/datum/job/terragov/squad/corpsman = 8,
		/datum/job/terragov/squad/smartgunner = 4,
		/datum/job/terragov/squad/leader = 4,
		/datum/job/terragov/squad/standard = -1,
		/datum/job/terragov/squad/robot = -1,
	)
	enable_fun_tads = TRUE
	xenorespawn_time = 1 MINUTES

/datum/game_mode/extended/announce()
	to_chat(world, "<b>Текущий игровой режим - Продолжительный Ролевой Отыгрыш</b>")
	to_chat(world, "<b>Просто веселитесь и отыгрывайте свою роль!</b>")

/datum/game_mode/extended/check_finished()
	if(!round_finished)
		return FALSE
	return TRUE

/datum/game_mode/extended/declare_completion()
	. = ..()
	to_chat(world, span_round_header("|[round_finished]|"))
	var/sound/S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)
	SEND_SOUND(world, S)

	log_game("[round_finished]\nИгровой режим: [name]\nВремя раунда: [duration2text()]\nКоличество людей к концу: [length(GLOB.clients)]\nИтого ксеноморфов заспавнилось: [GLOB.round_statistics.total_xenos_created]\nИтого людей заспавнилось: [GLOB.round_statistics.total_humans_created]")
