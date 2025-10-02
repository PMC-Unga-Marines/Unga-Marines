//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/spitter_acid_sweat
	name = "Acid Sweat"
	desc = "If you are on fire, consume 20/15/10 plasma to extinguish yourself and any fire under you."
	category = "Survival"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SPITTER_ACID_SWEAT
	buff_desc = "Plasma cost to extinguish fire"
	caste_restrictions = list("spitter")

/datum/xeno_mutation/spitter_corrosive_armor
	name = "Corrosive Armor"
	desc = "Gain 5/7.5/10 acid armor that damages attackers."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SPITTER_CORROSIVE_ARMOR
	buff_desc = "Acid armor that damages attackers"
	caste_restrictions = list("spitter")

/datum/xeno_mutation/spitter_acid_resistance
	name = "Acid Resistance"
	desc = "Gain 25/35/45% resistance to acid damage."
	category = "Survival"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SPITTER_ACID_RESISTANCE
	buff_desc = "Resistance to acid damage"
	caste_restrictions = list("spitter")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/spitter_rapid_fire
	name = "Rapid Fire"
	desc = "Spit cooldown reduced by 30/40/50% but costs 1.5x plasma."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SPITTER_RAPID_FIRE
	buff_desc = "Faster spit with higher plasma cost"
	caste_restrictions = list("spitter")

/datum/xeno_mutation/spitter_acid_splash
	name = "Acid Splash"
	desc = "Spit creates an acid splash in a 1-tile radius around the impact point."
	category = "Offensive"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SPITTER_ACID_SPLASH
	buff_desc = "Spit creates acid splash on impact"
	caste_restrictions = list("spitter")

/datum/xeno_mutation/spitter_corrosive_spit
	name = "Corrosive Spit"
	desc = "Spit deals 25/35/45% more damage and has 20/30/40% armor penetration."
	category = "Offensive"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SPITTER_CORROSIVE_SPIT
	buff_desc = "Enhanced spit damage and armor penetration"
	caste_restrictions = list("spitter")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/spitter_acid_rain
	name = "Acid Rain"
	desc = "Spit creates a lingering acid cloud that damages enemies over time."
	category = "Specialized"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SPITTER_ACID_RAIN
	buff_desc = "Spit creates lingering acid cloud"
	caste_restrictions = list("spitter")

/datum/xeno_mutation/spitter_plasma_siphon
	name = "Plasma Siphon"
	desc = "Spit damage converts 10/15/20% of damage dealt into plasma for you."
	category = "Specialized"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SPITTER_PLASMA_SIPHON
	buff_desc = "Spit damage converts to plasma"
	caste_restrictions = list("spitter")
