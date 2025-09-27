//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/runner_upfront_evasion
	name = "Upfront Evasion"
	desc = "Evasion is now 1/2/3 seconds longer, but no longer can auto-refresh."
	category = "Survival"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RUNNER_UPFRONT_EVASION
	buff_desc = "Longer evasion duration, no auto-refresh"
	caste_restrictions = list("runner")

/datum/xeno_mutation/runner_borrowed_time
	name = "Borrowed Time"
	desc = "Your critical threshold is decreased by 100. While you have negative health, you are slowed, staggered and cannot slash attack."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RUNNER_BORROWED_TIME
	buff_desc = "Lower critical threshold with movement penalties at negative health"
	caste_restrictions = list("runner")

/datum/xeno_mutation/runner_ingrained_evasion
	name = "Ingrained Evasion"
	desc = "Evasion can auto-refresh every 8/6/4 seconds, but its duration is reduced by 1 second."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RUNNER_INGRAINED_EVASION
	buff_desc = "Auto-refresh evasion with reduced duration"
	caste_restrictions = list("runner")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/runner_lightning_reflexes
	name = "Lightning Reflexes"
	desc = "Pounce has no cooldown but costs 2x plasma and has reduced range."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RUNNER_LIGHTNING_REFLEXES
	buff_desc = "No cooldown pounce with higher cost"
	caste_restrictions = list("runner")

/datum/xeno_mutation/runner_swift_strike
	name = "Swift Strike"
	desc = "Slash attacks have 20/30/40% chance to not trigger attack cooldown."
	category = "Offensive"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RUNNER_SWIFT_STRIKE
	buff_desc = "Chance to avoid attack cooldown"
	caste_restrictions = list("runner")

/datum/xeno_mutation/runner_adrenaline_rush
	name = "Adrenaline Rush"
	desc = "When below 30% health, gain 25/35/45% increased speed and 15/20/25% damage."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RUNNER_ADRENALINE_RUSH
	buff_desc = "Speed and damage boost at low health"
	caste_restrictions = list("runner")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/runner_phase_dash
	name = "Phase Dash"
	desc = "Pounce can pass through walls but costs 3x plasma and has a 10-second cooldown."
	category = "Specialized"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RUNNER_PHASE_DASH
	buff_desc = "Pounce passes through walls with high cost"
	caste_restrictions = list("runner")

/datum/xeno_mutation/runner_blur
	name = "Blur"
	desc = "While evading, you are partially transparent and move 20/30/40% faster."
	category = "Specialized"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_RUNNER_BLUR
	buff_desc = "Transparency and speed boost while evading"
	caste_restrictions = list("runner")
