/datum/xeno_caste/carrier
	caste_name = "Carrier"
	display_name = "Carrier"
	upgrade_name = ""
	caste_desc = "A carrier of huggies."

	caste_type_path = /mob/living/carbon/xenomorph/carrier

	tier = XENO_TIER_TWO
	upgrade = XENO_UPGRADE_BASETYPE
	wound_type = "carrier" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 22

	// *** Speed *** //
	speed = -0.4

	// *** Plasma *** //
	plasma_max = 1000
	plasma_gain = 45

	// *** Health *** //
	max_health = 425

	// *** Evolution *** //
	evolution_threshold = 225

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED
	can_hold_eggs = CAN_HOLD_ONE_HAND
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_HOLD_FACEHUGGERS|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER|CASTE_CAN_HOLD_JELLY
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 0, BIO = 5, FIRE = 25, ACID = 5)

	// *** Pheromones *** //
	aura_strength = 2.5

	// *** Minimap Icon *** //
	minimap_icon = "carrier"

	// *** Carrier Abilities *** //
	huggers_max = 9
	hugger_delay = 1.25 SECONDS

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/cocoon,
		/datum/action/ability/activable/xeno/plant_weeds,
		/datum/action/ability/activable/xeno/throw_hugger,
		/datum/action/ability/activable/xeno/call_younger,
		/datum/action/ability/xeno_action/lay_egg,
		/datum/action/ability/xeno_action/place_trap,
		/datum/action/ability/xeno_action/spawn_hugger,
		/datum/action/ability/xeno_action/pheromones,
		/datum/action/ability/xeno_action/pheromones/emit_recovery,
		/datum/action/ability/xeno_action/pheromones/emit_warding,
		/datum/action/ability/xeno_action/pheromones/emit_frenzy,
		/datum/action/ability/xeno_action/carrier_panic,
		/datum/action/ability/xeno_action/build_nest,
		/datum/action/ability/xeno_action/choose_hugger_type,
		/datum/action/ability/xeno_action/set_hugger_reserve,
	)

/datum/xeno_caste/carrier/normal
	upgrade = XENO_UPGRADE_NORMAL

/datum/xeno_caste/carrier/primodial
	upgrade_name = "Primordial"
	caste_desc = "It's literally crawling with 11 huggers."
	upgrade = XENO_UPGRADE_PRIMO
	primordial_message = "Not one tall will be left uninfected."

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/cocoon,
		/datum/action/ability/activable/xeno/plant_weeds,
		/datum/action/ability/activable/xeno/throw_hugger,
		/datum/action/ability/activable/xeno/call_younger,
		/datum/action/ability/xeno_action/lay_egg,
		/datum/action/ability/xeno_action/place_trap,
		/datum/action/ability/xeno_action/spawn_hugger,
		/datum/action/ability/xeno_action/pheromones,
		/datum/action/ability/xeno_action/pheromones/emit_recovery,
		/datum/action/ability/xeno_action/pheromones/emit_warding,
		/datum/action/ability/xeno_action/pheromones/emit_frenzy,
		/datum/action/ability/xeno_action/carrier_panic,
		/datum/action/ability/xeno_action/build_nest,
		/datum/action/ability/xeno_action/choose_hugger_type,
		/datum/action/ability/xeno_action/set_hugger_reserve,
		/datum/action/ability/xeno_action/build_hugger_turret,
	)
