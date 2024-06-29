/datum/xeno_caste/carrier
	evolves_to = list(/mob/living/carbon/xenomorph/defiler, /mob/living/carbon/xenomorph/gorger,)
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_HOLD_FACEHUGGERS|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER|CASTE_CAN_HOLD_JELLY

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
		/datum/action/ability/xeno_action/choose_hugger_type,
		/datum/action/ability/xeno_action/set_hugger_reserve,
	)

/datum/xeno_caste/carrier/primodial
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
		/datum/action/ability/xeno_action/choose_hugger_type,
		/datum/action/ability/xeno_action/set_hugger_reserve,
		/datum/action/ability/xeno_action/build_hugger_turret,
	)
