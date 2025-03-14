/datum/admins/proc/restart()
	set category = "Server.Round"
	set name = "Restart"
	set desc = "Restarts the server after a short pause."

	if(!check_rights(R_SERVER))
		return

	if(SSticker.admin_delay_notice && tgui_alert(usr, "Are you sure? An admin has already delayed the round end for the following reason: [SSticker.admin_delay_notice]", "Confirmation", list("Yes", "No"), 0) != "Yes")
		return

	if(tgui_alert(usr, "Restart the game world?", "Restart", list("Yes", "No"), 0) != "Yes")
		return

	var/message = FALSE
	if(CONFIG_GET(string/restart_message) && tgui_alert(usr, "Send the new round message?", "Message", list("Yes", "No"), 0) == "Yes")
		message = TRUE

	to_chat(world, span_danger("Restarting world!</span> <span class='notice'>Initiated by: [usr.key]"))

	log_admin("[key_name(usr)] initiated a restart.")
	message_admins("[ADMIN_TPMONTY(usr)] initiated a restart.")

	spawn(50)
		world.Reboot(message)

/datum/admins/proc/shutdown_server()
	set category = "Server.Server"
	set name = "Shutdown Server"
	set desc = "Shuts the server down."

	var/static/shuttingdown = null
	var/static/timeouts = list()
	var/waitforroundend = FALSE
	if(!CONFIG_GET(flag/allow_shutdown))
		to_chat(usr, span_danger("This has not been enabled by the server operator."))
		return

	if(!check_rights(R_SERVER))
		return

	if(shuttingdown)
		if(tgui_alert(usr, "Are you use you want to cancel the shutdown initiated by [shuttingdown]?", "Cancel the shutdown?", list("Yes", "No"), 0) != "Yes")
			return
		message_admins("[ADMIN_TPMONTY(usr)] Cancelled the server shutdown that [shuttingdown] started.")
		timeouts[shuttingdown] = world.time
		shuttingdown = FALSE
		return

	if(timeouts[usr.ckey] && timeouts[usr.ckey] + 2 MINUTES > world.time)
		to_chat(usr, span_danger("You must wait 2 minutes after your shutdown attempt is aborted before you can try again."))
		return

	if(tgui_alert(usr, "Are you sure you want to shutdown the server? Only somebody with remote access to the server can turn it back on.", "Shutdown Server?", list("Shutdown Server", "Cancel"), 0) != "Shutdown Server")
		return

	if(!SSticker)
		if(tgui_alert(usr, "The game ticker does not exist, normal checks will be bypassed.", "Continue Shutting Down Server?", list("Continue", "Cancel"), 0) != "Continue")
			return
	else
		var/required_state_message = "The server must be in either pre-game and the start must be delayed or already started with the end delayed to shutdown the server."
		if((SSticker.current_state == GAME_STATE_PREGAME && SSticker.time_left > 0) || (SSticker.current_state != GAME_STATE_PREGAME && !SSticker.delay_end))
			to_chat(usr, span_danger("[required_state_message] The round start/end is not delayed."))
			return
		if(SSticker.current_state == GAME_STATE_PLAYING || SSticker.current_state == GAME_STATE_SETTING_UP)
			#ifdef TGS_V3_API
			if(tgui_alert(usr, "The round is currently in progress, continue with shutdown?", "Continue Shutting Down Server?", list("Continue", "Cancel"), 0) != "Continue")
				return
			waitforroundend = TRUE
			#else
			to_chat(usr, span_danger(usr, "Restarting during the round requires the server toolkit. No server toolkit detected. Please end the round and try again."))
			return
			#endif

	to_chat(usr, span_danger("Alert: Delayed confirmation required. You will be asked to confirm again in 30 seconds."))
	message_admins("[ADMIN_TPMONTY(usr)] initiated the shutdown process. You may abort this by pressing the shutdown server button again.")
	shuttingdown = usr.ckey

	sleep(30 SECONDS)

	if(!shuttingdown || shuttingdown != usr.ckey)
		return

	if(!usr?.client)
		message_admins("[ADMIN_TPMONTY(usr)] left the server before they could finish confirming they wanted to shutdown the server.")
		shuttingdown = null
		return

	if(tgui_alert(usr, "ARE YOU SURE YOU WANT TO SHUTDOWN THE SERVER? ONLY SOMEBODY WITH REMOTE ACCESS TO THE SERVER CAN TURN IT BACK ON.", "Shutdown Server?", list("Yes!", "Cancel."), 0) != "Yes!")
		message_admins("[ADMIN_TPMONTY(usr)] decided against shutting down the server.")
		shuttingdown = null
		return
	to_chat(world, span_danger("Server shutting down [waitforroundend ? "after this round" : "in 30 seconds!"]</span> <span class='notice'>Initiated by: [usr.key]"))
	message_admins("[ADMIN_TPMONTY(usr)] is shutting down the server[waitforroundend ? " after this round" : ""]. You may abort this by pressing the shutdown server button again within 30 seconds.")

	sleep(31 SECONDS) //to give the admins that final second to hit the confirm button on the cancel prompt.

	if(!shuttingdown)
		to_chat(world, span_notice("Server shutdown was aborted"))
		return

	if(shuttingdown != usr.ckey) //somebody cancelled but then somebody started again.
		return

	to_chat(world, span_danger("Server shutting down[waitforroundend ? " after this round. " : ""].</span> <span class='notice'>Initiated by: [shuttingdown]"))
	log_admin("Server shutting down[waitforroundend ? " after this round" : ""]. Initiated by: [shuttingdown]")

#ifdef TGS_V3_API
	if(GLOB.tgs)
		var/datum/tgs_api/TA = GLOB.tgs
		var/tgs3_path = CONFIG_GET(string/tgs3_commandline_path)
		if(fexists(tgs3_path))
			var/instancename = TA.InstanceName()
			if(instancename)
				shell("[tgs3_path] --instance [instancename] dd stop --graceful") //this tells tgstation-server to ignore us shutting down
				if (waitforroundend)
					message_admins("tgstation-server has been ordered to shutdown the server after the current round. The server shutdown can no longer be cancelled.")
			else
				var/msg = "WARNING: Couldn't find tgstation-server3 instancename, server might restart after shutdown."
				message_admins(msg)
				log_admin(msg)
		else
			var/msg = "WARNING: Couldn't find tgstation-server3 command line interface, server will very likely restart after shutdown."
			message_admins(msg)
			log_admin(msg)
	else
		var/msg = "WARNING: Couldn't find tgstation-server3 api object, server could restart after shutdown, but it will very likely be just fine"
		message_admins(msg)
		log_admin(msg)
#endif
	if (waitforroundend)
		return
	sleep(world.tick_lag) //so messages can get sent to players.
	qdel(world) //there are a few ways to shutdown the server, but this is by far my favorite

/datum/admins/proc/toggle_ooc()
	set category = "Server.Chat"
	set name = "Toggle OOC"
	set desc = "Toggles OOC for non-admins."

	if(!check_rights(R_SERVER))
		return

	GLOB.ooc_allowed = !(GLOB.ooc_allowed)

	if(GLOB.ooc_allowed)
		to_chat(world, span_boldnotice("The OOC channel has been globally enabled!"))
	else
		to_chat(world, span_boldnotice("The OOC channel has been globally disabled!"))

	log_admin("[key_name(usr)] [GLOB.ooc_allowed ? "enabled" : "disabled"] OOC.")
	message_admins("[ADMIN_TPMONTY(usr)] [GLOB.ooc_allowed ? "enabled" : "disabled"] OOC.")

/datum/admins/proc/toggle_looc()
	set category = "Server.Chat"
	set name = "Toggle LOOC"
	set desc = "Toggles LOOC for non-admins."

	if(!check_rights(R_SERVER))
		return

	if(CONFIG_GET(flag/looc_enabled))
		CONFIG_SET(flag/looc_enabled, FALSE)
		to_chat(world, span_boldnotice("LOOC channel has been disabled!"))
	else
		CONFIG_SET(flag/looc_enabled, TRUE)
		to_chat(world, span_boldnotice("LOOC channel has been enabled!"))

	log_admin("[key_name(usr)] has [CONFIG_GET(flag/looc_enabled) ? "enabled" : "disabled"] LOOC.")
	message_admins("[ADMIN_TPMONTY(usr)] has [CONFIG_GET(flag/looc_enabled) ? "enabled" : "disabled"] LOOC.")

/datum/admins/proc/toggle_deadchat()
	set category = "Server.Chat"
	set name = "Toggle Deadchat"
	set desc = "Toggles deadchat for non-admins."

	if(!check_rights(R_SERVER))
		return

	GLOB.dsay_allowed = !GLOB.dsay_allowed

	if(GLOB.dsay_allowed)
		to_chat(world, span_boldnotice("Deadchat has been globally enabled!"))
	else
		to_chat(world, span_boldnotice("Deadchat has been globally disabled!"))

	log_admin("[key_name(usr)] [GLOB.dsay_allowed ? "enabled" : "disabled"] deadchat.")
	message_admins("[ADMIN_TPMONTY(usr)] [GLOB.dsay_allowed ? "enabled" : "disabled"] deadchat.")

/datum/admins/proc/toggle_deadooc()
	set category = "Server.Chat"
	set name = "Toggle Dead OOC"
	set desc = "Toggle the ability for dead non-admins to use OOC chat."

	if(!check_rights(R_SERVER))
		return

	GLOB.dooc_allowed = !GLOB.dooc_allowed

	if(GLOB.dooc_allowed)
		to_chat(world, span_boldnotice("Dead player OOC has been globally enabled!"))
	else
		to_chat(world, span_boldnotice("Dead player OOC has been globally disabled!"))

	log_admin("[key_name(usr)] [GLOB.dooc_allowed ? "enabled" : "disabled"] dead player OOC.")
	message_admins("[ADMIN_TPMONTY(usr)] [GLOB.dooc_allowed ? "enabled" : "disabled"] dead player OOC.")

/datum/admins/proc/start()
	set category = "Server.Round"
	set name = "Start Round"
	set desc = "Starts the round early."

	if(!check_rights(R_SERVER))
		return

	if(SSticker.current_state != GAME_STATE_STARTUP && SSticker.current_state != GAME_STATE_PREGAME)
		to_chat(usr, span_warning("The round has already started."))
		return

	if(SSticker.start_immediately)
		SSticker.start_immediately = FALSE
		log_admin("[key_name(usr)] has cancelled the early round start.")
		message_admins("[ADMIN_TPMONTY(usr)] has cancelled the early round start.")
		return

	var/msg = "has started the round early."

	if(SSticker.setup_failed)
		if(tgui_alert(usr, "Previous setup failed. Would you like to try again, bypassing the checks? Win condition checking will also be paused.", "Start Round", list("Yes", "No"), 0) != "Yes")
			return
		msg += " Bypassing roundstart checks."
		SSticker.bypass_checks = TRUE
		SSticker.roundend_check_paused = TRUE

	else if(tgui_alert(usr, "Are you sure you want to start the round early?", "Start Round", list("Yes", "No"), 0) != "Yes")
		return

	if(SSticker.current_state == GAME_STATE_STARTUP)
		msg += " The round is still setting up, but the round will be started as soon as possible. You may abort this by trying to start early again."

	SSticker.start_immediately = TRUE
	log_admin("[key_name(usr)] [msg]")
	message_admins("[ADMIN_TPMONTY(usr)] [msg]")

/datum/admins/proc/toggle_join()
	set category = "Server"
	set name = "Toggle Joining"
	set desc = "Players can still log into the server, but marines won't be able to join the game as a new mob."

	if(!check_rights(R_SERVER))
		return

	GLOB.enter_allowed = !GLOB.enter_allowed

	if(GLOB.enter_allowed)
		to_chat(world, span_boldnotice("New players may now join the game."))
	else
		to_chat(world, span_boldnotice("New players may no longer join the game."))

	log_admin("[key_name(usr)] [GLOB.enter_allowed ? "enabled" : "disabled"] new player joining.")
	message_admins("[ADMIN_TPMONTY(usr)] [GLOB.enter_allowed ? "enabled" : "disabled"] new player joining.")

/datum/admins/proc/toggle_respawn()
	set category = "Server"
	set name = "Toggle Respawn"
	set desc = "Allows players to respawn."

	if(!check_rights(R_SERVER))
		return

	GLOB.respawn_allowed = !GLOB.respawn_allowed

	if(GLOB.respawn_allowed)
		to_chat(world, span_boldnotice("You may now respawn."))
	else
		to_chat(world, span_boldnotice("You may no longer respawn."))

	log_admin("[key_name(usr)] [GLOB.respawn_allowed ? "enabled" : "disabled"] respawning.")
	message_admins("[ADMIN_TPMONTY(usr)] [GLOB.respawn_allowed ? "enabled" : "disabled"] respawning.")

/datum/admins/proc/set_respawn_time(time as num)
	set category = "Server"
	set name = "Set Respawn Timer"
	set desc = "Sets the global respawn timer."

	if(!check_rights(R_SERVER))
		return

	if(time < 0)
		return

	SSticker.mode?.respawn_time = time

	log_admin("[key_name(usr)] set the respawn time to [SSticker.mode?.respawn_time * 0.1] seconds.")
	message_admins("[ADMIN_TPMONTY(usr)] set the respawn time to [SSticker.mode?.respawn_time * 0.1] seconds.")

/datum/admins/proc/end_round()
	set category = "Server.Round"
	set name = "End Round"
	set desc = "Immediately ends the round, be very careful"

	if(!check_rights(R_SERVER))
		return

	if(!SSticker?.mode)
		return

	if(tgui_alert(usr, "Are you sure you want to end the round?", "End Round", list("Yes", "No"), 0) != "Yes")
		return

	var/winstate = tgui_input_list(usr, "What do you want the round end state to be?", "End Round", SSticker.mode.round_end_states + list("Custom", "Admin Intervention"), timeout = 0)
	if(!winstate)
		return

	if(winstate == "Custom")
		winstate = tgui_input_text(usr, "Please enter a custom round end state.", "End Round", timeout = 0)
		if(!winstate)
			return

	SSticker.force_ending = TRUE
	SSticker.mode.round_finished = winstate

	log_admin("[key_name(usr)] has made the round end early - [winstate].")
	message_admins("[ADMIN_TPMONTY(usr)] has made the round end early - [winstate].")

/datum/admins/proc/delay_start()
	set category = "Server.Round"
	set name = "Delay Round Start"

	if(!check_rights(R_SERVER))
		return

	if(!SSticker)
		return

	var/newtime = tgui_input_number(usr, "Set a new time in seconds. Set -1 for indefinite delay.", "Set Delay", round(SSticker.GetTimeLeft()), 9999, -1, 0)
	if(SSticker.current_state > GAME_STATE_PREGAME)
		return
	if(isnull(newtime))
		return

	newtime = newtime * 10
	SSticker.SetTimeLeft(newtime)
	if(newtime < 0)
		to_chat(world, span_boldnotice("The game start has been delayed."))
		log_admin("[key_name(usr)] delayed the round start.")
		message_admins("[ADMIN_TPMONTY(usr)] delayed the round start.")
	else
		to_chat(world, span_boldnotice("The game will start in [DisplayTimeText(newtime)]."))
		log_admin("[key_name(usr)] set the pre-game delay to [DisplayTimeText(newtime)].")
		message_admins("[ADMIN_TPMONTY(usr)] set the pre-game delay to [DisplayTimeText(newtime)].")

/datum/admins/proc/delay_end()
	set category = "Server.Round"
	set name = "Delay Round End"

	if(!check_rights(R_SERVER))
		return

	if(!SSticker)
		return

	if(SSticker.admin_delay_notice)
		if(tgui_alert(usr, "Do you want to remove the round end delay?", "Delay Round End", list("Yes", "No"), 0) != "Yes")
			return
		SSticker.admin_delay_notice = null
	else
		var/reason = tgui_input_text(usr, "Enter a reason for delaying the round end", "Round Delay Reason", timeout = 0)
		if(!reason)
			return
		if(SSticker.admin_delay_notice)
			to_chat(usr, span_warning("Someone already delayed the round end meanwhile."))
			return
		SSticker.admin_delay_notice = reason

	SSticker.delay_end = !SSticker.delay_end

	log_admin("[key_name(usr)] [SSticker.delay_end ? "delayed the round-end[SSticker.admin_delay_notice ? " for reason: [SSticker.admin_delay_notice]" : ""]" : "made the round end normally"].")
	message_admins("<hr><h4>[ADMIN_TPMONTY(usr)] [SSticker.delay_end ? "delayed the round-end[SSticker.admin_delay_notice ? " for reason: [SSticker.admin_delay_notice]" : ""]" : "made the round end normally"].</h4><hr>")

/datum/admins/proc/toggle_gun_restrictions()
	set name = "Toggle Gun Restrictions"
	set category = "Server"
	set desc = "Currently only affects MP guns."

	if(!check_rights(R_SERVER))
		return

	if(!config)
		return

	if(CONFIG_GET(flag/remove_gun_restrictions))
		CONFIG_SET(flag/remove_gun_restrictions, FALSE)
	else
		CONFIG_SET(flag/remove_gun_restrictions, TRUE)

	log_admin("[key_name(usr)] has [CONFIG_GET(flag/remove_gun_restrictions) ? "enabled" : "disabled"] gun restrictions.")
	message_admins("[ADMIN_TPMONTY(usr)] has [CONFIG_GET(flag/remove_gun_restrictions) ? "enabled" : "disabled"] gun restrictions.")

/datum/admins/proc/toggle_synthetic_restrictions()
	set category = "Server"
	set name = "Toggle Synthetic Restrictions"
	set desc = "Enabling this will allow synthetics to use weapons."

	if(!check_rights(R_SERVER))
		return

	if(!config)
		return

	if(CONFIG_GET(flag/allow_synthetic_gun_use))
		CONFIG_SET(flag/allow_synthetic_gun_use, FALSE)
	else
		CONFIG_SET(flag/allow_synthetic_gun_use, TRUE)

	log_admin("[key_name(src)] has [CONFIG_GET(flag/allow_synthetic_gun_use) ? "enabled" : "disabled"] synthetic weapon use.")
	message_admins("[ADMIN_TPMONTY(usr)] has [CONFIG_GET(flag/allow_synthetic_gun_use) ? "enabled" : "disabled"] synthetic weapon use.")

/datum/admins/proc/reload_admins()
	set category = "Server.Server"
	set name = "Reload Admins"
	set desc = "Manually load all admins from the .txt"

	if(!check_rights(R_SERVER))
		return

	if(tgui_alert(usr, "Are you sure you want to reload admins?", "Reload admins", list("Yes", "No"), 0) != "Yes")
		return

	load_admins()

	log_admin("[key_name(src)] manually reloaded admins.")
	message_admins("[ADMIN_TPMONTY(usr)] manually reloaded admins.")

/datum/admins/proc/change_ground_map()
	set category = "Server.Server"
	set name = "Change Ground Map"

	if(!check_rights(R_SERVER))
		return

	var/list/maprotatechoices = list()
	for(var/map in config.maplist[GROUND_MAP])
		var/datum/map_config/VM = config.maplist[GROUND_MAP][map]
		var/mapname = VM.map_name
		if(VM == config.defaultmaps[GROUND_MAP])
			mapname += " (Default)"

		if(VM.config_min_users > 0 || VM.config_max_users > 0)
			mapname += " \["
			if(VM.config_min_users > 0)
				mapname += "[VM.config_min_users]"
			else
				mapname += "0"
			mapname += "-"
			if(VM.config_max_users > 0)
				mapname += "[VM.config_max_users]"
			else
				mapname += "inf"
			mapname += "\]"

		maprotatechoices[mapname] = VM

	var/chosenmap = tgui_input_list(usr, "Choose a ground map to change to", "Change Ground Map", maprotatechoices, timeout = 0)
	if(!chosenmap)
		return

	var/datum/map_config/VM = maprotatechoices[chosenmap]
	if(!SSmapping.changemap(VM, GROUND_MAP))
		to_chat(usr, span_warning("Failed to change the ground map."))
		return

	log_admin("[key_name(usr)] changed the map to [VM.map_name].")
	message_admins("[ADMIN_TPMONTY(usr)] changed the map to [VM.map_name].")

/datum/admins/proc/panic_bunker()
	set category = "Server.Server"
	set name = "Toggle Panic Bunker"

	if(!check_rights(R_SERVER))
		return

	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, span_adminnotice("The Database is not enabled!"))
		return

	CONFIG_SET(flag/panic_bunker, !CONFIG_GET(flag/panic_bunker))

	log_admin("[key_name(usr)] has [CONFIG_GET(flag/panic_bunker) ? "enabled" : "disabled"] the panic bunker.")
	message_admins("[ADMIN_TPMONTY(usr)] has [CONFIG_GET(flag/panic_bunker) ? "enabled" : "disabled"] the panic bunker.")

/datum/admins/proc/mode_check()
	set category = "Server.Round"
	set name = "Toggle Mode Check"

	if(!check_rights(R_SERVER))
		return

	SSticker.roundend_check_paused = !SSticker.roundend_check_paused

	log_admin("[key_name(usr)] has [SSticker.roundend_check_paused ? "disabled" : "enabled"] gamemode end condition checking.")
	message_admins("[ADMIN_TPMONTY(usr)] has [SSticker.roundend_check_paused ? "disabled" : "enabled"] gamemode end condition checking.")

/client/proc/toggle_cdn()
	set name = "Toggle CDN"
	set category = "Server.Server"
	var/static/admin_disabled_cdn_transport = null
	if(tgui_alert(usr, "Are you sure you want to toggle the CDN asset transport?", "Confirm", list("Yes", "No"), 0) != "Yes")
		return
	var/current_transport = CONFIG_GET(string/asset_transport)
	if(!current_transport || current_transport == "simple")
		if(admin_disabled_cdn_transport)
			CONFIG_SET(string/asset_transport, admin_disabled_cdn_transport)
			admin_disabled_cdn_transport = null
			SSassets.OnConfigLoad()
			message_admins("[key_name_admin(usr)] re-enabled the CDN asset transport")
			log_admin("[key_name(usr)] re-enabled the CDN asset transport")
		else
			to_chat(usr, span_adminnotice("The CDN is not enabled!"))
			if(tgui_alert(usr, "The CDN asset transport is not enabled! If you having issues with assets you can also try disabling filename mutations.", "The CDN asset transport is not enabled!", list("Try disabling filename mutations", "Nevermind"), 0) == "Try disabling filename mutations")
				SSassets.transport.dont_mutate_filenames = !SSassets.transport.dont_mutate_filenames
				message_admins("[key_name_admin(usr)] [(SSassets.transport.dont_mutate_filenames ? "disabled" : "re-enabled")] asset filename transforms")
				log_admin("[key_name(usr)] [(SSassets.transport.dont_mutate_filenames ? "disabled" : "re-enabled")] asset filename transforms")
	else
		admin_disabled_cdn_transport = current_transport
		CONFIG_SET(string/asset_transport, "simple")
		SSassets.OnConfigLoad()
		SSassets.transport.dont_mutate_filenames = TRUE
		message_admins("[key_name_admin(usr)] disabled the CDN asset transport")
		log_admin("[key_name(usr)] disabled the CDN asset transport")

/**
 * Toggles players' ability to join valhalla
 */
/datum/admins/proc/toggle_valhalla()
	set category = "Server"
	set name = "Toggle Valhalla joining"
	set desc = "Allows players to join valhalla."

	if(!check_rights(R_SERVER))
		return

	GLOB.valhalla_allowed = !GLOB.valhalla_allowed

	log_admin("[key_name(usr)] [GLOB.valhalla_allowed ? "enabled" : "disabled"] valhalla joining.")
	message_admins("[ADMIN_TPMONTY(usr)] [GLOB.valhalla_allowed ? "enabled" : "disabled"] valhalla joining.")

/**
 * Toggles players' ability to take over SSD mobs
 */
/datum/admins/proc/toggle_sdd_possesion()
	set category = "Server"
	set name = "Toggle taking over SSD mobs"
	set desc = "Allows players to take over SSD mobs."

	if(!check_rights(R_SERVER))
		return

	GLOB.ssd_posses_allowed = !GLOB.ssd_posses_allowed

	log_admin("[key_name(usr)] [GLOB.ssd_posses_allowed ? "enabled" : "disabled"] taking over SSD mobs.")
	message_admins("[ADMIN_TPMONTY(usr)] [GLOB.ssd_posses_allowed ? "enabled" : "disabled"] taking over SSD mobs.")
