//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/crusher_tough_rock
	name = "Tough Rock"
	desc = "After not moving for 1 second, gain 5/7.5/10 soft armor in all categories."
	category = "Survival"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CRUSHER_TOUGH_ROCK
	buff_desc = "Soft armor when stationary"
	caste_restrictions = list("crusher")

/datum/xeno_mutation/crusher_heavy_impact
	name = "Heavy Impact"
	desc = "Charge's impact damage is increased by 10/15/20."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CRUSHER_HEAVY_IMPACT
	buff_desc = "Increased charge impact damage"
	caste_restrictions = list("crusher")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/crusher_rampage
	name = "Rampage"
	desc = "Charge's cooldown is set to 50% of its original value, but it costs 2x plasma."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CRUSHER_RAMPAGE
	buff_desc = "Faster charge cooldown, higher plasma cost"
	caste_restrictions = list("crusher")

/datum/xeno_mutation/crusher_berserker
	name = "Berserker"
	desc = "Charge's speed multiplier per step is increased by 0.02/0.03/0.04."
	category = "Offensive"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CRUSHER_BERSERKER
	buff_desc = "Increased charge speed per step"
	caste_restrictions = list("crusher")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/crusher_devastating_charge
	name = "Devastating Charge"
	desc = "Charge's maximum steps is increased by 2/4/6."
	category = "Specialized"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CRUSHER_DEVASTATING_CHARGE
	buff_desc = "Increased maximum charge steps"
	caste_restrictions = list("crusher")

/datum/xeno_mutation/crusher_earth_shaker
	name = "Earth Shaker"
	desc = "Charge creates a shockwave that knocks down nearby enemies."
	category = "Specialized"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CRUSHER_EARTH_SHAKER
	buff_desc = "Charge creates knockdown shockwave"
	caste_restrictions = list("crusher")
