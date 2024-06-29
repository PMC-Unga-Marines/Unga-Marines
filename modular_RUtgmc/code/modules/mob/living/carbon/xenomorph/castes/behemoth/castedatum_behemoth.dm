/datum/xeno_caste/behemoth

	// *** Health *** //
	max_health = 750

	// *** Melee Attacks *** //
	melee_damage = 26

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED|CASTE_IS_STRONG|CASTE_STAGGER_RESISTANT

	// *** Abilities *** ///
	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/landslide,
		/datum/action/ability/activable/xeno/earth_riser,
		/datum/action/ability/activable/xeno/seismic_fracture,
	)

/datum/xeno_caste/behemoth/primordial

	// *** Wrath *** //
	wrath_max = 750

	// *** Abilities *** ///
	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/landslide,
		/datum/action/ability/activable/xeno/earth_riser,
		/datum/action/ability/activable/xeno/seismic_fracture,
		/datum/action/ability/xeno_action/primal_wrath,
	)
