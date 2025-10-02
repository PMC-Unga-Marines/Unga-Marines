//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/hunter_fleeting_mirage
	name = "Fleeting Mirage"
	desc = "Upon reaching 25/40/55% health, a mirage will appear and run away from you."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HUNTER_FLEETING_MIRAGE
	buff_desc = "Emergency mirage at low health"
	caste_restrictions = list("hunter")

/datum/xeno_mutation/hunter_shadow_step
	name = "Shadow Step"
	desc = "Pounce has no cooldown but costs 2x plasma and has reduced range."
	category = "Survival"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HUNTER_SHADOW_STEP
	buff_desc = "No cooldown pounce with higher cost"
	caste_restrictions = list("hunter")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/hunter_predator_instincts
	name = "Predator Instincts"
	desc = "Deal 15/20/25% more damage to isolated targets."
	category = "Offensive"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HUNTER_PREDATOR_INSTINCTS
	buff_desc = "Increased damage to isolated targets"
	caste_restrictions = list("hunter")

/datum/xeno_mutation/hunter_bloodlust
	name = "Bloodlust"
	desc = "Each kill increases your damage by 5/7.5/10% for 30 seconds, stacking up to 5 times."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HUNTER_BLOODLUST
	buff_desc = "Damage increase on kills, stacks up to 5 times"
	caste_restrictions = list("hunter")

/datum/xeno_mutation/hunter_stealth_master
	name = "Stealth Master"
	desc = "Stealth duration increased by 50/75/100% and movement speed while stealthed increased by 20/30/40%."
	category = "Offensive"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HUNTER_STEALTH_MASTER
	buff_desc = "Enhanced stealth duration and speed"
	caste_restrictions = list("hunter")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/hunter_ghost_strike
	name = "Ghost Strike"
	desc = "Attacks from stealth deal 2x damage and apply a 3-second stun."
	category = "Specialized"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HUNTER_GHOST_STRIKE
	buff_desc = "Stealth attacks deal double damage and stun"
	caste_restrictions = list("hunter")

/datum/xeno_mutation/hunter_phase_shift
	name = "Phase Shift"
	desc = "Pounce can pass through walls but costs 3x plasma and has a 10-second cooldown."
	category = "Specialized"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_HUNTER_PHASE_SHIFT
	buff_desc = "Pounce passes through walls with high cost"
	caste_restrictions = list("hunter")
