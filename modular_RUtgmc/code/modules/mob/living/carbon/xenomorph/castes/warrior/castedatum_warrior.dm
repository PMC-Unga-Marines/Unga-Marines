/datum/xeno_caste/warrior

	melee_damage = 23

	plasma_max = 200
	plasma_gain = 20

	evolves_to = list(/mob/living/carbon/xenomorph/crusher, /mob/living/carbon/xenomorph/gorger, /mob/living/carbon/xenomorph/warlock, /mob/living/carbon/xenomorph/behemoth, /mob/living/carbon/xenomorph/chimera)

	// *** Flags *** //
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER|CASTE_CAN_HOLD_FACEHUGGERS|CASTE_CAN_HOLD_JELLY

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

/datum/xeno_caste/warrior/primordial

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
