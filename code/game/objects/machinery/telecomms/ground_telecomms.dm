#define TOWER_ON 0
#define TOWER_OFF 1
#define TOWER_BROKEN 2
#define STATE_DEFAULT 3
#define STATE_DISTRESS 4

/obj/machinery/telecomms/relay/preset/tower
	id = "Tower Relay"
	autolinkers = list("relay")
	icon = 'icons/obj/structures/comm_tower2.dmi'
	icon_state = "comm_tower"
	name = "TC-4T telecommunications tower"
	desc = "A portable compact TC-4T telecommunications tower. Used to set up subspace communications lines between planetary and extra-planetary locations."
	density = TRUE
	use_power = NO_POWER_USE
	idle_power_usage = 0
	on = FALSE
	freq_listening = TOWER_FREQS
	resistance_flags = DROPSHIP_IMMUNE | UNACIDABLE
	allow_pass_flags = PASS_PROJECTILE|PASS_AIR
	interaction_flags = INTERACT_MACHINE_TGUI
	obj_flags = IN_USE
	///Health for the miner we use because changing obj_integrity is apparently bad
	var/tower_integrity = 0
	///Max health of the miner
	var/max_tower_integrity = 100
	///Current status of the tower
	var/tower_status = TOWER_BROKEN
	//is tower currently activating
	var/activating = FALSE

	faction = FACTION_TERRAGOV

	///How much progress we get every tick, up to 100
	var/progress_interval = 0.50
	///Tracks how much of the terminal is completed
	var/progress = 0
	///have we logged into the terminal yet?
	var/logged_in = FALSE
	//for tuff animation
	var/first_login = TRUE
	//for announce
	var/first_login_alt = TRUE
	//communication console var's
	var/signal_used = FALSE
	var/state = STATE_DEFAULT
	var/just_called = FALSE
	var/status_display_freq = "1435"
	var/authenticated = 0

/obj/machinery/telecomms/relay/preset/tower/Initialize(mapload)
	. = ..()
	init_marker()
	RegisterSignal(SSdcs, COMSIG_GLOB_DROPSHIP_HIJACKED, PROC_REF(disable_on_hijack))

/obj/machinery/telecomms/relay/preset/tower/Destroy()
	if(src in GLOB.tower_relays)
		GLOB.tower_relays -= src
	return ..()

/obj/machinery/telecomms/relay/preset/tower/proc/init_marker()

	var/marker_icon = ""
	switch(tower_status)
		if(TOWER_ON)
			marker_icon = "comm_tower_on"
		if(TOWER_OFF)
			marker_icon = "comm_tower_off"
		if(TOWER_BROKEN)
			marker_icon= "comm_tower_broken"
	SSminimaps.add_marker(src, MINIMAP_FLAG_ALL, image('icons/UI_icons/map_blips_large.dmi', null, marker_icon, MINIMAP_BLIPS_LAYER))

/obj/machinery/telecomms/relay/preset/tower/update_icon()
	. = ..()
	switch(tower_status)
		if(TOWER_ON)
			icon_state = "comm_tower"
		if(TOWER_OFF)
			icon_state = "comm_tower_off"
		if(TOWER_BROKEN)
			icon_state = "comm_tower_broken"

/obj/machinery/telecomms/relay/preset/tower/welder_act(mob/living/user, obj/item/tool/weldingtool/I)
	. = ..()
	if(tower_status != TOWER_BROKEN)
		return
	if(!I.remove_fuel(1, user))
		to_chat(user, span_warning("You need more welding fuel to complete this task."))
		return FALSE
	if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
		user.visible_message(span_notice("[user] fumbles around figuring out [src]'s internals."),
		span_notice("You fumble around figuring out [src]'s internals."))
		var/fumbling_time = 10 SECONDS - 2 SECONDS * user.skills.getRating(SKILL_ENGINEER)
		if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED, extra_checks = CALLBACK(I, TYPE_PROC_REF(/obj/item/tool/weldingtool, isOn))))
			return FALSE
	user.visible_message(span_notice("[user] starts welding [src]'s internal damage."),
	span_notice("You start welding [src]'s internal damage."))
	if(!I.use_tool(src, user, 20 SECONDS, 1, 25, null, BUSY_ICON_BUILD))
		return FALSE
	if(tower_status != TOWER_BROKEN )
		return FALSE
	tower_integrity = max_tower_integrity
	set_tower_status()
	user.visible_message(span_notice("[user] welds [src]'s internal damage."),
	span_notice("You weld [src]'s internal damage."))
	return TRUE

/obj/machinery/telecomms/relay/preset/tower/examine(mob/user)
	. = ..()
	if(!ishuman(user))
		return

	switch(tower_status)
		if(TOWER_ON)
			. += span_info("It's on")
		if(TOWER_OFF)
			. += span_info("It's off")
		if(TOWER_BROKEN)
			. += span_info("It's lightly damaged, and you can see internal workings. Use a blowtorch to repair it.")

/obj/machinery/telecomms/relay/preset/tower/process()
	. = ..()
	set_tower_status()
	if(!activating)
		STOP_PROCESSING(SSmachines, src)
		return

	if(tower_status == TOWER_BROKEN)
		STOP_PROCESSING(SSmachines, src)
		visible_message("[icon2html(src, viewers(src))] <span><b>[src]</b> Too damaged! </span>")
		if(progress >= 75)
			progress = 25
			first_login_alt = TRUE
		else
			progress = 0
			first_login_alt = TRUE
		return

	progress += progress_interval

	if(first_login_alt)
		first_login_alt = FALSE
		priority_announce("Начинается процесс активации вышки связи [get_area(src)].", title = "[src]", sound = 'sound/AI/commandreport.ogg')
		xeno_message("Вышка связи активируется в [get_area(src)]", "xenoannounce", 7, XENO_HIVE_NORMAL, FALSE, src)

	if(progress >= 100)
		STOP_PROCESSING(SSmachines, src)
		GLOB.tower_relays += src
		activating = FALSE
		on = TRUE
		set_tower_status()
		priority_announce("Вышка сввязи успешно активирована в [get_area(src)].", title = "[src]", sound = 'sound/AI/commandreport.ogg')
		xeno_message("Вышка связи активирована в [get_area(src)]", "xenoannounce", 7, XENO_HIVE_NORMAL, FALSE, src)
	return

/obj/machinery/telecomms/relay/preset/tower/attack_alien(mob/living/carbon/xenomorph/X, damage_amount = X.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = "", effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(X.status_flags & INCORPOREAL) //Incorporeal xenos cannot attack physically.
		return
	while(tower_status != TOWER_BROKEN)
		if(X.do_actions)
			return balloon_alert(X, "busy")
		if(!do_after(X, 3 SECONDS, NONE, src, BUSY_ICON_DANGER, BUSY_ICON_HOSTILE))
			return
		if(tower_integrity <= 50)
			if(src in GLOB.tower_relays)
				GLOB.tower_relays -= src
			SEND_GLOBAL_SIGNAL(COMSIG_GLOB_TELETOWER)
		X.do_attack_animation(src, ATTACK_EFFECT_CLAW)
		X.visible_message(span_danger("[X] slashes \the [src]!"), \
		span_danger("We slash \the [src]!"), null, 5)
		playsound(loc, SFX_ALIEN_CLAW_METAL, 25, TRUE)
		tower_integrity -= 25
		set_tower_status()

/obj/machinery/telecomms/relay/preset/tower/Topic(href, href_list)
	. = ..()
	if(.)
		return

	switch(href_list["operation"])
		if("login")
			if(isAI(usr))
				authenticated = 2
				updateUsrDialog()
				return
			var/mob/living/carbon/human/C = usr
			var/obj/item/card/id/I = C.get_active_held_item()
			if(istype(I))
				if(check_access(I))
					authenticated = 1
				if(ACCESS_MARINE_LEADER in I.access)
					authenticated = 2
			else
				I = C.wear_id
				if(istype(I))
					if(check_access(I))
						authenticated = 1
					if(ACCESS_MARINE_LEADER in I.access)
						authenticated = 2

		if("distress")
			if(state == STATE_DISTRESS)
				if(!CONFIG_GET(flag/infestation_ert_allowed))
					log_admin_private("[key_name(usr)] may have attempted a href exploit on a [src]. [AREACOORD(usr)].")
					message_admins("[ADMIN_TPMONTY(usr)] may be attempting a href exploit on a [src]. [ADMIN_VERBOSEJMP(usr)].")
					return FALSE

				if(!SSticker?.mode)
					return FALSE //Not a game mode?

				if(just_called || SSticker.mode.waiting_for_candidates)
					to_chat(usr, span_warning("The distress beacon has been just launched."))
					return FALSE

				if(SSticker.mode.on_distress_cooldown)
					to_chat(usr, span_warning("The distress beacon is currently recalibrating."))
					return FALSE

				if(signal_used)
					to_chat(usr, span_warning("недостаточно заоряда для использования сигнала"))
					return FALSE

				var/All[] = SSticker.mode.count_humans_and_xenos()
				var/AllMarines[] = All[1]
				var/AllXenos[] = All[2]
				if(AllXenos < round(AllMarines * 0.8)) //If there's less humans (weighted) than xenos, humans get home-turf advantage
					to_chat(usr, span_warning("The sensors aren't picking up enough of a threat to warrant a distress beacon."))
					return FALSE

				SSticker.mode.distress_cancelled = FALSE
				just_called = TRUE

				var/datum/emergency_call/E = SSticker.mode.get_random_call()

				var/admin_response = admin_approval("<span color='prefix'>DISTRESS(g):</span> [ADMIN_TPMONTY(usr)] has called a ground Distress Beacon that was received by [E.name]. Humans: [AllMarines], Xenos: [AllXenos].",
					user_message = span_boldnotice("A ground distress beacon will launch in 60 seconds unless High Command responds otherwise."),
					options = list("approve" = "approve", "deny" = "deny", "deny without annoncing" = "deny without annoncing"),
					user = usr, admin_sound = sound('sound/effects/sos-morse-code.ogg', channel = CHANNEL_ADMIN))
				just_called = FALSE
				if(admin_response == "deny")
					SSticker.mode.distress_cancelled = TRUE
					priority_announce("Сигнал был заблокирован командованием.", "[src]", sound = 'sound/AI/distress_deny.ogg')
					return FALSE
				if(admin_response =="deny without annoncing")
					SSticker.mode.distress_cancelled = TRUE
					return FALSE
				if(SSticker.mode.on_distress_cooldown || SSticker.mode.waiting_for_candidates)
					return FALSE
				SSticker.mode.activate_distress(E)
				E.base_probability = 0
				signal_used = TRUE
				RegisterSignal(SSdcs, COMSIG_GLOB_ERT_CALLED_GROUND, PROC_REF(signal_proc))
				SEND_GLOBAL_SIGNAL(COMSIG_GLOB_ERT_CALLED_GROUND)
				return TRUE
			state = STATE_DISTRESS
	updateUsrDialog()

/obj/machinery/telecomms/relay/preset/tower/interact(mob/user)
	. = ..()
	if(.)
		return

	if(tower_status == BROKEN)
		return
	if(!on)
		return

	var/dat

	switch(state)
		if(STATE_DEFAULT)
			if(authenticated == 2)
				if(CONFIG_GET(flag/infestation_ert_allowed)) // We only add the UI if the flag is allowed
					dat += "<BR>\[ <A href='byond://?src=[text_ref(src)];operation=distress'>Send Distress Beacon</A> \]"
			else
				dat += "<BR>\[ <A href='byond://?src=[text_ref(src)];operation=login'>LOG IN</A> \]"

		if(STATE_DISTRESS)
			if(CONFIG_GET(flag/infestation_ert_allowed))
				dat += "Are you sure you want to trigger a distress signal? The signal can be picked up by anyone listening, friendly or not. \[ <A href='byond://?src=[text_ref(src)];operation=distress'>Confirm</A>\]"

	dat += "<BR>\[ [(state != STATE_DEFAULT) ? "<A href='byond://?src=[text_ref(src)];operation=main'>Main Menu</A>|" : ""]\]"

	var/datum/browser/popup = new(user, "communications", "<div align='center'> [src] communication panel </div>", 400, 500)
	popup.set_content(dat)
	popup.open(FALSE)
	onclose(user, "communications")
	return ..()

/obj/machinery/telecomms/relay/preset/tower/ui_interact(mob/user, datum/tgui/ui)
	if(tower_status == TOWER_BROKEN)
		return
	if(on)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "IntelComputer", "[src] charge")
		ui.open()

/obj/machinery/telecomms/relay/preset/tower/ui_data(mob/user)
	var/list/data = list()
	data["logged_in"] = logged_in
	data["first_login"] = first_login
	data["progress"] = progress
	data["printing"] = activating
	data["printed"] = on

	return data

/obj/machinery/telecomms/relay/preset/tower/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	switch(action)
		if("login")
			logged_in = TRUE
			. = TRUE
		if("first_load")
			first_login = FALSE
			. = TRUE
		if("start_progressing")
			START_PROCESSING(SSmachines, src)
			var/mob/living/ui_user = ui.user
			activating = TRUE
			faction = ui_user.faction
			update_icon()
	update_icon()

/// Deactivates this intel computer, for use on hijack
/obj/machinery/telecomms/relay/preset/tower/proc/disable_on_hijack()
	GLOB.tower_relays -= src // prevents the event running
	SStgui.close_uis(src)
	SSminimaps.remove_marker(src)
	on = FALSE
	if(activating)
		STOP_PROCESSING(SSmachines, src)
		activating = FALSE

/obj/machinery/telecomms/relay/preset/tower/proc/set_tower_status()
	var/health_percent = round((tower_integrity / max_tower_integrity) * 100)
	var/marker_icon = "comm_tower_broken"
	switch(health_percent)
		if(-INFINITY to 0)
			tower_status = TOWER_BROKEN
			marker_icon = "comm_tower_broken"
		if(1 to INFINITY)
			tower_status = on ? TOWER_ON : TOWER_OFF
			marker_icon = "comm_tower[on ? "_on" : "_off"]"
	SSminimaps.remove_marker(src)
	SSminimaps.add_marker(src, MINIMAP_FLAG_ALL, image('icons/UI_icons/map_blips_large.dmi', null, marker_icon, MINIMAP_BLIPS_LAYER))
	update_icon()

/obj/machinery/telecomms/relay/preset/tower/attack_ai(mob/user)
	return attack_hand(user)
/obj/machinery/telecomms/relay/preset/tower/proc/signal_proc()
	return TRUE
//override
/obj/machinery/telecomms/relay/preset/tower/update_power()
	return

#undef TOWER_ON
#undef TOWER_OFF
#undef TOWER_BROKEN
#undef STATE_DEFAULT
#undef STATE_DISTRESS
