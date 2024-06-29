/client
	var/datum/db_query/clan_info

/client/proc/load_player_predator_info()
	set waitfor = FALSE

	if(!SSdbcore.IsConnected())
		return // Urgle test without DB... don't make runtime

	if(GLOB.roles_whitelist[ckey] & WHITELIST_PREDATOR)
		if(!update_clan_info())
			return

		if(GLOB.roles_whitelist[ckey] & WHITELIST_YAUTJA_LEADER)
			clan_info.item[2] = CLAN_RANK_ADMIN_INT
			clan_info.item[3] |= CLAN_PERMISSION_ALL
		else
			clan_info.item[3] &= ~CLAN_PERMISSION_ADMIN_MANAGER // Only the leader can manage the ancients

		clan_info.sql = "UPDATE [format_table_name("clan_player")] SET clan_rank = :clan_rank, permissions = :permissions WHERE byond_ckey = :byond_ckey"
		clan_info.arguments = list("byond_ckey" = ckey, "clan_rank" = clan_info.item[2], "permissions" = clan_info.item[3])
		clan_info.Execute()

		clan_info.sql = "SELECT byond_ckey, clan_rank, permissions, clan_id, honor FROM [format_table_name("clan_player")] WHERE byond_ckey = :byond_ckey"
		clan_info.arguments = list("byond_ckey" = ckey)
		if(!clan_info.warn_execute())
			qdel(clan_info)
			return
		clan_info.next_row_to_take = 1
		clan_info.NextRow()

/client/proc/update_clan_info()
	if(!SSdbcore.IsConnected())
		return // Urgle test without DB... don't make runtime
	if(GLOB.roles_whitelist[ckey] & WHITELIST_PREDATOR)
		if(clan_info)
			clan_info.sql = "SELECT byond_ckey, clan_rank, permissions, clan_id, honor FROM [format_table_name("clan_player")] WHERE byond_ckey = :byond_ckey"
			clan_info.arguments = list("byond_ckey" = ckey)
			clan_info.next_row_to_take = 1
		else
			clan_info = SSdbcore.NewQuery("SELECT byond_ckey, clan_rank, permissions, clan_id, honor FROM [format_table_name("clan_player")] WHERE byond_ckey = :byond_ckey", list("byond_ckey" = ckey))
			clan_info.no_auto_delete = TRUE
			if(!clan_info.warn_execute())
				qdel(clan_info)
				return FALSE

		if(!clan_info.NextRow())
			clan_info.sql = "INSERT INTO [format_table_name("clan_player")] (byond_ckey, clan_rank, permissions, clan_id, honor) VALUES (:byond_ckey, 0, 0, 0, 0)"
			clan_info.Execute()
			clan_info.sql = "SELECT byond_ckey, clan_rank, permissions, clan_id, honor FROM [format_table_name("clan_player")] WHERE byond_ckey = :byond_ckey"
			if(!clan_info.warn_execute())
				qdel(clan_info)
				return FALSE

			clan_info.next_row_to_take = 1
			clan_info.NextRow()

		return TRUE
	else
		return FALSE

/client/proc/usr_create_new_clan()
	set name = "Create New Clan"
	set category = "Debug"

	if(!SSdbcore.IsConnected())
		return

	if(!istype(clan_info))
		return

	if(!(clan_info.item[3] & CLAN_PERMISSION_ADMIN_MANAGER))
		return

	var/input = tgui_input_text(src, "Set name to clan", "Clan Name")

	if(!input)
		return

	to_chat(src, span_notice("Made a new clan called: [input]"))

	create_new_clan(input)

/client/verb/view_clan_info()
	set name = "View Clan Info"
	set category = "OOC"

	if(!istype(clan_info))
		to_chat(src, span_warning("You don't have a yautja whitelist!"))
		return

	if(!has_clan_permission(CLAN_PERMISSION_VIEW))
		return

	var/clan_to_get
	if(clan_info.item[3] & CLAN_PERMISSION_ADMIN_VIEW)
		var/datum/db_query/db_clans = SSdbcore.NewQuery("SELECT id, name, description, honor, color FROM [format_table_name("clan")]")
		if(!db_clans.warn_execute())
			qdel(db_clans)
			return
		var/list/clans = list()
		while(db_clans.NextRow())
			clans += list("[db_clans.item[2]]" = db_clans.item[1])

		qdel(db_clans)

		clans += list("People without clans" = null)

		var/input = tgui_input_list(src, "Choose the clan to view", "View clan", clans)

		if(!input)
			to_chat(src, span_warning("Couldn't find any clans for you to view!"))
			return

		clan_to_get = clans[input]
	else if(clan_info.item[4])

		var/options = list(
			"Your clan" = clan_info.item[4],
			"People without clans" = null
		)

		var/input = tgui_input_list(src, "Choose the clan to view", "View clan", options)

		if(!input)
			return

		clan_to_get = options[input]
	else
		clan_to_get = null

	SSpredships.clan_ui.clan_id_by_user[mob] = clan_to_get

	SSpredships.clan_ui.ui_interact(mob)

/client/proc/has_clan_permission(permission_flag, clan_id, warn = TRUE)
	if(!update_clan_info() || !istype(clan_info) || length(clan_info.item) != 5)
		if(warn)
			to_chat(src, "You do not have a yautja whitelist!")
		return FALSE

	if(clan_id)
		if(clan_id != clan_info.item[4])
			if(warn)
				to_chat(src, "You do not have permission to perform actions on this clan!")
			return FALSE


	if(!(clan_info.item[3] & permission_flag))
		if(warn)
			to_chat(src, "You do not have the necessary permissions to perform this action!")
		return FALSE

	return TRUE

/client/proc/add_honor(number)
	if(!istype(clan_info))
		return FALSE

	clan_info.sql = "UPDATE [format_table_name("clan_player")] SET honor = :honor WHERE byond_ckey = :byond_ckey"
	clan_info.arguments = list("byond_ckey" = ckey, "honor" = number + clan_info.item[5])
	clan_info.Execute()

	clan_info.sql = "SELECT byond_ckey, clan_rank, permissions, clan_id, honor FROM [format_table_name("clan_player")] WHERE byond_ckey = :byond_ckey"
	clan_info.arguments = list("byond_ckey" = ckey)
	if(!clan_info.warn_execute())
		return
	clan_info.next_row_to_take = 1
	clan_info.NextRow()

	if(clan_info.item[4])
		var/datum/db_query/target_clan = SSdbcore.NewQuery("SELECT id, name, description, honor, color FROM [format_table_name("clan")] WHERE id = :clan_id", list("clan_id" = clan_info.item[4]))
		if(!target_clan.warn_execute())
			return
		target_clan.NextRow()
		target_clan.sql = "UPDATE [format_table_name("clan")] SET honor = :honor WHERE id = :clan_id"
		target_clan.arguments = list("clan_id" = clan_info.item[4], "honor" = number + target_clan.item[4])
		target_clan.Execute()
		qdel(target_clan)

	return TRUE
