//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/shrike_lone_healer
	name = "Lone Healer"
	desc = "Psychic Cure can now target yourself. Healing yourself is only 50/60/70% as effective."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SHRIKE_LONE_HEALER
	buff_desc = "Can heal yourself with psychic cure at reduced effectiveness"
	caste_restrictions = list("shrike")

/datum/xeno_mutation/shrike_shared_cure
	name = "Shared Cure"
	desc = "20/35/50% of the health restored from Psychic Cure is reapplied to you."
	category = "Survival"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SHRIKE_SHARED_CURE
	buff_desc = "Psychic cure healing is shared back to you"
	caste_restrictions = list("shrike")

/datum/xeno_mutation/shrike_enhanced_healing
	name = "Enhanced Healing"
	desc = "Heal allies 50/75/100% faster and restore 10/15/20% more health."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SHRIKE_ENHANCED_HEALING
	buff_desc = "Faster and more effective healing"
	caste_restrictions = list("shrike")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/shrike_psychic_dominance
	name = "Psychic Dominance"
	desc = "Psychic abilities have 30/40/50% reduced cooldown and cost 20/30/40% less plasma."
	category = "Offensive"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SHRIKE_PSYCHIC_DOMINANCE
	buff_desc = "Enhanced psychic abilities with reduced cooldown and cost"
	caste_restrictions = list("shrike")

/datum/xeno_mutation/shrike_royal_decree
	name = "Royal Decree"
	desc = "All xenomorphs within 7 tiles gain 15/20/25% increased damage and speed."
	category = "Offensive"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SHRIKE_ROYAL_DECREE
	buff_desc = "Allies gain damage and speed boost"
	caste_restrictions = list("shrike")

/datum/xeno_mutation/shrike_hive_mind
	name = "Hive Mind"
	desc = "Share vision and health with nearby xenomorphs within 10 tiles."
	category = "Offensive"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SHRIKE_HIVE_MIND
	buff_desc = "Share vision and health with nearby xenomorphs"
	caste_restrictions = list("shrike")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/shrike_psychic_overlord
	name = "Psychic Overlord"
	desc = "Can control multiple xenomorphs simultaneously and share abilities with them."
	category = "Specialized"
	cost = 50
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SHRIKE_PSYCHIC_OVERLORD
	buff_desc = "Control multiple xenomorphs and share abilities"
	caste_restrictions = list("shrike")

/datum/xeno_mutation/shrike_divine_intervention
	name = "Divine Intervention"
	desc = "Can resurrect fallen xenomorphs at the cost of significant plasma and health."
	category = "Specialized"
	cost = 60
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SHRIKE_DIVINE_INTERVENTION
	buff_desc = "Can resurrect fallen xenomorphs"
	caste_restrictions = list("shrike")
