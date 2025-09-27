//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/ravager_little_more
	name = "Little More"
	desc = "Endure further decreases your critical and death threshold by 20/35/50."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RAVAGER_LITTLE_MORE
	buff_desc = "Enhanced endure thresholds"
	caste_restrictions = list("ravager")

/datum/xeno_mutation/ravager_berserker_rage
	name = "Berserker Rage"
	desc = "When below 50% health, gain 20/30/40% increased damage and speed."
	category = "Survival"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RAVAGER_BERSERKER_RAGE
	buff_desc = "Damage and speed boost at low health"
	caste_restrictions = list("ravager")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/ravager_deep_slash
	name = "Deep Slash"
	desc = "Ravage's armor penetration is increased by 10/15/20."
	category = "Offensive"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RAVAGER_DEEP_SLASH
	buff_desc = "Increased armor penetration for ravage"
	caste_restrictions = list("ravager")

/datum/xeno_mutation/ravager_frenzy
	name = "Frenzy"
	desc = "Ravage's cooldown is reduced by 25/35/45% but costs 1.5x plasma."
	category = "Offensive"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RAVAGER_FRENZY
	buff_desc = "Faster ravage cooldown with higher cost"
	caste_restrictions = list("ravager")

/datum/xeno_mutation/ravager_blood_frenzy
	name = "Blood Frenzy"
	desc = "Each kill reduces ravage cooldown by 2/3/4 seconds for 30 seconds."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RAVAGER_BLOOD_FRENZY
	buff_desc = "Kills reduce ravage cooldown temporarily"
	caste_restrictions = list("ravager")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/ravager_devastating_blow
	name = "Devastating Blow"
	desc = "Ravage deals 25/35/45% more damage and has a 15% chance to stun."
	category = "Specialized"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RAVAGER_DEVASTATING_BLOW
	buff_desc = "Increased ravage damage with stun chance"
	caste_restrictions = list("ravager")

/datum/xeno_mutation/ravager_unstoppable_force
	name = "Unstoppable Force"
	desc = "Ravage cannot be interrupted and ignores stagger resistance."
	category = "Specialized"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RAVAGER_UNSTOPPABLE_FORCE
	buff_desc = "Uninterruptible ravage that ignores stagger resistance"
	caste_restrictions = list("ravager")
