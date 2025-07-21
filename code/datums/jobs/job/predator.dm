/datum/job/predator
	title = JOB_PREDATOR
	job_category = JOB_CAT_YAUTJA
	job_flags = JOB_FLAG_OVERRIDELATEJOINSPAWN|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_SHOW_OPEN_POSITIONS
	supervisors = "Ancients"
	outfit = /datum/outfit/job/yautja/blooded
	skills_type = /datum/skills/yautja/warrior
	faction = FACTION_YAUTJA
	minimap_icon = "predator"
	display_order = JOB_DISPLAY_ORDER_PREDATOR

	total_positions = 0
	max_positions = 0

/datum/job/predator/New()
	. = ..()
	gear_preset_whitelist = list(
		"[JOB_PREDATOR][CLAN_RANK_YOUNG]" = new /datum/outfit/job/yautja/youngblood,
		"[JOB_PREDATOR][CLAN_RANK_BLOODED]" = new /datum/outfit/job/yautja/blooded,
		"[JOB_PREDATOR][CLAN_RANK_ELITE]" = new /datum/outfit/job/yautja/elite,
		"[JOB_PREDATOR][CLAN_RANK_ELDER]" = new /datum/outfit/job/yautja/elder,
		"[JOB_PREDATOR][CLAN_RANK_LEADER]" = new /datum/outfit/job/yautja/leader,
		"[JOB_PREDATOR][CLAN_RANK_ADMIN]" = new /datum/outfit/job/yautja/ancient
	)

/datum/job/predator/return_spawn_type(datum/preferences/prefs)
	return /mob/living/carbon/human/species/yautja

/datum/job/predator/return_spawn_turf(mob/living/carbon/human/new_predator, client/player)
	var/clan_id = CLAN_SHIP_PUBLIC
	var/clan_rank = CLAN_RANK_BLOODED
	if(player.clan_info)
		clan_id = player.clan_info.item[4]
		clan_rank = player.clan_info.item[2] > 0 && player.clan_info.item[2] <= GLOB.clan_ranks_ordered.len ? GLOB.clan_ranks_ordered[player.clan_info.item[2]] : GLOB.clan_ranks_ordered[1]

	SSpredships.load_new(clan_id)
	var/turf/spawn_point = SAFEPICK(SSpredships.get_clan_spawnpoints(clan_id))
	if(!isturf(spawn_point))
		//log_debug("Failed to find spawn point for new_predator ship in transform_predator - clan_id=[clan_id]")
		to_chat(player, span_warning("Unable to setup spawn location - you might want to tell someone about this."))
		return

	if(SSticker.mode)
		SSticker.mode.initialize_predator(new_predator, player, clan_rank == CLAN_RANK_ADMIN)

	return spawn_point

/datum/job/predator/get_whitelist_status(list/roles_whitelist, client/player) // Might be a problem waiting here, but we've got no choice
	. = ..()
	if(!.)
		return

	if(!player || !player.clan_info)
		return CLAN_RANK_BLOODED

	var/title = player.clan_info.item[2] > 0 && player.clan_info.item[2] <= GLOB.clan_ranks_ordered.len ? GLOB.clan_ranks_ordered[player.clan_info.item[2]] : GLOB.clan_ranks_ordered[1]

	if(!title)
		return CLAN_RANK_BLOODED

	if(!("[JOB_PREDATOR][title]" in gear_preset_whitelist))
		return CLAN_RANK_BLOODED

	if(\
		(roles_whitelist[player.ckey] & (WHITELIST_YAUTJA_LEADER|WHITELIST_YAUTJA_COUNCIL|WHITELIST_YAUTJA_COUNCIL_LEGACY)) &&\
		get_desired_status(player.prefs.yautja_status, WHITELIST_COUNCIL) == WHITELIST_NORMAL\
	)
		return CLAN_RANK_BLOODED

	return title

/datum/job/predator/announce(mob/new_predator)
	to_chat(new_predator, span_notice("You are <B>Yautja</b>, a great and noble predator!"))
	to_chat(new_predator, span_notice("Your job is to first study your opponents. A hunt cannot commence unless intelligence is gathered."))
	to_chat(new_predator, span_notice("Hunt at your discretion, yet be observant rather than violent."))
	log_admin("([new_predator.key]) joined as Yautja, [new_predator.real_name].")
