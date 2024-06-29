
/datum/game_mode/infestation/crash/pre_setup()
	. = ..()
	//It's a crutch. It's wrong. But it works, and I'm too young to fix it.
	//Please somebody rework the squad spawn point code.
	//Also here we delete all squad spawn points, so marines spawn on the crash shuttle instead of the ship.
	GLOB.start_squad_landmarks_list = null

/datum/game_mode/infestation/crash
	valid_job_types = list(
		/datum/job/terragov/squad/standard = -1,
		/datum/job/terragov/squad/engineer = 1,
		/datum/job/terragov/squad/corpsman = 1,
		/datum/job/terragov/squad/smartgunner = 1,
		/datum/job/terragov/squad/leader = 1,
		/datum/job/terragov/medical/professor = 1,
		/datum/job/terragov/medical/medicalofficer = 1,
		/datum/job/terragov/silicon/synthetic = 1,
		/datum/job/terragov/command/fieldcommander = 1,
		/datum/job/xenomorph = FREE_XENO_AT_START
	)
