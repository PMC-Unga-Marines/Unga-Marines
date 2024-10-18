/*
This file is where all variables and functions related to personal lists are defined
I've done my best to make it as organized for future additions and changes, but yes it is a lot

The personal_statistics_list serves as a large directory for ckeys and their version of /datum/personal_statistics
In /datum/personal_statistics is where all the data is stored, manipulated by various procs throughout the code

The most basic way to add to something is like this:
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[ckey]
	personal_statistics.stat_you_want_changed++

It searches for the ckey in the global list (you may need to do mob.ckey) and then grabs their /datum/personal_statistics
Then it accesses the desired statistic in personal_statistics!

In the event where you are not using a ckey directly (for example: mob.ckey) you should always do an:
	if(mob.ckey)
		//continue with code

This is to prevent any possible errors with ckey-less mobs

To then display the statistic at the end of the round, you have to add it to the compose_report() proc like so:
	if(stat_you_want_changed)
		stats += "[stat_you_want_changed] things happened."

This is added to the list of stats that are put together for displaying to the player when the round ends

Hopefully this mini-tutorial helps you if you want to add more things to be tracked!
*/

GLOBAL_LIST_EMPTY(personal_statistics_list)

/datum/personal_statistics
	//Combat
	var/projectiles_fired = 0
	var/projectiles_hit = 0
	var/melee_hits = 0

	var/projectile_damage = 0
	var/melee_damage = 0

	//We are watching
	var/friendly_fire_damage = 0

	var/projectiles_caught = 0
	var/projectiles_reflected = 0
	var/rockets_reflected = 0

	var/grenades_primed = 0
	var/traps_created = 0

	var/limbs_lost = 0
	var/delimbs = 0
	var/internal_injuries = 0
	var/internal_injuries_inflicted = 0

	//Medical
	var/self_heals = 0
	var/heals = 0
	var/revives = 0
	var/surgical_actions_performed = 0
	var/list/chemicals_ingested = list()

	var/times_revived = 0
	var/deaths = 0

	//Downtime
	var/time_resting = 0
	var/time_unconscious = 0
	var/time_in_stasis = 0
	var/time_in_cryo = 0

	//Support & logistics
	var/weeds_planted = 0
	var/structures_built = 0
	var/times_repaired = 0
	var/integrity_repaired = 0
	var/generator_repairs_performed = 0
	var/miner_repairs_performed = 0
	var/apcs_repaired = 0

	var/generator_sabotages_performed = 0
	var/miner_sabotages_performed = 0
	var/apcs_slashed = 0

	var/artillery_fired = 0

	var/req_points_used = 0

	var/drained = 0
	var/cocooned = 0
	var/recycle_points_denied = 0
	var/huggers_created = 0
	var/impregnations = 0

	//Close air support
	var/cas_cannon_shots = 0
	var/cas_laser_shots = 0
	var/cas_minirockets_fired = 0
	var/cas_rockets_fired = 0
	var/cas_points_used = 0

	//Funny things to keep track of
	var/weights_lifted = 0
	var/sippies = 0
	var/war_crimes = 0
	var/tactical_unalives = 0	//Someone should add a way to determine if you died to a grenade in your hand and add it to this

///Calculated from the chemicals_ingested list, returns a string: "[chemical name], [amount] units"
/datum/personal_statistics/proc/get_most_ingested_chemical()
	var/list/winner = list("none", 0)
	if(LAZYLEN(chemicals_ingested))
		for(var/chem in chemicals_ingested)
			if(winner[2] < chemicals_ingested[chem])
				winner[1] = chem
				winner[2] = chemicals_ingested[chem]
	return "[winner[1]], [winner[2]] units"

///Assemble a list of statistics associated with the ckey this datum belongs to
/datum/personal_statistics/proc/compose_report()
	var/list/stats = list()
	stats += "<br><hr><u>Персональная статистика:</u><br>"
	//Combat
	if(projectiles_fired)
		stats += "Выстрелов сделано: [projectiles_fired], из которых: [projectiles_hit] попали в цель."
		stats += projectiles_hit ? "Твоя точность составила [PERCENT(projectiles_hit / projectiles_fired)]%!" : "Из-за своей рукожопости ты не сделал ни одного попадания!"
		stats += projectile_damage ? "Твои выстрелы нанесли [projectile_damage] урона!" : "Ты не наносил урон выстрелами."
		stats += ""
	if(melee_hits)
		stats += "Ударов сделано: [melee_hits]."
		stats += melee_damage ? "Твои удары нанесли [melee_damage] урона!" : "ты не наносил урон своими атаками."
		stats += ""
	stats += friendly_fire_damage ? "Ты нанес [friendly_fire_damage] урона союзникам...<br>" : "Тебе удалось избежать ведения дружественного огня!<br>"

	if(projectiles_caught)
		stats += "[projectiles_caught] выстрелов было поймано пси-щитом."
		stats += "[projectiles_reflected] выстрелов было отражено."
		if(rockets_reflected)
			stats += "[rockets_reflected] ракет были отражены!"
		stats += ""

	if(grenades_primed)
		stats += "Ты бросил [grenades_primed] [grenades_primed != 1 ? "гранат" : "гранату"]."
	if(traps_created)
		stats += "[traps_created] [traps_created != 1 ? "ловушек было установлено" : "ловушка была установлена"]."
	if(grenades_primed || traps_created)
		stats += ""

	stats += "Ты потерял [limbs_lost] [limbs_lost != 1 ? "конечностей" : "конечность"]."
	if(delimbs)
		stats += "Ты оторвал [delimbs] [delimbs != 1 ? "конечностей" : "конечность"]!"
	stats += internal_injuries ? "Ты получил [internal_injuries] [internal_injuries != 1 ? "внутренних травм" : "внутреннюю травму"]." : "Ты не получил ни одной внутренней травмы."
	if(internal_injuries_inflicted)
		stats += "Ты причинил [internal_injuries_inflicted > 1 ? "другим" : "кому-то"] [internal_injuries_inflicted] [internal_injuries_inflicted > 1 ? "внутренних травм" : "внутреннюю травму"]."

	//Medical
	stats += "<hr>"
	if(self_heals)
		stats += "Ты лечил свои травмы [self_heals] раз."
	if(heals)
		stats += "Ты лечил травмы союзников [heals] раз."
	if(surgical_actions_performed)
		stats += "Ты выполнил [surgical_actions_performed] [surgical_actions_performed != 1 ? "операций" : "операцию"]."
	if(revives)
		stats += "Ты реанимировал [revives] [revives != 1 ? "союзников" : "союзника"]."
	if(times_revived)
		stats += "Ты был реанимирован [times_revived] раз."
	stats += deaths ? "Ты умер [deaths] раз." : "Ты выжил на протяжении всего раунда."

	//Downtime
	var/list/downtime_stats = list()
	if(time_resting)
		downtime_stats += "Ты отдыхал [DisplayTimeText(time_resting)]."
	if(time_unconscious)
		downtime_stats += "Ты провел без сознания [DisplayTimeText(time_unconscious)]."
	if(time_in_stasis)
		downtime_stats += "Ты провел в стазисе [DisplayTimeText(time_in_stasis)]."
	if(time_in_cryo)
		downtime_stats += "Ты провел в криокамере [DisplayTimeText(time_in_cryo)]."

	if(LAZYLEN(downtime_stats))
		stats += "<hr>"
		stats += downtime_stats

	//Support & logistics
	var/list/support_stats = list()
	if(weeds_planted)
		support_stats += "Посажено [weeds_planted] наростов."
	if(structures_built)
		support_stats += "[structures_built != 1 ? "Построено [structures_built] структур" : "[structures_built] структура"]."
	if(times_repaired)
		support_stats += "[times_repaired != 1 ? "Произведено [times_repaired] ремонтов" : " Произведен [times_repaired] ремонт"]."
	if(integrity_repaired)
		support_stats += "Вы восстановили [integrity_repaired] очков прочности структур."
	if(generator_repairs_performed)
		support_stats += "[generator_repairs_performed != 1 ? "Вы отремонтировали [generator_repairs_performed] генераторов" : "Вы отремонтировали [generator_repairs_performed] генератор"]."
	if(miner_repairs_performed)
		support_stats += "Буры были отремонтированы [miner_repairs_performed] раз."
	if(apcs_repaired)
		support_stats += "Вы отремонтировали БРП [apcs_repaired] раз."

	if(generator_sabotages_performed)
		support_stats += "Вы произвели  [generator_sabotages_performed != 1 ? "[generator_sabotages_performed] саботажей генераторов" : "[generator_sabotages_performed] саботаж генераторов"]."
	if(miner_sabotages_performed)
		support_stats += "Вы произвели  [miner_sabotages_performed != 1 ? "[miner_sabotages_performed] саботажей генераторов" : "[miner_sabotages_performed] саботаж генераторов"]."
	if(apcs_slashed)
		support_stats += "Вы вывели из строя [apcs_slashed] БРП."

	if(artillery_fired)
		support_stats += "Вы выстрелили из артиллерии [artillery_fired] раз."

	if(req_points_used)
		support_stats += "Вы потратили [req_points_used] очков карго."

	if(drained)
		support_stats += "Вы истощили силы морпехов [drained] раз."
	if(cocooned)
		support_stats += "Вы завернули в кокон [cocooned] морпехов."
	if(recycle_points_denied)
		support_stats += "Вы утилизировали [recycle_points_denied] сестер. Помогать улью можно и после смерти."
	if(huggers_created)
		support_stats += "Вы выносили [huggers_created] лицехватов."
	if(impregnations)
		support_stats += "Вы заразили морпехов [impregnations] раз."

	if(LAZYLEN(support_stats))
		stats += "<hr>"
		stats += support_stats

	//Close air support
	var/list/cas_stats = list()
	if(cas_cannon_shots)
		cas_stats += "Вы сделали [cas_cannon_shots] заходов на GAU-21."
	if(cas_laser_shots)
		cas_stats += "Вы выжгли поле боя высокомощным лазером [cas_laser_shots] раз."
	if(cas_minirockets_fired)
		cas_stats += "Вы запустили [cas_minirockets_fired] неуправляемых ракет воздух-земля."
	if(cas_rockets_fired)
		cas_stats += "Вы запустили [cas_rockets_fired] управляемых ракет класса воздух-земля."
	if(cas_points_used)
		cas_stats += "Вы израсходовали [cas_points_used] поинтов фабрикатора."

	if(LAZYLEN(cas_stats))
		stats += "<hr>"
		stats += cas_stats

	//The funnies
	var/list/misc_stats = list()
	if(LAZYLEN(chemicals_ingested))
		misc_stats += "Больше всего вы приняли: [get_most_ingested_chemical()]"
	if(weights_lifted)
		misc_stats += "Вы сделали [weights_lifted != 1 ? "[weights_lifted] подходов на штанге лежа" : "[weights_lifted] подход на штанге лежа"]  [weights_lifted > 100 ? ". чел, харош!" : "."]"
	if(sippies)
		misc_stats += "Вы попили из фонтанчика [sippies] раз."
	if(war_crimes)
		misc_stats += "Вы совершили [war_crimes >= 10 ? "[war_crimes] военных преступлений, большой шлепа одобряет!" : "[war_crimes] военных преступлений."]"
	if(tactical_unalives)
		misc_stats += "Вы СТРАТЕГИЧЕСКИ покончили с собой [tactical_unalives] раз."

	if(LAZYLEN(misc_stats))
		stats += "<hr>"
		stats += misc_stats

	//Replace any instances of line breaks after horizontal rules to prevent unneeded empty spaces
	return replacetext(jointext(stats, "<br>"), "<hr><br>", "<hr>")



/* Not sure what folder to put a file of just record keeping procs, so just leaving them here
The alternative is scattering them everywhere under their respective objects which is a bit messy */

///Tally to personal_statistics that a melee attack took place, and record the damage dealt
/mob/living/proc/record_melee_damage(mob/living/user, damage)
	if(!user.ckey)
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[user.ckey]
	personal_statistics.melee_hits++
	personal_statistics.melee_damage += damage
	return TRUE

/mob/living/carbon/human/record_melee_damage(mob/living/user, damage, delimbed)
	. = ..()
	if(!. || !delimbed)
		return FALSE
	var/datum/personal_statistics/personal_statistics
	//Tally to the victim that they lost a limb; tally to the attacker that they delimbed someone
	if(ckey)
		personal_statistics = GLOB.personal_statistics_list[ckey]
		personal_statistics.limbs_lost++
	personal_statistics = GLOB.personal_statistics_list[user.ckey]
	personal_statistics.delimbs++
	return TRUE

///Record whenever a player shoots things, taking into account bonus projectiles without running these checks multiple times
/obj/projectile/proc/record_projectile_fire(mob/shooter)
	//Part of code where this is called already checks if the shooter is a mob
	if(!shooter.ckey)
		return FALSE

	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[shooter.ckey]
	//I am trusting that nobody makes an ammo type that fires multiple projectiles and that each of those fire multiple projectiles
	personal_statistics.projectiles_fired += 1 + ammo.bonus_projectiles_amount
	return TRUE

//Lasers have their own fire_at()
/obj/projectile/hitscan/record_projectile_fire(shooter)
	//It does not check if the shooter is a mob
	if(!ismob(shooter))
		return FALSE
	return ..()

///Tally to personal_statistics that a successful shot was made and record the damage dealt
/mob/living/proc/record_projectile_damage(damage, mob/living/victim)
	//Check if a ckey exists; the check for victim aliveness is handled before the proc call
	if(!ckey)
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[ckey]
	personal_statistics.projectiles_hit++
	personal_statistics.projectile_damage += damage
	if(faction == victim.faction)
		personal_statistics.friendly_fire_damage += damage	//FF multiplier already included by the way
	return TRUE

///Record what reagents and how much of them were transferred to a mob into their ckey's /datum/personal_statistics
/obj/item/reagent_containers/proc/record_reagent_consumption(amount, list/reagents_list, mob/user, mob/receiver)
	if(!amount || !LAZYLEN(reagents_list))
		return FALSE

	//Declare separate variables for the user and receiver's personal_statistics, then assign them or make them null if no ckey
	var/datum/personal_statistics/personal_statistics_user
	var/datum/personal_statistics/personal_statistics_receiver
	personal_statistics_user = user?.ckey ? GLOB.personal_statistics_list[user.ckey] : null
	if(user == receiver)
		receiver = null
	else
		personal_statistics_receiver = receiver?.ckey ? GLOB.personal_statistics_list[receiver.ckey] : null

	//Just give up, how did this even happen?
	if(!personal_statistics_user && !personal_statistics_receiver)
		return FALSE

	var/is_healing
	var/portion = amount / reagents.total_volume
	for(var/datum/reagent/chem in reagents_list)
		//If there is a receiving mob, let's try to record they ingested something
		if(receiver)
			if(personal_statistics_receiver)	//Only record if they have a ckey
				personal_statistics_receiver.chemicals_ingested[chem.name] += chem.volume * portion
		//If there is no receiver, that means the user is the one that needs their chems stat updated
		else
			personal_statistics_user.chemicals_ingested[chem.name] += chem.volume * portion

		//Determine if a healing chem was involved; only needs to be done once
		if(!is_healing && istype(chem, /datum/reagent/medicine))
			if(personal_statistics_user)
				//If a receiving mob exists, we tally up to the user mob's stats that it performed a heal
				if(receiver)
					personal_statistics_user.heals++
				else
					personal_statistics_user.self_heals++
			is_healing = TRUE
	return TRUE

///Determine if a self or non-self heal occurred, and tally up the user mob's respective stat
/obj/item/stack/medical/proc/record_healing(mob/living/user, mob/living/receiver)
	if(!user.ckey)
		return FALSE

	var/datum/personal_statistics/personal_statistics_user = GLOB.personal_statistics_list[user.ckey]
	if(user == receiver)
		receiver = null

	//If a receiving mob exists, we tally up to the user mob's stats that it performed a heal
	if(receiver)
		personal_statistics_user.heals++
	else
		personal_statistics_user.self_heals++
	return TRUE

///Record what was drank and if it was medicinal
/obj/machinery/deployable/reagent_tank/proc/record_sippies(amount, list/reagents_list, mob/user)
	if(!amount || !LAZYLEN(reagents_list) || !user.ckey)
		return FALSE

	var/is_healing
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[user.ckey]
	var/portion = amount / reagents.total_volume
	for(var/datum/reagent/chem in reagents_list)
		//Add the chem and amount consumed to the list
		personal_statistics.chemicals_ingested[chem.name] += chem.volume * portion
		//Determine if a healing chem was involved; only needs to be done once
		if(!is_healing && istype(chem, /datum/reagent/medicine))
			personal_statistics.self_heals++
			is_healing = TRUE
	personal_statistics.sippies++
	return TRUE

///Tally up the corresponding weapon used by the pilot into their /datum/personal_statistics
/obj/docking_port/mobile/marine_dropship/casplane/proc/record_cas_activity(obj/structure/dropship_equipment/cas/weapon/weapon)
	if(!chair.occupant.ckey)
		return FALSE

	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[chair.occupant.ckey]
	//Increment variable based on weapon type
	switch(weapon.type)
		if(/obj/structure/dropship_equipment/cas/weapon/heavygun)
			personal_statistics.cas_cannon_shots++
		if(/obj/structure/dropship_equipment/cas/weapon/heavygun/radial_cas)
			personal_statistics.cas_cannon_shots++
		if(/obj/structure/dropship_equipment/cas/weapon/laser_beam_gun)
			personal_statistics.cas_laser_shots++
		if(/obj/structure/dropship_equipment/cas/weapon/minirocket_pod)
			personal_statistics.cas_minirockets_fired++
		if(/obj/structure/dropship_equipment/cas/weapon/rocket_pod)
			personal_statistics.cas_rockets_fired++
	return TRUE

///Tally how many req-points worth of xenomorphs have been recycled
/mob/living/carbon/xenomorph/proc/record_recycle_points(mob/living/carbon/xenomorph/trash)
	if(!ckey)
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[ckey]
	personal_statistics.recycle_points_denied += trash.get_export_value()
	return TRUE

///Separate record keeping proc to reduce copy pasta
/obj/machinery/miner/proc/record_miner_repair(mob/user)
	if(!user.ckey)
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[user.ckey]
	personal_statistics.miner_repairs_performed++
	return TRUE

///Record how much time a mob was lying down for
/mob/living/proc/record_time_lying_down()
	if(!last_rested)
		return FALSE
	if(!ckey)	//Reset their time if they have no ckey
		last_rested = 0
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[ckey]
	personal_statistics.time_resting += world.time - last_rested
	return TRUE

///Record how long a mob was knocked out or sleeping
/mob/living/proc/record_time_unconscious()
	if(!last_unconscious)
		return FALSE
	if(!ckey)
		last_unconscious = 0
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[ckey]
	personal_statistics.time_unconscious += world.time - last_unconscious
	return TRUE

///Record how long a mob was in a stasis bag
/mob/living/proc/record_time_in_stasis()
	if(!time_entered_stasis)
		return FALSE
	if(!ckey)
		time_entered_stasis = 0
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[ckey]
	personal_statistics.time_in_stasis += world.time - time_entered_stasis
	return TRUE

///Record how long a mob was in a cryo tube
/mob/living/proc/record_time_in_cryo()
	if(!time_entered_cryo)
		return FALSE
	if(!ckey)
		time_entered_cryo = 0
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[ckey]
	personal_statistics.time_in_cryo += world.time - time_entered_cryo
	return TRUE

///Tally up to a player's generator_repairs_performed stat when a step is completed in a generator's repairs
/obj/machinery/power/proc/record_generator_repairs(mob/user)
	if(!user.ckey)
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[user.ckey]
	personal_statistics.generator_repairs_performed++
	return TRUE

///Tally up when a player damages/destroys/corrupts a generator
/obj/machinery/power/proc/record_generator_sabotages(mob/user)
	if(!user.ckey)
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[user.ckey]
	personal_statistics.generator_sabotages_performed++
	return TRUE

///Tally up when a player successfully completes a step
/datum/surgery_step/proc/record_surgical_operation(mob/user)
	if(!user.ckey)
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[user.ckey]
	personal_statistics.surgical_actions_performed++
	return TRUE

///Record when a bone break or internal bleeding is inflicted
/datum/species/proc/record_internal_injury(mob/living/carbon/human/victim, mob/attacker, old_status, new_status)
	if(old_status == new_status || (!victim.ckey && !attacker?.ckey))
		return FALSE

	//If neither of these flags was enabled after being damaged, then no internal injury occurred
	if(!(CHECK_BITFIELD(old_status, LIMB_BROKEN|LIMB_BLEEDING) ^ CHECK_BITFIELD(new_status, LIMB_BROKEN|LIMB_BLEEDING)))
		return FALSE

	if(victim.ckey)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[victim.ckey]
		personal_statistics.internal_injuries++
	if(attacker?.ckey)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[attacker.ckey]
		personal_statistics.internal_injuries_inflicted++
	return TRUE

///Short proc that tallies up traps_created; reduce copy pasta
/mob/proc/record_traps_created()
	if(!ckey)
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[ckey]
	personal_statistics.traps_created++
	return TRUE

///Tally up bullets caught/reflected
/obj/effect/xeno/shield/proc/record_projectiles_frozen(mob/user, amount, reflected = FALSE)
	if(!user.ckey)
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[user.ckey]
	personal_statistics.projectiles_caught += amount
	if(reflected)
		personal_statistics.projectiles_reflected += amount
	return TRUE

///Tally when a structure is constructed
/mob/proc/record_structures_built()
	if(!ckey)
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[ckey]
	personal_statistics.structures_built++
	return TRUE

/mob/proc/record_war_crime()
	if(!ckey)
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[ckey]
	personal_statistics.war_crimes++
	return TRUE

/mob/proc/record_tactical_unalive()
	if(!ckey)
		return FALSE
	var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[ckey]
	personal_statistics.tactical_unalives++
	return TRUE
