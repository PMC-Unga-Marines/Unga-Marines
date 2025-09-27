//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/praetorian_adaptive_armor
	name = "Adaptive Armor"
	desc = "When you are hit by a non-friendly projectile, you gain 10/15/20 armor against that particular projectile's armor type and lose 15/22.5/30 in all other types."
	category = "Survival"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_PRAETORIAN_ADAPTIVE_ARMOR
	buff_desc = "Armor adapts to last projectile type hit"
	caste_restrictions = list("praetorian")

/datum/xeno_mutation/praetorian_enhanced_regeneration
	name = "Enhanced Regeneration"
	desc = "Regenerate health 25/35/45% faster and restore 15/20/25% more health."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_PRAETORIAN_ENHANCED_REGENERATION
	buff_desc = "Faster and more effective regeneration"
	caste_restrictions = list("praetorian")

/datum/xeno_mutation/praetorian_royal_guard
	name = "Royal Guard"
	desc = "Allies within 5 tiles gain 10/15/20 armor and 15/20/25% damage resistance."
	category = "Survival"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_PRAETORIAN_ROYAL_GUARD
	buff_desc = "Allies gain armor and damage resistance"
	caste_restrictions = list("praetorian")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/praetorian_enhanced_strength
	name = "Enhanced Strength"
	desc = "Deal 15/20/25% more damage and have 20/30/40% chance to stun on slash attacks."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_PRAETORIAN_ENHANCED_STRENGTH
	buff_desc = "Increased damage and stun chance on slash"
	caste_restrictions = list("praetorian")

/datum/xeno_mutation/praetorian_psychic_dominance
	name = "Psychic Dominance"
	desc = "Psychic abilities have 30/40/50% reduced cooldown and cost 20/30/40% less plasma."
	category = "Offensive"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_PRAETORIAN_PSYCHIC_DOMINANCE
	buff_desc = "Enhanced psychic abilities with reduced cooldown and cost"
	caste_restrictions = list("praetorian")

/datum/xeno_mutation/praetorian_royal_decree
	name = "Royal Decree"
	desc = "All xenomorphs within 7 tiles gain 15/20/25% increased damage and speed."
	category = "Offensive"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_PRAETORIAN_ROYAL_DECREE
	buff_desc = "Allies gain damage and speed boost"
	caste_restrictions = list("praetorian")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/praetorian_hive_mind
	name = "Hive Mind"
	desc = "Share vision and health with nearby xenomorphs within 10 tiles."
	category = "Specialized"
	cost = 45
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_PRAETORIAN_HIVE_MIND
	buff_desc = "Share vision and health with nearby xenomorphs"
	caste_restrictions = list("praetorian")

/datum/xeno_mutation/praetorian_psychic_overlord
	name = "Psychic Overlord"
	desc = "Can control multiple xenomorphs simultaneously and share abilities with them."
	category = "Specialized"
	cost = 50
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_PRAETORIAN_PSYCHIC_OVERLORD
	buff_desc = "Control multiple xenomorphs and share abilities"
	caste_restrictions = list("praetorian")
