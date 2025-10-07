/mob/living/carbon/xenomorph/gorger
	caste_base_type = /datum/xeno_caste/gorger
	name = "Gorger"
	desc = "A large, powerfully muscled xeno with seemingly more vitality than others."
	icon = 'icons/Xeno/castes/gorger/basic.dmi'
	icon_state = "Gorger Walking"
	effects_icon = 'icons/Xeno/castes/gorger/effects.dmi'
	health = 600
	maxHealth = 600
	plasma_stored = 100
	pixel_x = -16
	tier = XENO_TIER_THREE
	upgrade = XENO_UPGRADE_NORMAL
	mob_size = MOB_SIZE_BIG
	bubble_icon = "alienroyal"

	skins = list(
		/datum/xenomorph_skin/gorger,
		/datum/xenomorph_skin/gorger/rouny,
	)

/mob/living/carbon/xenomorph/gorger/Initialize(mapload)
	. = ..()
	GLOB.huds[DATA_HUD_XENO_HEART].add_hud_to(src)

/mob/living/carbon/xenomorph/gorger/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/gorger/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/gorger/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/gorger/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/gorger/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/gorger/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/gorger/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
