/datum/xeno_caste/predalien
	caste_name = "Predalien"
	display_name = "Abomination"
	upgrade_name = ""
	caste_type_path = /mob/living/carbon/xenomorph/predalien
	tier = XENO_TIER_FOUR
	upgrade = XENO_UPGRADE_BASETYPE
	wound_type = "Predalien"

	// *** Melee Attacks *** //
	melee_damage = 40

	// *** Speed *** //
	speed = -0.8

	// *** Plasma *** //
	plasma_max = 300
	plasma_gain = 5

	soft_armor = list(MELEE = 60, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 80, BIO = 60, FIRE = 30, ACID = 60)

	// *** Health *** //
	max_health = 650

	// *** Evolution *** //
	maximum_active_caste = 1
	evolve_min_xenos = 10
	death_evolution_delay = 12 MINUTES

	// *** Flags *** //
	caste_flags = CASTE_IS_INTELLIGENT|CASTE_STAGGER_RESISTANT|CASTE_LEADER_TYPE|CASTE_INSTANT_EVOLUTION
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER|CASTE_CAN_CORRUPT_GENERATOR|CASTE_CAN_HOLD_FACEHUGGERS|CASTE_CAN_HOLD_JELLY
	caste_traits = null

	// *** Pheromones *** //
	aura_strength = 5

	// *** Minimap Icon *** //
	minimap_icon = "predalien"

	// *** Abilities *** ///
	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/pounce/predalien,
		/datum/action/ability/activable/xeno/predalien_roar,
		/datum/action/ability/activable/xeno/smash,
		/datum/action/ability/activable/xeno/devastate,
		/datum/action/ability/xeno_action/hive_message,
		/datum/action/ability/xeno_action/rally_hive,
		/datum/action/ability/xeno_action/rally_minion,
		/datum/action/ability/xeno_action/blessing_menu,
		/datum/action/ability/xeno_action/set_xeno_lead,
		/datum/action/ability/activable/xeno/corrosive_acid/strong,
	)


/datum/xeno_caste/predalien/normal
	upgrade = XENO_UPGRADE_NORMAL

/datum/xeno_caste/predalien/primordial
	upgrade_name = "Primordial"
	upgrade = XENO_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/pounce/predalien,
		/datum/action/ability/activable/xeno/predalien_roar,
		/datum/action/ability/activable/xeno/smash,
		/datum/action/ability/activable/xeno/devastate,
		/datum/action/ability/xeno_action/hive_message,
		/datum/action/ability/xeno_action/rally_hive,
		/datum/action/ability/xeno_action/rally_minion,
		/datum/action/ability/xeno_action/blessing_menu,
		/datum/action/ability/xeno_action/set_xeno_lead,
		/datum/action/ability/activable/xeno/corrosive_acid/strong,
		/datum/action/ability/xeno_action/pheromones,
		/datum/action/ability/xeno_action/pheromones/emit_recovery,
		/datum/action/ability/xeno_action/pheromones/emit_warding,
		/datum/action/ability/xeno_action/pheromones/emit_frenzy,
	)
