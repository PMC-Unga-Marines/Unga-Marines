/mob/living/carbon/xenomorph/chimera
	caste_base_type = /mob/living/carbon/xenomorph/chimera
	name = "Chimera"
	desc = "A slim, deadly alien creature. It has two additional arms with mantis blades."
	icon = 'modular_RUtgmc/icons/Xeno/castes/chimera.dmi'
	icon_state = "Chimera Walking"
	health = 400
	maxHealth = 400
	plasma_stored = 300
	pixel_x = -16
	old_x = -16
	drag_delay = 3
	tier = XENO_TIER_THREE
	upgrade = XENO_UPGRADE_NORMAL
	mob_size = MOB_SIZE_BIG
	pass_flags = PASS_LOW_STRUCTURE
	wall_smash = FALSE
	bubble_icon = "alienroyal"

/mob/living/carbon/xenomorph/chimera/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SILENT_FOOTSTEPS, XENO_TRAIT)

/mob/living/carbon/xenomorph/chimera/get_liquid_slowdown()
	return WARLOCK_WATER_SLOWDOWN

/mob/living/carbon/xenomorph/chimera/phantom
	caste_base_type = /mob/living/carbon/xenomorph/chimera/phantom
	tier = XENO_TIER_MINION
	upgrade = XENO_UPGRADE_BASETYPE
	mob_size = MOB_SIZE_XENO

/mob/living/carbon/xenomorph/chimera/phantom/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno)
