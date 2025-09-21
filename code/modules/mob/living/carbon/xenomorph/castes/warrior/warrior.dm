/mob/living/carbon/xenomorph/warrior
	caste_base_type = /datum/xeno_caste/warrior
	name = "Warrior"
	desc = "A beefy, alien with an armored carapace."
	icon = 'icons/Xeno/castes/warrior/basic.dmi'
	icon_state = "Warrior Walking"
	effects_icon = 'icons/Xeno/castes/warrior/effects.dmi'
	bubble_icon = "alienroyal"
	health = 200
	maxHealth = 200
	plasma_stored = 50
	pixel_x = -16
	tier = XENO_TIER_TWO
	upgrade = XENO_UPGRADE_NORMAL
	bubble_icon = "alienroyal"

	skins = list(
		/datum/xenomorph_skin/warrior,
		/datum/xenomorph_skin/warrior/rouny,
	)

/mob/living/carbon/xenomorph/warrior/handle_special_state()
	var/datum/action/ability/xeno_action/toggle_agility/agility_action = actions_by_path[/datum/action/ability/xeno_action/toggle_agility]
	if(agility_action?.toggled)
		icon_state = "[xeno_caste.caste_name] Agility"
		return TRUE
	return FALSE

/mob/living/carbon/xenomorph/warrior/handle_special_wound_states(severity)
	. = ..()
	var/datum/action/ability/xeno_action/toggle_agility/agility_action = actions_by_path[/datum/action/ability/xeno_action/toggle_agility]
	if(agility_action?.toggled)
		return "wounded_agility_[severity]"

/mob/living/carbon/xenomorph/warrior/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/warrior/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/warrior/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/warrior/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/warrior/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/warrior/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/warrior/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
