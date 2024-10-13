/datum/xeno_caste/beetle
	caste_name = "Beetle"
	display_name = "Beetle"
	upgrade_name = ""
	caste_desc = ""
	wound_type = ""

	caste_type_path = /mob/living/carbon/xenomorph/beetle

	tier = XENO_TIER_MINION
	upgrade = XENO_UPGRADE_BASETYPE

	// *** Melee Attacks *** //
	melee_damage = 17

	// *** Speed *** //
	speed = 0

	// *** Plasma *** //
	plasma_max = 320 ///4 forward charges
	plasma_gain = 10

	// *** Health *** //
	max_health = 250

	// *** Flags *** //
	caste_flags = CASTE_DO_NOT_ALERT_LOW_LIFE|CASTE_IS_A_MINION|CASTE_ACID_BLOOD
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_RIDE_CRUSHER
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 25, BULLET = 25, LASER = 25, ENERGY = 25, BOMB = 25, BIO = 25, FIRE = 25, ACID = 25)

	minimap_icon = "xenominion"

	crest_defense_armor = 20

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/activable/xeno/charge/forward_charge/unprecise,
		/datum/action/ability/xeno_action/toggle_crest_defense,
	)
