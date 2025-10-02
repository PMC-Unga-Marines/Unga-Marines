#define XENO_DEN_LEVEL_PATH "_maps/map_files/Xeno_den/Xeno_den.dmm"

/datum/game_mode/infestation/distress/points_defence
	name = "Points Defence"
	config_tag = "Points Defence"
	silo_scaling = 0 //do you really need a silo?
	max_silo_ammount = 1

	///The amount of sensor towers in sensor defence

	///Amount of activated sensors, activated sensors captured by marines
	var/sensors_activated = 0

	///Amount of activated sensors from which marines receive a multiplier to the points
	var/boost_condition_sensors_amount

	///Total amount of ground side sensors
	var/phorone_sensors_amount
	///Total amount of cave sensors
	var/platinum_sensors_amount

	//points generation
	var/points_check_interval = 1 MINUTES
	///Last time points balance was checked
	var/last_points_check

	//Victory point
	var/marine_victory_point = 0

	///Xeno points multiplier
	var/marine_victory_points_factor = 1

	///Amount of points to be scored
	var/points_to_win = 5000

	///Groud side xeno factor
	var/firts_stage_xeno_factor = 0.8
	///Den rush xeno factor
	var/second_stage_xeno_factor = 1.2

	var/can_hunt = FALSE

	round_type_flags = MODE_INFESTATION|MODE_LATE_OPENING_SHUTTER_TIMER|MODE_XENO_RULER|MODE_PSY_POINTS|MODE_PSY_POINTS_ADVANCED|MODE_DEAD_GRAB_FORBIDDEN|MODE_HIJACK_POSSIBLE|MODE_SILO_RESPAWN|MODE_SILOS_SPAWN_MINIONS|MODE_ALLOW_XENO_QUICKBUILD|MODE_XENO_DEN|MODE_HAS_EXCAVATION

/datum/game_mode/infestation/distress/points_defence/post_setup()
	. = ..()

	//xenoden setup may lag and long loading time
	load_new_z_level(XENO_DEN_LEVEL_PATH, "Xenoden", TRUE, list(ZTRAIT_GROUND = TRUE, ZTRAIT_XENO = TRUE))

	//number of sensors
	//the number of sensors is greater than necessary to win, so that the late game does not turn into a 1 point defense
	switch(TGS_CLIENT_COUNT)
		if(1 to 15) //i dunno who will play it
			boost_condition_sensors_amount = 2
			phorone_sensors_amount = 1
			platinum_sensors_amount = 1
		if(16 to 30)
			boost_condition_sensors_amount = 2
			phorone_sensors_amount = 1
			platinum_sensors_amount = 2
		if(31 to 40)
			boost_condition_sensors_amount = 3
			phorone_sensors_amount = 2
			platinum_sensors_amount = 2
		if(41 to 50)
			boost_condition_sensors_amount = 3
			phorone_sensors_amount = 1
			platinum_sensors_amount = 3
		if(51 to 75)
			boost_condition_sensors_amount = 4
			phorone_sensors_amount = 2
			platinum_sensors_amount = 3
		if(76 to 100)
			boost_condition_sensors_amount = 4
			phorone_sensors_amount = 1
			platinum_sensors_amount = 4
		else //madness
			boost_condition_sensors_amount = 5
			phorone_sensors_amount = 3
			platinum_sensors_amount = 3

	for(var/i in 1 to phorone_sensors_amount)
		var/turf/T = pick(GLOB.sensor_towers_infestation_ground)
		new /obj/structure/sensor_tower_infestation(T)
		GLOB.sensor_towers_infestation_ground -= T

	for(var/i in 1 to platinum_sensors_amount)
		var/turf/T = pick(GLOB.sensor_towers_infestation_caves)
		new /obj/structure/sensor_tower_infestation(T)
		GLOB.sensor_towers_infestation_caves -= T

	if(length(GLOB.tower_relay_locs))
		new /obj/machinery/telecomms/relay/preset/tower(pick(GLOB.tower_relay_locs))

	//xenoden landing zone
	var/turf/marine_dropship_loc = pick(GLOB.xenoden_docking_ports_locs)
	new /obj/docking_port/stationary/marine_dropship/lz_den(marine_dropship_loc)

	//core
	var/turf/T = pick(GLOB.xenoden_cores_locs)
	new /obj/structure/xeno/core(T)
	GLOB.xenoden_cores_locs -= T

	#ifdef TESTING
	marine_victory_point = points_to_win
	#endif

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
	var/estimated_joblarvaworth = get_total_joblarvaworth() * (round_stage != INFESTATION_MARINE_DEN_RUSH ? firts_stage_xeno_factor : second_stage_xeno_factor)
	var/larva_surplus = (estimated_joblarvaworth - (active_xenos * xeno_job.job_points_needed )) / xeno_job.job_points_needed
	var/real_larva_surplus
	if(!active_xenos)
		real_larva_surplus = max(1, round(larva_surplus, 1))
		xeno_job.add_job_positions(real_larva_surplus)
		GLOB.round_statistics.larva_from_xeno_core += real_larva_surplus
		xeno_hive.update_tier_limits()
		return
	if(larva_surplus < 1)
		return //Things are balanced, no burrowed needed
	real_larva_surplus = round(larva_surplus, 1)
	xeno_job.add_job_positions(real_larva_surplus)
	GLOB.round_statistics.larva_from_xeno_core += real_larva_surplus
	xeno_hive.update_tier_limits()

/datum/game_mode/infestation/distress/points_defence/proc/add_victory_points()
	//prohibit generation before the shutters open
	if(!SSsilo.can_fire)
		return

	//Victory point
	marine_victory_point += sensors_activated * (points_check_interval * 0.1) * marine_victory_points_factor / (phorone_sensors_amount + platinum_sensors_amount)
	if((marine_victory_point >= points_to_win || sensors_activated >= boost_condition_sensors_amount) && !can_hunt)//xeno is fucked up, so skip ground and go to xenorush
		can_hunt = TRUE
		for(var/mob/living/carbon/human/human AS in GLOB.alive_human_list)
			if(human.faction == FACTION_TERRAGOV)
				human.playsound_local(human, 'sound/effects/CIC_order.ogg', 10, 1)
				human.play_screen_text("<span class='maptext' style=font-size:24pt;text-align:left valign='top'><u>OVERWATCH</u></span><br>" + "New Destination has been added to the Normandy, take off and destroy them to the end. Extra points awarded in cargo", /atom/movable/screen/text/screen_text/picture/potrait)
				SSpoints.supply_points[FACTION_TERRAGOV] += 150

/datum/game_mode/infestation/distress/points_defence/siloless_hive_collapse()
	return

/datum/game_mode/infestation/distress/points_defence/get_siloless_collapse_countdown()
	return

/datum/game_mode/infestation/distress/points_defence/update_silo_death_timer(datum/hive_status/silo_owner)
	return

///Add gamemode related items to statpanel
/datum/game_mode/infestation/distress/points_defence/get_status_tab_items(datum/dcs, mob/source, list/items)
	. = ..()
	if(isobserver(source) || !isxeno(source))
		items +="Marine victory points: [marine_victory_point]"

/datum/game_mode/infestation/distress/points_defence/start_hunt()
	//marine announce
	for(var/mob/living/carbon/human/human AS in GLOB.alive_human_list)
		if(human.faction == FACTION_TERRAGOV)
			human.playsound_local(human, 'sound/effects/CIC_order.ogg', 10, 1)
			human.play_screen_text("<span class='maptext' style=font-size:24pt;text-align:left valign='top'><u>OVERWATCH</u></span><br>" + "Xeno den has been added to the Normandy destonation, destroy them to the end", /atom/movable/screen/text/screen_text/picture/potrait)
	round_stage = INFESTATION_MARINE_DEN_RUSH

/datum/game_mode/infestation/distress/points_defence/can_hunt()
	return can_hunt && round_stage != INFESTATION_MARINE_DEN_RUSH

#undef XENO_DEN_LEVEL_PATH
