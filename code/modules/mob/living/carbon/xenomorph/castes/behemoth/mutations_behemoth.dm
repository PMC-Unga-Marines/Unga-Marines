//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/behemoth_rocky_layers
	name = "Rocky Layers"
	desc = "When your health is 50% or lower, gain 15/20/25 hard armor."
	category = "Survival"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BEHEMOTH_ROCKY_LAYERS
	buff_desc = "Hard armor when health is low"
	caste_restrictions = list("behemoth")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/behemoth_refined_palate
	name = "Refined Palate"
	desc = "Your slashes deal an additional 0.5/1/1.5x damage to barricades."
	category = "Offensive"
	cost = 15
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BEHEMOTH_REFINED_PALATE
	buff_desc = "Extra damage to barricades"
	caste_restrictions = list("behemoth")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/behemoth_avalanche
	name = "Avalanche"
	desc = "Earth Riser can have 1/2/3 more pillars active at a time, but its cooldown duration is doubled."
	category = "Specialized"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BEHEMOTH_AVALANCHE
	buff_desc = "More Earth Riser pillars, longer cooldown"
	caste_restrictions = list("behemoth")
