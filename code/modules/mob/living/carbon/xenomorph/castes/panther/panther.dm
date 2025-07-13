/mob/living/carbon/xenomorph/panther
	caste_base_type = /datum/xeno_caste/panther
	name = "Panther"
	desc = "What you have done with this cute little rouny?"
	icon = 'icons/Xeno/castes/panther/basic.dmi'
	icon_state = "Panther Walking" //Panther sprites by Drawsstuff (CC BY-NC-SA 3.0)
	effects_icon = 'icons/Xeno/castes/panther/effects.dmi'
	rouny_icon = 'icons/Xeno/castes/panther/rouny.dmi'
	health = 50
	maxHealth = 100
	plasma_stored = 10
	pass_flags = PASS_LOW_STRUCTURE
	tier = XENO_TIER_TWO
	upgrade = XENO_UPGRADE_NORMAL
	pixel_x = -16
	bubble_icon = "alien"
	gib_chance = 44.81
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)

/mob/living/carbon/xenomorph/panther/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(adrenalin)), 1 SECONDS, TIMER_LOOP)

/mob/living/carbon/xenomorph/panther/proc/adrenalin()
	if(m_intent == MOVE_INTENT_RUN)
		if(last_move_time + 1 SECONDS >= world.time)
			gain_plasma(2)
			return
	if(plasma_stored >= 40)
		use_plasma(3)

/obj/item/reagent_containers/food/drinks/pantherheart
	name = "Panther heart"
	desc = "This is Panther heart... Wait, what?"
	icon = 'icons/obj/items/drinks.dmi'
	icon_state = "pantherheart"
	w_class = WEIGHT_CLASS_NORMAL
	force = 0
	throwforce = 0
	gulp_size = 3
	possible_transfer_amounts = null
	volume = 20
	list_reagents = list(/datum/reagent/medicine/adrenaline = 20)

/obj/item/reagent_containers/food/drinks/pantherheart/on_reagent_change()
	if(!reagents.total_volume)
		icon_state = "pantherheart_e"

/mob/living/carbon/xenomorph/panther/gib()
	new /obj/item/reagent_containers/food/drinks/pantherheart(loc)
	return ..()
