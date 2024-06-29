/datum/job
	var/list/datum/outfit/gear_preset_whitelist = list()//Gear preset name used for council snowflakes ;)

/datum/job/proc/get_whitelist_status(list/roles_whitelist, client/player)
	if(!roles_whitelist)
		return FALSE

	return WHITELIST_NORMAL
