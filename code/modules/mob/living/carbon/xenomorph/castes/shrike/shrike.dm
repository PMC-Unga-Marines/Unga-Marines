/mob/living/carbon/xenomorph/shrike
	caste_base_type = /datum/xeno_caste/shrike
	name = "Shrike"
	desc = "A large, lanky alien creature. It seems psychically unstable."
	icon = 'icons/Xeno/castes/shrike/basic.dmi'
	icon_state = "Shrike Walking"
	effects_icon = 'icons/Xeno/castes/shrike/effects.dmi'
	bubble_icon = "alienroyal"
	skins = list(
		/datum/xenomorph_skin/shrike,
		/datum/xenomorph_skin/shrike/rouny,
		/datum/xenomorph_skin/shrike/joker,
		/datum/xenomorph_skin/shrike/clown,
	)
	health = 240
	maxHealth = 240
	plasma_stored = 300
	pixel_x = -16
	drag_delay = 3 //pulling a medium dead xeno is hard
	tier = XENO_TIER_FOUR
	upgrade = XENO_UPGRADE_NORMAL
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
		/mob/living/carbon/xenomorph/proc/hijack,
	)

/mob/living/carbon/xenomorph/shrike/add_to_hive(datum/hive_status/HS, force = FALSE, prevent_ruler=FALSE) // override to ensure proper queen/hive behaviour
	. = ..()

	if(HS.living_xeno_ruler)
		return
	if(prevent_ruler)
		return

	HS.update_ruler()

/mob/living/carbon/xenomorph/shrike/remove_from_hive()
	var/datum/hive_status/hive_removed_from = hive

	. = ..()

	if(hive_removed_from.living_xeno_ruler == src)
		hive_removed_from.set_ruler(null)
		hive_removed_from.update_ruler() //Try to find a successor.

/mob/living/carbon/xenomorph/shrike/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/shrike/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/shrike/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/shrike/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/shrike/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/shrike/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/shrike/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
