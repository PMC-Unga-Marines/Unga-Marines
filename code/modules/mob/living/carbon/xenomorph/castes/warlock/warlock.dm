/mob/living/carbon/xenomorph/warlock
	caste_base_type = /datum/xeno_caste/warlock
	name = "Warlock"
	desc = "A large, physically frail creature. It hovers in the air and seems to buzz with psychic power."
	icon = 'icons/Xeno/castes/warlock/basic.dmi'
	icon_state = "Warlock Walking"
	effects_icon = 'icons/Xeno/castes/warlock/effects.dmi'
	rouny_icon = 'icons/Xeno/castes/warlock/rouny.dmi'
	bubble_icon = "alienroyal"
	skins = list(
		/datum/xenomorph_skin/warlock/arabian,
		/datum/xenomorph_skin/warlock,
	)
	attacktext = "slashes"
	attack_sound = null
	friendly = "nuzzles"
	wall_smash = FALSE
	health = 320
	maxHealth = 320
	plasma_stored = 1400
	pixel_x = -16
	drag_delay = 3
	tier = XENO_TIER_THREE
	upgrade = XENO_UPGRADE_NORMAL
	pass_flags = PASS_LOW_STRUCTURE

	can_walk_zoomed = TRUE

/mob/living/carbon/xenomorph/warlock/Initialize(mapload)
	. = ..()
	ammo = GLOB.ammo_list[/datum/ammo/energy/xeno/psy_blast]
	ADD_TRAIT(src, TRAIT_SILENT_FOOTSTEPS, XENO_TRAIT)

/mob/living/carbon/xenomorph/warlock/get_liquid_slowdown()
	return WARLOCK_WATER_SLOWDOWN
