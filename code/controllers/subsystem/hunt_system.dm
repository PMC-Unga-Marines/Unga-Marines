SUBSYSTEM_DEF(hunting)
	name = "hunting"
	wait = 10 MINUTES
	flags = SS_NO_INIT

	var/list/xeno_blacklist = list(
		/mob/living/carbon/xenomorph/drone,
		/mob/living/carbon/xenomorph/queen,
		/mob/living/carbon/xenomorph/king,
		/mob/living/carbon/xenomorph/shrike,
		/mob/living/carbon/xenomorph/boiler,
		/mob/living/carbon/xenomorph/hivelord,
		/mob/living/carbon/xenomorph/defiler,
		/mob/living/carbon/xenomorph/larva,
		/mob/living/carbon/xenomorph/hivemind
	)
	var/list/human_blacklist = list(
		/datum/job/terragov/squad/corpsman,
		/datum/job/terragov/medical,
	)
	var/list/human_blacklist_type = list(
		/datum/job/fallen,
		/datum/job/terragov/command,
		/datum/job/terragov/silicon
	)
	var/list/hunter_datas = list()

/datum/controller/subsystem/hunting/fire(resumed, init_tick_checks)
	for(var/datum/huntdata/data as anything in hunter_datas)
		if(data.dishonored || data.thralled)
			continue
		if(ishuman(data.owner))
			if(isyautja(data.owner))
				continue
			if(!data.owner.job || (data.owner.job.type in human_blacklist))
				continue
			var/found = FALSE
			for(var/str in human_blacklist_type)
				if(istype(data.owner.job, str))
					found = TRUE
					break
			if(found)
				continue
		else if(isxeno(data.owner))
			var/mob/living/carbon/xenomorph/xeno = data.owner
			if(xeno.hive == XENO_HIVE_FALLEN)
				continue
			var/number_tier = GLOB.tier_as_number[xeno.tier]
			if(number_tier <= 0 || (xeno.type in xeno_blacklist))
				continue
		else
			continue
		if(data.owner.stat || !data.honored && data.owner.life_kills_total < 2 || data.owner.life_value == 0) // Don't make zero kills xeno as target for additional honor or stunned/dead
			continue
		if(prob(80)) // nah
			continue

		for(var/mob/living/carbon/pred in GLOB.yautja_mob_list)
			if(pred.stat || !pred.hunter_data)
				continue
			if(length(pred.hunter_data.targets) > 4)
				continue
			data.automatic_target = TRUE
			data.targeted = pred
			pred.hunter_data.targets += data
			hunter_datas -= data
			break

/datum/controller/subsystem/hunting/Recover()
	hunter_datas = SShunting.hunter_datas
	return ..()
