/mob/living/carbon/xenomorph/spitter
	caste_base_type = /datum/xeno_caste/spitter
	name = "Spitter"
	desc = "A gross, oozing alien of some kind."
	icon = 'icons/Xeno/castes/spitter/basic.dmi'
	icon_state = "Spitter Walking"
	effects_icon = 'icons/Xeno/castes/spitter/effects.dmi'
	bubble_icon = "alienroyal"
	health = 180
	maxHealth = 180
	plasma_stored = 150
	pixel_x = -16
	old_x = -16
	tier = XENO_TIER_TWO
	upgrade = XENO_UPGRADE_NORMAL
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)
	extract_rewards = list(
		/obj/item/reagent_containers/food/drinks/pantherheart/sentinel/spitter,
	)

/obj/item/reagent_containers/food/drinks/pantherheart/sentinel/spitter
	name = "Spitter gland"
	desc = "This is spitter gland. Stings when touched"
	volume = 40
	list_reagents = list(/datum/reagent/xeno_extract/green_mucus = 40)
