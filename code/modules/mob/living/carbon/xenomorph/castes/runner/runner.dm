/mob/living/carbon/xenomorph/runner
	caste_base_type = /datum/xeno_caste/runner
	name = "Runner"
	desc = "A small red alien that looks like it could run fairly quickly..."
	icon = 'icons/Xeno/castes/runner/basic.dmi' //They are now like, 2x1 or something
	effects_icon = 'icons/Xeno/castes/runner/basic_effects.dmi'
	icon_state = "Runner Walking"
	bubble_icon = "alienleft"
	health = 100
	maxHealth = 100
	plasma_stored = 50
	pass_flags = PASS_LOW_STRUCTURE
	tier = XENO_TIER_ONE
	upgrade = XENO_UPGRADE_NORMAL
	pixel_x = -16  //Needed for 2x2
	bubble_icon = "alien"
	skins = list(
		/datum/xenomorph_skin/runner,
		/datum/xenomorph_skin/runner/rouny,
		/datum/xenomorph_skin/runner/gold,
		/datum/xenomorph_skin/runner/gold_rouny,
		/datum/xenomorph_skin/runner/tacticool,
	)
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)

/mob/living/carbon/xenomorph/runner/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_LIGHT_STEP, XENO_TRAIT)

/mob/living/carbon/xenomorph/runner/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(!ishuman(over))
		return
	if(!back)
		balloon_alert(over,"This runner isn't wearing a saddle!")
		return
	if(!do_after(over, 3 SECONDS, NONE, src))
		return
	var/obj/item/storage/backpack/marine/duffelbag/xenosaddle/saddle = back
	dropItemToGround(saddle,TRUE)

/mob/living/carbon/xenomorph/runner/can_mount(mob/living/user, target_mounting = FALSE)
	. = ..()
	if(!target_mounting)
		user = pulling
	if(!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/human_pulled = user
	if(human_pulled.stat == DEAD)
		return FALSE
	if(!istype(back, /obj/item/storage/backpack/marine/duffelbag/xenosaddle)) //cant ride without a saddle
		return FALSE
	return TRUE

/mob/living/carbon/xenomorph/runner/resisted_against(datum/source)
	user_unbuckle_mob(source, source)

/mob/living/carbon/xenomorph/runner/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/runner/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/runner/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/runner/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/runner/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/runner/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/runner/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
