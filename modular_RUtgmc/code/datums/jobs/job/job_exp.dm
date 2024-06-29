/client/proc/facehugger_exp_update(stat = 0)
	if(!CONFIG_GET(flag/use_exp_tracking))
		return -1
	if(!SSdbcore.Connect())
		return -1
	if(!isnum(stat) || !stat)
		return -1

	LAZYINITLIST(GLOB.exp_to_update)
	GLOB.exp_to_update.Add(list(list(
			"job" = EXP_TYPE_FACEHUGGER_STAT,
			"ckey" = ckey,
			"minutes" = stat)))
	prefs.exp[EXP_TYPE_FACEHUGGER_STAT] += stat

/proc/get_exp_format(expnum)
	if(expnum > 60)
		if(round(expnum % 60) > 0)
			return num2text(round(expnum / 60)) + "h" + num2text(round(expnum % 60)) + "m"
		else
			return num2text(round(expnum / 60)) + "h"
	else if(expnum > 0)
		return num2text(expnum) + "m"
	else
		return "0h"

/client/get_exp_report()
	if(!CONFIG_GET(flag/use_exp_tracking))
		return "Tracking is disabled in the server configuration file."
	var/list/play_records = prefs.exp
	if(!length(play_records))
		set_exp_from_db()
		play_records = prefs.exp
		if(!length(play_records))
			return "[key] has no records."
	var/return_text = list()
	return_text += "<UL>"
	var/list/exp_data = list()
	for(var/category in SSjob.name_occupations)
		if(!(category in GLOB.jobs_regular_all))
			continue
		if(play_records[category])
			exp_data[category] = text2num(play_records[category])
		else
			exp_data[category] = 0
	for(var/category in GLOB.exp_specialmap)
		if(category == EXP_TYPE_XENO)
			if(GLOB.exp_specialmap[category])
				for(var/innercat in GLOB.exp_specialmap[category])
					if(play_records[innercat])
						exp_data[innercat] = text2num(play_records[innercat])
					else
						exp_data[innercat] = 0
		else
			if(play_records[category])
				exp_data[category] = text2num(play_records[category])
			else
				exp_data[category] = 0

	for(var/dep in exp_data)
		if(exp_data[dep] <= 0)
			continue
		if(exp_data[EXP_TYPE_LIVING] > 0 && (dep == EXP_TYPE_GHOST || dep == EXP_TYPE_LIVING))
			var/percentage = num2text(round(exp_data[dep] / (exp_data[EXP_TYPE_LIVING] + exp_data[EXP_TYPE_GHOST])  * 100))
			return_text += "<LI>[dep] [get_exp_format(exp_data[dep])] ([percentage]%) total.</LI>"
		else if(exp_data[EXP_TYPE_LIVING] > 0 && dep != EXP_TYPE_ADMIN)
			var/percentage = num2text(round(exp_data[dep] / exp_data[EXP_TYPE_LIVING] * 100))
			return_text += "<LI>[dep] [get_exp_format(exp_data[dep])] ([percentage]%) while alive.</LI>"
		else
			return_text += "<LI>[dep] [get_exp_format(exp_data[dep])] </LI>"

	for(var/mob_type AS in GLOB.xeno_caste_datums)
		var/datum/xeno_caste/caste_type = GLOB.xeno_caste_datums[mob_type][XENO_UPGRADE_BASETYPE]
		return_text += "<LI>[caste_type.caste_name] [get_exp_format(play_records[caste_type.caste_name])] while alive.</LI>"
	return return_text
