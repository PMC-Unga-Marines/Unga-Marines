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
