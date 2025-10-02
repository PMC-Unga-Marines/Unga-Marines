/mob/living/carbon/xenomorph/warlock
	caste_base_type = /datum/xeno_caste/warlock
	name = "Warlock"
	desc = "A large, physically frail creature. It hovers in the air and seems to buzz with psychic power."
	icon = 'icons/Xeno/castes/warlock/basic.dmi'
	icon_state = "Warlock Walking"
	effects_icon = 'icons/Xeno/castes/warlock/effects.dmi'
	bubble_icon = "alienroyal"
	skins = list(
		/datum/xenomorph_skin/warlock,
		/datum/xenomorph_skin/warlock/rouny,
		/datum/xenomorph_skin/warlock/arabian,
	)
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

/mob/living/carbon/xenomorph/warlock/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/warlock/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/warlock/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/warlock/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/warlock/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/warlock/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/warlock/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
