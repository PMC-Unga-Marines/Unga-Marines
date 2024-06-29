/datum/admins/proc/unforbid()
	set category = "Admin"
	set name = "Unforbid"

	if(!check_rights(R_ADMIN))
		return

	if(GLOB.hive_datums[XENO_HIVE_NORMAL])
		GLOB.hive_datums[XENO_HIVE_NORMAL].unforbid_all_castes(TRUE)
		log_game("[key_name(usr)] unforbid all castes in [GLOB.hive_datums[XENO_HIVE_NORMAL].name] hive")
		message_admins("[ADMIN_TPMONTY(usr)] unforbid all castes in [GLOB.hive_datums[XENO_HIVE_NORMAL].name] hive")
	else
		log_game("[key_name(usr)] failed to unforbid")
		message_admins("[ADMIN_TPMONTY(usr)] failed to unforbid")

/datum/admins/proc/military_policeman()
	set category = "Debug"
	set name = "Military Policeman"

	if(!check_rights(R_FUN))
		return

	var/mob/M = usr
	var/mob/living/carbon/human/H
	var/spatial = FALSE
	if(ishuman(M))
		H = M
		var/datum/job/J = H.job
		spatial = istype(J, /datum/job/terragov/command/military_police)

	if(spatial)
		log_admin("[key_name(M)] stopped being a debug military policeman.")
		message_admins("[ADMIN_TPMONTY(M)] stopped being a debug military policeman.")
		qdel(M)
	else
		H = new(get_turf(M))
		M.client.prefs.copy_to(H)
		M.mind.transfer_to(H, TRUE)
		var/datum/job/J = SSjob.GetJobType(/datum/job/terragov/command/military_police)
		H.apply_assigned_role_to_spawn(J)
		qdel(M)

		log_admin("[key_name(H)] became a debug military policeman.")
		message_admins("[ADMIN_TPMONTY(H)] became a debug military policeman.")

/client/proc/cmd_admin_create_predator_report()
	set name = "Report: Yautja AI"
	set category = "Admin"

	if(!check_rights(R_ADMIN))
		to_chat(src, "Only administrators may use this command.")
		return
	var/input = input(usr, "This is a message from the predator ship's AI. Check with online staff before you send this.", "What?", "") as message|null
	if(!input)
		return FALSE
	yautja_announcement(span_yautjaboldbig(input))
	message_admins("[key_name_admin(src)] has created a predator ship AI report")
	log_admin("[key_name_admin(src)] predator ship AI report: [input]")

/datum/admins/proc/force_predator_round()
	set category = "Server"
	set name = "Toggle Predator Round"
	set desc = "Force-toggle a predator round for the round type. Only works on maps that support Predator spawns."

	if(!check_rights(R_SERVER))
		return

	var/datum/game_mode/predator_round = SSticker.mode
	if(!predator_round)
		to_chat(usr, span_adminnotice("Wait until round start!"))
		return

	if(alert("Are you sure you want to force-toggle a predator round? Predators currently: [(predator_round.flags_round_type & MODE_PREDATOR) ? "Enabled" : "Disabled"]",, "Yes", "No") != "Yes")
		return

	if(!(predator_round.flags_round_type & MODE_PREDATOR))
		var/datum/job/PJ = SSjob.GetJobType(/datum/job/predator)
		var/new_pred_max = min(max(round(length(GLOB.clients) * PREDATOR_TO_TOTAL_SPAWN_RATIO), 1), 4)
		PJ.total_positions = new_pred_max
		PJ.max_positions = new_pred_max
		predator_round.flags_round_type |= MODE_PREDATOR
	else
		predator_round.flags_round_type &= ~MODE_PREDATOR

	log_admin("[key_name_admin(usr)] has [(predator_round.flags_round_type & MODE_PREDATOR) ? "allowed predators to spawn" : "prevented predators from spawning"].")
	message_admins("[ADMIN_TPMONTY(usr)] has [(predator_round.flags_round_type & MODE_PREDATOR) ? "allowed predators to spawn" : "prevented predators from spawning"].")
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_PREDATOR_ROUND_TOGGLED)
