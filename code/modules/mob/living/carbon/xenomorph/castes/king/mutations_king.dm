//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/king_stone_armor
	name = "Stone Armor"
	desc = "Allies that are in range of Petrify are granted 5/10/15 armor for the duration of it."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_KING_STONE_ARMOR
	buff_desc = "Allies gain armor during petrify"
	caste_restrictions = list("king")

/datum/xeno_mutation/king_royal_guard
	name = "Royal Guard"
	desc = "Allies within 5 tiles gain 10/15/20 armor and 15/20/25% damage resistance."
	category = "Survival"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_KING_ROYAL_GUARD
	buff_desc = "Allies gain armor and damage resistance"
	caste_restrictions = list("king")

/datum/xeno_mutation/king_enhanced_pheromones
	name = "Enhanced Pheromones"
	desc = "Pheromone effects are 50/75/100% stronger and last 25/35/45% longer."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_KING_ENHANCED_PHEROMONES
	buff_desc = "Enhanced pheromone strength and duration"
	caste_restrictions = list("king")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/king_minion_king
	name = "Minion King"
	desc = "Psychic Summon only affects minions. Once Psychic Summon is completed, the summoned gain a 0/10/20% melee damage increase for 30 seconds."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_KING_MINION_KING
	buff_desc = "Enhanced psychic summon for minions with damage boost"
	caste_restrictions = list("king")

/datum/xeno_mutation/king_psychic_dominance
	name = "Psychic Dominance"
	desc = "Psychic abilities have 30/40/50% reduced cooldown and cost 20/30/40% less plasma."
	category = "Offensive"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_KING_PSYCHIC_DOMINANCE
	buff_desc = "Enhanced psychic abilities with reduced cooldown and cost"
	caste_restrictions = list("king")

/datum/xeno_mutation/king_royal_decree
	name = "Royal Decree"
	desc = "All xenomorphs within 7 tiles gain 15/20/25% increased damage and speed."
	category = "Offensive"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_KING_ROYAL_DECREE
	buff_desc = "Allies gain damage and speed boost"
	caste_restrictions = list("king")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/king_hive_mind
	name = "Hive Mind"
	desc = "Share vision and health with nearby xenomorphs within 10 tiles."
	category = "Specialized"
	cost = 45
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_KING_HIVE_MIND
	buff_desc = "Share vision and health with nearby xenomorphs"
	caste_restrictions = list("king")

/datum/xeno_mutation/king_psychic_overlord
	name = "Psychic Overlord"
	desc = "Can control multiple xenomorphs simultaneously and share abilities with them."
	category = "Specialized"
	cost = 50
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_KING_PSYCHIC_OVERLORD
	buff_desc = "Control multiple xenomorphs and share abilities"
	caste_restrictions = list("king")
