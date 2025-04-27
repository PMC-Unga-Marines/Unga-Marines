/mob/living/carbon/xenomorph/widow
	caste_base_type = /datum/xeno_caste/widow
	name = "Widow"
	desc = "A large arachnid xenomorph, with fangs ready to bear and crawling with many little spiderlings ready to grow."
	icon = 'icons/Xeno/castes/widow/basic.dmi'
	effects_icon = 'icons/Xeno/castes/widow/effects.dmi'
	icon_state = "Widow Walking"
	bubble_icon = "alienroyal"
	health = 200
	maxHealth = 200
	plasma_stored = 150
	tier = XENO_TIER_THREE
	upgrade = XENO_UPGRADE_NORMAL
	buckle_flags = CAN_BUCKLE
	pixel_x = -16
	max_buckled_mobs = 5

/mob/living/carbon/xenomorph/widow/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_LIGHT_STEP, XENO_TRAIT)
	RegisterSignals(src, list(COMSIG_XENOMORPH_POSTATTACK_LIVING, COMSIG_XENOMORPH_ATTACK_OBJ), PROC_REF(postattack))

/mob/living/carbon/xenomorph/widow/proc/postattack(mob/living/source, atom/target, damage)
	SIGNAL_HANDLER
	SEND_SIGNAL(src, COMSIG_SPIDERLING_CHANGE_ALL_ORDER, SPIDERLING_ATTACK, target)
	SEND_SIGNAL(src, COMSIG_SPIDERLING_CHANGE_ALL_ORDER, SPIDERLING_ATTACK, target)

/mob/living/carbon/xenomorph/widow/buckle_mob(mob/living/buckling_mob, force = FALSE, check_loc = TRUE, lying_buckle = FALSE, hands_needed = 0, target_hands_needed = 0, silent)
	if(!force)
		return FALSE
	return ..()

/mob/living/carbon/xenomorph/widow/post_unbuckle_mob(mob/living/M)
	M.layer = initial(M.layer)
	M.pixel_x = rand(-8, 8)
	M.pixel_y = rand(-8, 8)

//Prevents humans unbuckling spiderlings
/mob/living/carbon/xenomorph/widow/user_unbuckle_mob(mob/living/buckled_mob, mob/user, silent)
	if(ishuman(user))
		return
	return ..()

/mob/living/carbon/xenomorph/widow/death(gibbing, deathmessage, silent)
	unbuckle_all_mobs(TRUE) //RELEASE THE HORDE
	return ..()

/mob/living/carbon/xenomorph/widow/transfer_to_hive(hivenumber)
	. = ..()
	var/mob/living/carbon/xenomorph/widow/X = src
	var/datum/action/ability/xeno_action/create_spiderling/create_spiderling_action = X.actions_by_path[/datum/action/ability/xeno_action/create_spiderling]
	for(var/mob/living/carbon/xenomorph/spider AS in create_spiderling_action.spiderlings)
		spider.transfer_to_hive(hivenumber)

/mob/living/carbon/xenomorph/widow/on_eord(turf/destination)
	. = ..()
	var/datum/action/ability/xeno_action/create_spiderling/create_spiderling_action = actions_by_path[/datum/action/ability/xeno_action/create_spiderling]
	for(var/mob/living/carbon/xenomorph/spider AS in create_spiderling_action.spiderlings)
		spider.revive(TRUE)
		spider.forceMove(destination)
