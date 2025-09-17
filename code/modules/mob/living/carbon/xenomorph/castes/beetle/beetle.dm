/mob/living/carbon/xenomorph/beetle
	caste_base_type = /datum/xeno_caste/beetle
	name = "Beetle"
	desc = "A bulky, six-legged alien with a horn. Its carapace seems quite durable."
	icon = 'icons/Xeno/castes/beetle/basic.dmi'
	icon_state = "Beetle Walking"
	effects_icon = 'icons/Xeno/castes/beetle/effects.dmi'
	health = 200
	maxHealth = 200
	plasma_stored = 50
	pixel_x = -16
	tier = XENO_TIER_MINION
	upgrade = XENO_UPGRADE_BASETYPE
	pull_speed = -2
	life_value = 0
	default_honor_value = 0

// ***************************************
// *********** Icon
// ***************************************
/mob/living/carbon/xenomorph/beetle/handle_special_state()
	if(crest_defense)
		icon_state = "[xeno_caste.caste_name] Crest"
		return TRUE
	return FALSE

/mob/living/carbon/xenomorph/beetle/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/beetle/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/beetle/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/beetle/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/beetle/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/beetle/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
