/datum/xeno_caste/warrior
	caste_name = "Warrior"
	display_name = "Warrior"
	upgrade_name = ""
	caste_desc = "A powerful front line combatant."
	caste_type_path = /mob/living/carbon/xenomorph/warrior
	tier = XENO_TIER_TWO
	upgrade = XENO_UPGRADE_BASETYPE
	wound_type = "warrior" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 23

	// *** Speed *** //
	speed = -0.5

	// *** Plasma *** //
	plasma_max = 200
	plasma_gain = 20

	// *** Health *** //
	max_health = 350

	// *** Sunder *** //
	sunder_multiplier = 0.8

	// *** Evolution *** //
	evolution_threshold = 225

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED|CASTE_IS_STRONG
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER|CASTE_CAN_HOLD_FACEHUGGERS|CASTE_CAN_HOLD_JELLY
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 40, BULLET = 60, LASER = 60, ENERGY = 40, BOMB = 20, BIO = 50, FIRE = 25, ACID = 50)

	// *** Minimap Icon *** //
	minimap_icon = "warrior"

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/xeno_action/empower,
		/datum/action/ability/xeno_action/toggle_agility,
		/datum/action/ability/activable/xeno/warrior/lunge,
		/datum/action/ability/activable/xeno/warrior/fling,
		/datum/action/ability/activable/xeno/warrior/grapple_toss,
		/datum/action/ability/activable/xeno/warrior/punch,
		/datum/action/ability/activable/xeno/warrior/punch/jab,
	)

/datum/xeno_caste/warrior/normal
	upgrade = XENO_UPGRADE_NORMAL

/datum/xeno_caste/warrior/primordial
	upgrade_name = "Primordial"
	caste_desc = "A champion of the hive, methodically shatters its opponents with punches rather than slashes."
	primordial_message = "Our rhythm is unmatched and our strikes lethal, no single foe can stand against us."
	upgrade = XENO_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/xeno_action/empower,
		/datum/action/ability/xeno_action/toggle_agility,
		/datum/action/ability/activable/xeno/warrior/lunge,
		/datum/action/ability/activable/xeno/warrior/fling,
		/datum/action/ability/activable/xeno/warrior/grapple_toss,
		/datum/action/ability/activable/xeno/warrior/punch,
		/datum/action/ability/activable/xeno/warrior/punch/jab,
		/datum/action/ability/activable/xeno/warrior/punch/flurry,
	)
