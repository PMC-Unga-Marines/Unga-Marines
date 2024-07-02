SUBSYSTEM_DEF(predships)
	name   = "PredShips"
	init_order = INIT_ORDER_PREDSHIPS
	flags  = SS_NO_FIRE

	var/datum/map_template/ship_template // Current ship template in use
	var/list/list/managed_z   // Maps initating clan id to list(datum/space_level, list/turf(spawns))
	var/list/turf/spawnpoints // List of all spawn landmark locations
	/* Note we map clan_id as string due to legacy code using them internally */

	var/datum/clan_ui/clan_ui = new

/datum/controller/subsystem/predships/Initialize(timeofday)
	if(!ship_template)
		ship_template = new /datum/map_template(HUNTERSHIPS_TEMPLATE_PATH, cache = TRUE)
	LAZYINITLIST(managed_z)
	load_new(CLAN_SHIP_PUBLIC)
	return SS_INIT_SUCCESS

/datum/controller/subsystem/predships/proc/init_spawnpoint(obj/effect/landmark/clan_spawn/clan_spawn)
	LAZYADD(spawnpoints, get_turf(clan_spawn))

/datum/controller/subsystem/predships/proc/get_clan_spawnpoints(clan_id)
	RETURN_TYPE(/list/turf)
	if(isnum(clan_id))
		clan_id = "[clan_id]"
	if(clan_id in managed_z)
		return managed_z[clan_id][2]

/datum/controller/subsystem/predships/proc/is_clanship_loaded(clan_id)
	if(isnum(clan_id))
		clan_id = "[clan_id]"
	if((clan_id in managed_z) && managed_z[clan_id][2])
		return TRUE
	return FALSE

/datum/controller/subsystem/predships/proc/load_new(initiating_clan_id)
	RETURN_TYPE(/list)
	if(isnum(initiating_clan_id))
		initiating_clan_id = "[initiating_clan_id]"
	if(!ship_template || !initiating_clan_id)
		return NONE
	if(initiating_clan_id in managed_z)
		return managed_z[initiating_clan_id]
	var/datum/space_level/level = ship_template.load_new_z()
	if(level)
		var/new_z = level.z_value
		var/list/turf/new_spawns = list()
		SSminimaps.add_zlevel(new_z)
		for(var/turf/spawnpoint in spawnpoints)
			if(spawnpoint?.z == new_z)
				new_spawns += spawnpoint
		managed_z[initiating_clan_id] = list(level, new_spawns)
	return managed_z[initiating_clan_id]

/datum/clan_ui
	var/list/clan_id_by_user = list()

/datum/clan_ui/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ClanMenu", "Clan Menu")
		ui.open()
		ui.set_autoupdate(TRUE)

/datum/clan_ui/ui_data(mob/user)
	. = list()

	var/datum/db_query/clan
	var/datum/db_query/clan_players
	var/clan_to_get = clan_id_by_user[user]

	if(clan_to_get)
		clan = SSdbcore.NewQuery("SELECT id, name, description, honor, color FROM [format_table_name("clan")] WHERE id = :clan_id", list("clan_id" = clan_to_get))
		if(!clan.warn_execute())
			qdel(clan_players)
			return
		if(!clan.NextRow())
			qdel(clan)

	clan_players = SSdbcore.NewQuery("SELECT byond_ckey, clan_rank, permissions, clan_id, honor FROM [format_table_name("clan_player")] WHERE clan_id = :clan_id", list("clan_id" = clan ? clan.item[1] : 0))

	if(!clan_players.warn_execute())
		qdel(clan_players)
		return

	//safety, if something went wrong
	var/player_rank = 1
	var/player_permissions = 0

	if(user.client?.clan_info && length(user.client.clan_info.item))
		player_rank = user.client.clan_info.item[2]
		player_permissions = user.client.clan_info.item[3]

		if(player_permissions & CLAN_PERMISSION_ADMIN_MANAGER)
			player_rank = 999 // Target anyone except other managers

	if(clan)
		. += list(
			clan_id = clan.item[1],
			clan_name = html_encode(clan.item[2]),
			clan_description = html_encode(clan.item[3]),
			clan_honor = clan.item[4],
			clan_keys = list(),

			player_rank_pos = player_rank,

			player_delete_clan = (player_permissions & CLAN_PERMISSION_ADMIN_MANAGER),
			player_sethonor_clan = (player_permissions & CLAN_PERMISSION_ADMIN_MANAGER),
			player_setcolor_clan = (player_permissions & CLAN_PERMISSION_ADMIN_MODIFY),

			player_rename_clan = (player_permissions & CLAN_PERMISSION_ADMIN_MODIFY),
			player_setdesc_clan = (player_permissions & CLAN_PERMISSION_MODIFY),
			player_modify_ranks = (player_permissions & CLAN_PERMISSION_MODIFY),

			player_purge = (player_permissions & CLAN_PERMISSION_ADMIN_MANAGER),
			player_move_clans = (player_permissions & CLAN_PERMISSION_ADMIN_MOVE)
		)
	else
		. += list(
			clan_id = null,
			clan_name = "Players without a clan",
			clan_description = "This is a list of players without a clan",
			clan_honor = null,
			clan_keys = list(),

			player_rank_pos = player_rank,

			player_delete_clan = FALSE,
			player_sethonor_clan = FALSE,
			player_setcolor_clan = FALSE,

			player_rename_clan = FALSE,
			player_setdesc_clan = FALSE,
			player_modify_ranks = FALSE,

			player_purge = (player_permissions & CLAN_PERMISSION_ADMIN_MANAGER),
			player_move_clans = (player_permissions & CLAN_PERMISSION_ADMIN_MOVE)
		)

	while(clan_players.NextRow())
		var/clan_rank = clan_players.item[2] > 0 && clan_players.item[2] <= GLOB.clan_ranks_ordered.len ? GLOB.clan_ranks_ordered[clan_players.item[2]] : GLOB.clan_ranks_ordered[1]
		.["clan_keys"] += list(list(
			name = clan_players.item[1],
			rank = clan_rank, // rank_to_give not used here, because we need to get their visual rank, not their position
			rank_pos = clan_players.item[3] & CLAN_PERMISSION_ADMIN_MANAGER ? 999 : clan_players.item[2],
			honor = clan_players.item[5]
		))

	qdel(clan)
	qdel(clan_players)

/datum/clan_ui/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/mob/user = usr

	if(!user.client.clan_info)
		return

	user.client.clan_info.sql = "SELECT byond_ckey, clan_rank, permissions, clan_id, honor FROM [format_table_name("clan_player")] WHERE byond_ckey = :byond_ckey"
	if(!user.client.clan_info.warn_execute())
		return
	user.client.clan_info.next_row_to_take = 1
	user.client.clan_info.NextRow()

	var/clan_id = clan_id_by_user[user]
	var/datum/db_query/db_query = SSdbcore.NewQuery()
	db_query.no_auto_delete = TRUE

	addtimer(CALLBACK(db_query, GLOBAL_PROC_REF(qdel), db_query), 10 MINUTES)

	switch(action)
		if(CLAN_ACTION_CLAN_RENAME)
			db_query.sql = "SELECT id, name, description, honor, color FROM [format_table_name("clan")] WHERE id = :clan_id"
			db_query.arguments = list("clan_id" = params["clan_id"])
			if(!db_query.warn_execute())
				return
			db_query.NextRow()
			if(!user.client.has_clan_permission(CLAN_PERMISSION_ADMIN_MODIFY))
				return

			var/input = input(user, "Input the new name", "Set Name", db_query.item[2]) as text|null

			if(!input || input == db_query.item[2])
				return


			log_admin("[key_name_admin(user)] has set the name of [db_query.item[2]] to [input].")
			to_chat(user, span_notice("Set the name of [db_query.item[2]] to [input]."))

			db_query.sql = "UPDATE [format_table_name("clan")] SET name = :name WHERE id = :clan_id"
			db_query.arguments = list("clan_id" = clan_id, "name" = trim(input))
			if(!db_query.warn_execute())
				return

		if(CLAN_ACTION_CLAN_SETDESC)
			db_query.sql = "SELECT id, name, description, honor, color FROM [format_table_name("clan")] WHERE id = :clan_id"
			db_query.arguments = list("clan_id" = params["clan_id"])
			if(!db_query.warn_execute())
				return
			db_query.NextRow()
			if(!user.client.has_clan_permission(CLAN_PERMISSION_USER_MODIFY))
				return

			var/input = input(usr, "Input a new description", "Set Description", db_query.item[3]) as message|null

			if(!input || input == db_query.item[3])
				return

			log_admin("[key_name_admin(user)] has set the description of [db_query.item[2]].")
			to_chat(user, span_notice("Set the description of [db_query.item[2]]."))

			db_query.sql = "UPDATE [format_table_name("clan")] SET description = :description WHERE id = :clan_id"
			db_query.arguments = list("clan_id" = clan_id, "description" = trim(input))
			if(!db_query.warn_execute())
				return

		if(CLAN_ACTION_CLAN_SETCOLOR)
			db_query.sql = "SELECT id, name, description, honor, color FROM [format_table_name("clan")] WHERE id = :clan_id"
			db_query.arguments = list("clan_id" = params["clan_id"])
			if(!db_query.warn_execute())
				return
			db_query.NextRow()
			if(!user.client.has_clan_permission(CLAN_PERMISSION_ADMIN_MODIFY))
				return

			var/color = input(usr, "Input a new color", "Set Color", db_query.item[5]) as color|null

			if(!color || color == db_query.item[5])
				return

			log_admin("[key_name_admin(user)] has set the color of [db_query.item[2]] to [color].")
			to_chat(user, span_notice("Set the name of [db_query.item[2]] to [color]."))

			db_query.sql = "UPDATE [format_table_name("clan")] SET color = :color WHERE id = :clan_id"
			db_query.arguments = list("clan_id" = clan_id, "color" = color)
			db_query.Execute()

		if(CLAN_ACTION_CLAN_SETHONOR)
			db_query.sql = "SELECT id, name, description, honor, color FROM [format_table_name("clan")] WHERE id = :clan_id"
			db_query.arguments = list("clan_id" = params["clan_id"])
			if(!db_query.warn_execute())
				return
			db_query.NextRow()
			if(!user.client.has_clan_permission(CLAN_PERMISSION_ADMIN_MANAGER))
				return

			var/input = tgui_input_number(user, "Input the new honor", "Set Honor", db_query.item[4])

			if((!input && input != 0) || input == db_query.item[4])
				return

			log_admin("[key_name_admin(user)] has set the honor of clan [db_query.item[2]] from [db_query.item[4]] to [input].")
			to_chat(user, span_notice("Set the honor of [db_query.item[2]] from [db_query.item[4]] to [input]."))

			db_query.sql = "UPDATE [format_table_name("clan")] SET honor = :honor WHERE id = :clan_id"
			db_query.arguments = list("clan_id" = clan_id, "honor" = input)
			db_query.Execute()

		if(CLAN_ACTION_CLAN_DELETE)
			db_query.sql = "SELECT id, name, description, honor, color FROM [format_table_name("clan")] WHERE id = :clan_id"
			db_query.arguments = list("clan_id" = params["clan_id"])
			if(!db_query.warn_execute())
				return
			db_query.NextRow()
			if(!user.client.has_clan_permission(CLAN_PERMISSION_ADMIN_MANAGER))
				return

			var/input = input(user, "Please input the name of the clan to proceed.", "Delete Clan") as text|null

			if(input != db_query.item[2])
				to_chat(user, "You have decided not to delete [db_query.item[2]].")
				return

			log_admin("[key_name_admin(user)] has deleted the clan [db_query.item[2]].")
			to_chat(user, span_notice("You have deleted [db_query.item[2]]."))

			db_query.sql = "UPDATE [format_table_name("clan_player")] SET clan_id = 0 WHERE clan_id = :clan_id"
			db_query.arguments = list("clan_id" = clan_id)
			db_query.Execute()

			db_query.sql = "DELETE FROM [format_table_name("clan")] WHERE id = :clan_id"
			db_query.arguments = list("clan_id" = clan_id)
			db_query.Execute()

			clan_id_by_user[user] = null

		if(CLAN_ACTION_PLAYER_PURGE)
			db_query.sql = "SELECT byond_ckey, clan_rank, permissions, clan_id, honor FROM [format_table_name("clan_player")] WHERE byond_ckey = :byond_ckey"
			db_query.arguments = list("byond_ckey" = params["ckey"])
			if(!db_query.warn_execute())
				return
			db_query.NextRow()
			var/player_rank = user.client.clan_info.item[2]
			if(user.client.has_clan_permission(CLAN_PERMISSION_ADMIN_MANAGER, warn = FALSE))
				player_rank = 999

			if((db_query.item[3] & CLAN_PERMISSION_ADMIN_MANAGER) || player_rank <= db_query.item[2])
				to_chat(user, span_danger("You can't target this person!"))
				return

			if(!user.client.has_clan_permission(CLAN_PERMISSION_ADMIN_MANAGER))
				return

			var/input = input(user, "Are you sure you want to purge this person? Type '[db_query.item[1]]' to purge", "Confirm Purge") as text|null

			if(!input || input != db_query.item[1])
				return

			log_admin("[key_name_admin(user)] has purged [db_query.item[1]]'s clan profile.")
			to_chat(user, span_notice("You have purged [db_query.item[1]]'s clan profile."))

			db_query.sql = "DELETE FROM [format_table_name("clan_player")] WHERE byond_ckey = :byond_ckey"
			db_query.arguments = list("byond_ckey" = params["ckey"])
			db_query.Execute()

		if(CLAN_ACTION_PLAYER_MOVECLAN)
			db_query.sql = "SELECT byond_ckey, clan_rank, permissions, clan_id, honor FROM [format_table_name("clan_player")] WHERE byond_ckey = :byond_ckey"
			db_query.arguments = list("byond_ckey" = params["ckey"])
			if(!db_query.warn_execute())
				return
			db_query.NextRow()
			var/player_rank = user.client.clan_info.item[2]
			if(user.client.has_clan_permission(CLAN_PERMISSION_ADMIN_MANAGER, warn = FALSE))
				player_rank = 999

			if((db_query.item[3] & CLAN_PERMISSION_ADMIN_MANAGER) || player_rank <= db_query.item[2])
				to_chat(user, span_danger("You can't target this person!"))
				return

			if(!user.client.has_clan_permission(CLAN_PERMISSION_ADMIN_MOVE))
				return

			var/datum/db_query/db_clans = SSdbcore.NewQuery("SELECT id, name, description, honor, color FROM [format_table_name("clan")]")
			if(!db_clans.warn_execute())
				qdel(db_clans)
				return
			var/list/clans = list()
			while(db_clans.NextRow())
				clans += list("[db_clans.item[2]]" = db_clans.item[1])

			qdel(db_clans)

			var/is_clan_manager = user.client.has_clan_permission(CLAN_PERMISSION_ADMIN_MANAGER, warn = FALSE)
			if(is_clan_manager && clans.len >= 1)
				if(db_query.item[3] & CLAN_PERMISSION_ADMIN_ANCIENT)
					clans += list("Remove from Ancient")
				else
					clans += list("Make Ancient")

			if(db_query.item[4])
				clans += list("Remove from clan")

			var/input = tgui_input_list(user, "Choose the clan to put them in", "Change player's clan", clans)

			if(!input)
				return

			if(input == "Remove from clan" && db_query.item[4])
				to_chat(user, span_notice("Removed [db_query.item[1]] from their clan."))
				log_admin("[key_name_admin(user)] has removed [db_query.item[1]] from their current clan.")

				db_query.sql = "UPDATE [format_table_name("clan_player")] SET clan_rank = :clan_rank, clan_id = 0 WHERE byond_ckey = :byond_ckey"
				db_query.arguments = list("byond_ckey" = params["ckey"], "clan_rank" = GLOB.clan_ranks_ordered[CLAN_RANK_YOUNG])
				db_query.Execute()

			else if(input == "Remove from Ancient")
				to_chat(user, span_notice("Removed [db_query.item[1]] from ancient."))
				log_admin("[key_name_admin(user)] has removed [db_query.item[1]] from ancient.")

				db_query.sql = "UPDATE [format_table_name("clan_player")] SET clan_rank = :clan_rank, permissions = :permissions WHERE byond_ckey = :byond_ckey"
				db_query.arguments = list("byond_ckey" = params["ckey"], "clan_rank" = GLOB.clan_ranks_ordered[CLAN_RANK_YOUNG], "permissions" = GLOB.clan_ranks[CLAN_RANK_YOUNG].permissions)
				db_query.Execute()

			else if(input == "Make Ancient" && is_clan_manager)
				to_chat(user, span_notice("Made [db_query.item[1]] an ancient."))
				log_admin("[key_name_admin(user)] has made [db_query.item[1]] an ancient.")

				db_query.sql = "UPDATE [format_table_name("clan_player")] SET clan_rank = :clan_rank, permissions = :permissions WHERE byond_ckey = :byond_ckey"
				db_query.arguments = list("byond_ckey" = params["ckey"], "clan_rank" = GLOB.clan_ranks_ordered[CLAN_RANK_ADMIN], "permissions" = CLAN_PERMISSION_ADMIN_ANCIENT)
				db_query.Execute()

			else
				to_chat(user, span_notice("Moved [db_query.item[1]] to [input]."))
				log_admin("[key_name_admin(user)] has moved [db_query.item[1]] to clan [input].")

				if(!(db_query.item[3] & CLAN_PERMISSION_ADMIN_ANCIENT))
					db_query.sql = "UPDATE [format_table_name("clan_player")] SET clan_rank = :clan_rank, permissions = :permissions WHERE byond_ckey = :byond_ckey"
					db_query.arguments = list("byond_ckey" = params["ckey"], "clan_rank" = GLOB.clan_ranks_ordered[CLAN_RANK_BLOODED], "permissions" = GLOB.clan_ranks[CLAN_RANK_BLOODED].permissions)
					db_query.Execute()

				db_query.sql = "UPDATE [format_table_name("clan_player")] SET clan_id = :clan_id WHERE byond_ckey = :byond_ckey"
				db_query.arguments = list("byond_ckey" = params["ckey"], "clan_id" = clans[input])
				db_query.Execute()

		if(CLAN_ACTION_PLAYER_MODIFYRANK)
			db_query.sql = "SELECT byond_ckey, clan_rank, permissions, clan_id, honor FROM [format_table_name("clan_player")] WHERE byond_ckey = :byond_ckey"
			db_query.arguments = list("byond_ckey" = params["ckey"])
			if(!db_query.warn_execute())
				return
			db_query.NextRow()
			var/player_rank = user.client.clan_info.item[2]
			if(user.client.has_clan_permission(CLAN_PERMISSION_ADMIN_MANAGER, warn = FALSE))
				player_rank = 999

			if((db_query.item[3] & CLAN_PERMISSION_ADMIN_MANAGER) || player_rank <= db_query.item[2])
				to_chat(user, span_danger("You can't target this person!"))
				return

			if(!db_query.item[4])
				to_chat(user, span_warning("This player doesn't belong to a clan!"))
				return

			var/list/datum/yautja_rank/ranks = GLOB.clan_ranks.Copy()
			ranks -= CLAN_RANK_ADMIN // Admin rank should not and cannot be obtained from here

			var/datum/yautja_rank/chosen_rank
			if(user.client.has_clan_permission(CLAN_PERMISSION_ADMIN_MODIFY, warn = FALSE))
				var/input = tgui_input_list(user, "Select the rank to change this user to.", "Select Rank", ranks)

				if(!input)
					return

				chosen_rank = ranks[input]

			else if(user.client.has_clan_permission(CLAN_PERMISSION_USER_MODIFY, user.client.clan_info.item[4]))
				for(var/rank in ranks)
					if(!user.client.has_clan_permission(ranks[rank].permission_required, warn = FALSE))
						ranks -= rank

				var/input = tgui_input_list(user, "Select the rank to change this user to.", "Select Rank", ranks)

				if(!input)
					return

				chosen_rank = ranks[input]

				if(chosen_rank.limit_type)
					db_query.sql = "SELECT byond_ckey, clan_rank, permissions, clan_id, honor FROM [format_table_name("clan_player")] WHERE clan_id = :clan_id AND clan_rank = :clan_rank"
					db_query.arguments = list("clan_id" = clan_id, "clan_rank" = GLOB.clan_ranks_ordered[input])
					db_query.Execute()

					var/players_in_rank = length(db_query.rows)
					switch(chosen_rank.limit_type)
						if(CLAN_LIMIT_NUMBER)
							if(players_in_rank >= chosen_rank.limit)
								to_chat(user, span_danger("This slot is full! (Maximum of [chosen_rank.limit] slots)"))
								return
						if(CLAN_LIMIT_SIZE)
							db_query.sql = "SELECT byond_ckey, clan_rank, permissions, clan_id, honor FROM [format_table_name("clan_player")] WHERE clan_id = :clan_id"
							db_query.arguments = list("clan_id" = clan_id)
							db_query.Execute()
							var/available_slots = length(db_query.rows) / chosen_rank.limit

							if(players_in_rank >= available_slots)
								to_chat(user, span_danger("This slot is full! (Maximum of [chosen_rank.limit] per player in the clan, currently [available_slots])"))
								return


			else
				return // Doesn't have permission to do this

			if(!user.client.has_clan_permission(chosen_rank.permission_required)) // Double check
				return

			log_admin("[key_name_admin(user)] has set the rank of [db_query.item[1]] to [chosen_rank.name] for their clan.")
			to_chat(user, span_notice("Set [db_query.item[1]]'s rank to [chosen_rank.name]"))

			db_query.sql = "UPDATE [format_table_name("clan_player")] SET clan_rank = :clan_rank, permissions = :permissions WHERE byond_ckey = :byond_ckey"
			db_query.arguments = list("byond_ckey" = params["ckey"], "clan_rank" = GLOB.clan_ranks_ordered[chosen_rank.name], "permissions" = chosen_rank.permissions)
			db_query.Execute()

/datum/clan_ui/ui_status(mob/user, datum/ui_state/state)
	return UI_INTERACTIVE
