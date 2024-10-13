/mob/living/carbon/xenomorph/praetorian
	caste_base_type = /datum/xeno_caste/praetorian
	name = "Praetorian"
	desc = "A huge, looming beast of an alien."
	icon = 'icons/Xeno/castes/praetorian/basic.dmi'
	icon_state = "Praetorian Walking"
	effects_icon = 'icons/Xeno/castes/praetorian/effects.dmi'
	rouny_icon = 'icons/Xeno/castes/praetorian/rouny.dmi'
	health = 210
	maxHealth = 210
	plasma_stored = 200
	pixel_x = -16
	old_x = -16
	mob_size = MOB_SIZE_BIG
	drag_delay = 6 //pulling a big dead xeno is hard
	tier = XENO_TIER_THREE
	upgrade = XENO_UPGRADE_NORMAL
	bubble_icon = "alienroyal"
	skins = list(
		/datum/xenomorph_skin/praetorian/tacticool,
		/datum/xenomorph_skin/praetorian,
	)

