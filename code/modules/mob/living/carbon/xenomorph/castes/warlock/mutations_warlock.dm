//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/warlock_cautious_mind
	name = "Cautious Mind"
	desc = "Psychic Shield will attempt to detonate if it was automatically canceled while the shield is intact. The detonation cost is now 125/100/75% of its original cost."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARLOCK_CAUTIOUS_MIND
	buff_desc = "Psychic shield detonates when canceled with reduced cost"
	caste_restrictions = list("warlock")

/datum/xeno_mutation/warlock_enhanced_shield
	name = "Enhanced Shield"
	desc = "Psychic Shield has 50/75/100% more health and regenerates over time."
	category = "Survival"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARLOCK_ENHANCED_SHIELD
	buff_desc = "Enhanced psychic shield health and regeneration"
	caste_restrictions = list("warlock")

/datum/xeno_mutation/warlock_psychic_immunity
	name = "Psychic Immunity"
	desc = "Gain 25/35/45% resistance to psychic damage and effects."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARLOCK_PSYCHIC_IMMUNITY
	buff_desc = "Resistance to psychic damage and effects"
	caste_restrictions = list("warlock")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/warlock_draining_blast
	name = "Draining Blast"
	desc = "Psychic Blast now deals stamina damage, briefly knockdowns on direct impact, and knockback on non-direct impact."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARLOCK_DRAINING_BLAST
	buff_desc = "Psychic blast deals stamina damage with knockdown/knockback"
	caste_restrictions = list("warlock")

/datum/xeno_mutation/warlock_psychic_dominance
	name = "Psychic Dominance"
	desc = "Psychic abilities have 30/40/50% reduced cooldown and cost 20/30/40% less plasma."
	category = "Offensive"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARLOCK_PSYCHIC_DOMINANCE
	buff_desc = "Enhanced psychic abilities with reduced cooldown and cost"
	caste_restrictions = list("warlock")

/datum/xeno_mutation/warlock_mind_control
	name = "Mind Control"
	desc = "Psychic abilities can briefly control enemy actions."
	category = "Offensive"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARLOCK_MIND_CONTROL
	buff_desc = "Psychic abilities can control enemy actions"
	caste_restrictions = list("warlock")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/warlock_psychic_overlord
	name = "Psychic Overlord"
	desc = "Can control multiple enemies simultaneously and share abilities with them."
	category = "Specialized"
	cost = 50
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARLOCK_PSYCHIC_OVERLORD
	buff_desc = "Control multiple enemies and share abilities"
	caste_restrictions = list("warlock")

/datum/xeno_mutation/warlock_reality_warper
	name = "Reality Warper"
	desc = "Can manipulate the environment and create temporary structures with psychic energy."
	category = "Specialized"
	cost = 60
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARLOCK_REALITY_WARPER
	buff_desc = "Manipulate environment and create structures"
	caste_restrictions = list("warlock")
