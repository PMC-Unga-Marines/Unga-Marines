//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/boiler_staggered_panic
	name = "Staggered Panic"
	desc = "If you are staggered while carrying 7/5/3 stored globs, adjacent tiles will be sprayed with stunning acid. This recharges once you reach full health."
	category = "Survival"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BOILER_STAGGERED_PANIC
	buff_desc = "Acid spray when staggered with globs"
	caste_restrictions = list("boiler")

/datum/xeno_mutation/boiler_thick_containment
	name = "Thick Containment"
	desc = "Having excess globs no longer causes you to glow, but will instead slow you down by 0.15/0.1/0.05 for each excess glob."
	category = "Survival"
	cost = 15
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BOILER_THICK_CONTAINMENT
	buff_desc = "Slowdown instead of glow for excess globs"
	caste_restrictions = list("boiler")

/datum/xeno_mutation/boiler_dim_containment
	name = "Dim Containment"
	desc = "The threshold for having excess globs is increased by 1/2/3."
	category = "Survival"
	cost = 10
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BOILER_DIM_CONTAINMENT
	buff_desc = "Higher threshold for excess globs"
	caste_restrictions = list("boiler")

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/boiler_gaseous_spray
	name = "Gaseous Spray"
	desc = "If you have 7/5/3 stored globs, your acid spray also leaves a trail of non-opaque gas of your selected glob type."
	category = "Offensive"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BOILER_GASEOUS_SPRAY
	buff_desc = "Gas trail with acid spray"
	caste_restrictions = list("boiler")

/datum/xeno_mutation/boiler_hip_fire
	name = "Hip Fire"
	desc = "Bombard's preparation and firing cast delay is set to 50/40/30% of their original value. You lose Long Range Sight."
	category = "Offensive"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BOILER_HIP_FIRE
	buff_desc = "Faster bombard, lose long range sight"
	caste_restrictions = list("boiler")

/datum/xeno_mutation/boiler_rapid_fire
	name = "Rapid Fire"
	desc = "Your normal globs are replaced with fast globs. Fast globs are twice as fast, but the gas is transparent, smaller, and dissipates in two seconds. If a fast glob is used, Bombard's cooldown to 50/40/30% of its original value."
	category = "Offensive"
	cost = 30
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BOILER_RAPID_FIRE
	buff_desc = "Fast globs with reduced cooldown"
	caste_restrictions = list("boiler")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/boiler_acid_trail
	name = "Acid Trail"
	desc = "Whenever you move while carrying 7/5/3 stored globs, a short acid splatter is created underneath you."
	category = "Specialized"
	cost = 15
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BOILER_ACID_TRAIL
	buff_desc = "Acid splatter when moving with globs"
	caste_restrictions = list("boiler")

/datum/xeno_mutation/boiler_chemical_mixing
	name = "Chemical Mixing"
	desc = "Bombard now has the option to shoot Ozelomelyn, Hemodile, and Sanguinal. These will consume 6/4/2 stored globs per shot."
	category = "Specialized"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BOILER_CHEMICAL_MIXING
	buff_desc = "Special chemical globs for bombard"
	caste_restrictions = list("boiler")

/datum/xeno_mutation/boiler_binoculars
	name = "Binoculars"
	desc = "Bombard and Long Range Sight can go 2/4/6 tiles further. The time required to use Long Range Sight is set to 250% of its original value."
	category = "Specialized"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BOILER_BINOCULARS
	buff_desc = "Increased range for bombard and sight"
	caste_restrictions = list("boiler")
