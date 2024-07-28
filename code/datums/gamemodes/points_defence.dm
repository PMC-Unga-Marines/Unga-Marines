/datum/game_mode/infestation/distress/points_defence
	name = "Points Defence"
	config_tag = "Points Defence"
	silo_scaling = 0 //do you really need a silo?

	///The amount of sensor towers in sensor defence

	var/sensors_activated = 0

	var/victory_condition_sensors_amount
	var/phorone_sensors
	var/platinum_sensors

	//points generation
	var/points_check_interval = 1 MINUTES
	///Last time points balance was checked
	var/last_points_check
	///Ponderation rate of sensors output
	var/sensors_larva_points_scaling = 2.4

	//Victory point
	var/marine_victory_point = 5000
	var/xeno_victory_point = 5000

	var/points_to_win = 5000

	var/allow_hijack = FALSE
	var/can_hunt = FALSE

	flags_round_type = MODE_INFESTATION|MODE_LATE_OPENING_SHUTTER_TIMER|MODE_XENO_RULER|MODE_PSY_POINTS|MODE_PSY_POINTS_ADVANCED|MODE_DEAD_GRAB_FORBIDDEN|MODE_HIJACK_POSSIBLE|MODE_SILO_RESPAWN|MODE_SILOS_SPAWN_MINIONS|MODE_ALLOW_XENO_QUICKBUILD|MODE_TELETOWER|MODE_XENO_DEN

/datum/game_mode/infestation/distress/points_defence/post_setup()
	. = ..()

	//delete miners
	for(var/atom/A AS in GLOB.miners_phorone)
		qdel(A)
	for(var/atom/A AS in GLOB.miners_platinum)
		qdel(A)

	//number of sensors
	//the number of sensors is greater than necessary to win, so that the late game does not turn into a 1 point defense
	switch(TGS_CLIENT_COUNT)
		if(1 to 15) //i dunno who will play it
			victory_condition_sensors_amount = 2
			phorone_sensors = 1
			platinum_sensors = 1
		if(16 to 30)
			victory_condition_sensors_amount = 2
			phorone_sensors = 1
			platinum_sensors = 2
		if(31 to 40)
			victory_condition_sensors_amount = 3
			phorone_sensors = 2
			platinum_sensors = 2
		if(41 to 50)
			victory_condition_sensors_amount = 3
			phorone_sensors = 1
			platinum_sensors = 3
		if(51 to 75)
			victory_condition_sensors_amount = 4
			phorone_sensors = 2
			platinum_sensors = 3
		if(76 to 100)
			victory_condition_sensors_amount = 4
			phorone_sensors = 1
			platinum_sensors = 4
		else //madness
			victory_condition_sensors_amount = 5
			phorone_sensors = 3
			platinum_sensors = 3


	// TODOD поменять на стационарные точки
	//setip sensor towers
	for(var/i in 1 to phorone_sensors)
		var/turf/T = pick(GLOB.miner_phorone_locs)
		new /obj/structure/sensor_tower_infestation(T)
		GLOB.miner_phorone_locs -= T

	for(var/i in 1 to platinum_sensors)
		var/turf/T = pick(GLOB.miner_platinum_locs)
		new /obj/structure/sensor_tower_infestation(T)
		GLOB.miner_platinum_locs -= T

	//comms
	for(var/i in 1 to phorone_sensors)
		var/turf/T = pick(GLOB.miner_phorone_locs)
		new /obj/machinery/telecomms/relay/preset/tower(T)
		GLOB.miner_phorone_locs -= T

/datum/game_mode/infestation/distress/points_defence/check_finished()
	if(round_finished)
		return TRUE

	if(world.time < (SSticker.round_start_time + 5 SECONDS))
		return FALSE

	var/list/living_player_list = count_humans_and_xenos(count_flags = COUNT_IGNORE_ALIVE_SSD|COUNT_IGNORE_XENO_SPECIAL_AREA)
	var/num_humans = living_player_list[1]
	var/num_xenos = living_player_list[2]
	var/num_humans_ship = living_player_list[3]

	//TODO поменять условие победы на очки и чтобы была возможность пройти на 2 этап игры
	if(SSevacuation.dest_status == NUKE_EXPLOSION_FINISHED)
		message_admins("Round finished: [MODE_GENERIC_DRAW_NUKE]") //ship blows, no one wins
		round_finished = MODE_GENERIC_DRAW_NUKE
		return TRUE

	if(round_stage == INFESTATION_DROPSHIP_CAPTURED_XENOS)
		message_admins("Round finished: [MODE_INFESTATION_X_MINOR]")
		round_finished = MODE_INFESTATION_X_MINOR
		return TRUE

	if(round_stage == INFESTATION_MARINE_MINOR)
		message_admins("Round finished: [MODE_INFESTATION_M_MINOR]")
		round_finished = MODE_INFESTATION_M_MINOR
		return TRUE

	if(round_stage == INFESTATION_MARIN_RUSH_MAJOR)
		message_admins("Round finished: [MODE_INFESTATION_M_MAJOR]")
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

/datum/game_mode/infestation/distress/points_defence/process()
	. = ..()
	if(world.time > last_points_check + points_check_interval)
		add_larva_points()
		add_victory_points()
		last_points_check = world.time

/datum/game_mode/infestation/distress/points_defence/proc/add_larva_points()

	var/datum/hive_status/normal/xeno_hive = GLOB.hive_datums[XENO_HIVE_NORMAL]
	var/datum/job/xeno_job = SSjob.GetJobType(/datum/job/xenomorph)
	var/active_xenos = xeno_job.total_positions - xeno_job.current_positions //burrowed
	for(var/mob/living/carbon/xenomorph/xeno AS in GLOB.alive_xeno_list_hive[XENO_HIVE_NORMAL])
		if(xeno.xeno_caste.caste_flags & CASTE_IS_A_MINION)
			continue
		active_xenos++
	var/larva_surplus = (get_total_joblarvaworth() - (active_xenos * xeno_job.job_points_needed )) / xeno_job.job_points_needed
	if(!active_xenos)
		xeno_job.add_job_positions(max(1, round(larva_surplus, 1)))
		return
	if(larva_surplus < 1)
		return //Things are balanced, no burrowed needed
	xeno_job.add_job_positions(round(larva_surplus, 1))
	xeno_hive.update_tier_limits()

/datum/game_mode/infestation/distress/points_defence/proc/add_victory_points()
	//prohibit generation before the shutters open
	if(!SSsilo.can_fire)
		return

	//Victory point
	marine_victory_point += sensors_activated * (points_check_interval / 10)
	if(marine_victory_point >= points_to_win && !can_hunt)
		can_hunt = TRUE
		for(var/mob/living/carbon/human/human AS in GLOB.alive_human_list)
			if(human.faction == FACTION_TERRAGOV)
				human.playsound_local(human, "sound/effects/CIC_order.ogg", 10, 1)
				human.play_screen_text("<span class='maptext' style=font-size:24pt;text-align:left valign='top'><u>OVERWATCH</u></span><br>" + "New Destination has been added to the Normandy, take off and destroy them to the end", /atom/movable/screen/text/screen_text/picture/potrait)

	xeno_victory_point += ((phorone_sensors + platinum_sensors) - sensors_activated) * (points_check_interval / 10)
	if(xeno_victory_point >= points_to_win && !allow_hijack)
		allow_hijack = TRUE
		for(var/mob/living/carbon/xenomorph/xeno AS in GLOB.alive_xeno_list_hive[XENO_HIVE_NORMAL])
			xeno.playsound_local(xeno, "sound/voice/alien_hiss1.ogg", 10, 1)
			xeno.play_screen_text("<span class='maptext' style=font-size:24pt;text-align:left valign='top'><u>HIVEMIND</u></span><br>" + "We have enough strength. Hijack a bird freely", /atom/movable/screen/text/screen_text/picture/potrait/queen_mother)

/datum/game_mode/infestation/distress/points_defence/siloless_hive_collapse()
	return

/datum/game_mode/infestation/distress/points_defence/get_siloless_collapse_countdown()
	return

/datum/game_mode/infestation/distress/points_defence/update_silo_death_timer(datum/hive_status/silo_owner)
	return

///Add gamemode related items to statpanel
/datum/game_mode/infestation/distress/points_defence/get_status_tab_items(datum/dcs, mob/source, list/items)
	. = ..()
	if(isobserver(source))
		items +="Marine victory points: [marine_victory_point]"
		items +="Xeno victory points: [xeno_victory_point]"
	else
		if(isxeno(source))
			items +="Victory points: [xeno_victory_point]"
		else
			items +="Victory points: [marine_victory_point]"

			///Add gamemode related items to statpanel
/datum/game_mode/infestation/distress/points_defence/proc/start_hunt()
	//marine announce
	for(var/mob/living/carbon/human/human AS in GLOB.alive_human_list)
		if(human.faction == FACTION_TERRAGOV)
			human.playsound_local(human, "sound/effects/CIC_order.ogg", 10, 1)
			human.play_screen_text("<span class='maptext' style=font-size:24pt;text-align:left valign='top'><u>OVERWATCH</u></span><br>" + "New Destination has been added to the Normandy, take off and destroy them to the end", /atom/movable/screen/text/screen_text/picture/potrait)
	round_stage = INFESTATION_MARINE_DEN_RUSH

/datum/game_mode/infestation/distress/points_defence/proc/can_hunt()
	if(marine_victory_point >= points_to_win && round_stage != INFESTATION_MARINE_DEN_RUSH)
		return TRUE
	return FALSE

/datum/game_mode/infestation/distress/points_defence/proc/allow_hijack()
	return allow_hijack
