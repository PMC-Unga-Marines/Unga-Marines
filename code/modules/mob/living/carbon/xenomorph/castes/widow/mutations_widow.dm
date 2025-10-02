//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/widow_hive_toughness
	name = "Hive Toughness"
	desc = "Being adjacent to any resin wall grants 10/15/20 soft armor in all categories."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WIDOW_HIVE_TOUGHNESS
	buff_desc = "Armor when adjacent to resin walls"
	caste_restrictions = list("widow")

/datum/xeno_mutation/widow_web_master
	name = "Web Master"
	desc = "Web abilities have 50/75/100% reduced cooldown and cost 25/35/45% less plasma."
	category = "Survival"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WIDOW_WEB_MASTER
	buff_desc = "Enhanced web abilities with reduced cooldown and cost"
	caste_restrictions = list("widow")

/datum/xeno_mutation/widow_spider_sense
	name = "Spider Sense"
	desc = "Gain 15/20/25% evasion chance and detect enemies within 5 tiles."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WIDOW_SPIDER_SENSE
	buff_desc = "Evasion chance and enemy detection"
	caste_restrictions = list("widow")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/widow_venomous_bite
	name = "Venomous Bite"
	desc = "Slash attacks have 20/30/40% chance to apply poison that deals damage over time."
	category = "Offensive"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WIDOW_VENOMOUS_BITE
	buff_desc = "Chance to apply poison on slash attacks"
	caste_restrictions = list("widow")

/datum/xeno_mutation/widow_web_trap
	name = "Web Trap"
	desc = "Web abilities create traps that slow and damage enemies."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WIDOW_WEB_TRAP
	buff_desc = "Web abilities create damaging traps"
	caste_restrictions = list("widow")

/datum/xeno_mutation/widow_swarm_commander
	name = "Swarm Commander"
	desc = "Allies within 5 tiles gain 10/15/20% increased damage and speed."
	category = "Offensive"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WIDOW_SWARM_COMMANDER
	buff_desc = "Allies gain damage and speed boost"
	caste_restrictions = list("widow")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/widow_arachnophobia
	name = "Arachnophobia"
	desc = "Enemies within 3 tiles are slowed and take 15/20/25% more damage from all sources."
	category = "Specialized"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WIDOW_ARACHNOPHOBIA
	buff_desc = "Enemies are slowed and take more damage"
	caste_restrictions = list("widow")

/datum/xeno_mutation/widow_hive_mind
	name = "Hive Mind"
	desc = "Share vision and health with nearby xenomorphs within 7 tiles."
	category = "Specialized"
	cost = 45
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WIDOW_HIVE_MIND
	buff_desc = "Share vision and health with nearby xenomorphs"
	caste_restrictions = list("widow")
