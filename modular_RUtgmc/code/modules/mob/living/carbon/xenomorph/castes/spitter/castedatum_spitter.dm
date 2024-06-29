/datum/xeno_caste/spitter

	// *** Flags *** //
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER|CASTE_CAN_RIDE_CRUSHER|CASTE_CAN_HOLD_FACEHUGGERS|CASTE_CAN_HOLD_JELLY
	spit_types = list(/datum/ammo/xeno/acid/medium/passthrough)

/datum/xeno_caste/spitter/primordial
	spit_types = list(/datum/ammo/xeno/acid/medium/passthrough, /datum/ammo/xeno/acid/auto)
