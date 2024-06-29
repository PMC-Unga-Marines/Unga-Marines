/datum/xeno_caste/boiler

	// *** Ranged Attack *** //
	spit_types = list(/datum/ammo/xeno/boiler_gas/corrosive)

	// *** Flags *** //
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER|CASTE_CAN_HOLD_FACEHUGGERS|CASTE_CAN_HOLD_JELLY

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/xeno_action/place_acidwell,
		/datum/action/ability/activable/xeno/corrosive_acid/strong,
		/datum/action/ability/xeno_action/create_boiler_bomb,
		/datum/action/ability/activable/xeno/bombard,
		/datum/action/ability/xeno_action/toggle_long_range,
		/datum/action/ability/xeno_action/toggle_bomb,
		/datum/action/ability/activable/xeno/spray_acid/line/boiler,
		/datum/action/ability/xeno_action/dump_acid,
		/datum/action/ability/xeno_action/place_trap,
	)

/datum/xeno_caste/boiler/primordial

	// *** Ranged Attack *** //
	spit_types = list(/datum/ammo/xeno/boiler_gas/corrosive, /datum/ammo/xeno/boiler_gas/corrosive/lance)


	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/xeno_action/place_acidwell,
		/datum/action/ability/activable/xeno/corrosive_acid/strong,
		/datum/action/ability/xeno_action/create_boiler_bomb,
		/datum/action/ability/activable/xeno/bombard,
		/datum/action/ability/xeno_action/toggle_long_range,
		/datum/action/ability/xeno_action/toggle_bomb,
		/datum/action/ability/activable/xeno/spray_acid/line/boiler,
		/datum/action/ability/xeno_action/dump_acid,
		/datum/action/ability/xeno_action/place_trap,
	)

