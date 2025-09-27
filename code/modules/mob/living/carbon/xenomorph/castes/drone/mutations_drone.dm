//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/drone_scout
	name = "Scout"
	desc = "You gain 5/10/15 armor in all categories. You lose this armor if you've been on weeds for longer than 5 seconds."
	category = "Survival"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DRONE_SCOUT
	buff_desc = "Armor when not on weeds for too long"
	caste_restrictions = list("drone")

/datum/xeno_mutation/drone_construction_master
	name = "Construction Master"
	desc = "Build structures 25/35/45% faster and with 20/30/40% reduced plasma cost."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DRONE_CONSTRUCTION_MASTER
	buff_desc = "Faster building with reduced plasma cost"
	caste_restrictions = list("drone")

/datum/xeno_mutation/drone_weaver
	name = "Weaver"
	desc = "Weeds spread 2/3/4 tiles further and regenerate 10/15/20% faster."
	category = "Survival"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DRONE_WEAVER
	buff_desc = "Enhanced weed spread and regeneration"
	caste_restrictions = list("drone")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/drone_essence_link
	name = "Essence Link"
	desc = "Link with another xenomorph to share plasma and health regeneration."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DRONE_ESSENCE_LINK
	buff_desc = "Link with another xenomorph for shared benefits"
	caste_restrictions = list("drone")

/datum/xeno_mutation/drone_enhanced_healing
	name = "Enhanced Healing"
	desc = "Heal allies 50/75/100% faster and restore 10/15/20% more health."
	category = "Offensive"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DRONE_ENHANCED_HEALING
	buff_desc = "Faster and more effective healing"
	caste_restrictions = list("drone")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/drone_hive_architect
	name = "Hive Architect"
	desc = "Build advanced structures and gain 1/2/3 additional structure slots."
	category = "Specialized"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DRONE_HIVE_ARCHITECT
	buff_desc = "Advanced structures and additional slots"
	caste_restrictions = list("drone")

/datum/xeno_mutation/drone_plasma_siphon
	name = "Plasma Siphon"
	desc = "Drain plasma from structures and transfer it to nearby xenomorphs."
	category = "Specialized"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DRONE_PLASMA_SIPHON
	buff_desc = "Drain and transfer plasma from structures"
	caste_restrictions = list("drone")
