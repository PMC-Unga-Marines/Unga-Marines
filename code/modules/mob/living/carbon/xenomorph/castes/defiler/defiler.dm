/mob/living/carbon/xenomorph/defiler
	caste_base_type = /datum/xeno_caste/defiler
	name = "Defiler"
	desc = "A large, powerfully muscled xeno replete with dripping spines and gas leaking dorsal vents."
	icon = 'icons/Xeno/castes/defiler/basic.dmi'
	icon_state = "Defiler Walking"
	effects_icon = 'icons/Xeno/castes/defiler/effects.dmi'
	bubble_icon = "alienroyal"
	health = 225
	maxHealth = 225
	plasma_stored = 400
	pixel_x = -16
	tier = XENO_TIER_THREE
	upgrade = XENO_UPGRADE_NORMAL
	life_value = 0
	default_honor_value = 0
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)

	skins = list(
		/datum/xenomorph_skin/defiler,
		/datum/xenomorph_skin/defiler/rouny,
	)

/mob/living/carbon/xenomorph/defiler/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/defiler/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/defiler/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/defiler/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/defiler/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/defiler/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/defiler/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
