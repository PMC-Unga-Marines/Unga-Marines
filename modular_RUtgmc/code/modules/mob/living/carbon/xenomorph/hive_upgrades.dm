/datum/hive_upgrade/building/silo/can_buy(mob/living/carbon/xenomorph/buyer, silent = TRUE)
	. = ..()
	if(!.)
		return

	var/turf/buildloc = get_step(buyer, building_loc)
	if(!buildloc)
		return FALSE

	if(buildloc.density)
		if(!silent)
			to_chat(buyer, span_xenowarning("You cannot build in a dense location!"))
		return FALSE

	for(var/hive in GLOB.xeno_resin_silos_by_hive)
		for(var/silo in hive)
			if(get_dist(silo, buyer) < 15)
				to_chat(buyer, span_xenowarning("Another silo is too close!"))
				return FALSE

	if(length(GLOB.xeno_resin_silos_by_hive[buyer.hivenumber]) >= 2)
		if(!silent)
			to_chat(buyer, span_xenowarning("Hive cannot support more than 2 active silos!"))
		return FALSE

/datum/hive_upgrade/defence/oblivion
    name = "Oblivion"
    desc = "Destroy the bodies beneath you "
    icon = "smartminions"
    psypoint_cost = 1000
    flags_gamemode = ABILITY_NUCLEARWAR

/datum/hive_upgrade/defence/oblivion/can_buy(mob/living/carbon/xenomorph/buyer, silent = TRUE)
	. = ..()
	if(!.)
		return
	var/turf/T = get_turf(buyer)
	var/mob/living/carbon/human/H = locate() in T
	var/mob/living/carbon/human/species/synthetic = locate() in T
	if(!H || H.stat != DEAD || synthetic)
		if(!silent)
			to_chat(buyer, span_xenowarning("You cannot destroy nothing or alive"))
		return FALSE

	return TRUE

/datum/hive_upgrade/defence/oblivion/on_buy(mob/living/carbon/xenomorph/buyer)

	if(!can_buy(buyer, FALSE))
		return FALSE

	var/turf/T = get_turf(buyer)
	var/mob/living/carbon/human/H = locate() in T
	xeno_message("[buyer] sent [H] into oblivion!", "xenoannounce", 5, buyer.hivenumber)
	to_chat(buyer, span_xenowarning("WE HAVE SENT THE [H] INTO OBLIVION"))
	H.gib()

	log_game("[buyer] sent [H] into oblivion, spending [psypoint_cost] psy points in the process")


	return ..()

/datum/hive_upgrade/building/nest
	name = "Thick nest"
	desc = "A very thick nest, oozing with a thick sticky substance."
	psypoint_cost = 0
	icon = "nest"
	building_type = /obj/structure/xeno/thick_nest
	building_loc = 0 //This results in spawning the structure under the user.
	building_time = 5 SECONDS

/datum/hive_upgrade/building/nest/can_buy(mob/living/carbon/xenomorph/buyer, silent = TRUE)
	. = ..()
	if(length(buyer.hive.thick_nests) >= buyer.hive.max_thick_nests)
		to_chat(buyer, span_xenowarning("You cannot build any more thick nests!"))
		return FALSE
	return .

/datum/hive_upgrade/building/silo
	psypoint_cost = 800

/datum/hive_upgrade/building/evotower
	desc = "Constructs a tower that increases the rate of evolution point."

/datum/hive_upgrade/building/pherotower
	psypoint_cost = 150

/datum/hive_upgrade/defence/turret
	psypoint_cost = 80

/datum/hive_upgrade/defence/turret/sticky
	psypoint_cost = 50

/datum/hive_upgrade/primordial
	category = "Primordial"

/datum/hive_upgrade/primordial/tier_four
	psypoint_cost = 800

/datum/hive_upgrade/primordial/tier_three
	psypoint_cost = 1000

/datum/hive_upgrade/primordial/tier_two
	psypoint_cost = 800

/datum/hive_upgrade/primordial/tier_one
	psypoint_cost = 600
