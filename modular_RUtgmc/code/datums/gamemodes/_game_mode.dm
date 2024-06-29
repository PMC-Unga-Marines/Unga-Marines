/datum/game_mode
	var/list/predators = list()

	var/pred_current_num = 0 //How many are there now?
	var/pred_per_players = 20 //Preds per player
	var/pred_start_count = 0 //The initial count of predators

	var/pred_additional_max = 0
	var/pred_leader_count = 0 //How many Leader preds are active
	var/pred_leader_max = 1 //How many Leader preds are permitted. Currently fixed to 1. May add admin verb to adjust this later.
	var/quickbuild_points_flags = NONE

	blacklist_ground_maps = list(MAP_DELTA_STATION, MAP_WHISKEY_OUTPOST, MAP_OSCAR_OUTPOST, MAP_FORT_PHOBOS)

/datum/game_mode/post_setup()
	if(flags_round_type & MODE_SILO_RESPAWN)
		var/datum/hive_status/normal/HN = GLOB.hive_datums[XENO_HIVE_NORMAL]
		HN.RegisterSignals(SSdcs, list(COMSIG_GLOB_OPEN_TIMED_SHUTTERS_LATE, COMSIG_GLOB_OPEN_SHUTTERS_EARLY), TYPE_PROC_REF(/datum/hive_status/normal, set_siloless_collapse_timer))
	return ..()

/// called to check for updates that might require starting/stopping the siloless collapse timer
/datum/game_mode/proc/update_silo_death_timer(datum/hive_status/silo_owner)
	return

///starts the timer to end the round when no silo is left
/datum/game_mode/proc/get_siloless_collapse_countdown()
	return

///Add gamemode related items to statpanel
/datum/game_mode/get_status_tab_items(datum/dcs, mob/source, list/items)
	. = ..()
	if(isobserver(source))
		var/siloless_countdown = SSticker.mode.get_siloless_collapse_countdown()
		if(siloless_countdown)
			items +="Silo less hive collapse timer: [siloless_countdown]"
	else if(isxeno(source))
		var/mob/living/carbon/xenomorph/xeno_source = source
		if(xeno_source.hivenumber == XENO_HIVE_NORMAL)
			var/siloless_countdown = SSticker.mode.get_siloless_collapse_countdown()
			if(siloless_countdown)
				items +="Silo less hive collapse timer: [siloless_countdown]"

/datum/game_mode/proc/predator_round()
	switch(CONFIG_GET(number/pred_round))
		if(0)
			return
		if(1)
			if(!prob(CONFIG_GET(number/pred_round_chance)))
				return

	var/datum/job/PJ = SSjob.GetJobType(/datum/job/predator)
	var/new_pred_max = min(max(round(length(GLOB.clients) * PREDATOR_TO_TOTAL_SPAWN_RATIO), 1), 4)
	PJ.total_positions = new_pred_max
	PJ.max_positions = new_pred_max
	flags_round_type |= MODE_PREDATOR

/datum/game_mode/proc/initialize_predator(mob/living/carbon/human/new_predator, client/player, ignore_pred_num = FALSE)
	predators[lowertext(player.ckey)] = list("Name" = new_predator.real_name, "Status" = "Alive")
	if(!ignore_pred_num)
		pred_current_num++

/datum/game_mode/proc/get_whitelisted_predators(readied = 1)
	// Assemble a list of active players who are whitelisted.
	var/players[] = new

	var/mob/new_player/new_pred
	for(var/mob/player in GLOB.player_list)
		if(!player.client) continue //No client. DCed.
		if(isyautja(player)) continue //Already a predator. Might be dead, who knows.
		if(readied) //Ready check for new players.
			new_pred = player
			if(!istype(new_pred)) continue //Have to be a new player here.
			if(!new_pred.ready) continue //Have to be ready.
		else
			if(!istype(player,/mob/dead)) continue //Otherwise we just want to grab the ghosts.

		if(GLOB.roles_whitelist[player.ckey] & WHITELIST_PREDATOR)  //Are they whitelisted?
			if(!player.client.prefs)
				player.client.prefs = new /datum/preferences(player.client) //Somehow they don't have one.

			if(player.client.prefs.job_preferences[JOB_PREDATOR] > 0) //Are their prefs turned on?
				if(!player.mind) //They have to have a key if they have a client.
					player.mind_initialize() //Will work on ghosts too, but won't add them to active minds.
				players += player.mind
	return players

#define calculate_pred_max (length(GLOB.player_list) / pred_per_players + pred_additional_max + pred_start_count)

/datum/game_mode/proc/check_predator_late_join(mob/pred_candidate, show_warning = TRUE)
	if(!pred_candidate?.client) // Nigga, how?!
		return

	var/datum/job/job = SSjob.GetJobType(/datum/job/predator)

	if(!job)
		if(show_warning)
			to_chat(pred_candidate, span_warning("Something went wrong!"))
		return

	if(show_warning && alert(pred_candidate, "Confirm joining the hunt. You will join as \a [lowertext(job.get_whitelist_status(GLOB.roles_whitelist, pred_candidate.client))] predator", "Confirm", "Yes", "No") != "Yes")
		return

	if(!(GLOB.roles_whitelist[pred_candidate.ckey] & WHITELIST_PREDATOR))
		if(show_warning)
			to_chat(pred_candidate, span_warning("You are not whitelisted! You may apply on the forums to be whitelisted as a predator."))
		return

	if(is_banned_from(ckey(pred_candidate.key), JOB_PREDATOR))
		if(show_warning)
			to_chat(pred_candidate, span_warning("You are banned."))
		return

	if(!(flags_round_type & MODE_PREDATOR))
		if(show_warning)
			to_chat(pred_candidate, span_warning("There is no Hunt this round! Maybe the next one."))
		return

	if(pred_candidate.ckey in predators)
		if(show_warning)
			to_chat(pred_candidate, span_warning("You already were a Yautja! Give someone else a chance."))
		return

	if(get_desired_status(pred_candidate.client.prefs.yautja_status, WHITELIST_COUNCIL) == WHITELIST_NORMAL)
		var/pred_max = calculate_pred_max
		if(pred_current_num >= pred_max)
			if(show_warning)
				to_chat(pred_candidate, span_warning("Only [pred_max] predators may spawn this round, but Councillors and Ancients do not count."))
			return

	return TRUE

#undef calculate_pred_max

/datum/game_mode/proc/join_predator(mob/pred_candidate)
	var/datum/job/job = SSjob.GetJobType(/datum/job/predator)
	var/datum/preferences/prefs = pred_candidate.client.prefs
	var/spawn_type = job.return_spawn_type(prefs)
	var/mob/living/carbon/human/new_predator = new spawn_type()
	new_predator.forceMove(job.return_spawn_turf(pred_candidate, pred_candidate.client))
	new_predator.ckey = pred_candidate.ckey
	new_predator.apply_assigned_role_to_spawn(job)
	job.after_spawn(new_predator)
	qdel(pred_candidate)
