/mob/living/carbon/xenomorph/nymph
	caste_base_type = /datum/xeno_caste/nymph
	name = "Nymph"
	desc = "An ant-looking creature."
	icon = 'icons/Xeno/castes/nymph/basic.dmi'
	icon_state = "Nymph Walking"
	effects_icon = 'icons/Xeno/castes/nymph/effects.dmi'
	health = 200
	maxHealth = 200
	plasma_stored = 50
	pixel_x = -16
	tier = XENO_TIER_MINION
	upgrade = XENO_UPGRADE_BASETYPE
	pull_speed = -2

/mob/living/carbon/xenomorph/nymph/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/nymph/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/nymph/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/nymph/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/nymph/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/nymph/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
