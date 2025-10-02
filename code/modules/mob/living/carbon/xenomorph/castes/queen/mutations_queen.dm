//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/queen_healthy_bulwark
	name = "Healthy Bulwark"
	desc = "Bulwark no longer grants armor. Bulwark now grants overheal of 60/80/100 for entering the affected area for the first time."
	category = "Survival"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_QUEEN_HEALTHY_BULWARK
	buff_desc = "Bulwark grants overheal instead of armor"
	caste_restrictions = list("queen")

/datum/xeno_mutation/queen_royal_guard
	name = "Royal Guard"
	desc = "Bulwark's radius is increased by 1/2/3 tiles."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_QUEEN_ROYAL_GUARD
	buff_desc = "Increased bulwark radius"
	caste_restrictions = list("queen")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/queen_enhanced_pheromones
	name = "Enhanced Pheromones"
	desc = "All pheromone effects are increased by 25/35/45%."
	category = "Offensive"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_QUEEN_ENHANCED_PHEROMONES
	buff_desc = "Increased pheromone effectiveness"
	caste_restrictions = list("queen")

/datum/xeno_mutation/queen_psychic_dominance
	name = "Psychic Dominance"
	desc = "Psychic Crush's range is increased by 2/4/6 tiles and its damage by 10/15/20."
	category = "Offensive"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_QUEEN_PSYCHIC_DOMINANCE
	buff_desc = "Increased psychic crush range and damage"
	caste_restrictions = list("queen")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/queen_hive_mind
	name = "Hive Mind"
	desc = "All xenomorphs within 7 tiles gain 10/15/20% increased damage and speed."
	category = "Specialized"
	cost = 50
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_QUEEN_HIVE_MIND
	buff_desc = "Aura buffs nearby xenomorphs"
	caste_restrictions = list("queen")

/datum/xeno_mutation/queen_royal_decree
	name = "Royal Decree"
	desc = "Screech's cooldown is reduced by 20/30/40% and its range increased by 2/4/6 tiles."
	category = "Specialized"
	cost = 45
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_QUEEN_ROYAL_DECREE
	buff_desc = "Improved screech cooldown and range"
	caste_restrictions = list("queen")
