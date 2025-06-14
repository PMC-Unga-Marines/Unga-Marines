/datum/admins/proc/set_view_range()
	set category = "Admin.Fun"
	set name = "Set View Range"

	if(!check_rights(R_FUN))
		return

	if(usr.client.view_size.get_client_view_size() != usr.client.view_size.default)
		usr.client.view_size.reset_to_default()
		return

	var/newview = input("Select view range:", "Change View Range", 7) as null|num
	if(!newview)
		return

	newview = VIEW_NUM_TO_STRING(newview)
	if(newview == usr.client.view)
		return

	usr.client.view_size.set_view_radius_to(newview)

	log_admin("[key_name(usr)] changed their view range to [usr.client.view].")
	message_admins("[ADMIN_TPMONTY(usr)] changed their view range to [usr.client.view].")


/datum/admins/proc/emp()
	set category = "Admin.Fun"
	set name = "EM Pulse"

	if(!check_rights(R_FUN))
		return

	var/heavy = input("Range of heavy pulse.", "EM Pulse") as num|null
	if(isnull(heavy))
		return

	var/light = input("Range of light pulse.", "EM Pulse") as num|null
	if(isnull(light))
		return

	heavy = clamp(heavy, 0, 10000)
	light = clamp(light, 0, 10000)

	empulse(usr, heavy, light)

	log_admin("[key_name(usr)] created an EM Pulse ([heavy], [light]) at [AREACOORD(usr.loc)].")
	message_admins("[ADMIN_TPMONTY(usr)] created an EM Pulse ([heavy], [light]) at [ADMIN_VERBOSEJMP(usr.loc)].")


/datum/admins/proc/queen_report()
	set category = "Admin.Fun"
	set name = "Queen Mother Report"

	if(!check_rights(R_FUN))
		return

	var/customname = tgui_input_text(usr, "What do you want the title of this report to be?", "Report Title", "Queen Mother Directive", encode = FALSE)
	var/input = tgui_input_text(usr, "This should be a message from the ruler of the Xenomorph race.", "Queen Mother Report", "", multiline = TRUE, encode = FALSE)
	if(!input || !customname)
		return


	for(var/i in (GLOB.xeno_mob_list + GLOB.observer_list))
		var/mob/M = i
		to_chat(M, assemble_alert(
			title = customname,
			message = input,
			color_override = "purple"
		))

	log_admin("[key_name(usr)] created a Queen Mother report: [input]")
	message_admins("[ADMIN_TPMONTY(usr)] created a Queen Mother report.")

/datum/admins/proc/rouny_all()
	set name = "Toggle Glob Xeno Rouny"
	set category = "Admin.Fun"
	set desc = "Toggle all living xenos into rouny versions of themselves"

	if(!check_rights(R_FUN))
		return

	for(var/mob/living/carbon/xenomorph/xeno in GLOB.xeno_mob_list)
		if(!isxeno(xeno)) // will it even do something?
			continue
		if(!xeno.rouny_icon)
			continue
		xeno.toggle_rouny_skin()

/datum/admins/proc/hive_status()
	set category = "Admin.Fun"
	set name = "Check Hive Status"
	set desc = "Check the status of the hive."

	if(!check_rights(R_FUN))
		return

	if(!SSticker)
		return

	check_hive_status(usr)

	log_admin("[key_name(usr)] checked the hive status.")


/datum/admins/proc/ai_report()
	set category = "Admin.Fun"
	set name = "AI Report"

	if(!check_rights(R_FUN))
		return

	var/customname = tgui_input_text(usr, "What do you want the AI to be called?.", "AI Report", "AI", encode = FALSE)
	var/input = tgui_input_text(usr, "This should be a message from the ship's AI.", "AI Report", multiline = TRUE, encode = FALSE)
	if(!input || !customname)
		return

	var/paper
	switch(tgui_alert(usr, "Do you want to print out a paper at the communications consoles?", "AI Report", list("Yes", "No", "Cancel")))
		if("Yes")
			paper = TRUE
		if("No")
			paper = FALSE
		else
			return

	priority_announce(input, customname, sound = 'sound/misc/interference.ogg')

	if(paper)
		print_command_report(input, "[customname] Update", announce = FALSE)

	log_admin("[key_name(usr)] has created an AI report: [input]")
	message_admins("[ADMIN_TPMONTY(usr)] has created an AI report: [input]")


/datum/admins/proc/command_report()
	set category = "Admin.Fun"
	set name = "Command Report"

	if(!check_rights(R_FUN))
		return


	var/customname = tgui_input_text(usr, "Pick a title for the report.", "Title", "TGMC Update", encode = FALSE)
	var/customsubtitle = tgui_input_text(usr, "Pick a subtitle for the report.", "Subtitle", "", encode = FALSE)
	var/input = tgui_input_text(usr, "Please enter anything you want. Anything. Serious.", "What?", "", multiline = TRUE, encode = FALSE)
	var/override = tgui_input_list(usr, "Pick a color for the report.", "Color", faction_alert_colors - "default", default = "blue")

	if(!input || !customname)
		return

	if(tgui_alert(usr, "Do you want to print out a paper at the communications consoles?", null, list("Yes", "No")) == "Yes")
		print_command_report(input, "[SSmapping.configs[SHIP_MAP].map_name] Update", announce = FALSE)

	switch(tgui_alert(usr, "Should this be announced to the general population?", "Announce", list("Yes", "No", "Cancel")))
		if("Yes")
			priority_announce(input, customname, customsubtitle, sound = 'sound/AI/commandreport.ogg', color_override = override);
		if("No")
			priority_announce("Новое объявление доступно на всех консолях связи.", "Получена конфиденциальная передача", type = ANNOUNCEMENT_PRIORITY, sound = 'sound/AI/commandreport.ogg')
		else
			return

	log_admin("[key_name(usr)] has created a command report: [input]")
	message_admins("[ADMIN_TPMONTY(usr)] has created a command report.")


/datum/admins/proc/narrate_global()
	set category = "Admin.Fun"
	set name = "Global Narrate"

	if(!check_rights(R_FUN))
		return

	var/msg = tgui_input_text(usr, "Enter the text you wish to appear to everyone.", "Global Narrate", multiline = TRUE , encode = FALSE, max_length = INFINITY)

	if(!msg)
		return

	to_chat(world, msg)

	log_admin("GlobalNarrate: [key_name(usr)] : [msg]")
	message_admins("[ADMIN_TPMONTY(usr)] used Global Narrate: [msg]")


/datum/admins/proc/narage_direct(mob/M in GLOB.mob_list)
	set category = null
	set name = "Direct Narrate"

	if(!check_rights(R_FUN))
		return

	var/msg = tgui_input_text(usr, "Enter the text you wish to appear to your target.", "Direct Narrate", multiline = TRUE, encode = FALSE)
	if(!msg)
		return

	to_chat(M, "[msg]")

	log_admin("DirectNarrate: [key_name(usr)] to [key_name(M)]: [msg]")
	message_admins("[ADMIN_TPMONTY(usr)] used Direct Narrate on [ADMIN_TPMONTY(M)]: [msg]")


/datum/admins/proc/subtle_message(mob/M in GLOB.player_list)
	set category = null
	set name = "Subtle Message"

	if(!check_rights(R_FUN|R_MENTOR))
		return

	var/msg = tgui_input_text(usr, "Subtle PM to [key_name(M)]:", "Subtle Message", "", multiline = TRUE, encode = FALSE)

	if(!M?.client || !msg)
		return

	if(check_rights(R_ADMIN, FALSE))
		msg = noscript(msg)
	else
		msg = sanitize(msg)

	to_chat(M, "<b>You hear a voice in your head... [msg]</b>")

	admin_ticket_log(M, "[key_name_admin(usr)] used Subtle Message: [sanitize(msg)]")
	log_admin("SubtleMessage: [key_name(usr)] to [key_name(M)]: [msg]")
	message_admins("[ADMIN_TPMONTY(usr)] used Subtle Message on [ADMIN_TPMONTY(M)]: [msg]")


/datum/admins/proc/subtle_message_panel()
	set category = "Admin.Fun"
	set name = "Subtle Message Mob"

	if(!check_rights(R_FUN|R_MENTOR))
		return

	var/mob/M
	switch(input("Message by:", "Subtle Message") as null|anything in list("Key", "Mob"))
		if("Key")
			var/client/C = input("Please, select a key.", "Subtle Message") as null|anything in sortKey(GLOB.clients)
			if(!C)
				return
			M = C.mob
		if("Mob")
			var/mob/N = input("Please, select a mob.", "Subtle Message") as null|anything in sortNames(GLOB.player_list)
			if(!N)
				return
			M = N
		else
			return

	var/msg = tgui_input_text(usr, "Subtle PM to [key_name(M)]:", "Subtle Message", "", multiline = TRUE, encode = FALSE)

	if(!M?.client || !msg)
		return

	if(check_rights(R_ADMIN, FALSE))
		msg = noscript(msg)
	else
		msg = sanitize(msg)

	to_chat(M, "<b>You hear a voice in your head... [msg]</b>")

	admin_ticket_log(M, "[key_name_admin(usr)] used Subtle Message: [sanitize(msg)]")
	log_admin("SubtleMessage: [key_name(usr)] to [key_name(M)]: [msg]")
	message_admins("[ADMIN_TPMONTY(usr)] used Subtle Message on [ADMIN_TPMONTY(M)]: [msg]")


/datum/admins/proc/award_medal()
	set category = "Admin.Fun"
	set name = "Award a Medal"

	if(!check_rights(R_FUN))
		return

	give_medal_award()


/datum/admins/proc/custom_info()
	set category = "Admin.Fun"
	set name = "Change Custom Info"

	if(!check_rights(R_FUN))
		return

	var/new_info = tgui_input_text(usr, "Set the custom information players get on joining or via the OOC tab.", "Custom info", GLOB.custom_info, multiline = TRUE, encode = FALSE)
	new_info = noscript(new_info)
	if(isnull(new_info) || GLOB.custom_info == new_info)
		return

	if(!new_info)
		log_admin("[key_name(usr)] has cleared the custom info.")
		message_admins("[ADMIN_TPMONTY(usr)] has cleared the custom info.")
		return

	GLOB.custom_info = new_info

	to_chat(world, assemble_alert(
		title = "Custom Information",
		subtitle = "An admin set custom information for this round.",
		message = GLOB.custom_info,
		color_override = "red"
	))
	SEND_SOUND(src, sound('sound/misc/adm_announce.ogg'))

	log_admin("[key_name(usr)] has changed the custom event text: [GLOB.custom_info]")
	message_admins("[ADMIN_TPMONTY(usr)] has changed the custom event text.")


/client/verb/custom_info()
	set category = "OOC"
	set name = "Custom Info"

	if(!GLOB.custom_info)
		to_chat(src, span_notice("There currently is no custom information set."))
		return

	to_chat(src, assemble_alert(
		title = "Custom Information",
		subtitle = "An admin set custom information for this round.",
		message = GLOB.custom_info,
		color_override = "red"
	))
	SEND_SOUND(src, sound('sound/misc/adm_announce.ogg'))

/datum/admins/proc/sound_file(S as sound)
	set category = "Admin.Fun"
	set name = "Play Imported Sound"
	set desc = "Play a sound imported from anywhere on your computer."

	if(!check_rights(R_SOUND))
		return

	var/heard_midi = 0
	var/sound/uploaded_sound = sound(S, repeat = 0, wait = 1, channel = CHANNEL_MIDI)
	uploaded_sound.priority = 250

	var/style = tgui_alert(usr, "Play sound globally or locally?", "Play Imported Sound", list("Global", "Local"), timeout = 0)
	switch(style)
		if("Global")
			for(var/i in GLOB.clients)
				var/client/C = i
				if(C.prefs.toggles_sound & SOUND_MIDI)
					SEND_SOUND(C, uploaded_sound)
					heard_midi++
		if("Local")
			playsound(get_turf(usr), uploaded_sound, 50, 0)
			for(var/mob/M in view())
				heard_midi++
		else
			return

	log_admin("[key_name(usr)] played sound '[S]' for [heard_midi] player(s). [length(GLOB.clients) - heard_midi] player(s) [style == "Global" ? "have disabled admin midis" : "were out of view"].")
	message_admins("[ADMIN_TPMONTY(usr)] played sound '[S]' for [heard_midi] player(s). [length(GLOB.clients) - heard_midi] player(s) [style == "Global" ? "have disabled admin midis" : "were out of view"].")

/datum/admins/proc/sound_web()
	set category = "Admin.Fun"
	set name = "Play Internet Sound"

	if(!check_rights(R_SOUND))
		return

	var/ytdl = CONFIG_GET(string/invoke_yt_dlp)
	if(!ytdl)
		to_chat(usr, span_warning("yt-dlp was not configured, action unavailable."))
		return

	var/web_sound_input = input("Enter content URL (supported sites only)", "Play Internet Sound via yt-dlp") as text|null
	if(!istext(web_sound_input) || !length(web_sound_input))
		return

	web_sound_input = trim(web_sound_input)

	if(findtext(web_sound_input, ":") && !findtext(web_sound_input, GLOB.is_http_protocol))
		to_chat(usr, span_warning("Non-http(s) URIs are not allowed."))
		to_chat(usr, span_warning("For yt-dlp shortcuts like ytsearch: please use the appropriate full url from the website."))
		return

	var/web_sound_url = ""
	var/list/music_extra_data = list()
	var/title
	var/show = FALSE

	var/list/output = world.shelleo("[ytdl] --format \"bestaudio\[ext=mp3]/best\[ext=mp4]\[height<=360]/bestaudio\[ext=m4a]/bestaudio\[ext=aac]\" --dump-single-json --no-playlist -- \"[shell_url_scrub(web_sound_input)]\"")
	var/errorlevel = output[SHELLEO_ERRORLEVEL]
	var/stdout = output[SHELLEO_STDOUT]
	var/stderr = output[SHELLEO_STDERR]

	if(errorlevel)
		to_chat(usr, span_warning("yt-dlp URL retrieval FAILED: [stderr]"))
		return

	var/list/data = list()
	try
		data = json_decode(stdout)
	catch(var/exception/e)
		to_chat(usr, span_warning("yt-dlp JSON parsing FAILED: [e]: [stdout]"))
		return

	if(data["url"])
		web_sound_url = data["url"]
		title = data["title"]
		music_extra_data["start"] = data["start_time"]
		music_extra_data["end"] = data["end_time"]
		music_extra_data["link"] = data["webpage_url"]
		music_extra_data["title"] = data["title"]
		switch(tgui_alert(usr, "Show the title of and link to this song to the players?\n[title]", "Play Internet Sound", list("Yes", "No"), timeout = 0))
			if("Yes")
				show = TRUE
			if("No")
				show = FALSE
			else
				return

	if(web_sound_url && !findtext(web_sound_url, GLOB.is_http_protocol))
		to_chat(usr, span_warning("BLOCKED: Content URL not using http(s) protocol"))
		to_chat(usr, span_warning("The media provider returned a content URL that isn't using the HTTP or HTTPS protocol"))
		return

	var/list/targets
	var/style = tgui_input_list(usr, "Do you want to play this globally or to the xenos/marines?", null, list("Globally", "Xenos", "Marines", "Locally"))
	switch(style)
		if("Globally")
			targets = GLOB.player_list
		if("Xenos")
			targets = GLOB.xeno_mob_list + GLOB.observer_list
		if("Marines")
			targets = GLOB.human_mob_list + GLOB.observer_list
		if("Locally")
			targets = viewers(usr.client.view, usr)
		else
			return

	for(var/i in targets)
		var/mob/M = i
		var/client/C = M?.client
		if(!(C?.prefs.toggles_sound & SOUND_MIDI))
			continue
		C.tgui_panel?.play_music(web_sound_url, music_extra_data)
		if(show)
			to_chat(C, span_boldnotice("An admin played: <a href='[data["webpage_url"]]'>[title]</a>"))

	log_admin("[key_name(usr)] played web sound: [web_sound_input] - [title] - [style]")
	message_admins("[ADMIN_TPMONTY(usr)] played web sound: [web_sound_input] - [title] - [style]")

/datum/admins/proc/sound_stop()
	set category = "Admin.Fun"
	set name = "Stop Regular Sounds"

	if(!check_rights(R_SOUND))
		return

	for(var/mob/M in GLOB.player_list)
		if(M.client)
			SEND_SOUND(M, sound(null))

	log_admin("[key_name(usr)] stopped regular sounds.")
	message_admins("[ADMIN_TPMONTY(usr)] stopped regular sounds.")

/datum/admins/proc/music_stop()
	set category = "Admin.Fun"
	set name = "Stop Playing Music"

	if(!check_rights(R_SOUND))
		return

	for(var/i in GLOB.clients)
		var/client/C = i
		C?.tgui_panel?.stop_music()

	log_admin("[key_name(usr)] stopped the currently playing music.")
	message_admins("[ADMIN_TPMONTY(usr)] stopped the currently playing music.")

/datum/admins/proc/announce()
	set category = "Admin.Fun"
	set name = "Admin Announce"

	if(!check_rights(R_FUN))
		return

	var/message = tgui_input_text(usr, "Global message to send:", "Admin Announce", multiline = TRUE, encode = FALSE, max_length = INFINITY)

	message = noscript(message)

	if(!message)
		return

	log_admin("Announce: [key_name(usr)] : [message]")
	message_admins("[ADMIN_TPMONTY(usr)] Announces:")
	send_ooc_announcement(message, "From [usr.client.holder.fakekey ? "Administrator" : usr.key]")


/datum/admins/proc/force_distress()
	set category = "Admin.Fun"
	set name = "Distress Beacon"
	set desc = "Call a distress beacon manually."

	if(!check_rights(R_FUN))
		return

	if(!SSticker?.mode)
		to_chat(src, span_warning("Please wait for the round to begin first."))

	if(SSticker.mode.waiting_for_candidates)
		to_chat(src, span_warning("Please wait for the current beacon to be finalized."))
		return

	if(SSticker.mode.picked_call)
		SSticker.mode.picked_call.reset()
		SSticker.mode.picked_call = null

	var/list/list_of_calls = list()
	for(var/datum/emergency_call/L in SSticker.mode.all_calls)
		if(L.name)
			list_of_calls += L.name

	list_of_calls += "Randomize"

	var/choice = tgui_input_list(usr, "Which distress do you want to call?", null, list_of_calls)
	if(!choice)
		return

	if(choice == "Randomize")
		SSticker.mode.picked_call = SSticker.mode.get_random_call()
	else
		for(var/datum/emergency_call/C in SSticker.mode.all_calls)
			if(C.name == choice)
				SSticker.mode.picked_call = C
				break

	if(!istype(SSticker.mode.picked_call))
		return

	var/max = tgui_input_number(usr, "What should the maximum amount of mobs be?", "Max mobs", SSticker.mode.picked_call.mob_max)
	if(!max || max < 1)
		return

	SSticker.mode.picked_call.mob_max = max

	var/min = tgui_input_number(usr, "What should the minimum amount of mobs be?", "Min Mobs", SSticker.mode.picked_call.mob_min)
	if(!min || min < 1)
		min = 0

	SSticker.mode.picked_call.mob_min = min

	var/is_announcing = TRUE
	if(tgui_alert(usr, "Would you like to announce the distress beacon to the server population? This will reveal the distress beacon to all players.", "Announce distress beacon?", list("Yes", "No")) != "Yes")
		is_announcing = FALSE

	SSticker.mode.picked_call.activate(is_announcing)

	log_admin("[key_name(usr)] called a [choice == "Randomize" ? "randomized ":""]distress beacon: [SSticker.mode.picked_call.name]. Min: [min], Max: [max].")
	message_admins("[ADMIN_TPMONTY(usr)] called a [choice == "Randomize" ? "randomized ":""]distress beacon: [SSticker.mode.picked_call.name] Min: [min], Max: [max].")


/datum/admins/proc/object_sound(atom/O as obj)
	set category = null
	set name = "Object Sound"

	if(!check_rights(R_FUN))
		return

	if(!O)
		return

	var/message = input("What do you want the message to be?", "Object Sound") as text|null
	if(!message)
		return

	var/method = input("What do you want the verb to be? Make sure to include s if applicable.", "Object Sound") as text|null
	if(!method)
		return

	O.audible_message("<b>[O]</b> [method], \"[message]\"")
	if(usr.control_object)
		usr.show_message("<b>[O.name]</b> [method], \"[message]\"", 2)

	log_admin("[key_name(usr)] forced [O] ([O.type]) to: [method] [message]")
	message_admins("[ADMIN_TPMONTY(usr)] forced [O] ([O.type]) to: [method] [message]")


/datum/admins/proc/drop_bomb()
	set category = "Admin.Fun"
	set name = "Drop Bomb"
	set desc = "Cause an explosion of varying strength at your location."

	if(!check_rights(R_FUN))
		return

	var/choice = tgui_input_list(usr, "What explosion would you like to produce?", "Drop Bomb", list("CAS: Widow Maker", "CAS: Banshee", "CAS: Keeper", "CAS: Fatty", "CAS: Napalm", "Small Bomb", "Medium Bomb", "Big Bomb", "Custom Bomb"))
	switch(choice)
		if("CAS: Widow Maker")
			playsound(usr.loc, 'sound/machines/hydraulics_2.ogg', 70, TRUE)
			new /obj/effect/overlay/temp/blinking_laser (usr.loc)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(delayed_detonate_bomb), get_turf(usr.loc), 320, 80, 3), 1 SECONDS)
		if("CAS: Banshee")
			playsound(usr.loc, 'sound/machines/hydraulics_2.ogg', 70, TRUE)
			new /obj/effect/overlay/temp/blinking_laser (usr.loc)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(delayed_detonate_bomb_banshee), get_turf(usr.loc)), 1 SECONDS)
		if("CAS: Keeper")
			playsound(usr.loc, 'sound/machines/hydraulics_2.ogg', 70, TRUE)
			new /obj/effect/overlay/temp/blinking_laser (usr.loc)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(delayed_detonate_bomb), get_turf(usr.loc), 450, 120, 3), 1 SECONDS)
		if("CAS: Fatty")
			playsound(usr.loc, 'sound/machines/hydraulics_2.ogg', 70, TRUE)
			new /obj/effect/overlay/temp/blinking_laser (usr.loc)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(delayed_detonate_bomb_fatty), get_turf(usr.loc)), 1 SECONDS)
		if("CAS: Napalm")
			playsound(usr.loc, 'sound/machines/hydraulics_2.ogg', 70, TRUE)
			new /obj/effect/overlay/temp/blinking_laser (usr.loc)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(delayed_detonate_bomb_napalm), get_turf(usr.loc)), 1 SECONDS)
		if("Small Bomb")
			cell_explosion(usr.loc, 150, 50)
		if("Medium Bomb")
			cell_explosion(usr.loc, 250, 75)
		if("Big Bomb")
			cell_explosion(usr.loc, 420, 70)
		if("Custom Bomb")
			var/input_severity = tgui_input_number(usr, "Explosion Severity:", "Drop Bomb", 500, EXPLOSION_MAX_POWER, 1)
			if(isnull(input_severity))
				return
			var/input_falloff = tgui_input_number(usr, "Explosion Falloff:", "Drop Bomb", 50, EXPLOSION_MAX_POWER, 1)
			if(isnull(input_falloff))
				return
			var/input_shape
			switch(tgui_alert(usr, "Falloff Shape", "Choose falloff shape", list("Linear", "Exponential"), 0))
				if("Linear")
					input_shape = EXPLOSION_FALLOFF_SHAPE_LINEAR
				if("Exponential")
					input_shape = EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL
			switch(tgui_alert(usr, "Deploy payload?", "Severity: [input_severity] | Falloff: [input_falloff]", list("Launch!", "Cancel"), 0))
				if("Launch!")
					cell_explosion(usr.loc, input_severity, input_falloff, input_shape)
				else
					return
			choice = "[choice] ([input_severity], [input_falloff])" //For better logging.
		else
			return

	log_admin("[key_name(usr)] dropped a [choice] at [AREACOORD(usr.loc)].")
	message_admins("[ADMIN_TPMONTY(usr)] dropped a [choice] at [ADMIN_VERBOSEJMP(usr.loc)].")

/proc/delayed_detonate_bomb(turf/impact, input_power, input_falloff, ceiling_debris)
	if(ceiling_debris)
		impact.ceiling_debris_check(ceiling_debris)
	cell_explosion(impact, input_power, input_falloff)

/proc/delayed_detonate_bomb_banshee(turf/impact)
	impact.ceiling_debris_check(3)
	cell_explosion(impact, 320, 100)
	flame_radius(7, impact)

/proc/delayed_detonate_bomb_fatty(turf/impact)
	impact.ceiling_debris_check(2)
	cell_explosion(impact, 250, 90)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(delayed_detonate_bomb_fatty_final), impact), 3 SECONDS)

/proc/delayed_detonate_bomb_fatty_final(turf/impact)
	var/list/impact_coords = list(list(-3, 3), list(0, 4), list(3, 3), list(-4, 0), list(4, 0), list(-3, -3), list(0, -4), list(3, -3))
	for(var/i in 1 to 8)
		var/list/coords = impact_coords[i]
		var/turf/detonation_target = locate(impact.x+coords[1],impact.y+coords[2],impact.z)
		detonation_target.ceiling_debris_check(2)
		cell_explosion(detonation_target, 250, 90, adminlog = FALSE)

/proc/delayed_detonate_bomb_napalm(turf/impact)
	impact.ceiling_debris_check(3)
	cell_explosion(impact, 250, 90)
	flame_radius(5, impact, 30, 60)

/datum/admins/proc/drop_OB()
	set category = "Admin.Fun"
	set name = "Drop OB"
	set desc = "Cause an OB explosion of varying strength at your location."

	if(!check_rights(R_FUN))
		return

	var/list/firemodes = list("Standard OB List", "Custom HE", "Custom Cluster", "Custom Incendiary", "Custom Plasmaloss")
	var/mode = tgui_input_list(usr, "Select fire mode:", "Fire mode", firemodes)
	// Select the warhead.
	var/obj/structure/ob_ammo/warhead/warhead
	switch(mode)
		if("Standard OB List")
			var/list/warheads = subtypesof(/obj/structure/ob_ammo/warhead/)
			var/choice = tgui_input_list(usr, "Select the warhead:", "Warhead to use", warheads)
			warhead = new choice
		if("Custom HE")
			var/obj/structure/ob_ammo/warhead/explosive/OBShell = new
			OBShell.explosion_power = tgui_input_number(src, "How much explosive power should the wall clear blast have?", "Set clear power", 1425, EXPLOSION_MAX_POWER, 1)
			if(isnull(OBShell.explosion_power))
				return
			OBShell.explosion_falloff = tgui_input_number(src, "How much falloff should the wall clear blast have?", "Set clear falloff", 90, EXPLOSION_MAX_POWER, 1)
			if(isnull(OBShell.explosion_falloff))
				return
			warhead = OBShell
		if("Custom Cluster")
			var/obj/structure/ob_ammo/warhead/cluster/OBShell = new
			OBShell.cluster_amount = tgui_input_number(src, "How many salvos should be fired?", "Set cluster number", 25, 100)
			if(isnull(OBShell.cluster_amount))
				return
			OBShell.cluster_power = tgui_input_number(src, "How strong should the blasts be?", "Set blast power", 240, EXPLOSION_MAX_POWER, 1)
			if(isnull(OBShell.cluster_power))
				return
			OBShell.cluster_falloff = tgui_input_number(src, "How much falloff should the blasts have?", "Set blast falloff", 40, EXPLOSION_MAX_POWER, 1)
			if(isnull(OBShell.cluster_falloff))
				return
			warhead = OBShell
		if("Custom Incendiary")
			var/obj/structure/ob_ammo/warhead/incendiary/OBShell = new
			OBShell.flame_intensity = tgui_input_number(src, "How intensive should the fire be?", "Set fire intensivity", 36)
			if(isnull(OBShell.flame_intensity))
				return
			OBShell.flame_duration = tgui_input_number(src, "How long should the fire last?", "Set fire duration", 40)
			if(isnull(OBShell.flame_duration))
				return
			var/list/fire_colors = list("red", "green", "blue")
			OBShell.flame_colour = tgui_input_list(usr, "Select the fire color:", "Fire color", fire_colors, "blue")
			if(isnull(OBShell.flame_colour))
				return
			OBShell.smoke_radius = tgui_input_number(src, "How far should the smoke go?", "Set smoke radius", 17)
			if(isnull(OBShell.smoke_radius))
				return
			OBShell.smoke_duration = tgui_input_number(src, "How long should the smoke last?", "Set smoke duration", 20)
			if(isnull(OBShell.smoke_duration))
				return
			warhead = OBShell
		if("Custom Plasmaloss")
			var/obj/structure/ob_ammo/warhead/plasmaloss/OBShell = new
			OBShell.smoke_radius = tgui_input_number(src, "How many tiles radius should the smoke be?", "Set smoke radius", 25)
			if(isnull(OBShell.smoke_radius))
				return
			OBShell.smoke_duration = tgui_input_number(src, "How long should the fire last? (In deci-seconds)", "Set smoke duration", 30)
			if(isnull(OBShell.smoke_duration))
				return
			warhead = OBShell
		else
			return

	var/turf/target = get_turf(usr.loc)

	switch(tgui_input_list(usr, "What do you want exactly?", "Mode", list("Immitate Orbital Cannon shot.", "Spawn OB effects.", "Spawn Warhead."), "Immitate Orbital Cannon shot", 0))
		if("Immitate Orbital Cannon shot.")
			playsound_z_humans(target.z, 'sound/effects/OB_warning_announce.ogg', 100) //for marines on ground
			playsound(target, 'sound/effects/OB_warning_announce_novoiceover.ogg', 125, FALSE, 30, 10) //VOX-less version for xenomorphs

			var/impact_time = 10 SECONDS
			var/impact_timerid = addtimer(CALLBACK(warhead, TYPE_PROC_REF(/obj/structure/ob_ammo/warhead, warhead_impact), target), impact_time, TIMER_STOPPABLE)

			var/canceltext = "Warhead: [warhead.warhead_kind]. Impact at [ADMIN_VERBOSEJMP(target)] <a href='?_src_=holder;[HrefToken(TRUE)];cancelob=[impact_timerid]'>\[CANCEL OB\]</a>"
			message_admins("[span_prefix("OB FIRED:")] <span class='message linkify'>[canceltext]</span>")
			log_game("OB fired by [key_name(usr)] at [AREACOORD(target)], OB type: [warhead.warhead_kind], timerid to cancel: [impact_timerid]")
			notify_ghosts("<b>[key_name(usr)]</b> has just fired \the <b>[warhead]</b>!", source = target, action = NOTIFY_JUMP)

			warhead.impact_message(target, impact_time)

			sleep((impact_time / 3) - 0.5 SECONDS)
			for(var/mob/our_mob AS in hearers(WARHEAD_FALLING_SOUND_RANGE, target))
				our_mob.playsound_local(target, 'sound/effects/OB_incoming.ogg', falloff = 2)
			new /obj/effect/temp_visual/ob_impact(target, warhead)
		if("Spawn OB effects.")
			message_admins("[key_name(usr)] has fired \an [warhead.name] at ([target.x],[target.y],[target.z]).")
			warhead.warhead_impact(target)
		if("Spawn Warhead.")
			warhead.loc = target

/datum/admins/proc/change_security_level()
	set category = "Admin.Fun"
	set name = "Set Security Level"

	if(!check_rights(R_FUN))
		return

	var/sec_level = tgui_input_list(usr, "It's currently code [GLOB.marine_main_ship.get_security_level()]. Choose the new security level.", "Set Security Level", list("green", "blue", "red", "delta") - GLOB.marine_main_ship.get_security_level())
	if(!sec_level)
		return

	if(tgui_alert(usr, "Switch from code [GLOB.marine_main_ship.get_security_level()] to code [sec_level]?", "Set Security Level", list("Yes", "No")) != "Yes")
		return

	GLOB.marine_main_ship.set_security_level(sec_level)

	log_admin("[key_name(usr)] changed the security level to code [sec_level].")
	message_admins("[ADMIN_TPMONTY(usr)] changed the security level to code [sec_level].")


/datum/admins/proc/rank_and_equipment(mob/living/carbon/human/H in GLOB.human_mob_list)
	set category = "Admin.Fun"
	set name = "Rank and Equipment"

	if(!check_rights(R_FUN))
		return

	var/dat = "<br>"
	var/obj/item/card/id/C = H.wear_id

	if(!H.mind)
		dat += "No mind! <a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=createmind;mob=[REF(H)]'>Create</a><br>"
		dat += "Take-over job: [H.job ? H.job.title : "None"] <a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=rank;mob=[REF(H)]'>Edit</a><br>"
		if(ismarinejob(H.job))
			dat += "Squad: [H.assigned_squad] <a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=squad;mob=[REF(H)]'>Edit</a><br>"
	else
		dat += "Job: [H.job ? H.job.title : "Unassigned"] <a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=rank;mob=[REF(H)]'>Edit</a> "
		dat += "<a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=rank;doequip=1;mob=[REF(H)]'>Edit and Equip</a> "
		dat += "<a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=rank;doset=1;mob=[REF(H)]'>Edit and Set</a><br>"
		dat += "<br>"
		dat += "Skillset: [H.skills.name] <a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=skills;mob=[REF(H)]'>Edit</a><br>"
		dat += "Comms title: [H.comm_title] <a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=commstitle;mob=[REF(H)]'>Edit</a><br>"
		if(ismarinejob(H.job))
			dat += "Squad: [H.assigned_squad] <a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=squad;mob=[REF(H)]'>Edit</a><br>"
	if(istype(C))
		dat += "<br>"
		dat += "Chat title: [get_paygrades(C.paygrade, FALSE, H.gender)] <a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=chattitle;mob=[REF(H)];id=[REF(C)]'>Edit</a><br>"
		dat += "ID title: [C.assignment] <a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=idtitle;mob=[REF(H)];id=[REF(C)]'>Edit</a><br>"
		dat += "ID name: [C.registered_name] <a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=idname;mob=[REF(H)];id=[REF(C)]'>Edit</a><br>"
		dat += "Access: [get_access_job_name(C)] <a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=access;mob=[REF(H)];id=[REF(C)]'>Edit</a><br>"
	else
		dat += "No ID! <a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=createid;mob=[REF(H)]'>Give ID</a><br>"

	dat += "<br>"
	dat += "<a href='?src=[REF(usr.client.holder)];[HrefToken()];rank=equipment;mob=[REF(H)]'>Select Equipment</a>"


	var/datum/browser/browser = new(usr, "edit_rank_[key_name(H)]", "<div align='center'>Edit Rank [key_name(H)]</div>", 400, 350)
	browser.set_content(dat)
	browser.open(FALSE)


/datum/admins/proc/edit_appearance(mob/living/carbon/human/H in GLOB.human_mob_list)
	set category = "Admin.Fun"
	set name = "Edit Appearance"

	if(!check_rights(R_FUN))
		return

	if(!istype(H))
		return

	var/hcolor = "#[num2hex(H.r_hair, 2)][num2hex(H.g_hair, 2)][num2hex(H.b_hair, 2)]"
	var/fcolor = "#[num2hex(H.r_facial, 2)][num2hex(H.g_facial, 2)][num2hex(H.b_facial, 2)]"
	var/ecolor = "#[num2hex(H.r_eyes, 2)][num2hex(H.g_eyes, 2)][num2hex(H.b_eyes, 2)]"
	var/bcolor = "#[num2hex(H.r_skin, 2)][num2hex(H.g_skin, 2)][num2hex(H.b_skin, 2)]"

	var/dat = "<br>"

	dat += "Hair style: [H.h_style] <a href='?src=[REF(usr.client.holder)];[HrefToken()];appearance=hairstyle;mob=[REF(H)]'>Edit</a><br>"
	dat += "Hair color: <font face='fixedsys' size='3' color='[hcolor]'><table style='display:inline;' bgcolor='[hcolor]'><tr><td>_.</td></tr></table></font> <a href='?src=[REF(usr.client.holder)];[HrefToken()];appearance=haircolor;mob=[REF(H)]'>Edit</a><br>"
	dat += "<br>"
	dat += "Facial hair style: [H.f_style] <a href='?src=[REF(usr.client.holder)];[HrefToken()];appearance=facialhairstyle;mob=[REF(H)]'>Edit</a><br>"
	dat += "Facial hair color: <font face='fixedsys' size='3' color='[fcolor]'><table style='display:inline;' bgcolor='[fcolor]'><tr><td>_.</td></tr></table></font> <a href='?src=[REF(usr.client.holder)];[HrefToken()];appearance=facialhaircolor;mob=[REF(H)]'>Edit</a><br>"
	dat += "<br>"
	dat += "Eye color: <font face='fixedsys' size='3' color='[ecolor]'><table style='display:inline;' bgcolor='[ecolor]'><tr><td>_.</td></tr></table></font> <a href='?src=[REF(usr.client.holder)];[HrefToken()];appearance=eyecolor;mob=[REF(H)]'>Edit</a><br>"
	dat += "Body color: <font face='fixedsys' size='3' color='[bcolor]'><table style='display:inline;' bgcolor='[bcolor]'><tr><td>_.</td></tr></table></font> <a href='?src=[REF(usr.client.holder)];[HrefToken()];appearance=bodycolor;mob=[REF(H)]'>Edit</a><br>"
	dat += "<br>"
	dat += "Gender: [H.gender] <a href='?src=[REF(usr.client.holder)];[HrefToken()];appearance=gender;mob=[REF(H)]'>Edit</a><br>"
	dat += "Ethnicity: [H.ethnicity] <a href='?src=[REF(usr.client.holder)];[HrefToken()];appearance=ethnicity;mob=[REF(H)]'>Edit</a><br>"
	dat += "Species: [H.species] <a href='?src=[REF(usr.client.holder)];[HrefToken()];appearance=species;mob=[REF(H)]'>Edit</a><br>"

	var/datum/browser/browser = new(usr, "edit_appearance_[key_name(H)]", "<div align='center'>Edit Appearance [key_name(H)]</div>")
	browser.set_content(dat)
	browser.open(FALSE)


/datum/admins/proc/offer(mob/living/L in GLOB.mob_living_list)
	set category = "Admin.Fun"
	set name = "Offer Mob"

	if(!check_rights(R_FUN))
		return

	if(L.client)
		if(tgui_alert(usr, "This mob has a player inside, are you sure you want to proceed?", "Offer Mob", list("Yes", "No")) != "Yes")
			return
		L.ghostize(FALSE)

	else if(L in GLOB.offered_mob_list)
		switch(tgui_alert(usr, "This mob has been offered, do you want to re-announce it?", "Offer Mob", list("Yes", "Remove", "Cancel")))
			if("Remove")
				GLOB.offered_mob_list -= L
				log_admin("[key_name(usr)] has removed offer of [key_name_admin(L)].")
				message_admins("[ADMIN_TPMONTY(usr)] has removed offer of [ADMIN_TPMONTY(L)].")
				return
			if(!"Yes")
				return

	else if(tgui_alert(usr, "Are you sure you want to offer this mob?", "Offer Mob", list("Yes", "No")) != "Yes")
		return

	if(!istype(L))
		to_chat(usr, span_warning("Target is no longer valid."))
		return

	L.offer_mob()

	log_admin("[key_name(usr)] has offered [key_name_admin(L)].")
	message_admins("[ADMIN_TPMONTY(usr)] has offered [ADMIN_TPMONTY(L)].")


/datum/admins/proc/xeno_panel(mob/living/carbon/xenomorph/X in GLOB.xeno_mob_list)
	set category = "Admin.Fun"
	set name = "Xeno Panel"

	if(!check_rights(R_FUN))
		return

	if(!istype(X))
		return

	var/dat = "<br>"

	dat += "Hive: [X.hive.hivenumber] <a href='?src=[REF(usr.client.holder)];[HrefToken()];xeno=hive;mob=[REF(X)]'>Edit</a><br>"
	dat += "Nicknumber: [X.nicknumber] <a href='?src=[REF(usr.client.holder)];[HrefToken()];xeno=nicknumber;mob=[REF(X)]'>Edit</a><br>"
	dat += "Upgrade Tier: [X.xeno_caste.upgrade_name] <a href='?src=[REF(usr.client.holder)];[HrefToken()];xeno=upgrade;mob=[REF(X)]'>Edit</a><br>"

	var/datum/browser/browser = new(usr, "xeno_panel_[key_name(X)]", "<div align='center'>Xeno Panel [key_name(X)]</div>")
	browser.set_content(dat)
	browser.open(FALSE)



/datum/admins/proc/release(obj/OB in world)
	set category = null
	set name = "Release Obj"

	if(!check_rights(R_FUN))
		return

	var/mob/M = usr

	if(!M.control_object)
		return

	var/obj/O = M.control_object

	var/datum/player_details/P = GLOB.player_details[M.ckey]

	M.real_name = P.played_names[length(P.played_names)]
	M.name = M.real_name

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.name = H.get_visible_name()

	M.loc = get_turf(M.control_object)
	M.reset_perspective()
	M.control_object = null

	log_admin("[key_name(usr)] has released [O] ([O.type]).")
	message_admins("[ADMIN_TPMONTY(usr)] has released [O] ([O.type]).")


/datum/admins/proc/possess(obj/O in world)
	set category = null
	set name = "Possess Obj"

	if(!check_rights(R_FUN))
		return

	var/mob/M = usr

	M.loc = O
	M.real_name = O.name
	M.name = O.name
	M.reset_perspective()
	M.control_object = O

	log_admin("[key_name(usr)] has possessed [O] ([O.type]).")
	message_admins("[ADMIN_TPMONTY(usr)] has possessed [O] ([O.type]).")


/datum/admins/proc/imaginary_friend()
	set category = "Admin.Fun"
	set name = "Imaginary Friend"

	if(!check_rights(R_FUN|R_MENTOR))
		return

	var/client/C = usr.client

	if(istype(C.mob, /mob/camera/imaginary_friend))
		var/mob/camera/imaginary_friend/IF = C.mob
		IF.ghostize()
		return

	var/mob/living/friend_owner = C.holder.apicker("Select by:", "Imaginary Friend", list(APICKER_CLIENT, APICKER_LIVING))
	if(!friend_owner)
		// nothing was picked, probably canceled
		return
	C.holder.create_ifriend(friend_owner)

/// Handles actually spawning in the friend, if the rest of the checks pass
/datum/admins/proc/create_ifriend(mob/living/friend_owner, seek_confirm = FALSE)
	if(!check_rights(R_FUN|R_MENTOR))
		return
	if(!istype(friend_owner)) // living only
		to_chat(usr, span_warning("That creature can not have Imaginary Friends") )
		return
	if(seek_confirm && tgui_alert(usr, "Become Imaginary Friend of [friend_owner]?", "Confirm", list("Yes", "No")) != "Yes")
		return

	var/client/C = usr.client
	if(!isobserver(C.mob))
		if(is_mentor(C) && tgui_alert(usr, "You will be unable to return to your old body without admin help. Are you sure?", "Confirm", list("Yes", "No")) != "Yes")
			return
		C.holder.admin_ghost()
	var/mob/camera/imaginary_friend/IF = new(get_turf(friend_owner), friend_owner)
	C.mob.mind.transfer_to(IF)

	admin_ticket_log(friend_owner, "[key_name_admin(C)] became an imaginary friend of [key_name(friend_owner)]")
	log_admin("[key_name(IF)] started being imaginary friend of [key_name(friend_owner)].")
	message_admins("[ADMIN_TPMONTY(IF)] started being imaginary friend of [ADMIN_TPMONTY(friend_owner)].")

/datum/admins/proc/force_dropship()
	set category = "Admin.Fun"
	set name = "Force Dropship"

	if(!check_rights(R_FUN))
		return

	if(!length(SSshuttle.dropship_list) && !SSshuttle.canterbury)
		return

	var/list/available_shuttles = list()
	for(var/i in SSshuttle.mobile_docking_ports)
		var/obj/docking_port/mobile/M = i
		available_shuttles["[M.name] ([M.shuttle_id])"] = M.shuttle_id

	var/answer = tgui_input_list(usr, "Which shuttle do you want to move?", "Force Dropship", available_shuttles)
	var/shuttle_id = available_shuttles[answer]
	if(!shuttle_id)
		return

	var/obj/docking_port/mobile/D
	for(var/i in SSshuttle.mobile_docking_ports)
		var/obj/docking_port/mobile/M = i
		if(M.shuttle_id != shuttle_id)
			continue
		D = M

	if(!D)
		to_chat(usr, span_warning("Unable to find shuttle"))
		return

	if(D.mode != SHUTTLE_IDLE && tgui_alert(usr, "[D.name] is not idle, move anyway?", "Force Dropship", list("Yes", "No")) != "Yes")
		return

	var/list/valid_docks = list()
	var/i = 1
	for(var/obj/docking_port/stationary/S in SSshuttle.stationary_docking_ports)
		if(istype(S, /obj/docking_port/stationary/transit))
			continue // Don't use transit destinations
		if(!D.check_dock(S, silent=TRUE))
			continue
		valid_docks["[S.name] ([i++])"] = S

	if(!length(valid_docks))
		to_chat(usr, span_warning("No valid destinations found!"))
		return

	var/dock = tgui_input_list(usr, "Choose the destination.", "Force Dropship", valid_docks)
	if(!dock)
		return

	var/obj/docking_port/stationary/target = valid_docks[dock]
	if(!target)
		to_chat(usr, span_warning("No valid dock found!"))
		return

	var/instant = FALSE
	if(tgui_alert(usr, "Do you want to move the [D.name] instantly?", "Force Dropship", list("Yes", "No")) == "Yes")
		instant = TRUE

	var/success = SSshuttle.moveShuttleToDock(D.shuttle_id, target, !instant)
	switch(success)
		if(0)
			success = "successfully"
		if(1)
			success = "failing to find the shuttle"
		if(2)
			success = "failing to dock"
		else
			success = "failing somehow"

	log_admin("[key_name(usr)] has moved [D.name] ([D.shuttle_id]) to [target] ([target.shuttle_id])[instant ? " instantly" : ""] [success].")
	message_admins("[ADMIN_TPMONTY(usr)] has moved [D.name] ([D.shuttle_id]) to [target] ([target.shuttle_id])[instant ? " instantly" : ""] [success].")


/datum/admins/proc/play_cinematic()
	set category = "Admin.Fun"
	set name = "Play Cinematic"

	if(!check_rights(R_FUN))
		return

	var/datum/cinematic/choice = tgui_input_list(usr, "Choose a cinematic to play.", "Play Cinematic", subtypesof(/datum/cinematic))
	if(!choice)
		return

	Cinematic(initial(choice.id), world)

	log_admin("[key_name(usr)] played the [choice] cinematic.")
	message_admins("[ADMIN_TPMONTY(usr)] played the [choice] cinematic.")


/datum/admins/proc/set_tip()
	set category = "Admin.Fun"
	set name = "Set Tip"

	if(!check_rights(R_FUN))
		return

	var/tip = tgui_input_text(usr, "Please specify your tip that you want to send to the players.", "Tip", multiline = TRUE, encode = FALSE)
	if(!tip)
		return

	SSticker.selected_tip = tip

	//If we've already tipped, then send it straight away.
	if(SSticker.tipped)
		SSticker.send_tip_of_the_round()

	log_admin("[key_name(usr)] set a tip of the round: [tip]")
	message_admins("[ADMIN_TPMONTY(usr)] set a tip of the round.")


/datum/admins/proc/ghost_interact()
	set category = "Admin.Fun"
	set name = "Ghost Interact"

	if(!check_rights(R_FUN))
		return

	usr.client.holder.ghost_interact = !usr.client.holder.ghost_interact

	log_admin("[key_name(usr)] has [usr.client.holder.ghost_interact ? "enabled" : "disabled"] ghost interact.")
	message_admins("[ADMIN_TPMONTY(usr)] has [usr.client.holder.ghost_interact ? "enabled" : "disabled"] ghost interact.")

/client/proc/run_weather()
	set category = "Admin.Fun"
	set name = "Run Weather"
	set desc = "Triggers a weather on the z-level you choose."

	if(!holder)
		return

	var/weather_type = tgui_input_list(usr, "Choose a weather", "Weather", subtypesof(/datum/weather))
	if(!weather_type)
		return

	var/turf/T = get_turf(mob)
	var/z_level = tgui_input_number(usr, "Z-Level to target?", "Z-Level", T?.z)
	if(!isnum(z_level))
		return

	SSweather.run_weather(weather_type, z_level)

	message_admins("[key_name_admin(usr)] started weather of type [weather_type] on the z-level [z_level].")
	log_admin("[key_name(usr)] started weather of type [weather_type] on the z-level [z_level].")
	SSblackbox.record_feedback(FEEDBACK_TALLY, "admin_verb", 1, "Run Weather")

///client verb to set round end sound
/client/proc/set_round_end_sound(S as sound)
	set category = "Admin.Fun"
	set name = "Set Round End Sound"
	if(!check_rights(R_SOUND))
		return

	SSticker.SetRoundEndSound(S)

	log_admin("[key_name(src)] set the round end sound to [S]")
	message_admins("[key_name_admin(src)] set the round end sound to [S]")
	SSblackbox.record_feedback(FEEDBACK_TALLY, "admin_verb", 1, "Set Round End Sound") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

///Adjusts gravity, modifying the jump component for all mobs
/datum/admins/proc/adjust_gravity()
	set category = "Admin.Fun"
	set name = "Adjust Gravity"

	if(!check_rights(R_FUN))
		return

	var/choice = tgui_input_list(usr, "What would you like to set gravity to?", "Gravity adjustment", list("Standard gravity", "Low gravity", "John Woo", "Exceeding orbital velocity"))
	switch(choice)
		if("Standard gravity")
			to_chat(GLOB.mob_living_list, span_userdanger("You feel gravity return to normal."))
			for(var/mob/living/living_mob AS in GLOB.mob_living_list)
				living_mob.set_jump_component()
		if("Low gravity")
			to_chat(GLOB.mob_living_list, span_userdanger("You feel gravity pull gently at you."))
			for(var/mob/living/living_mob AS in GLOB.mob_living_list)
				living_mob.set_jump_component(duration = 1 SECONDS, cooldown = 1.5 SECONDS, cost = 2, height = 32, jump_pass_flags = PASS_LOW_STRUCTURE|PASS_FIRE|PASS_DEFENSIVE_STRUCTURE|PASS_TANK)
		if("John Woo")
			to_chat(GLOB.mob_living_list, span_userdanger("You feel gravity grow weak, and the urge to fly."))
			for(var/mob/living/living_mob AS in GLOB.mob_living_list)
				living_mob.set_jump_component(duration = 1 SECONDS, cooldown = 1.5 SECONDS, cost = 2, height = 48, sound = SFX_JUMP, flags = JUMP_SPIN, jump_pass_flags = HOVERING|PASS_PROJECTILE|PASS_TANK)
		if("Exceeding orbital velocity")
			to_chat(GLOB.mob_living_list, span_userdanger("You feel gravity fade to nothing. Will you even come back down?"))
			for(var/mob/living/living_mob AS in GLOB.mob_living_list)
				living_mob.set_jump_component(duration = 4 SECONDS, cooldown = 6 SECONDS, cost = 0, height = 128, sound = SFX_JUMP, flags = JUMP_SPIN, jump_pass_flags = HOVERING|PASS_PROJECTILE|PASS_TANK)
		else
			return

	log_admin("[key_name(usr)] set gravity to [choice].")
