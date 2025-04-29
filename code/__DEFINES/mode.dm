//SSticker.current_state values
#define GAME_STATE_STARTUP 0
#define GAME_STATE_PREGAME 1
#define GAME_STATE_SETTING_UP 2
#define GAME_STATE_PLAYING 3
#define GAME_STATE_FINISHED 4


//SD and evac
#define NUKE_EXPLOSION_INACTIVE 0
#define NUKE_EXPLOSION_ACTIVE 1
#define NUKE_EXPLOSION_IN_PROGRESS 2
#define NUKE_EXPLOSION_FINISHED 3

#define SELF_DESTRUCT_ROD_STARTUP_TIME 20 MINUTES

#define SELF_DESTRUCT_MACHINE_INACTIVE 0
#define SELF_DESTRUCT_MACHINE_ACTIVE 1
#define SELF_DESTRUCT_MACHINE_ARMED 2

#define EVACUATION_STATUS_STANDING_BY 0
#define EVACUATION_STATUS_INITIATING 1
#define EVACUATION_STATUS_IN_PROGRESS 2
#define EVACUATION_STATUS_COMPLETE 3

#define EVACUATION_AUTOMATIC_DEPARTURE 8 MINUTES //All pods automatically depart in 10 minutes, unless they are full or unable to launch for some reason.
#define EVACUATION_ESTIMATE_DEPARTURE ((evac_time + EVACUATION_AUTOMATIC_DEPARTURE - world.time) * 0.1)
#define EVACUATION_POD_LAUNCH_COOLDOWN 5 SECONDS

#define EVACUATION_DENY_flags (1<<0)
#define SELF_DESTRUCT_DENY_flags (1<<1)
#define SDEVAC_TIMELOCK_flags (1<<2)


//Mode defines
#define MODE_INFESTATION (1<<0) //TODO this flag is way too general
#define MODE_NO_LATEJOIN (1<<1)
#define MODE_LATE_OPENING_SHUTTER_TIMER (1<<2)
#define MODE_XENO_SPAWN_PROTECT (1<<3)
#define MODE_XENO_RULER (1<<4)
#define MODE_PSY_POINTS (1<<5)
#define MODE_PSY_POINTS_ADVANCED (1<<6)
#define MODE_HIJACK_POSSIBLE (1<<7)
#define MODE_DEAD_GRAB_FORBIDDEN (1<<8)
#define MODE_SILO_RESPAWN (1<<9)
#define MODE_SILOS_SPAWN_MINIONS (1<<10)
#define MODE_ALLOW_XENO_QUICKBUILD (1<<11)
#define MODE_DISALLOW_RAILGUN (1<<12)
#define MODE_SILO_NO_LARVA (1<<13)
#define MODE_TELETOWER (1<<14)
#define MODE_XENO_DEN (1<<15)
#define MODE_HAS_EXCAVATION (1<<16)

#define MODE_INFESTATION_X_MAJOR "Xenomorph Major Victory"
#define MODE_INFESTATION_M_MAJOR "Marine Major Victory"
#define MODE_INFESTATION_X_MINOR "Xenomorph Minor Victory"
#define MODE_INFESTATION_M_MINOR "Marine Minor Victory"

#define MODE_ZOMBIE_Z_MAJOR "Zombie Major Victory"
#define MODE_ZOMBIE_Z_MINOR "Zombie Minor Victory"

#define MODE_INFESTATION_DRAW_DEATH "DRAW: Mutual Annihilation"

#define MODE_GENERIC_DRAW_NUKE "DRAW: Nuclear Explosion"

#define CRASH_EVAC_NONE "CRASH_EVAC_NONE"
#define CRASH_EVAC_INPROGRESS "CRASH_EVAC_INPROGRESS"
#define CRASH_EVAC_COMPLETED "CRASH_EVAC_COMPLETED"

#define INFESTATION_NUKE_NONE "INFESTATION_NUKE_NONE"
#define INFESTATION_NUKE_INPROGRESS "INFESTATION_NUKE_INPROGRESS"
#define INFESTATION_NUKE_COMPLETED "INFESTATION_NUKE_COMPLETED"
#define INFESTATION_NUKE_COMPLETED_SHIPSIDE "INFESTATION_NUKE_COMPLETED_SHIPSIDE"
#define INFESTATION_NUKE_COMPLETED_OTHER "INFESTATION_NUKE_COMPLETED_OTHER"

#define SURVIVOR_WEAPONS list(\
				list(/obj/item/weapon/gun/smg/mp7, /obj/item/ammo_magazine/smg/mp7),\
				list(/obj/item/weapon/gun/shotgun/double/sawn, /obj/item/ammo_magazine/handful/buckshot),\
				list(/obj/item/weapon/gun/smg/uzi, /obj/item/ammo_magazine/smg/uzi),\
				list(/obj/item/weapon/gun/smg/m25, /obj/item/ammo_magazine/smg/m25),\
				list(/obj/item/weapon/gun/rifle/m16, /obj/item/ammo_magazine/rifle/m16),\
				list(/obj/item/weapon/gun/shotgun/pump/bolt, /obj/item/ammo_magazine/rifle/bolt),\
				list(/obj/item/weapon/gun/shotgun/pump/lever, /obj/item/ammo_magazine/packet/magnum))

//Balance defines
#define MARINE_GEAR_SCALING 30

#define MAX_TUNNELS_PER_MAP 10

#define FOG_DELAY_INTERVAL 40 MINUTES

#define EVACUATION_TIME_LOCK 30 MINUTES

//Nuclear war mode collapse duration
#define NUCLEAR_WAR_ORPHAN_HIVEMIND 5 MINUTES

#define SHUTTLE_HIJACK_LOCK 30 MINUTES

#define COOLDOWN_COMM_REQUEST 5 MINUTES
#define COOLDOWN_COMM_MESSAGE 1 MINUTES
#define COOLDOWN_COMM_CENTRAL 30 SECONDS

#define SUPPLY_POINT_MARINE_SPAWN 25

#define AFK_TIMER 5 MINUTES
#define TIME_BEFORE_TAKING_BODY 1 MINUTES

#define DEATHTIME_CHECK(M) ((world.time - GLOB.key_to_time_of_role_death[M.key]) < SSticker.mode?.respawn_time)
#define DEATHTIME_MESSAGE(M) to_chat(M, span_warning("You have been dead for [(world.time - GLOB.key_to_time_of_role_death[M.key]) * 0.1] second\s.</span><br><span class='warning'>You must wait [SSticker.mode?.respawn_time * 0.1] seconds before rejoining the game!"))

#define XENODEATHTIME_CHECK(M) ((world.time - (GLOB.key_to_time_of_xeno_death[M.key] ? GLOB.key_to_time_of_xeno_death[M.key] : -INFINITY) < SSticker.mode?.xenorespawn_time))
#define XENODEATHTIME_MESSAGE(M) to_chat(M, span_warning("You have been dead for [(world.time - GLOB.key_to_time_of_xeno_death[M.key]) * 0.1] second\s.</span><br><span class ='warning'>You must wait [SSticker.mode?.xenorespawn_time * 0.1] seconds before rejoining the game as a Xenomorph! You can take a SSD minion without resetting your timer."))

#define COUNT_IGNORE_HUMAN_SSD (1<<0)
#define COUNT_IGNORE_XENO_SSD (1<<1)
#define COUNT_IGNORE_XENO_SPECIAL_AREA (1<<2)

#define COUNT_IGNORE_ALIVE_SSD (COUNT_IGNORE_HUMAN_SSD|COUNT_IGNORE_XENO_SSD)

#define SILO_PRICE 800
#define XENO_TURRET_PRICE 100

//How many psy points a hive gets if all generators are corrupted
#define GENERATOR_PSYCH_POINT_OUTPUT 1
//How many psy points are gave for each marine psy drained
#define PSY_DRAIN_REWARD 60
//How many psy points are gave every 5 second by a cocoon
#define COCOON_PSY_POINTS_REWARD 2

/// How each alive marine contributes to burrower larva output per minute. So with one pool, 15 marines are giving 0.375 points per minute, so it's a new xeno every 22 minutes
#define SILO_BASE_OUTPUT_PER_MARINE 0.035
/// This is used to ponderate the number of silo, so to reduces the diminishing returns of having more and more silos
#define SILO_OUTPUT_PONDERATION 1.75

#define INFESTATION_MARINE_DEPLOYMENT 0
#define INFESTATION_MARINE_CRASHING 1
#define INFESTATION_DROPSHIP_CAPTURED_XENOS 2
#define INFESTATION_MARINE_MINOR 3
#define INFESTATION_MARINE_DEN_RUSH 4
#define INFESTATION_MARIN_RUSH_MAJOR 5

#define NUCLEAR_WAR_LARVA_POINTS_NEEDED 8
#define CRASH_LARVA_POINTS_NEEDED 10

#define FREE_XENO_AT_START 2

#define MAX_UNBALANCED_RATIO_TWO_HUMAN_FACTIONS 1.1

#define SENSOR_CAP_ADDITION_TIME_BONUS 3 MINUTES //additional time granted by capturing a sensor tower
#define SENSOR_CAP_TIMER_PAUSED "paused"

#define MAX_FACEHUGGERS 5

//Time (after shutters open) before siloless timer can start
#define MINIMUM_TIME_SILO_LESS_COLLAPSE 15 MINUTES

//Distress mode collapse duration
#define DISTRESS_SILO_COLLAPSE 5 MINUTES

#define WHITELIST_YAUTJA (1<<0)
///Old holders of YAUTJA_ELDER
#define WHITELIST_YAUTJA_LEGACY (1<<1)
#define WHITELIST_YAUTJA_COUNCIL (1<<2)
///Old holders of YAUTJA_COUNCIL for 3 months
#define WHITELIST_YAUTJA_COUNCIL_LEGACY (1<<3)
#define WHITELIST_YAUTJA_LEADER (1<<4)
#define WHITELIST_PREDATOR (WHITELIST_YAUTJA|WHITELIST_YAUTJA_LEGACY|WHITELIST_YAUTJA_COUNCIL|WHITELIST_YAUTJA_COUNCIL_LEGACY|WHITELIST_YAUTJA_LEADER)

#define WHITELIST_NORMAL	"Normal"
#define WHITELIST_COUNCIL	"Council"
#define WHITELIST_LEADER	"Leader"

#define WHITELIST_HIERARCHY	list(WHITELIST_NORMAL, WHITELIST_COUNCIL, WHITELIST_LEADER)

/proc/get_desired_status(desired_status, status_limit)
	var/found_desired = FALSE
	var/found_limit = FALSE

	for(var/status in WHITELIST_HIERARCHY)
		if(status == desired_status)
			found_desired = TRUE
			break
		if(status == status_limit)
			found_limit = TRUE
			break

	if(found_desired)
		return desired_status
	else if(found_limit)
		return status_limit

	return desired_status

#define MODE_SHIPSIDE_SD (1<<16)
#define MODE_PREDATOR (1<<17)

#define MAX_EXCAVATIONS 10

// make sure you don't turn 0 into a false positive
#define BIOSCAN_DELTA(count, delta) count ? max(0, count + rand(-delta, delta)) : 0

#define BIOSCAN_LOCATION(show_locations, location) ((show_locations && location) ? ", including one in [location]" : "")

#define AI_SCAN_DELAY 15 SECONDS
