/datum/preferences/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)

		ui = new(user, src, "PlayerPreferences", "Preferences")
		ui.set_autoupdate(FALSE)
		ui.open()
		// HACK: Without this the character starts out really tiny because of some BYOND bug.
		// You can fix it by changing a preference, so let's just forcably update the body to emulate this.
		// Lemon from the future: this issue appears to replicate if the byond map (what we're relaying here)
		// Is shown while the client's mouse is on the screen. As soon as their mouse enters the main map, it's properly scaled
		// I hate this place
		addtimer(CALLBACK(src, PROC_REF(update_preview_icon)), 1 SECONDS)

/datum/preferences/ui_close(mob/user)
	. = ..()
	user.client?.clear_character_previews()

/datum/preferences/ui_state(mob/user)
	return GLOB.always_state

/datum/preferences/ui_data(mob/user)
	var/list/data = list()
	data["tabIndex"] = tab_index
	data["slot"] = default_slot
	data["save_slot_names"] = list()
	if(!path)
		return data
	var/savefile/S = new (path)
	if(!S)
		return data
	var/name
	for(var/i in 1 to MAX_SAVE_SLOTS)
		S.cd = "/character[i]"
		S["real_name"] >> name
		if(!name)
			continue
		data["save_slot_names"]["[i]"] = name

	data["unique_action_use_active_hand"] = unique_action_use_active_hand

	switch(tab_index)
		if(CHARACTER_CUSTOMIZATION)
			data["r_hair"] = r_hair
			data["g_hair"] = g_hair
			data["b_hair"] = b_hair
			data["r_grad"] = r_grad
			data["g_grad"] = g_grad
			data["b_grad"] = b_grad
			data["r_facial"] = r_facial
			data["g_facial"] = g_facial
			data["b_facial"] = b_facial
			data["r_eyes"] = r_eyes
			data["g_eyes"] = g_eyes
			data["b_eyes"] = b_eyes
			data["real_name"] = real_name
			data["xeno_name"] = xeno_name
			data["synthetic_name"] = synthetic_name
			data["synthetic_type"] = synthetic_type
			data["squad_robot_name"] = squad_robot_name
			data["squad_robot_type"] = squad_robot_type
			data["random_name"] = random_name
			data["ai_name"] = ai_name
			data["age"] = age
			data["gender"] = gender
			data["ethnicity"] = ethnicity
			data["species"] = species || "Human"
			data["good_eyesight"] = good_eyesight
			data["citizenship"] = citizenship
			data["religion"] = religion
			data["h_style"] = h_style
			data["grad_style"] = grad_style
			data["f_style"] = f_style
		if(PRED_CHARACTER_CUSTOMIZATION)
			data["has_wl"] = GLOB.roles_whitelist[user.ckey] & WHITELIST_PREDATOR
			data["legacy"] = GLOB.roles_whitelist[user.ckey] & WHITELIST_YAUTJA_LEGACY
			data["predator_name"] = predator_name
			data["predator_gender"] = predator_gender
			data["predator_age"] = predator_age
			data["predator_h_style"] = predator_h_style
			data["predator_skin_color"] = predator_skin_color
			data["predator_use_legacy"] = predator_use_legacy
			data["predator_translator_type"] = predator_translator_type
			data["predator_mask_type"] = predator_mask_type
			data["predator_armor_type"] = predator_armor_type
			data["predator_boot_type"] = predator_boot_type
			data["predator_armor_material"] = predator_armor_material
			data["predator_mask_material"] = predator_mask_material
			data["predator_greave_material"] = predator_greave_material
			data["predator_caster_material"] = predator_caster_material
			data["predator_cape_type"] = predator_cape_type
			data["predator_cape_color"] = predator_cape_color
			data["predator_flavor_text"] = predator_flavor_text
			data["pred_r_eyes"] = pred_r_eyes
			data["pred_g_eyes"] = pred_g_eyes
			data["pred_b_eyes"] = pred_b_eyes
			data["yautja_status"] = yautja_status
		if(BACKGROUND_INFORMATION)
			data["slot"] = default_slot
			data["flavor_text"] = flavor_text
			data["med_record"] = med_record
			data["gen_record"] = gen_record
			data["sec_record"] = sec_record
			data["exploit_record"] = exploit_record
		if(GEAR_CUSTOMIZATION)
			data["gearsets"] = list()
			for(var/g in GLOB.gear_datums)
				var/datum/gear/gearset = GLOB.gear_datums[g]
				data["gearsets"][gearset.display_name] = list(
					"name" = gearset.display_name,
					"cost" = gearset.cost,
					"slot" = gearset.slot,
				)
			data["gear"] = gear || list()
			data["undershirt"] = undershirt
			data["underwear"] = underwear
			data["backpack"] = backpack
			data["gender"] = gender
		if(JOB_PREFERENCES)
			data["job_preferences"] = job_preferences
			data["preferred_squad"] = preferred_squad
			data["alternate_option"] = alternate_option
			data["special_occupation"] = be_special
		if(GAME_SETTINGS)
			data["is_admin"] = user.client?.holder ? TRUE : FALSE
			data["ui_style_color"] = ui_style_color
			data["ui_style"] = ui_style
			data["ui_style_alpha"] = ui_style_alpha
			data["windowflashing"] = windowflashing
			data["auto_fit_viewport"] = auto_fit_viewport
			data["accessible_tgui_themes"] = accessible_tgui_themes
			data["tgui_fancy"] = tgui_fancy
			data["tgui_input"] = tgui_input
			data["tgui_input_big_buttons"] = tgui_input_big_buttons
			data["tgui_input_buttons_swap"] = tgui_input_buttons_swap
			data["clientfps"] = clientfps
			data["chat_on_map"] = chat_on_map
			data["max_chat_length"] = max_chat_length
			data["see_chat_non_mob"] = see_chat_non_mob
			data["see_rc_emotes"] = see_rc_emotes
			data["mute_others_combat_messages"] = mute_others_combat_messages
			data["mute_self_combat_messages"] = mute_self_combat_messages
			data["show_xeno_rank"] = show_xeno_rank
			data["show_typing"] = show_typing
			data["tooltips"] = tooltips
			data["widescreenpref"] = widescreenpref
			data["radialmedicalpref"] = !!(toggles_gameplay & RADIAL_MEDICAL)
			data["radialstackspref"] = !!(toggles_gameplay & RADIAL_STACKS)
			data["radiallasersgunpref"] = !!(toggles_gameplay & RADIAL_LASERGUNS)
			data["autointeractdeployablespref"] = !!(toggles_gameplay & AUTO_INTERACT_DEPLOYABLES)
			data["directional_attacks"] = !!(toggles_gameplay & DIRECTIONAL_ATTACKS)
			data["toggle_clickdrag"] = !(toggles_gameplay & TOGGLE_CLICKDRAG)
			data["scaling_method"] = scaling_method
			data["pixel_size"] = pixel_size
			data["parallax"] = parallax
			data["fullscreen_mode"] = fullscreen_mode
			data["show_status_bar"] = show_status_bar
			data["ambient_occlusion"] = ambient_occlusion
			data["multiz_parallax"] = multiz_parallax
			data["multiz_performance"] = multiz_performance
			data["fast_mc_refresh"] = fast_mc_refresh
			data["split_admin_tabs"] = split_admin_tabs
			data["hear_ooc_anywhere_as_staff"] = hear_ooc_anywhere_as_staff
			data["volume_adminhelp"] = volume_adminhelp
			data["volume_adminmusic"] = volume_adminmusic
			data["volume_ambience"] = volume_ambience
			data["volume_lobby"] = volume_lobby
			data["volume_instruments"] = volume_instruments
			data["volume_weather"] = volume_weather
			data["volume_end_of_round"] = volume_end_of_round
		if(KEYBIND_SETTINGS)
			data["is_admin"] = user.client?.holder ? TRUE : FALSE
			data["key_bindings"] = list()
			for(var/key in key_bindings)
				for(var/kb_name in key_bindings[key])
					data["key_bindings"][kb_name] += list(key)
			data["custom_emotes"] = list()
			for(var/id in 1 to CUSTOM_EMOTE_SLOTS)
				var/datum/custom_emote/emote = custom_emotes[id]
				data["custom_emotes"]["Custom emote :[id]"] = list(
					sentence = emote.message,
					emote_type = (emote.spoken_emote ? "say" : "me"),
					)
		if(DRAW_ORDER)
			data["draw_order"] = list()
			for(var/slot in slot_draw_order_pref)
				data["draw_order"] += slot_flag_to_fluff(slot)
			data["quick_equip"] = list()
			for(var/quick_equip_slots in quick_equip)
				data["quick_equip"] += slot_flag_to_fluff(quick_equip_slots)
	return data

/datum/preferences/ui_static_data(mob/user)
	. = list()
	switch(tab_index)
		if(CHARACTER_CUSTOMIZATION, PRED_CHARACTER_CUSTOMIZATION)
			.["mapRef"] = "player_pref_map"
		if(GEAR_CUSTOMIZATION)
			.["clothing"] = list(
				"underwear" = list(
					"male" = GLOB.underwear_m,
					"female" = GLOB.underwear_f,
					"plural" = GLOB.underwear_f + GLOB.underwear_m,
				),
				"undershirt" = list(
					"male" = GLOB.undershirt_m,
					"female" = GLOB.undershirt_f,
					"plural" = GLOB.undershirt_m + GLOB.undershirt_f,
				),
				"backpack" = GLOB.backpacklist,
				)
			.["gearsets"] = list()
			for(var/g in GLOB.gear_datums)
				var/datum/gear/gearset = GLOB.gear_datums[g]
				.["gearsets"][gearset.display_name] = list(
					"name" = gearset.display_name,
					"cost" = gearset.cost,
					"slot" = gearset.slot,
				)
		if(JOB_PREFERENCES)
			.["squads"] = SELECTABLE_SQUADS
			.["jobs"] = list()
			for(var/datum/job/job AS in SSjob.joinable_occupations)
				var/rank = job.title
				.["jobs"][rank] = list(
					"color" = job.selection_color,
					"description" = job.html_description,
					"banned" = is_banned_from(user.ckey, rank),
					"playtime_req" = job.required_playtime_remaining(user.client),
					"exp_string" = "[get_exp_format(text2num(user.client.calc_exp_type(job.get_exp_req_type())))] / [get_exp_format(job.get_exp_req_amount())] as [job.get_exp_req_type()]",
					"account_age_req" = !job.player_old_enough(user.client),
					"flags" = list(
						"bold" = (job.job_flags & JOB_FLAG_BOLD_NAME_ON_SELECTION) ? TRUE : FALSE
					)
				)
			.["overflow_job"] = SSjob?.overflow_role?.title
			.["special_occupations"] = list(
				"Latejoin Xenomorph" = BE_ALIEN,
				"Xenomorph when unrevivable" = BE_ALIEN_UNREVIVABLE,
				"End of Round Deathmatch" = BE_DEATHMATCH,
				"Prefer Squad over Role" = BE_SQUAD_STRICT
			)
		if(KEYBIND_SETTINGS)
			.["all_keybindings"] = list()
			for(var/name in GLOB.keybindings_by_name)
				var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
				.["all_keybindings"][kb.category] += list(list(
					name = kb.name,
					display_name = kb.full_name,
					desc = kb.description,
					category = kb.category,
				))

/datum/preferences/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	var/client/current_client = CLIENT_FROM_VAR(usr)
	var/mob/user = current_client.mob

	switch(action)
		if("changeslot")
			if(!load_character(text2num(params["changeslot"])))
				random_character()
				real_name = random_unique_name(gender)
				save_character()
				update_preview_icon()

		if("tab_change")
			tab_index = params["tabIndex"]
			update_static_data(ui.user, ui)

		if("random")
			randomize_appearance_for()
			save_character()
			update_preview_icon()

		if("name_real")
			var/newValue = params["newValue"]
			newValue = reject_bad_name(newValue, TRUE)
			if(!newValue)
				tgui_alert(user, "Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .", "Invalid name", list("Ok"))
				return
			real_name = newValue

		if("randomize_name")
			var/datum/species/S = GLOB.all_species[species]
			real_name = S.random_name(gender)

		if("toggle_always_random")
			random_name = !random_name

		if("randomize_appearance")
			randomize_appearance_for()
			update_preview_icon()

		if("synthetic_name")
			var/newValue = params["newValue"]
			newValue = reject_bad_name(newValue, TRUE)
			if(!newValue)
				tgui_alert(user, "Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .", "Invalid name", list("Ok"))
				return
			synthetic_name = newValue

		if("synthetic_type")
			var/choice = tgui_input_list(ui.user, "What kind of synthetic do you want to play with?", "Synthetic type choice", SYNTH_TYPES)
			if(!choice)
				return
			synthetic_type = choice
			update_preview_icon()

		if("predator_name")
			var/raw_name = input(user, "Choose your Predator's name:", "Character Preference")  as text|null
			if(raw_name) // Check to ensure that the user entered text (rather than cancel.)
				var/new_name = reject_bad_name(raw_name)
				if(new_name) predator_name = new_name
				else to_chat(user, "Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .")

		if("predator_gender")
			predator_gender = predator_gender == MALE ? FEMALE : MALE

		if("predator_age")
			var/new_predator_age = tgui_input_number(user, "Choose your Predator's age(20 to 10000):", "Character Preference", 1234, 10000, 20)
			if(new_predator_age) predator_age = max(min( round(text2num(new_predator_age)), 10000),20)

		if("predator_use_legacy")
			var/legacy_choice = tgui_input_list(user, "What legacy set do you wish to use?", "Legacy Set", PRED_LEGACIES)
			if(!legacy_choice)
				return
			predator_use_legacy = legacy_choice

		if("predator_translator_type")
			var/new_translator_type = tgui_input_list(user, "Choose your translator type.", "Translator Type", PRED_TRANSLATORS)
			if(!new_translator_type)
				return
			predator_translator_type = new_translator_type

		if("predator_mask_type")
			var/new_predator_mask_type = tgui_input_number(user, "Choose your mask type:\n(1-12)", "Mask Selection", 1, 12, 1)
			if(new_predator_mask_type) predator_mask_type = round(text2num(new_predator_mask_type))
			update_preview_icon(SSjob.GetJobType(/datum/job/predator), DUMMY_PRED_SLOT_PREFERENCES)

		if("predator_armor_type")
			var/new_predator_armor_type = tgui_input_number(user, "Choose your armor type:\n(1-7)", "Armor Selection", 1, 7, 1)
			if(new_predator_armor_type) predator_armor_type = round(text2num(new_predator_armor_type))
			update_preview_icon(SSjob.GetJobType(/datum/job/predator), DUMMY_PRED_SLOT_PREFERENCES)

		if("predator_boot_type")
			var/new_predator_boot_type = tgui_input_number(user, "Choose your greaves type:\n(1-4)", "Greave Selection", 1, 4, 1)
			if(new_predator_boot_type) predator_boot_type = round(text2num(new_predator_boot_type))
			update_preview_icon(SSjob.GetJobType(/datum/job/predator), DUMMY_PRED_SLOT_PREFERENCES)

		if("predator_mask_material")
			var/new_pred_mask_mat = tgui_input_list(user, "Choose your mask material:", "Mask Material", PRED_MATERIALS)
			if(!new_pred_mask_mat)
				return
			predator_mask_material = new_pred_mask_mat
			update_preview_icon(SSjob.GetJobType(/datum/job/predator), DUMMY_PRED_SLOT_PREFERENCES)

		if("predator_armor_material")
			var/new_pred_armor_mat = tgui_input_list(user, "Choose your armor material:", "Armor Material", PRED_MATERIALS)
			if(!new_pred_armor_mat)
				return
			predator_armor_material = new_pred_armor_mat
			update_preview_icon(SSjob.GetJobType(/datum/job/predator), DUMMY_PRED_SLOT_PREFERENCES)

		if("predator_greave_material")
			var/new_pred_greave_mat = tgui_input_list(user, "Choose your greave material:", "Greave Material", PRED_MATERIALS)
			if(!new_pred_greave_mat)
				return
			predator_greave_material = new_pred_greave_mat
			update_preview_icon(SSjob.GetJobType(/datum/job/predator), DUMMY_PRED_SLOT_PREFERENCES)

		if("predator_caster_material")
			var/new_pred_caster_mat = tgui_input_list(user, "Choose your caster material:", "Caster Material", PRED_MATERIALS + "retro")
			if(!new_pred_caster_mat)
				return
			predator_caster_material = new_pred_caster_mat
			update_preview_icon(SSjob.GetJobType(/datum/job/predator), DUMMY_PRED_SLOT_PREFERENCES)

		if("predator_cape_type")
			var/datum/job/J = SSjob.GetJobType(/datum/job/predator)
			var/whitelist_status = GLOB.clan_ranks_ordered[J.get_whitelist_status(GLOB.roles_whitelist, current_client)]

			var/list/options = list("None", "Default")
			for(var/cape_name in GLOB.all_yautja_capes)
				var/obj/item/clothing/yautja_cape/cape = GLOB.all_yautja_capes[cape_name]
				if(whitelist_status >= initial(cape.clan_rank_required) || (initial(cape.councillor_override) && (GLOB.roles_whitelist[user.ckey] & (WHITELIST_YAUTJA_COUNCIL|WHITELIST_YAUTJA_COUNCIL_LEGACY))))
					options += cape_name

			var/new_cape = tgui_input_list(user, "Choose your cape type:", "Cape Type", options)
			if(!new_cape)
				return
			predator_cape_type = new_cape
			update_preview_icon(SSjob.GetJobType(/datum/job/predator), DUMMY_PRED_SLOT_PREFERENCES)

		if("predator_cape_color")
			var/new_cape_color = input(user, "Choose your cape color:", "Cape Color") as null|color
			if(!new_cape_color)
				return
			predator_cape_color = new_cape_color
			update_preview_icon(SSjob.GetJobType(/datum/job/predator), DUMMY_PRED_SLOT_PREFERENCES)

		if("predator_h_style")
			var/new_h_style = input(user, "Choose your quill style:", "Quill Style") as null|anything in GLOB.yautja_hair_styles_list
			if(!new_h_style)
				return
			predator_h_style = new_h_style
			update_preview_icon(SSjob.GetJobType(/datum/job/predator), DUMMY_PRED_SLOT_PREFERENCES)

		if("predator_skin_color")
			var/new_skin_color = tgui_input_list(user, "Choose your skin color:", "Skin Color", PRED_SKIN_COLOR)
			if(!new_skin_color)
				return
			predator_skin_color = new_skin_color
			update_preview_icon(SSjob.GetJobType(/datum/job/predator), DUMMY_PRED_SLOT_PREFERENCES)

		if("predator_flavor_text")
			var/pred_flv_raw = input(user, "Choose your Predator's flavor text:", "Flavor Text", predator_flavor_text) as message
			if(!pred_flv_raw)
				predator_flavor_text = "None"
				return
			predator_flavor_text = strip_html(pred_flv_raw, MAX_MESSAGE_LEN)

		if("pred_eyecolor")
			var/eyecolor = input(user, "Choose your character's eye colour:", "Character Preference") as null|color
			if(!eyecolor)
				return
			pred_r_eyes = hex2num(copytext_char(eyecolor, 2, 4))
			pred_g_eyes = hex2num(copytext_char(eyecolor, 4, 6))
			pred_b_eyes = hex2num(copytext_char(eyecolor, 6, 8))
			update_preview_icon(SSjob.GetJobType(/datum/job/predator), DUMMY_PRED_SLOT_PREFERENCES)

		if("yautja_status")
			var/list/options = list("Normal" = WHITELIST_NORMAL)

			if(GLOB.roles_whitelist[user.ckey] & (WHITELIST_YAUTJA_COUNCIL|WHITELIST_YAUTJA_COUNCIL_LEGACY))
				options += list("Council" = WHITELIST_COUNCIL)
			if(GLOB.roles_whitelist[user.ckey] & WHITELIST_YAUTJA_LEADER)
				options += list("Leader" = WHITELIST_LEADER)

			var/new_yautja_status = tgui_input_list(user, "Choose your new Yautja Whitelist Status.", "Yautja Status", options)
			if(!new_yautja_status)
				return

			yautja_status = options[new_yautja_status]

		if("squad_robot_name")
			var/newValue = params["newValue"]
			newValue = reject_bad_name(newValue, TRUE)
			if(!newValue)
				tgui_alert(user, "Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .", "Invalid name", list("Ok"))
				return
			squad_robot_name = newValue

		if("squad_robot_type")
			var/choice = tgui_input_list(ui.user, "What model of robot do you want to play with?", "Robot model choice", ROBOT_TYPES)
			if(!choice)
				return
			squad_robot_type = choice
			update_preview_icon()

		if("xeno_name")
			var/newValue = params["newValue"]
			if(newValue == "")
				xeno_name = "Undefined"
			else
				newValue = reject_bad_name(newValue)
				if(!newValue)
					tgui_alert(user, "Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .", "Invalid name", list("Ok"))
					return
				xeno_name = newValue

		if("ai_name")
			var/newValue = params["newValue"]
			if(newValue == "")
				ai_name = "ARES v3.2"
			else
				newValue = reject_bad_name(newValue, TRUE)
				if(!newValue)
					tgui_alert(user, "Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .", "Invalid name", list("Ok"))
					return
				ai_name = newValue

		if("age")
			var/new_age = text2num(params["newValue"])
			if(!isnum(new_age))
				return
			new_age = round(new_age)
			age = clamp(new_age, AGE_MIN, AGE_MAX)

		if("toggle_gender")
			gender = params["newgender"]
			if(gender == FEMALE)
				f_style = "Shaved"
			else
				underwear = 1
			update_preview_icon()


		if("ethnicity")
			var/choice = tgui_input_list(ui.user, "What ethnicity do you want to play with?", "Ethnicity choice", GLOB.human_ethnicities_list)
			if(!choice)
				return
			ethnicity = choice
			update_preview_icon()

		if("species")
			var/choice = tgui_input_list(ui.user, "What species do you want to play with?", "Species choice", get_playable_species())
			if(!choice || species == choice)
				return
			species = choice
			var/datum/species/S = GLOB.all_species[species]
			real_name = S.random_name(gender)
			update_preview_icon()

		if("toggle_eyesight")
			good_eyesight = !good_eyesight

		if("be_special")
			var/flag = text2num(params["flag"])
			TOGGLE_BITFIELD(be_special, flag)

		if("jobselect")
			UpdateJobPreference(user, params["job"], text2num(params["level"]))
			update_preview_icon()

		if("jobalternative")
			var/newValue = text2num(params["newValue"])
			alternate_option = clamp(newValue, 0, 2)

		if("jobreset")
			job_preferences = list()
			preferred_squad = "None"
			alternate_option = 2 // return to lobby
			update_preview_icon()

		if("underwear")
			var/list/underwear_options
			if(gender == MALE)
				underwear_options = GLOB.underwear_m
			else
				underwear_options = GLOB.underwear_f

			var/new_underwear = underwear_options.Find(params["newValue"])
			if(!new_underwear)
				return
			underwear = new_underwear
			update_preview_icon()

		if("undershirt")
			var/list/undershirt_options
			if(gender == MALE)
				undershirt_options = GLOB.undershirt_m
			else
				undershirt_options = GLOB.undershirt_f

			var/new_undershirt = undershirt_options.Find(params["newValue"])
			if(!new_undershirt)
				return
			undershirt = new_undershirt
			update_preview_icon()

		if("backpack")
			var/new_backpack = GLOB.backpacklist.Find(params["newValue"])
			if(!new_backpack)
				return
			backpack = new_backpack
			update_preview_icon()

		if("loadoutadd")
			var/choice = params["gear"]
			if(!(choice in GLOB.gear_datums))
				return

			var/total_cost = 0
			var/datum/gear/C = GLOB.gear_datums[choice]

			if(!C)
				return

			if(length(gear))
				for(var/gear_name in gear)
					if(GLOB.gear_datums[gear_name])
						var/datum/gear/G = GLOB.gear_datums[gear_name]
						total_cost += G.cost

			total_cost += C.cost
			if(total_cost <= MAX_GEAR_COST)
				if(!islist(gear))
					gear = list()
				gear += choice
				to_chat(user, span_notice("Added '[choice]' for [C.cost] points ([MAX_GEAR_COST - total_cost] points remaining)."))
			else
				to_chat(user, span_warning("Adding '[choice]' will exceed the maximum loadout cost of [MAX_GEAR_COST] points."))

		if("loadoutremove")
			gear.Remove(params["gear"])
			if(!islist(gear))
				gear = list()

		if("loadoutclear")
			gear.Cut()
			if(!islist(gear))
				gear = list()

		if("ui")
			var/choice = tgui_input_list(ui.user, "What UI style do you want?", "UI style choice", UI_STYLES)
			if(!choice)
				return
			ui_style = choice

		if("uicolor")
			var/ui_style_color_new = input(user, "Choose your UI color, dark colors are not recommended!", "UI Color") as null|color
			if(!ui_style_color_new)
				return
			ui_style_color = ui_style_color_new

		if("uialpha")
			var/ui_style_alpha_new = text2num(params["newValue"])
			if(!ui_style_alpha_new)
				return
			ui_style_alpha_new = round(ui_style_alpha_new)
			ui_style_alpha = clamp(ui_style_alpha_new, 55, 230)

		if("hairstyle")
			var/list/valid_hairstyles = list()
			for(var/hairstyle in GLOB.hair_styles_list)
				var/datum/sprite_accessory/S = GLOB.hair_styles_list[hairstyle]
				if(!(species in S.species_allowed))
					continue

				valid_hairstyles[hairstyle] = GLOB.hair_styles_list[hairstyle]
			var/choice = tgui_input_list(ui.user, "What hair style do you want?", "Hair style choice", valid_hairstyles)
			if(!choice)
				return
			h_style = choice
			update_preview_icon()

		if("haircolor")
			var/new_color = input(user, "Choose your character's hair colour:", "Hair Color") as null|color
			if(!new_color)
				return
			r_hair = hex2num(copytext(new_color, 2, 4))
			g_hair = hex2num(copytext(new_color, 4, 6))
			b_hair = hex2num(copytext(new_color, 6, 8))

		if("grad_color")
			var/new_grad = input(user, "Choose your character's secondary hair color:", "Gradient Color") as null|color
			if(!new_grad)
				return
			r_grad = hex2num(copytext(new_grad, 2, 4))
			g_grad = hex2num(copytext(new_grad, 4, 6))
			b_grad = hex2num(copytext(new_grad, 6, 8))
			update_preview_icon()

		if("grad_style")
			var/list/valid_grads = list()
			for(var/grad in GLOB.hair_gradients_list)
				var/datum/sprite_accessory/S = GLOB.hair_gradients_list[grad]
				if(!(species in S.species_allowed))
					continue

				valid_grads[grad] = GLOB.hair_gradients_list[grad]

			var/choice = tgui_input_list(ui.user, "What hair grad style do you want?", "Hair grad style choice", valid_grads)
			if(choice)
				grad_style = choice
			update_preview_icon()

		if("facial_style")
			var/list/valid_facialhairstyles = list()
			for(var/facialhairstyle in GLOB.facial_hair_styles_list)
				var/datum/sprite_accessory/S = GLOB.facial_hair_styles_list[facialhairstyle]
				if(gender == FEMALE && S.gender == MALE)
					continue
				if(!(species in S.species_allowed))
					continue

				valid_facialhairstyles[facialhairstyle] = GLOB.facial_hair_styles_list[facialhairstyle]

			var/choice = tgui_input_list(ui.user, "What facial hair style do you want?", "Facial hair style choice", valid_facialhairstyles)
			if(!choice)
				return
			f_style = choice
			update_preview_icon()

		if("facialcolor")
			var/facial_color = input(user, "Choose your character's facial-hair colour:", "Facial Hair Color") as null|color
			if(!facial_color)
				return
			r_facial = hex2num(copytext(facial_color, 2, 4))
			g_facial = hex2num(copytext(facial_color, 4, 6))
			b_facial = hex2num(copytext(facial_color, 6, 8))
			update_preview_icon()

		if("eyecolor")
			var/eyecolor = input(user, "Choose your character's eye colour:", "Character Preference") as null|color
			if(!eyecolor)
				return
			r_eyes = hex2num(copytext(eyecolor, 2, 4))
			g_eyes = hex2num(copytext(eyecolor, 4, 6))
			b_eyes = hex2num(copytext(eyecolor, 6, 8))
			update_preview_icon()

		if("citizenship")
			var/choice = tgui_input_list(ui.user, "Where do you hail from?", "Place of Origin", CITIZENSHIP_CHOICES)
			if(!choice)
				return
			citizenship = choice

		if("religion")
			var/choice = tgui_input_list(ui.user, "What religion do you belive in?", "Belief", RELIGION_CHOICES)
			if(!choice)
				return
			religion = choice

		if("squad")
			var/new_squad = params["newValue"]
			if(!(new_squad in SELECTABLE_SQUADS))
				return
			preferred_squad = new_squad

		if("med_record")
			var/new_record = trim(html_encode(params["medicalDesc"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			med_record = new_record

		if("sec_record")
			var/new_record = trim(html_encode(params["securityDesc"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			sec_record = new_record

		if("gen_record")
			var/new_record = trim(html_encode(params["employmentDesc"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			gen_record = new_record

		if("exploit_record")
			var/new_record = trim(html_encode(params["exploitsDesc"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			exploit_record = new_record

		if("flavor_text")
			var/new_record = trim(html_encode(params["characterDesc"]), MAX_MESSAGE_LEN)
			if(!new_record)
				return
			flavor_text = new_record

		if("windowflashing")
			windowflashing = !windowflashing

		if("auto_fit_viewport")
			auto_fit_viewport = !auto_fit_viewport
			parent?.attempt_auto_fit_viewport()

		if("accessible_tgui_themes")
			accessible_tgui_themes = !accessible_tgui_themes

		if("tgui_fancy")
			tgui_fancy = !tgui_fancy

		if("tgui_lock")
			tgui_lock = !tgui_lock

		if("tgui_input")
			tgui_input = !tgui_input

		if("tgui_input_big_buttons")
			tgui_input_big_buttons = !tgui_input_big_buttons

		if("tgui_input_buttons_swap")
			tgui_input_buttons_swap = !tgui_input_buttons_swap

		if("clientfps")
			var/desiredfps = text2num(params["newValue"])
			if(!isnum(desiredfps))
				return
			desiredfps = clamp(desiredfps, 0, 240)
			clientfps = desiredfps
			parent.fps = desiredfps

		if("chat_on_map")
			chat_on_map = !chat_on_map

		if ("max_chat_length")
			var/desiredlength = text2num(params["newValue"])
			if(!isnull(desiredlength))
				max_chat_length = clamp(desiredlength, 1, CHAT_MESSAGE_MAX_LENGTH)

		if("see_chat_non_mob")
			see_chat_non_mob = !see_chat_non_mob

		if("see_rc_emotes")
			see_rc_emotes = !see_rc_emotes

		if("mute_self_combat_messages")
			mute_self_combat_messages = !mute_self_combat_messages

		if("mute_others_combat_messages")
			mute_others_combat_messages = !mute_others_combat_messages

		if("show_xeno_rank")
			show_xeno_rank = !show_xeno_rank

		if("change_quick_equip")
			var/editing_slot = params["selection"]
			var/slot = tgui_input_list(usr, "Which slot would you like to draw/equip from?", "Preferred Slot", SLOT_FLUFF_DRAW)
			if(!slot)
				return
			quick_equip[editing_slot] = slot_fluff_to_flag(slot)
			to_chat(src, span_notice("You will now equip/draw from the [slot] slot first."))

		if("equip_slot_equip_position")
			var/returned_item_list_position = slot_draw_order_pref.Find(slot_fluff_to_flag(params["changing_item"]))
			if(isnull(returned_item_list_position))
				return
			var/direction = params["direction"]
			if(!direction)
				return
			var/swapping_with = returned_item_list_position
			switch(direction)
				if("down")
					if(returned_item_list_position == length(SLOT_DRAW_ORDER))
						return
					swapping_with += 1
					slot_draw_order_pref.Swap(returned_item_list_position, swapping_with)
				if("up")
					if(returned_item_list_position == 1)
						return
					swapping_with -= 1
					slot_draw_order_pref.Swap(swapping_with, returned_item_list_position)

		if("show_typing")
			show_typing = !show_typing
			// Need to remove any currently shown
			if(!show_typing && istype(user))
				user.remove_all_indicators()

		if("tooltips")
			tooltips = !tooltips
			if(!tooltips)
				closeToolTip(usr)
			else if(!current_client.tooltips && tooltips)
				current_client.tooltips = new /datum/tooltip(current_client)

		if("fullscreen_mode")
			fullscreen_mode = !fullscreen_mode
			user.client?.set_fullscreen(fullscreen_mode)

		if("show_status_bar")
			show_status_bar = !show_status_bar
			user.client?.toggle_status_bar(show_status_bar)

		if("ambient_occlusion")
			ambient_occlusion = !ambient_occlusion
			for(var/atom/movable/screen/plane_master/plane_master as anything in parent.mob?.hud_used?.get_true_plane_masters(GAME_PLANE))
				plane_master.show_to(parent.mob)

		if("multiz_parallax")
			multiz_parallax = !multiz_parallax
			var/datum/hud/my_hud = parent.mob?.hud_used
			if(!my_hud)
				return

			for(var/group_key as anything in my_hud.master_groups)
				var/datum/plane_master_group/group = my_hud.master_groups[group_key]
				group.build_planes_offset(my_hud, my_hud.current_plane_offset)

		if("multiz_performance")
			multiz_performance = WRAP(multiz_performance + 1, MAX_EXPECTED_Z_DEPTH-1, MULTIZ_PERFORMANCE_DISABLE + 1)
			var/datum/hud/my_hud = parent.mob?.hud_used
			if(!my_hud)
				return

			for(var/group_key as anything in my_hud.master_groups)
				var/datum/plane_master_group/group = my_hud.master_groups[group_key]
				group.build_planes_offset(my_hud, my_hud.current_plane_offset)

		if("set_keybind")
			var/kb_name = params["keybind_name"]
			if(!kb_name)
				return

			var/old_key = params["old_key"]
			if(key_bindings[old_key])
				key_bindings[old_key] -= kb_name
				if(!length(key_bindings[old_key]))
					key_bindings -= old_key

			if(!params["key"])
				return
			var/mods = params["key_mods"]
			var/full_key = convert_ru_key_to_en_key(params["key"])
			var/Altmod = ("ALT" in mods) ? "Alt" : ""
			var/Ctrlmod = ("CONTROL" in mods) ? "Ctrl" : ""
			var/Shiftmod = ("SHIFT" in mods) ? "Shift" : ""
			full_key = Altmod + Ctrlmod + Shiftmod + full_key

			if(GLOB._kbMap[full_key])
				full_key = GLOB._kbMap[full_key]

			if(kb_name in key_bindings[full_key]) //We pressed the same key combination that was already bound here, so let's remove to re-add and re-sort.
				key_bindings[full_key] -= kb_name

			key_bindings[full_key] += list(kb_name)
			key_bindings[full_key] = sortList(key_bindings[full_key])
			current_client.set_macros()
			save_keybinds()
			if(user)
				SEND_SIGNAL(user, COMSIG_MOB_KEYBINDINGS_UPDATED, GLOB.keybindings_by_name[kb_name])
			return TRUE

		if("clear_keybind")
			var/kb_name = params["keybinding"]
			for(var/key in key_bindings)
				if(!(kb_name in key_bindings[key]))
					continue
				key_bindings[key] -= kb_name
				if(!length(key_bindings[key]))
					key_bindings -= key
					continue
				key_bindings[key] = sortList(key_bindings[key])
			current_client.set_macros()
			save_keybinds()
			return TRUE

		if("setCustomSentence")
			var/kb_name = params["name"]
			if(!kb_name)
				return
			var/list/part = splittext(kb_name, ":")
			var/id = text2num(part[2])
			var/datum/custom_emote/emote = custom_emotes[id]
			var/new_message = params["sentence"]
			if(length(new_message) > 300)
				return
			emote.message = new_message
			custom_emotes[id] = emote

		if("setEmoteType")
			var/kb_name = params["name"]
			if(!kb_name)
				return
			var/list/part = splittext(kb_name, ":")
			var/id = text2num(part[2])
			var/datum/custom_emote/emote = custom_emotes[id]
			emote.spoken_emote = !emote.spoken_emote

		if("reset-keybindings")
			key_bindings = deep_copy_list(GLOB.hotkey_keybinding_list_by_key)
			current_client.set_macros()
			save_keybinds()

		if("bancheck")
			var/list/ban_details = is_banned_from_with_details(user.ckey, user.client.address, user.client.computer_id, params["role"])
			var/admin = FALSE
			if(GLOB.admin_datums[user.ckey] || GLOB.deadmins[user.ckey])
				admin = TRUE
			for(var/i in ban_details)
				if(admin && !text2num(i["applies_to_admins"]))
					continue
				ban_details = i
				break //we only want to get the most recent ban's details
			if(!length(ban_details))
				return

			var/expires = "This is a permanent ban."
			if(ban_details["expiration_time"])
				expires = " The ban is for [DisplayTimeText(text2num(ban_details["duration"]) MINUTES)] and expires on [ban_details["expiration_time"]] (server time)."
			to_chat(user, span_danger("You, or another user of this computer or connection ([ban_details["key"]]) is banned from playing [params["role"]].<br>The ban reason is: [ban_details["reason"]]<br>This ban (BanID #[ban_details["id"]]) was applied by [ban_details["admin_key"]] on [ban_details["bantime"]] during round ID [ban_details["round_id"]].<br>[expires]"))

		if("widescreenpref")
			widescreenpref = !widescreenpref
			user.client.view_size.set_default(get_screen_size(widescreenpref))

		if("radialmedicalpref")
			toggles_gameplay ^= RADIAL_MEDICAL

		if("radiallasersgunpref")
			toggles_gameplay ^= RADIAL_LASERGUNS

		if("radialstackspref")
			toggles_gameplay ^= RADIAL_STACKS

		if("autointeractdeployablespref")
			toggles_gameplay ^= AUTO_INTERACT_DEPLOYABLES

		if("directional_attacks")
			toggles_gameplay ^= DIRECTIONAL_ATTACKS

		if("toggle_clickdrag")
			toggles_gameplay ^= TOGGLE_CLICKDRAG

		if("pixel_size")
			switch(pixel_size)
				if(PIXEL_SCALING_AUTO)
					pixel_size = PIXEL_SCALING_1X
				if(PIXEL_SCALING_1X)
					pixel_size = PIXEL_SCALING_1_2X
				if(PIXEL_SCALING_1_2X)
					pixel_size = PIXEL_SCALING_2X
				if(PIXEL_SCALING_2X)
					pixel_size = PIXEL_SCALING_3X
				if(PIXEL_SCALING_3X)
					pixel_size = PIXEL_SCALING_AUTO
			user.client.view_size.apply() //Let's winset() it so it actually works

		if("parallax")
			parallax = WRAP(parallax + 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
			if(parent?.mob && parent.mob.hud_used)
				parent.mob.hud_used.update_parallax_pref(parent.mob)

		if("scaling_method")
			switch(scaling_method)
				if(SCALING_METHOD_NORMAL)
					scaling_method = SCALING_METHOD_DISTORT
				if(SCALING_METHOD_DISTORT)
					scaling_method = SCALING_METHOD_BLUR
				if(SCALING_METHOD_BLUR)
					scaling_method = SCALING_METHOD_NORMAL
			user.client.view_size.update_zoom_mode()

		if("unique_action_use_active_hand")
			unique_action_use_active_hand = !unique_action_use_active_hand

		if("fast_mc_refresh")
			fast_mc_refresh = !fast_mc_refresh

		if("split_admin_tabs")
			split_admin_tabs = !split_admin_tabs

		if("hear_ooc_anywhere_as_staff")
			hear_ooc_anywhere_as_staff = !hear_ooc_anywhere_as_staff

		if("volume_adminhelp")
			volume_adminhelp = params["newValue"]

		if("volume_adminmusic")
			volume_adminmusic = params["newValue"]
			if(!volume_adminmusic)
				user.stop_sound_channel(CHANNEL_MIDI)

		if("volume_ambience")
			volume_ambience = params["newValue"]
			if(!volume_ambience)
				user.stop_sound_channel(CHANNEL_AMBIENCE)
			user.client.update_ambience_pref()

		if("volume_lobby")
			volume_lobby = params["newValue"]
			if(volume_lobby && isnewplayer(user))
				user.client.play_title_music()
			else
				user.stop_sound_channel(CHANNEL_LOBBYMUSIC)

		if("volume_instruments")
			volume_instruments = params["newValue"]

		if("volume_weather")
			volume_weather = params["newValue"]

		if("volume_end_of_round")
			volume_end_of_round = params["newValue"]

		else //  Handle the unhandled cases
			return

	save_preferences()
	save_character()
	save_keybinds()
	ui_interact(user, ui)
	SEND_SIGNAL(current_client, COMSIG_CLIENT_PREFERENCES_UIACTED)
	return TRUE
