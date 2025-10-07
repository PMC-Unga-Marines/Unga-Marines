/mob/living/carbon/xenomorph/hivelord
	caste_base_type = /datum/xeno_caste/hivelord
	name = "Hivelord"
	desc = "A huge ass xeno covered in weeds! Oh shit!"
	icon = 'icons/Xeno/castes/hivelord/basic.dmi'
	icon_state = "Hivelord Walking"
	effects_icon = 'icons/Xeno/castes/hivelord/effects.dmi'
	bubble_icon = "alienroyal"
	health = 250
	maxHealth = 250
	plasma_stored = 200
	pixel_x = -16
	mob_size = MOB_SIZE_BIG
	drag_delay = 6 //pulling a big dead xeno is hard
	tier = XENO_TIER_TWO
	upgrade = XENO_UPGRADE_NORMAL

	skins = list(
		/datum/xenomorph_skin/hivelord,
		/datum/xenomorph_skin/hivelord/rouny,
	)

// ***************************************
// *********** Init
// ***************************************
/mob/living/carbon/xenomorph/hivelord/Initialize(mapload)
	. = ..()
	update_spits()

/mob/living/carbon/xenomorph/hivelord/get_status_tab_items()
	. = ..()
	. += "Active Tunnel Sets: [LAZYLEN(tunnels)] / [HIVELORD_TUNNEL_SET_LIMIT]"

/mob/living/carbon/xenomorph/hivelord/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/hivelord/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/hivelord/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/hivelord/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/hivelord/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/hivelord/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/hivelord/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
