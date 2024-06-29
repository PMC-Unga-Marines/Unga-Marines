/datum/xeno_caste/queen

	max_health = 600

	sunder_recover = 1.5

	// *** Defense *** //
	soft_armor = list(MELEE = 65, BULLET = 65, LASER = 65, ENERGY = 65, BOMB = 80, BIO = 60, FIRE = 60, ACID = 60)

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/cocoon,
		/datum/action/ability/activable/xeno/plant_weeds,
		/datum/action/ability/activable/xeno/secrete_resin,
		/datum/action/ability/xeno_action/blessing_menu,
		/datum/action/ability/xeno_action/place_acidwell,
		/datum/action/ability/xeno_action/lay_egg,
		/datum/action/ability/xeno_action/call_of_the_burrowed,
		/datum/action/ability/activable/xeno/screech,
		/datum/action/ability/activable/xeno/plasma_screech,
		/datum/action/ability/activable/xeno/frenzy_screech,
		/datum/action/ability/xeno_action/bulwark,
		/datum/action/ability/activable/xeno/corrosive_acid/strong,
		/datum/action/ability/activable/xeno/xeno_spit,
		/datum/action/ability/xeno_action/create_jelly,
		/datum/action/ability/activable/xeno/psychic_cure/queen_give_heal,
		/datum/action/ability/activable/xeno/neurotox_sting/ozelomelyn,
		/datum/action/ability/xeno_action/pheromones,
		/datum/action/ability/xeno_action/pheromones/emit_recovery,
		/datum/action/ability/xeno_action/pheromones/emit_warding,
		/datum/action/ability/xeno_action/pheromones/emit_frenzy,
		/datum/action/ability/xeno_action/toggle_queen_zoom,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/xeno_action/set_xeno_lead,
		/datum/action/ability/activable/xeno/queen_give_plasma,
		/datum/action/ability/xeno_action/hive_message,
		/datum/action/ability/xeno_action/rally_minion,
		/datum/action/ability/xeno_action/rally_hive,
		/datum/action/ability/activable/xeno/command_minions,
	)

//same stats as ancient
/datum/xeno_caste/queen/primordial

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/cocoon,
		/datum/action/ability/activable/xeno/plant_weeds,
		/datum/action/ability/activable/xeno/secrete_resin,
		/datum/action/ability/xeno_action/blessing_menu,
		/datum/action/ability/xeno_action/place_acidwell,
		/datum/action/ability/xeno_action/lay_egg,
		/datum/action/ability/xeno_action/call_of_the_burrowed,
		/datum/action/ability/activable/xeno/screech,
		/datum/action/ability/activable/xeno/plasma_screech,
		/datum/action/ability/activable/xeno/frenzy_screech,
		/datum/action/ability/xeno_action/bulwark,
		/datum/action/ability/activable/xeno/corrosive_acid/strong,
		/datum/action/ability/activable/xeno/xeno_spit,
		/datum/action/ability/xeno_action/create_jelly,
		/datum/action/ability/activable/xeno/psychic_cure/queen_give_heal,
		/datum/action/ability/activable/xeno/neurotox_sting/ozelomelyn,
		/datum/action/ability/xeno_action/pheromones,
		/datum/action/ability/xeno_action/pheromones/emit_recovery,
		/datum/action/ability/xeno_action/pheromones/emit_warding,
		/datum/action/ability/xeno_action/pheromones/emit_frenzy,
		/datum/action/ability/xeno_action/toggle_queen_zoom,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/xeno_action/set_xeno_lead,
		/datum/action/ability/activable/xeno/queen_give_plasma,
		/datum/action/ability/xeno_action/sow,
		/datum/action/ability/xeno_action/hive_message,
		/datum/action/ability/xeno_action/rally_minion,
		/datum/action/ability/xeno_action/rally_hive,
		/datum/action/ability/activable/xeno/command_minions,
		/datum/action/ability/xeno_action/ready_charge/queen_charge,
	)

