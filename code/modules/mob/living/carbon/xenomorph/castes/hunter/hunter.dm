/mob/living/carbon/xenomorph/hunter
	caste_base_type = /datum/xeno_caste/hunter
	name = "Hunter"
	desc = "A beefy, fast alien with sharp claws."
	icon = 'icons/Xeno/castes/hunter/basic.dmi'
	icon_state = "Hunter Running"
	effects_icon = 'icons/Xeno/castes/hunter/effects.dmi'
	bubble_icon = "alien"
	health = 150
	maxHealth = 150
	plasma_stored = 50
	tier = XENO_TIER_TWO
	upgrade = XENO_UPGRADE_NORMAL
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)

/mob/living/carbon/xenomorph/hunter/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SILENT_FOOTSTEPS, XENO_TRAIT)

/mob/living/carbon/xenomorph/hunter/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/hunter/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/hunter/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/hunter/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/hunter/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/hunter/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/hunter/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
