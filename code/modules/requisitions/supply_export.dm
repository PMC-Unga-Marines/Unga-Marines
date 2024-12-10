///Function that sells whatever object this is to the faction_selling; returns a /datum/export_report if successful
/atom/movable/proc/supply_export(faction_selling)
	var/points = get_export_value()
	if(!points)
		return FALSE

	SSpoints.supply_points[faction_selling] += points
	SSpoints.dropship_points += points * 0.1
	return new /datum/export_report(points, name, faction_selling)

/mob/living/carbon/human/supply_export(faction_selling)
	if(!can_sell_human_body(src, faction_selling))
		return new /datum/export_report(0, name, faction_selling)
	return ..()

/mob/living/carbon/xenomorph/supply_export(faction_selling)
	. = ..()
	if(!.)
		return FALSE

	var/points = get_export_value()
	GLOB.round_statistics.points_from_xenos += points

/atom/movable/proc/get_export_value(export_value = 0)
	return export_value

/mob/living/carbon/human/get_export_value(export_value)
	if(!job)
		return export_value
	switch(job.job_category)
		if(JOB_CAT_CIVILIAN)
			export_value = 10
		if(JOB_CAT_ENGINEERING, JOB_CAT_MEDICAL, JOB_CAT_REQUISITIONS)
			export_value = 150
		if(JOB_CAT_MARINE)
			export_value = 100
		if(JOB_CAT_SILICON)
			export_value = 800
		if(JOB_CAT_COMMAND)
			export_value = 1000
	return export_value

/mob/living/carbon/human/species/yautja/get_export_value()
	return 3000

/mob/living/carbon/xenomorph/get_export_value(export_value)
	switch(tier)
		if(XENO_TIER_MINION)
			export_value = 50
		if(XENO_TIER_ZERO)
			export_value = 70
		if(XENO_TIER_ONE)
			export_value = 150
		if(XENO_TIER_TWO)
			export_value = 300
		if(XENO_TIER_THREE)
			export_value = 500
		if(XENO_TIER_FOUR)
			export_value = 1000
	return export_value

//I hate it but it's how it was so I'm not touching it further than this
/mob/living/carbon/xenomorph/shrike/get_export_value()
	return 500

/obj/item/reagent_containers/food/snacks/req_pizza/get_export_value()
	return 10

/proc/can_sell_human_body(mob/living/carbon/human/human_to_sell, seller_faction)
	var/to_sell_alignement = GLOB.faction_to_alignement[human_to_sell.faction]
	switch(to_sell_alignement)
		if(ALIGNEMENT_NEUTRAL)
			if(seller_faction == human_to_sell.faction)
				return TRUE
			return TRUE
		if(ALIGNEMENT_HOSTILE)
			if(seller_faction == human_to_sell.faction)
				return TRUE
			return TRUE
		if(ALIGNEMENT_FRIENDLY)
			if(seller_faction == human_to_sell.faction)
				return TRUE
			return TRUE

/mob/living/carbon/human/species/robot/supply_export(faction_selling)
	SSpoints.supply_points[faction_selling] += 45
	return new /datum/export_report(45, name, faction_selling)
