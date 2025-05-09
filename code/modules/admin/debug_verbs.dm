/datum/admins/proc/delete_all()
	set category = "Debug"
	set name = "Delete Instances"

	var/blocked = list(/obj, /obj/item, /obj/effect, /obj/machinery, /mob, /mob/living, /mob/living/carbon, /mob/living/carbon/xenomorph, /mob/living/carbon/human, /mob/dead, /mob/dead/observer, /mob/living/silicon, /mob/living/silicon/ai)
	var/chosen_deletion = input(usr, "Type the path of the object you want to delete", "Delete:") as null|text

	if(!chosen_deletion)
		return

	chosen_deletion = text2path(chosen_deletion)
	if(!ispath(chosen_deletion))
		return

	if(!ispath(/mob) && !ispath(/obj))
		to_chat(usr,
			type = MESSAGE_TYPE_DEBUG,
			html = span_warning("Only works for types of /obj or /mob."))
		return

	var/hsbitem = input(usr, "Choose an object to delete.", "Delete:") as null|anything in typesof(chosen_deletion)
	if(!hsbitem)
		return

	var/do_delete = TRUE
	if(hsbitem in blocked)
		if(alert("Are you REALLY sure you wish to delete all instances of [hsbitem]? This will lead to catastrophic results!",,"Yes","No") != "Yes")
			do_delete = FALSE

	var/del_amt = 0
	if(!do_delete)
		return

	for(var/atom/O in world)
		if(istype(O, hsbitem))
			del_amt++
			qdel(O)

	log_admin("[key_name(usr)] deleted all instances of [hsbitem] ([del_amt]).")
	message_admins("[ADMIN_TPMONTY(usr)] deleted all instances of [hsbitem] ([del_amt]).")


/datum/admins/proc/generate_powernets()
	set category = "Debug"
	set name = "Generate Powernets"
	set desc = "Regenerate all powernets."

	if(!check_rights(R_DEBUG))
		return

	SSmachines.makepowernets()

	log_admin("[key_name(usr)] has remade powernets.")
	message_admins("[ADMIN_TPMONTY(usr)] has remade powernets.")


/datum/admins/proc/debug_mob_lists()
	set category = "Debug"
	set name = "Debug Mob Lists"

	var/dat

	var/choice = input("Which list?") as null|anything in list("Players", "Observers", "New Players", "Admins", "Clients", "Mobs", "Living Mobs", "Alive Living Mobs", "Dead Mobs", "Xenos", "Alive Xenos", "Dead Xenos", "Humans", "Alive Humans", "Dead Humans")
	if(!choice)
		return

	switch(choice)
		if("Players")
			for(var/i in GLOB.player_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Observers")
			for(var/i in GLOB.observer_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("New Players")
			for(var/i in GLOB.new_player_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Admins")
			for(var/i in GLOB.admins)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Clients")
			for(var/i in GLOB.clients)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Mobs")
			for(var/i in GLOB.mob_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Living Mobs")
			for(var/i in GLOB.mob_living_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Alive Living Mobs")
			for(var/i in GLOB.alive_living_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Dead Mobs")
			for(var/i in GLOB.dead_mob_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Xenos")
			for(var/i in GLOB.xeno_mob_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Alive Xenos")
			for(var/i in GLOB.alive_xeno_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Dead Xenos")
			for(var/i in GLOB.dead_xeno_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Humans")
			for(var/i in GLOB.human_mob_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Alive Humans")
			for(var/i in GLOB.alive_human_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Dead Humans")
			for(var/i in GLOB.dead_human_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"

	var/datum/browser/browser = new(usr, "moblists", "<div align='center'>[choice]</div>")
	browser.set_content(dat)
	browser.open(FALSE)

	log_admin("[key_name(usr)] is debugging the [choice] list.")
	message_admins("[ADMIN_TPMONTY(usr)] is debugging the [choice] list.")


/datum/admins/proc/spawn_atom(object as text)
	set category = "Debug"
	set desc = "(atom path) Spawn an atom"
	set name = "Spawn"

	if(!check_rights(R_SPAWN) || !object)
		return

	var/list/preparsed = splittext(object,":")
	var/path = preparsed[1]
	var/amount = 1
	if(length(preparsed) > 1)
		amount = clamp(text2num(preparsed[2]),1,ADMIN_SPAWN_CAP)

	var/chosen = pick_closest_path(path)
	if(!chosen)
		return
	var/turf/T = get_turf(usr)

	if(ispath(chosen, /turf))
		T.change_turf(chosen)
	else
		for(var/i in 1 to amount)
			var/atom/A = new chosen(T)
			A.atom_flags |= ADMIN_SPAWNED

	log_admin("[key_name(usr)] spawned [amount] x [chosen] at [AREACOORD(usr)]")
	SSblackbox.record_feedback(FEEDBACK_TALLY, "admin_verb", 1, "Spawn Atom") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/delete_atom(atom/A as obj|mob|turf in world)
	set category = null
	set name = "Delete"

	if(!check_rights(R_DEBUG))
		return

	if(alert(src, "Are you sure you want to delete: [A]?", "Delete", "Yes", "No") != "Yes")
		return

	if(QDELETED(A))
		return

	var/turf/T = get_turf(A)

	log_admin("[key_name(usr)] deleted [A]([A.type]) at [AREACOORD(T)].")
	message_admins("[ADMIN_TPMONTY(usr)] deleted [A]([A.type]) at [ADMIN_VERBOSEJMP(T)].")

	if(isturf(A))
		var/turf/deleting_turf = A
		deleting_turf.scrape_away()
		return

	qdel(A)


/datum/admins/proc/restart_controller(controller in list("Master", "Failsafe"))
	set category = "Debug"
	set name = "Restart Controller"
	set desc = "Restart one of the various periodic loop controllers for the game (be careful!)"

	if(!check_rights(R_DEBUG))
		return

	switch(controller)
		if("Master")
			Recreate_MC()
		if("Failsafe")
			new /datum/controller/failsafe()

	log_admin("[key_name(usr)] has restarted the [controller] controller.")
	message_admins("[ADMIN_TPMONTY(usr)] has restarted the [controller] controller.")


/client/proc/debug_controller()
	set category = "Debug"
	set name = "Debug Controller"
	set desc = "Debug the various periodic loop controllers for the game (be careful!)"

	if(!check_rights(R_DEBUG))
		return

	var/list/controllers = list()
	var/list/controller_choices = list()

	for(var/datum/controller/controller)
		if(istype(controller, /datum/controller/subsystem))
			continue
		controllers["[controller] (controller.type)"] = controller //we use an associated list to ensure clients can't hold references to controllers
		controller_choices += "[controller] (controller.type)"

	var/datum/controller/controller_string = input("Select controller to debug", "Debug Controller") as null|anything in controller_choices
	var/datum/controller/controller = controllers[controller_string]

	if(!istype(controller))
		return
	debug_variables(controller)

	log_admin("[key_name(usr)] is debugging the [controller] controller.")
	message_admins("Admin [key_name_admin(usr)] is debugging the [controller] controller.")

/datum/admins/proc/check_contents()
	set category = "Debug"
	set name = "Check Contents"

	if(!check_rights(R_DEBUG))
		return

	var/mob/living/L = usr.client.holder.apicker("Check contents of:", "Check Contents", list(APICKER_CLIENT, APICKER_LIVING))
	if(!istype(L))
		return

	var/dat = "<br>"
	for(var/i in L.GetAllContents())
		var/atom/A = i
		dat += "[A] [ADMIN_VV(A)]<br>"

	var/datum/browser/popup = new(usr, "contents_[key_name(L)]", "<div align='center'>Contents of [key_name(L)]</div>")
	popup.set_content(dat)
	popup.open(FALSE)

	log_admin("[key_name(usr)] checked the contents of [key_name(L)].")
	message_admins("[ADMIN_TPMONTY(usr)] checked the contents of [ADMIN_TPMONTY(L)].")



/datum/admins/proc/reestablish_db_connection()
	set category = "Debug"
	set name = "Reestablish DB Connection"

	if(!check_rights(R_DEBUG))
		return

	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, span_adminnotice("The Database is not enabled!"))
		return

	if(SSdbcore.IsConnected(TRUE))
		if(alert("The database is already connected! If you *KNOW* that this is incorrect, you can force a reconnection", "The database is already connected!", "Force Reconnect", "Cancel") != "Force Reconnect")
			return

		SSdbcore.Disconnect()
		log_admin("[key_name(usr)] has forced the database to disconnect")
		message_admins("[ADMIN_TPMONTY(usr)] has forced the database to disconnect!")

	log_admin("[key_name(usr)] is attempting to re-established the DB Connection.")
	message_admins("[ADMIN_TPMONTY(usr)] is attempting to re-established the DB Connection.")

	SSdbcore.failed_connections = 0

	if(!SSdbcore.Connect())
		log_admin("Database connection failed: " + SSdbcore.ErrorMsg())
		message_admins("Database connection failed: " + SSdbcore.ErrorMsg())
	else
		log_admin("Database connection re-established!")
		message_admins("Database connection re-established!")

/datum/admins/proc/view_runtimes()
	set category = "Debug"
	set name = "View Runtimes"
	set desc = "Open the runtime Viewer"

	if(!check_rights(R_RUNTIME|R_DEBUG))
		return

	GLOB.error_cache.show_to(usr.client)

	log_admin("[key_name(usr)] viewed the runtimes.")


/datum/admins/proc/spatial_agent()
	set category = "Debug"
	set name = "Spatial Agent"

	if(!check_rights(R_FUN))
		return

	var/mob/M = usr
	var/mob/living/carbon/human/H
	var/spatial = FALSE
	if(ishuman(M))
		H = M
		var/datum/job/J = H.job
		spatial = istype(J, /datum/job/spatial_agent)

	if(spatial)
		log_admin("[key_name(M)] stopped being a spatial agent.")
		message_admins("[ADMIN_TPMONTY(M)] stopped being a spatial agent.")
		qdel(M)
	else
		H = new(get_turf(M))
		M.client.prefs.copy_to(H)
		M.mind.transfer_to(H, TRUE)
		var/datum/job/J = SSjob.GetJobType(/datum/job/spatial_agent)
		H.apply_assigned_role_to_spawn(J)
		qdel(M)

		log_admin("[key_name(H)] became a spatial agent.")
		message_admins("[ADMIN_TPMONTY(H)] became a spatial agent.")

/datum/admins/proc/profiler()
	set category = "Debug"
	set name = "Profiler"

	if(!check_rights(R_DEBUG|R_RUNTIME))
		return

	winset(usr, null, "command=.profile")

/datum/admins/proc/wipe_color_and_text(list/atom/wiping)
	for(var/i in wiping)
		var/atom/atom_to_clean = i
		atom_to_clean.color = null
		atom_to_clean.maptext = ""

/client/proc/cmd_display_del_log()
	set category = "Debug"
	set name = "Display del() Log"
	set desc = "Display del's log of everything that's passed through it."

	var/list/dellog = list("<B>List of things that have gone through qdel this round</B><BR><BR><ol>")
	sortTim(SSgarbage.items, cmp=/proc/cmp_qdel_item_time, associative = TRUE)
	for(var/path in SSgarbage.items)
		var/datum/qdel_item/I = SSgarbage.items[path]
		dellog += "<li><u>[path]</u><ul>"
		if (I.qdel_flags & QDEL_ITEM_SUSPENDED_FOR_LAG)
			dellog += "<li>SUSPENDED FOR LAG</li>"
		if (I.failures)
			dellog += "<li>Failures: [I.failures]</li>"
		dellog += "<li>qdel() Count: [I.qdels]</li>"
		dellog += "<li>Destroy() Cost: [I.destroy_time]ms</li>"
		if (I.hard_deletes)
			dellog += "<li>Total Hard Deletes [I.hard_deletes]</li>"
			dellog += "<li>Time Spent Hard Deleting: [I.hard_delete_time]ms</li>"
			dellog += "<li>Highest Time Spent Hard Deleting: [I.hard_delete_max]ms</li>"
			if (I.hard_deletes_over_threshold)
				dellog += "<li>Hard Deletes Over Threshold: [I.hard_deletes_over_threshold]</li>"
		if (I.slept_destroy)
			dellog += "<li>Sleeps: [I.slept_destroy]</li>"
		if (I.no_respect_force)
			dellog += "<li>Ignored force: [I.no_respect_force]</li>"
		if (I.no_hint)
			dellog += "<li>No hint: [I.no_hint]</li>"
		dellog += "</ul></li>"

	dellog += "</ol>"

	usr << browse(dellog.Join(), "window=dellog")

/client/proc/debugstatpanel()
	set name = "Debug Stat Panel"
	set category = "Debug"

	src.stat_panel.send_message("create_debug")
