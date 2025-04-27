/mob/living/carbon/xenomorph/shrike
	caste_base_type = /datum/xeno_caste/shrike
	name = "Shrike"
	desc = "A large, lanky alien creature. It seems psychically unstable."
	icon = 'icons/Xeno/castes/shrike/basic.dmi'
	icon_state = "Shrike Walking"
	effects_icon = 'icons/Xeno/castes/shrike/effects.dmi'
	rouny_icon = 'icons/Xeno/castes/shrike/rouny.dmi'
	bubble_icon = "alienroyal"
	skins = list(
		/datum/xenomorph_skin/shrike/joker,
		/datum/xenomorph_skin/shrike,
	)
	attacktext = "bites"
	attack_sound = null
	friendly = "nuzzles"
	wall_smash = FALSE
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

