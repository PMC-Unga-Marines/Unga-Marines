/mob/living/carbon/xenomorph/bull
	caste_base_type = /datum/xeno_caste/bull
	name = "Bull"
	desc = "A bright red alien with a matching temper."
	icon = 'icons/Xeno/castes/bull/basic.dmi'
	icon_state = "Bull Walking"
	effects_icon = 'icons/Xeno/castes/bull/effects.dmi'
	bubble_icon = "alien"
	health = 160
	maxHealth = 160
	plasma_stored = 200
	tier = XENO_TIER_TWO
	upgrade = XENO_UPGRADE_NORMAL

	pixel_x = -16
	pixel_y = -3

	skins = list(
		/datum/xenomorph_skin/bull,
		/datum/xenomorph_skin/bull/rouny,
	)

/mob/living/carbon/xenomorph/bull/handle_special_state()
	if(is_charging >= CHARGE_ON)
		icon_state = "[xeno_caste.caste_name] Charging"
		return TRUE
	return FALSE

/mob/living/carbon/xenomorph/bull/handle_special_wound_states(severity)
	. = ..()
	if(is_charging >= CHARGE_ON)
		return "wounded_charging_[severity]"

/mob/living/carbon/xenomorph/bull/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/bull/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/bull/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/bull/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/bull/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/bull/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/bull/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
