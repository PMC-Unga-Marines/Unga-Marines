//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/defiler_panic_gas
	name = "Panic Gas"
	desc = "While you have more than 60/40/50% of your maximum plasma, getting staggered will consume that much plasma to release non-opaque gas of your last selected gas."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFILER_PANIC_GAS
	buff_desc = "Release gas when staggered at high plasma"
	caste_restrictions = list("defiler")

/datum/xeno_mutation/defiler_toxic_immunity
	name = "Toxic Immunity"
	desc = "You are immune to your own toxic effects and gain 15/20/25% resistance to all toxins."
	category = "Survival"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFILER_TOXIC_IMMUNITY
	buff_desc = "Immunity to own toxins and toxin resistance"
	caste_restrictions = list("defiler")

/datum/xeno_mutation/defiler_gas_master
	name = "Gas Master"
	desc = "Gas abilities have 30/40/50% reduced cooldown and cost 20/30/40% less plasma."
	category = "Survival"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFILER_GAS_MASTER
	buff_desc = "Enhanced gas abilities with reduced cooldown and cost"
	caste_restrictions = list("defiler")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/defiler_venomous_strike
	name = "Venomous Strike"
	desc = "Slash attacks have 20/30/40% chance to apply toxic effect."
	category = "Offensive"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFILER_VENOMOUS_STRIKE
	buff_desc = "Chance to apply toxic effect on slash"
	caste_restrictions = list("defiler")

/datum/xeno_mutation/defiler_poison_master
	name = "Poison Master"
	desc = "All toxic effects last 50/75/100% longer and deal 25/35/45% more damage."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFILER_POISON_MASTER
	buff_desc = "Enhanced toxic effect duration and damage"
	caste_restrictions = list("defiler")

/datum/xeno_mutation/defiler_toxic_aura
	name = "Toxic Aura"
	desc = "Creates a toxic aura around you that poisons nearby enemies."
	category = "Offensive"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFILER_TOXIC_AURA
	buff_desc = "Toxic aura around the defiler"
	caste_restrictions = list("defiler")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/defiler_plague_bearer
	name = "Plague Bearer"
	desc = "Toxic effects spread to nearby enemies and last indefinitely until cured."
	category = "Specialized"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFILER_PLAGUE_BEARER
	buff_desc = "Toxic effects spread and persist indefinitely"
	caste_restrictions = list("defiler")

/datum/xeno_mutation/defiler_hive_poisoner
	name = "Hive Poisoner"
	desc = "All xenomorphs within 5 tiles gain 10/15/20% increased damage against poisoned enemies."
	category = "Specialized"
	cost = 45
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFILER_HIVE_POISONER
	buff_desc = "Allies gain damage bonus against poisoned enemies"
	caste_restrictions = list("defiler")
