#define STARTUP_STAGE 1
#define MAIN_STAGE 2
#define WIND_DOWN_STAGE 3
#define END_STAGE 4

//Used for all kinds of weather, ex. lavaland ash storms.
SUBSYSTEM_DEF(weather)
	name = "Weather"
	flags = SS_BACKGROUND
	wait = 10
	runlevels = RUNLEVEL_GAME
	var/list/processing = list()
	var/list/eligible_zlevels = list()
	var/list/next_hit_by_zlevel = list() //Used by barometers to know when the next storm is coming
	var/list/last_weather_by_zlevel = list()

/datum/controller/subsystem/weather/fire()
	// process active weather
	for(var/V in processing)
		var/datum/weather/W = V
		if(W.aesthetic || W.stage != MAIN_STAGE)
			continue
		for(var/i in GLOB.mob_living_list)
			var/mob/living/L = i
			if(W.can_weather_act(L))
				W.weather_act(L)

	// start random weather on relevant levels
	for(var/z in eligible_zlevels)
		var/list/possible_weather = deep_copy_list(eligible_zlevels[z])
		var/datum/weather/W = last_weather_by_zlevel[z]
		if(!isnull(W) && !initial(W.repeatable))
			possible_weather -= last_weather_by_zlevel[z]
		W = pickweight(possible_weather)
		last_weather_by_zlevel[z] = W
		run_weather(W, list(text2num(z)))
		var/randTime = rand(3000, 6000)
		next_hit_by_zlevel["[z]"] = addtimer(CALLBACK(src, PROC_REF(make_eligible), z, eligible_zlevels[z]), randTime + initial(W.weather_duration_upper), TIMER_UNIQUE|TIMER_STOPPABLE) //Around 5-10 minutes between weathers
		eligible_zlevels -= z

/datum/controller/subsystem/weather/Initialize()
	for(var/V in subtypesof(/datum/weather))
		var/datum/weather/W = V
		var/probability = initial(W.probability)
		var/target_trait = initial(W.target_trait)

		// any weather with a probability set may occur at random
		if(probability)
			for(var/z in SSmapping.levels_by_trait(target_trait))
				LAZYINITLIST(eligible_zlevels["[z]"])
				eligible_zlevels["[z]"][W] = probability
	return SS_INIT_SUCCESS

///Loads weather for a particular z-level, used for late loading
/datum/controller/subsystem/weather/proc/load_late_z(z_level)
	for(var/V in subtypesof(/datum/weather))
		var/datum/weather/W = V
		var/probability = initial(W.probability)
		var/target_trait = initial(W.target_trait)

		if(!probability)
			continue
		if(z_level in SSmapping.levels_by_trait(target_trait))
			LAZYINITLIST(eligible_zlevels["[z_level]"])
			eligible_zlevels["[z_level]"][W] = probability

/datum/controller/subsystem/weather/proc/run_weather(datum/weather/weather_datum_type, z_levels)
	if(istext(weather_datum_type))
		for(var/V in subtypesof(/datum/weather))
			var/datum/weather/W = V
			if(W.name == weather_datum_type)
				weather_datum_type = V
				break
	if(!ispath(weather_datum_type, /datum/weather))
		CRASH("run_weather called with invalid weather_datum_type: [weather_datum_type || "null"]")

	if(isnull(z_levels))
		z_levels = SSmapping.levels_by_trait(weather_datum_type.target_trait)
	else if(isnum(z_levels))
		z_levels = list(z_levels)
	else if(!islist(z_levels))
		CRASH("run_weather called with invalid z_levels: [z_levels || "null"]")

	var/datum/weather/W = new weather_datum_type(z_levels)
	W.telegraph()

/datum/controller/subsystem/weather/proc/make_eligible(z, possible_weather)
	eligible_zlevels[z] = possible_weather
	next_hit_by_zlevel["[z]"] = null

/datum/controller/subsystem/weather/proc/get_weather(z, area/active_area)
	var/datum/weather/A
	for(var/V in processing)
		var/datum/weather/W = V
		if((z in W.impacted_z_levels) && W.area_type == active_area.type)
			A = W
			break
	return A
