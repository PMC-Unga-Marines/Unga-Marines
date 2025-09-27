//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/sentinel_comforting_acid
	name = "Comforting Acid"
	desc = "Toxic Slash will cause humans to passively heal you for 1/1.5/2 health per stack of Intoxicated as long you are adjacent to them."
	category = "Survival"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SENTINEL_COMFORTING_ACID
	buff_desc = "Healing from intoxicated humans"
	caste_restrictions = list("sentinel")

/datum/xeno_mutation/sentinel_healing_sting
	name = "Healing Sting"
	desc = "Drain Sting now heals 150/175/200% of its original value. Any leftover healing is converted to overheal health."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SENTINEL_HEALING_STING
	buff_desc = "Enhanced drain sting healing with overheal"
	caste_restrictions = list("sentinel")

/datum/xeno_mutation/sentinel_toxic_immunity
	name = "Toxic Immunity"
	desc = "You are immune to your own toxic effects and gain 10/15/20% resistance to all toxins."
	category = "Survival"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SENTINEL_TOXIC_IMMUNITY
	buff_desc = "Immunity to own toxins and toxin resistance"
	caste_restrictions = list("sentinel")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/sentinel_venomous_strike
	name = "Venomous Strike"
	desc = "Slash attacks have 15/20/25% chance to apply toxic slash effect."
	category = "Offensive"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SENTINEL_VENOMOUS_STRIKE
	buff_desc = "Chance to apply toxic effect on slash"
	caste_restrictions = list("sentinel")

/datum/xeno_mutation/sentinel_acid_spray
	name = "Acid Spray"
	desc = "Toxic Slash creates an acid spray in a 1-tile radius around the target."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SENTINEL_ACID_SPRAY
	buff_desc = "Toxic slash creates acid spray"
	caste_restrictions = list("sentinel")

/datum/xeno_mutation/sentinel_poison_master
	name = "Poison Master"
	desc = "All toxic effects last 50/75/100% longer and deal 25/35/45% more damage."
	category = "Offensive"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SENTINEL_POISON_MASTER
	buff_desc = "Enhanced toxic effect duration and damage"
	caste_restrictions = list("sentinel")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/sentinel_toxic_aura
	name = "Toxic Aura"
	desc = "Creates a toxic aura around you that poisons nearby enemies."
	category = "Specialized"
	cost = 40
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SENTINEL_TOXIC_AURA
	buff_desc = "Toxic aura around the sentinel"
	caste_restrictions = list("sentinel")

/datum/xeno_mutation/sentinel_plague_bearer
	name = "Plague Bearer"
	desc = "Toxic effects spread to nearby enemies and last indefinitely until cured."
	category = "Specialized"
	cost = 45
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SENTINEL_PLAGUE_BEARER
	buff_desc = "Toxic effects spread and persist indefinitely"
	caste_restrictions = list("sentinel")
