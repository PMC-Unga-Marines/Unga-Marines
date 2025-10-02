//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/hivelord_hardened_travel
	name = "Hardened Travel"
	desc = "Resin Walk increases all soft armor by 10/15/20, but prevents you from regenerating plasma."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HIVELORD_HARDENED_TRAVEL
	buff_desc = "Armor boost with resin walk, no plasma regeneration"
	caste_restrictions = list("hivelord")

/datum/xeno_mutation/hivelord_costly_travel
	name = "Costly Travel"
	desc = "Resin Walk creates temporary weeds as you move. Each created weed consumes 75/50/25 plasma."
	category = "Survival"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HIVELORD_COSTLY_TRAVEL
	buff_desc = "Resin walk creates weeds with plasma cost"
	caste_restrictions = list("hivelord")

/datum/xeno_mutation/hivelord_construction_master
	name = "Construction Master"
	desc = "Build structures 25/35/45% faster and with 20/30/40% reduced plasma cost."
	category = "Survival"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HIVELORD_CONSTRUCTION_MASTER
	buff_desc = "Faster building with reduced plasma cost"
	caste_restrictions = list("hivelord")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/hivelord_weaver
	name = "Weaver"
	desc = "Weeds spread 2/3/4 tiles further and regenerate 10/15/20% faster."
	category = "Offensive"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HIVELORD_WEAVER
	buff_desc = "Enhanced weed spread and regeneration"
	caste_restrictions = list("hivelord")

/datum/xeno_mutation/hivelord_resin_master
	name = "Resin Master"
	desc = "Resin structures have 50/75/100% more health and regenerate over time."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HIVELORD_RESIN_MASTER
	buff_desc = "Enhanced resin structure health and regeneration"
	caste_restrictions = list("hivelord")

/datum/xeno_mutation/hivelord_hive_architect
	name = "Hive Architect"
	desc = "Build advanced structures and gain 1/2/3 additional structure slots."
	category = "Offensive"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HIVELORD_HIVE_ARCHITECT
	buff_desc = "Advanced structures and additional slots"
	caste_restrictions = list("hivelord")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/hivelord_plasma_siphon
	name = "Plasma Siphon"
	desc = "Drain plasma from structures and transfer it to nearby xenomorphs."
	category = "Specialized"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HIVELORD_PLASMA_SIPHON
	buff_desc = "Drain and transfer plasma from structures"
	caste_restrictions = list("hivelord")

/datum/xeno_mutation/hivelord_hive_mind
	name = "Hive Mind"
	desc = "All xenomorphs within 7 tiles gain 10/15/20% increased damage and speed."
	category = "Specialized"
	cost = 45
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HIVELORD_HIVE_MIND
	buff_desc = "Allies gain damage and speed boost"
	caste_restrictions = list("hivelord")
