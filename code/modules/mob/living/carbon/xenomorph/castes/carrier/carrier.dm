/mob/living/carbon/xenomorph/carrier
	caste_base_type = /datum/xeno_caste/carrier
	name = "Carrier"
	desc = "A strange-looking alien creature. It carries a number of scuttling jointed crablike creatures."
	icon = 'icons/Xeno/castes/carrier/basic.dmi' //They are now like, 2x2
	icon_state = "Carrier Walking"
	effects_icon = 'icons/Xeno/castes/carrier/effects.dmi'
	bubble_icon = "alienroyal"
	health = 200
	maxHealth = 200
	plasma_stored = 50
	tier = XENO_TIER_TWO
	upgrade = XENO_UPGRADE_NORMAL
	pixel_x = -16 //Needed for 2x2
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)
	///Facehuggers overlay
	var/mutable_appearance/hugger_overlays_icon

// ***************************************
// *********** Life overrides
// ***************************************
/mob/living/carbon/xenomorph/carrier/Initialize(mapload)
	. = ..()
	hugger_overlays_icon = mutable_appearance(effects_icon, "empty")

/mob/living/carbon/xenomorph/carrier/get_status_tab_items()
	. = ..()
	. += "Stored Facehuggers: [huggers] / [xeno_caste.huggers_max]"
	. += "Reserved Facehuggers: [xeno_caste.huggers_reserved] / [xeno_caste.huggers_max]"

/mob/living/carbon/xenomorph/carrier/update_icons()
	. = ..()

	if(!hugger_overlays_icon)
		return

	overlays -= hugger_overlays_icon
	hugger_overlays_icon.overlays.Cut()

	if(!huggers)
		return

	///Dispayed number of huggers
	var/displayed = round((huggers / xeno_caste.huggers_max) * 3.999) + 1
	for(var/i = 1; i <= displayed; i++)
		if(stat == DEAD)
			hugger_overlays_icon.overlays += mutable_appearance(effects_icon, "clinger_[i] Knocked Down")
		else if(lying_angle)
			if((resting || has_status_effect(STATUS_EFFECT_SLEEPING)) && (!has_status_effect(STATUS_EFFECT_PARALYZED) && !has_status_effect(STATUS_EFFECT_UNCONSCIOUS) && health > 0))
				hugger_overlays_icon.overlays += mutable_appearance(effects_icon, "clinger_[i] Sleeping")
			else
				hugger_overlays_icon.overlays += mutable_appearance(effects_icon, "clinger_[i] Knocked Down")
		else
			hugger_overlays_icon.overlays += mutable_appearance(effects_icon, "clinger_[i]")
	overlays += hugger_overlays_icon

//Observers can become playable facehuggers by clicking on the carrier
/mob/living/carbon/xenomorph/carrier/attack_ghost(mob/dead/observer/user)
	. = ..()

	var/datum/hive_status/hive = GLOB.hive_datums[hivenumber]
	if(stat == DEAD)
		return FALSE

	if(xeno_caste.huggers_reserved >= huggers)
		return FALSE

	if(!hive.can_spawn_as_hugger(user))
		return FALSE

	var/mob/living/carbon/xenomorph/facehugger/new_hugger = new(get_turf(src))
	new_hugger.transfer_to_hive(hivenumber)
	huggers--
	new_hugger.transfer_mob(user)
	return TRUE

//Sentient facehugger can climb on the carrier
/mob/living/carbon/xenomorph/carrier/attack_facehugger(mob/living/carbon/xenomorph/facehugger/F, damage_amount, damage_type, damage_flag, effects, armor_penetration, isrightclick)
	. = ..()
	if(tgui_alert(F, "Do you want to climb on the carrier?", "Climb on the carrier", list("Yes", "No")) != "Yes")
		return
	if(huggers >= xeno_caste.huggers_max)
		balloon_alert(F, "The carrier has no space")
		return
	if(F.health < F.maxHealth)
		balloon_alert(F, "You're too damaged!")
		return

	huggers++
	F.visible_message(span_xenowarning("[F] climb on the [src]."),span_xenonotice("You climb on the [src]."))
	F.ghostize()
	F.death(deathmessage = "climb on the carrier", silent = TRUE)
	qdel(F)
