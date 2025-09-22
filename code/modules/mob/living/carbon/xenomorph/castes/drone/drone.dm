/mob/living/carbon/xenomorph/drone
	caste_base_type = /datum/xeno_caste/drone
	name = "Drone"
	desc = "An Alien Drone"
	icon = 'icons/Xeno/castes/drone/basic.dmi'
	icon_state = "Drone Walking"
	effects_icon = 'icons/Xeno/castes/drone/effects.dmi'
	bubble_icon = "alien"
	skins = list(
		/datum/xenomorph_skin/drone,
		/datum/xenomorph_skin/drone/rouny,
		/datum/xenomorph_skin/drone/king,
		/datum/xenomorph_skin/drone/cyborg,
		/datum/xenomorph_skin/drone/hornet,
	)
	health = 120
	maxHealth = 120
	plasma_stored = 350
	tier = XENO_TIER_ONE
	upgrade = XENO_UPGRADE_NORMAL
	pixel_x = -12
	pull_speed = -2
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)

/mob/living/carbon/xenomorph/drone/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/drone/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/drone/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/drone/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/drone/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/drone/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/drone/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
