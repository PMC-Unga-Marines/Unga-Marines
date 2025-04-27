/mob/living/carbon
	gender = MALE
	buckle_flags = CAN_BE_BUCKLED|BUCKLE_PREVENTS_PULL
	blood_volume = BLOOD_VOLUME_NORMAL

	///Contains icon generation and language information, set during New().
	var/datum/species/species
	///The amount of life ticks that have processed on this mob.
	var/life_tick = 0
	///Whether or not the mob is handcuffed
	var/obj/item/restraints/handcuffs/handcuffed

	///Tracks whether our most recent breath has failed, for messages and HUD feedback.
	var/breath_failing = FALSE
	
	var/butchery_progress = 0

	var/list/internal_organs = list()
	///Overall drunkenness - check handle_status_effects() in life.dm for effects
	var/drunkenness = 0

	var/rotate_on_lying = TRUE

	/// Levels of pain in your body caused by all the damage
	var/painloss = 0

	///Causes breathing to fail and generate oxyloss instead of recover it, even outside crit.
	var/losebreath = 0
	var/nutrition = NUTRITION_WELLFED

	var/obj/item/back //Human //todo move to human level

	var/blood_type
	// halucination vars
	var/hal_screwyhud = SCREWYHUD_NONE
	var/next_hallucination = 0

	/// % Chance of exploding on death, incremented by total damage taken if not initially zero.
	var/gib_chance = 0
	///list of abilities this mob has access to
	var/list/datum/action/ability/mob_abilities = list()
	///Currently selected ability
	var/datum/action/ability/activable/selected_ability
	///carbon overlay layers
	var/list/overlays_standing[TOTAL_LAYERS]

/mob/living/carbon/proc/transfer_identity(mob/living/carbon/destination)
	if(!istype(destination))
		return
	destination.blood_type = blood_type
