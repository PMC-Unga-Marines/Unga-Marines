// ***************************************
// ***************************************
// ***************************************

// BULL MUTATIONS

// ***************************************
// ***************************************
// ***************************************

/atom/movable/screen/alert/status_effect/bull_unstoppable
	name = "Unstoppable"
	desc = "Charging grants stagger immunity at max steps"
	icon_state = "xenobuff_generic"

/datum/status_effect/bull_unstoppable
	id = "bull_unstoppable"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/bull_unstoppable
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/bull_unstoppable/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/bull_speed_demon
	name = "Speed Demon"
	desc = "Increased charge speed, higher plasma cost"
	icon_state = "xenobuff_generic"

/datum/status_effect/bull_speed_demon
	id = "bull_speed_demon"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/bull_speed_demon
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/bull_speed_demon/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/bull_railgun
	name = "Railgun"
	desc = "Increased maximum charge steps"
	icon_state = "xenobuff_generic"

/datum/status_effect/bull_railgun
	id = "bull_railgun"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/bull_railgun
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/bull_railgun/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

// ***************************************
// ***************************************
// ***************************************

// BEHEMOTH MUTATIONS

// ***************************************
// ***************************************
// ***************************************

/atom/movable/screen/alert/status_effect/behemoth_rocky_layers
	name = "Rocky Layers"
	desc = "Hard armor when health is low"
	icon_state = "xenobuff_generic"

/datum/status_effect/behemoth_rocky_layers
	id = "behemoth_rocky_layers"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/behemoth_rocky_layers
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/behemoth_rocky_layers/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/behemoth_refined_palate
	name = "Refined Palate"
	desc = "Extra damage to barricades"
	icon_state = "xenobuff_generic"

/datum/status_effect/behemoth_refined_palate
	id = "behemoth_refined_palate"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/behemoth_refined_palate
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/behemoth_refined_palate/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/behemoth_avalanche
	name = "Avalanche"
	desc = "More Earth Riser pillars, longer cooldown"
	icon_state = "xenobuff_generic"

/datum/status_effect/behemoth_avalanche
	id = "behemoth_avalanche"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/behemoth_avalanche
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/behemoth_avalanche/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

// ***************************************
// ***************************************
// ***************************************

// BOILER MUTATIONS

// ***************************************
// ***************************************
// ***************************************

/atom/movable/screen/alert/status_effect/boiler_staggered_panic
	name = "Staggered Panic"
	desc = "Acid spray when staggered with globs"
	icon_state = "xenobuff_generic"

/datum/status_effect/boiler_staggered_panic
	id = "boiler_staggered_panic"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/boiler_staggered_panic
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/boiler_staggered_panic/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/boiler_thick_containment
	name = "Thick Containment"
	desc = "Slowdown instead of glow for excess globs"
	icon_state = "xenobuff_generic"

/datum/status_effect/boiler_thick_containment
	id = "boiler_thick_containment"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/boiler_thick_containment
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/boiler_thick_containment/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/boiler_dim_containment
	name = "Dim Containment"
	desc = "Higher threshold for excess globs"
	icon_state = "xenobuff_generic"

/datum/status_effect/boiler_dim_containment
	id = "boiler_dim_containment"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/boiler_dim_containment
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/boiler_dim_containment/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/boiler_gaseous_spray
	name = "Gaseous Spray"
	desc = "Gas trail with acid spray"
	icon_state = "xenobuff_generic"

/datum/status_effect/boiler_gaseous_spray
	id = "boiler_gaseous_spray"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/boiler_gaseous_spray
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/boiler_gaseous_spray/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/boiler_hip_fire
	name = "Hip Fire"
	desc = "Faster bombard, lose long range sight"
	icon_state = "xenobuff_generic"

/datum/status_effect/boiler_hip_fire
	id = "boiler_hip_fire"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/boiler_hip_fire
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/boiler_hip_fire/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/boiler_rapid_fire
	name = "Rapid Fire"
	desc = "Fast globs with reduced cooldown"
	icon_state = "xenobuff_generic"

/datum/status_effect/boiler_rapid_fire
	id = "boiler_rapid_fire"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/boiler_rapid_fire
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/boiler_rapid_fire/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/boiler_acid_trail
	name = "Acid Trail"
	desc = "Acid splatter when moving with globs"
	icon_state = "xenobuff_generic"

/datum/status_effect/boiler_acid_trail
	id = "boiler_acid_trail"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/boiler_acid_trail
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/boiler_acid_trail/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/boiler_chemical_mixing
	name = "Chemical Mixing"
	desc = "Special chemical globs for bombard"
	icon_state = "xenobuff_generic"

/datum/status_effect/boiler_chemical_mixing
	id = "boiler_chemical_mixing"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/boiler_chemical_mixing
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/boiler_chemical_mixing/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/boiler_binoculars
	name = "Binoculars"
	desc = "Increased range for bombard and sight"
	icon_state = "xenobuff_generic"

/datum/status_effect/boiler_binoculars
	id = "boiler_binoculars"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/boiler_binoculars
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/boiler_binoculars/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

// ***************************************
// ***************************************
// ***************************************

// CARRIER MUTATIONS

// ***************************************
// ***************************************
// ***************************************

/atom/movable/screen/alert/status_effect/carrier_shared_jelly
	name = "Shared Jelly"
	desc = "Fire immunity for thrown huggers"
	icon_state = "xenobuff_generic"

/datum/status_effect/carrier_shared_jelly
	id = "carrier_shared_jelly"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/carrier_shared_jelly
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/carrier_shared_jelly/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/carrier_hugger_overflow
	name = "Hugger Overflow"
	desc = "Auto-drop huggers when staggered"
	icon_state = "xenobuff_generic"

/datum/status_effect/carrier_hugger_overflow
	id = "carrier_hugger_overflow"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/carrier_hugger_overflow
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/carrier_hugger_overflow/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/carrier_recurring_panic
	name = "Recurring Panic"
	desc = "Auto-activate panic with reduced cost"
	icon_state = "xenobuff_generic"

/datum/status_effect/carrier_recurring_panic
	id = "carrier_recurring_panic"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/carrier_recurring_panic
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/carrier_recurring_panic/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/carrier_leapfrog
	name = "Leapfrog"
	desc = "Huggers can leap, faster activation"
	icon_state = "xenobuff_generic"

/datum/status_effect/carrier_leapfrog
	id = "carrier_leapfrog"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/carrier_leapfrog
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/carrier_leapfrog/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/carrier_claw_delivered
	name = "Claw Delivered"
	desc = "Faster hugger attachment to humans"
	icon_state = "xenobuff_generic"

/datum/status_effect/carrier_claw_delivered
	id = "carrier_claw_delivered"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/carrier_claw_delivered
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/carrier_claw_delivered/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/carrier_fake_huggers
	name = "Fake Huggers"
	desc = "Fake huggers accompany real ones"
	icon_state = "xenobuff_generic"

/datum/status_effect/carrier_fake_huggers
	id = "carrier_fake_huggers"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/carrier_fake_huggers
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/carrier_fake_huggers/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/carrier_oviposition
	name = "Oviposition"
	desc = "Eggs contain selected huggers, lose spawn ability"
	icon_state = "xenobuff_generic"

/datum/status_effect/carrier_oviposition
	id = "carrier_oviposition"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/carrier_oviposition
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/carrier_oviposition/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/carrier_life_for_life
	name = "Life for Life"
	desc = "Free spawn hugger with health cost"
	icon_state = "xenobuff_generic"

/datum/status_effect/carrier_life_for_life
	id = "carrier_life_for_life"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/carrier_life_for_life
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/carrier_life_for_life/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE

/atom/movable/screen/alert/status_effect/carrier_swarm_trap
	name = "Swarm Trap"
	desc = "More huggers per trap, reduced stun duration"
	icon_state = "xenobuff_generic"

/datum/status_effect/carrier_swarm_trap
	id = "carrier_swarm_trap"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/carrier_swarm_trap
	var/mob/living/carbon/xenomorph/buff_owner

/datum/status_effect/carrier_swarm_trap/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	return TRUE
