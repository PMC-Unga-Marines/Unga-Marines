//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/gorger_unmoving_link
	name = "Unmoving Link"
	desc = "While Psychic Link is active, you gain maximum movement resistance and gain 5/15/25 armor."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_GORGER_UNMOVING_LINK
	buff_desc = "Movement resistance and armor while psychic link is active"
	caste_restrictions = list("gorger")

/datum/xeno_mutation/gorger_enhanced_absorption
	name = "Enhanced Absorption"
	desc = "Absorb abilities restore 25/35/45% more health and plasma."
	category = "Survival"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_GORGER_ENHANCED_ABSORPTION
	buff_desc = "Enhanced absorption healing and plasma restoration"
	caste_restrictions = list("gorger")

/datum/xeno_mutation/gorger_psychic_shield
	name = "Psychic Shield"
	desc = "Gain 10/15/20% resistance to all damage while Psychic Link is active."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_GORGER_PSYCHIC_SHIELD
	buff_desc = "Damage resistance while psychic link is active"
	caste_restrictions = list("gorger")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/gorger_psychic_drain
	name = "Psychic Drain"
	desc = "Psychic Link drains health and plasma from the target over time."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_GORGER_PSYCHIC_DRAIN
	buff_desc = "Psychic link drains target over time"
	caste_restrictions = list("gorger")

/datum/xeno_mutation/gorger_mind_control
	name = "Mind Control"
	desc = "Psychic Link can briefly control the target's actions."
	category = "Offensive"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_GORGER_MIND_CONTROL
	buff_desc = "Psychic link can control target actions"
	caste_restrictions = list("gorger")

/datum/xeno_mutation/gorger_psychic_explosion
	name = "Psychic Explosion"
	desc = "Breaking Psychic Link creates a psychic explosion that damages nearby enemies."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_GORGER_PSYCHIC_EXPLOSION
	buff_desc = "Psychic explosion when link breaks"
	caste_restrictions = list("gorger")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/gorger_hive_link
	name = "Hive Link"
	desc = "Psychic Link can connect to multiple targets simultaneously."
	category = "Specialized"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_GORGER_HIVE_LINK
	buff_desc = "Psychic link can connect to multiple targets"
	caste_restrictions = list("gorger")

/datum/xeno_mutation/gorger_psychic_dominance
	name = "Psychic Dominance"
	desc = "All xenomorphs within 5 tiles gain 15/20/25% increased damage and speed."
	category = "Specialized"
	cost = 45
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_GORGER_PSYCHIC_DOMINANCE
	buff_desc = "Allies gain damage and speed boost"
	caste_restrictions = list("gorger")
