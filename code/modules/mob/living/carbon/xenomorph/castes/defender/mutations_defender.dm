//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/defender_carapace_waxing
	name = "Carapace Waxing"
	desc = "Regenerate Skin additionally reduces various debuffs by 1/2/3 stacks or 2/4/6 seconds."
	category = "Survival"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFENDER_CARAPACE_WAXING
	buff_desc = "Enhanced debuff removal with regenerate skin"
	caste_restrictions = list("defender")

/datum/xeno_mutation/defender_brittle_upclose
	name = "Brittle Upclose"
	desc = "You can no longer be staggered by projectiles and gain 5/7.5/10 bullet armor, but lose 30/35/40 melee armor."
	category = "Survival"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFENDER_BRITTLE_UPCLOSE
	buff_desc = "Bullet armor, stagger resistance, reduced melee armor"
	caste_restrictions = list("defender")

/datum/xeno_mutation/defender_adaptive_armor
	name = "Adaptive Armor"
	desc = "Your armor adapts to the last damage type received, gaining 10/15/20 resistance to that type."
	category = "Survival"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFENDER_ADAPTIVE_ARMOR
	buff_desc = "Armor adapts to last damage type"
	caste_restrictions = list("defender")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/defender_shield_bash
	name = "Shield Bash"
	desc = "Fortify now knocks down enemies in a 1-tile radius when activated."
	category = "Offensive"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFENDER_SHIELD_BASH
	buff_desc = "Fortify knocks down nearby enemies"
	caste_restrictions = list("defender")

/datum/xeno_mutation/defender_counter_strike
	name = "Counter Strike"
	desc = "When taking melee damage, retaliate with 1.2/1.4/1.6x damage."
	category = "Offensive"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFENDER_COUNTER_STRIKE
	buff_desc = "Retaliate with increased damage when hit"
	caste_restrictions = list("defender")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/defender_guardian_aura
	name = "Guardian Aura"
	desc = "Allies within 3 tiles gain 5/7.5/10 armor when you are fortified."
	category = "Specialized"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFENDER_GUARDIAN_AURA
	buff_desc = "Allies gain armor when fortified"
	caste_restrictions = list("defender")

/datum/xeno_mutation/defender_impregnable_fortress
	name = "Impregnable Fortress"
	desc = "Fortify's duration is increased by 50/75/100% and cooldown reduced by 20/30/40%."
	category = "Specialized"
	cost = 35
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DEFENDER_IMPREGNABLE_FORTRESS
	buff_desc = "Enhanced fortify duration and cooldown"
	caste_restrictions = list("defender")
