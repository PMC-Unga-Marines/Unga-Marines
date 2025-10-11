/datum/game_mode/infestation/distro_crush
	name = "Distro Crash"
	config_tag = "Distro Crash"
	silo_scaling = 2
	required_players = 2
	round_type_flags = MODE_INFESTATION|MODE_LATE_OPENING_SHUTTER_TIMER|MODE_PSY_POINTS|MODE_DEAD_GRAB_FORBIDDEN|MODE_SILO_RESPAWN|MODE_SILOS_SPAWN_MINIONS|MODE_ALLOW_XENO_QUICKBUILD|MODE_HAS_EXCAVATION
	xeno_abilities_flags = ABILITY_DISTRESS
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
		/datum/job/xenomorph = FREE_XENO_AT_START
	)

	// Round end conditions
	var/shuttle_landed = FALSE
	var/marines_evac = CRASH_EVAC_NONE

	// Shuttle details
	var/shuttle_id = SHUTTLE_CANTERBURY
	var/obj/docking_port/mobile/crashmode/shuttle
	var/LZ_dock = FALSE

	var/siloless_hive_timer

/datum/game_mode/infestation/distro_crush/pre_setup()
	. = ..()

	// Spawn the ship
	if(TGS_CLIENT_COUNT >= 25)
		shuttle_id = SHUTTLE_BIGBURY
	if(!SSmapping.shuttle_templates[shuttle_id])
		message_admins("Gamemode: couldn't find a valid shuttle template for [shuttle_id]")
		CRASH("Shuttle [shuttle_id] wasn't found and can't be loaded")

	var/datum/map_template/shuttle/ST = SSmapping.shuttle_templates[shuttle_id]
	shuttle = SSshuttle.load_template_to_transit(ST)

	// Redefine the relevant spawnpoints after spawning the ship.
	for(var/job_type in shuttle.spawns_by_job)
		GLOB.spawns_by_job[job_type] = shuttle.spawns_by_job[job_type]

	GLOB.start_squad_landmarks_list = null
	GLOB.latejoin_squad_landmarks_list = null

	GLOB.latejoin = shuttle.latejoins
	GLOB.latejoin_cryo = shuttle.latejoins
	GLOB.latejoin_gateway = shuttle.latejoins
	// Launch shuttle
	var/list/valid_docks = list()
	if(locate(/obj/docking_port/stationary/marine_dropship/lz1) in SSshuttle.stationary_docking_ports)
		valid_docks += locate(/obj/docking_port/stationary/marine_dropship/lz1) in SSshuttle.stationary_docking_ports
	if(locate(/obj/docking_port/stationary/marine_dropship/lz2) in SSshuttle.stationary_docking_ports)
		valid_docks += locate(/obj/docking_port/stationary/marine_dropship/lz2) in SSshuttle.stationary_docking_ports
	for(var/obj/docking_port/stationary/docking_port in valid_docks)
		//cuz we use lz landing zone
		docking_port.width = max(19, docking_port.width)
		docking_port.height = max(31, docking_port.height)
		docking_port.dwidth = max(9, docking_port.dwidth)
		docking_port.dheight = max(15, docking_port.dheight)

	if(!length(valid_docks))
		CRASH("No valid crash sides found!")
	var/obj/docking_port/stationary/actual_crash_site = pick(valid_docks)

	shuttle.crashing = TRUE
	SSshuttle.moveShuttleToDock(shuttle.shuttle_id, actual_crash_site, TRUE) // FALSE = instant arrival
	addtimer(CALLBACK(src, PROC_REF(crash_shuttle), actual_crash_site), 10 MINUTES)

	GLOB.start_squad_landmarks_list = null

	for(var/obj/machinery/telecomms/relay/preset/telecomms/relay AS in GLOB.ground_telecomms_relay)
		qdel(relay) // so there's no double intercomms, hacky, but i don't know a better way.

/datum/game_mode/infestation/distro_crush/post_setup()
	. = ..()
	SSpoints.add_psy_points(XENO_HIVE_NORMAL, 2 * SILO_PRICE + 4 * XENO_TURRET_PRICE)

	for(var/obj/effect/landmark/corpsespawner/corpse AS in GLOB.corpse_landmarks_list)
		corpse.create_mob()

	for(var/mob/living/carbon/xenomorph/xeno AS in GLOB.alive_xeno_list)
		if(isxenolarva(xeno)) // Larva
			xeno.evolution_stored = xeno.xeno_caste.evolution_threshold //Immediate roundstart evo for larva.

	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_OPEN_TIMED_SHUTTERS_CRASH)

/datum/game_mode/infestation/distro_crush/announce()
	to_chat(world, span_round_header("The current map is - [SSmapping.configs[GROUND_MAP].map_name]!"))
	priority_announce("Высадка запланирована через 10 минут. Приготовьтесь к посадке. Предварительное сканирование показывает наличие агрессивных форм биологической жизни", title = "Доброе утро, товарищи!", type = ANNOUNCEMENT_PRIORITY, sound = 'sound/AI/crash_start.ogg', color_override = "red")

/datum/game_mode/infestation/distro_crush/proc/crash_shuttle(obj/docking_port/stationary/target)
	shuttle_landed = TRUE
	shuttle.crashing = FALSE
	SSsilo.can_fire = TRUE
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_CANTERBURRY_LANDING)

/datum/game_mode/infestation/distro_crush/scale_roles(initial_players_assigned)
	. = ..()
	if(!.)
		return
	var/datum/job/scaled_job = SSjob.GetJobType(/datum/job/xenomorph) //Xenos
	scaled_job.job_points_needed = NUCLEAR_WAR_LARVA_POINTS_NEEDED

/datum/game_mode/infestation/distro_crush/get_hivemind_collapse_countdown()
	var/eta = timeleft(orphan_hive_timer) MILLISECONDS
	return !isnull(eta) ? round(eta) : 0

/datum/game_mode/infestation/distro_crush/update_silo_death_timer(datum/hive_status/silo_owner)
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
/datum/game_mode/infestation/distro_crush/proc/siloless_hive_collapse()
	if(!(round_type_flags & MODE_INFESTATION))
		return
	if(round_finished)
		return
	if(round_stage == INFESTATION_MARINE_CRASHING)
		return
	round_finished = MODE_INFESTATION_M_MAJOR

/datum/game_mode/infestation/distro_crush/get_siloless_collapse_countdown()
	var/eta = timeleft(siloless_hive_timer) MILLISECONDS
	return !isnull(eta) ? round(eta) : 0

/datum/game_mode/infestation/distro_crush/can_summon_dropship(mob/user)
	to_chat(src, span_warning("This power doesn't work in this gamemode."))
	return FALSE
