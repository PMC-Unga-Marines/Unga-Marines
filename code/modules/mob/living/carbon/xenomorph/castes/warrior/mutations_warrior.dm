//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/warrior_zoomies
	name = "Zoomies"
	desc = "Agility gives an additional 0.3/0.6/0.9 more speed, but decreases your armor by an additional 10/20/30."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARRIOR_ZOOMIES
	buff_desc = "Enhanced agility speed with armor reduction"
	caste_restrictions = list("warrior")

/datum/xeno_mutation/warrior_berserker_rage
	name = "Berserker Rage"
	desc = "When below 50% health, gain 20/30/40% increased damage and speed."
	category = "Survival"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARRIOR_BERSERKER_RAGE
	buff_desc = "Damage and speed boost at low health"
	caste_restrictions = list("warrior")

/datum/xeno_mutation/warrior_unbreakable
	name = "Unbreakable"
	desc = "Cannot be stunned or knocked down while above 75% health."
	category = "Survival"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARRIOR_UNBREAKABLE
	buff_desc = "Stun immunity at high health"
	caste_restrictions = list("warrior")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/warrior_enhanced_strength
	name = "Enhanced Strength"
	desc = "Lunge can be activated from 1/2/3 additional tiles away. Fling and Grapple Toss can now sends your target 1/2/3 tiles further."
	category = "Offensive"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARRIOR_ENHANCED_STRENGTH
	buff_desc = "Increased lunge range and throw distance"
	caste_restrictions = list("warrior")

/datum/xeno_mutation/warrior_devastating_blow
	name = "Devastating Blow"
	desc = "Slash attacks have 15/20/25% chance to stun for 2 seconds."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARRIOR_DEVASTATING_BLOW
	buff_desc = "Chance to stun on slash attacks"
	caste_restrictions = list("warrior")

/datum/xeno_mutation/warrior_blood_frenzy
	name = "Blood Frenzy"
	desc = "Each kill increases your damage by 5/7.5/10% for 30 seconds, stacking up to 5 times."
	category = "Offensive"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARRIOR_BLOOD_FRENZY
	buff_desc = "Damage increase on kills, stacks up to 5 times"
	caste_restrictions = list("warrior")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/warrior_guardian_instincts
	name = "Guardian Instincts"
	desc = "Allies within 3 tiles gain 10/15/20 armor when you are in combat."
	category = "Specialized"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARRIOR_GUARDIAN_INSTINCTS
	buff_desc = "Allies gain armor when in combat"
	caste_restrictions = list("warrior")

/datum/xeno_mutation/warrior_unstoppable_force
	name = "Unstoppable Force"
	desc = "Lunge cannot be interrupted and ignores stagger resistance."
	category = "Specialized"
	cost = 45
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_WARRIOR_UNSTOPPABLE_FORCE
	buff_desc = "Uninterruptible lunge that ignores stagger resistance"
	caste_restrictions = list("warrior")
