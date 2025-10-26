// small ert shuttles
/obj/docking_port/stationary/ert
	name = "ert shuttle"
	shuttle_id = SHUTTLE_DISTRESS
	dir = SOUTH
	dwidth = 3
	width = 7
	height = 13

/obj/docking_port/stationary/ert/target
	shuttle_id = "distress_target"

/obj/docking_port/mobile/ert
	name = "ert shuttle"
	dir = SOUTH
	dwidth = 5
	width = 11
	height = 21
	ignitionTime = 10 SECONDS
	prearrivalTime = 10 SECONDS
	rechargeTime = 3 MINUTES
	callTime = 1 MINUTES

	shuttle_flags = GAMEMODE_IMMUNE

	var/list/mob_spawns = list()
	var/list/item_spawns = list()
	var/list/shutters = list()
	var/departing = FALSE

/obj/docking_port/mobile/ert/proc/get_destinations()
	var/list/docks = list()
	for(var/obj/docking_port/stationary/S in SSshuttle.stationary_docking_ports)
		if(!istype(S, /obj/docking_port/stationary/ert/target))
			continue
		if(canDock(S) != SHUTTLE_CAN_DOCK) // discards occupied docks
			continue
		docks += S
	if(SEND_GLOBAL_SIGNAL(COMSIG_GLOB_ERT_CALLED_GROUND))
		docks.Cut()
		for(var/obj/docking_port/stationary/marine_dropship/S in SSshuttle.stationary_docking_ports)
			if(!istype(S, /obj/docking_port/stationary/marine_dropship/lz1))
				if(!istype(S, /obj/docking_port/stationary/marine_dropship/lz2))
					continue

				else
					docks += S
			else
				docks += S

			if(canDock(S) != SHUTTLE_CAN_DOCK)
				continue
	for(var/i in SSshuttle.ert_shuttle_list)
		var/obj/docking_port/mobile/ert/E = i
		if(!(E.destination in docks))
			continue
		docks -= E.destination // another shuttle already headed there

	for(var/obj/docking_port/stationary/docking_port in docks)
		//cuz we use lz landing zone
		docking_port.width = max(19, docking_port.width)
		docking_port.height = max(31, docking_port.height)
		docking_port.dwidth = max(9, docking_port.dwidth)
		docking_port.dheight = max(15, docking_port.dheight)
	return docks

/obj/docking_port/mobile/ert/proc/auto_launch()
	var/obj/docking_port/stationary/S = pick(get_destinations())
	if(!S)
		return FALSE
	SSshuttle.moveShuttle(shuttle_id, S.shuttle_id, TRUE)
	return TRUE

/obj/docking_port/mobile/ert/proc/open_shutters()
	for(var/i in shutters)
		var/obj/machinery/door/poddoor/shutters/transit/T = i
		if(T.density)
			T.open()

/obj/docking_port/mobile/ert/proc/close_shutters()
	for(var/i in shutters)
		var/obj/machinery/door/poddoor/shutters/transit/T = i
		if(!T.density)
			T.close()

/obj/docking_port/mobile/ert/after_shuttle_move()
	. = ..()
	if(istype(get_docked(), /obj/docking_port/stationary/ert/target))
		open_shutters()
	else
		if(!istype(get_docked(), /obj/docking_port/stationary/marine_dropship/lz1))
			if(!istype(get_docked(), /obj/docking_port/stationary/marine_dropship/lz2))
				close_shutters()
			else
				open_shutters()
		else
			open_shutters()

/obj/docking_port/mobile/ert/Destroy(force)
	. = ..()
	if(force)
		SSshuttle.ert_shuttle_list -= src

/obj/docking_port/mobile/ert/register()
	. = ..()
	SSshuttle.ert_shuttle_list += src
	for(var/t in return_turfs())
		var/turf/T = t
		for(var/atom/movable/O in T.GetAllContents())
			if(istype(O, /obj/effect/landmark/distress))
				mob_spawns += O
			else if(istype(O, /obj/effect/landmark/distress_item))
				item_spawns += O
			else if(istype(O, /obj/machinery/door/poddoor/shutters/transit))
				shutters += O
	close_shutters()


/obj/machinery/computer/shuttle/ert
	interaction_flags = INTERACT_MACHINE_TGUI|INTERACT_MACHINE_NOSILICON //No AIs allowed

/obj/machinery/computer/shuttle/ert/valid_destinations()
	var/obj/docking_port/mobile/ert/M = SSshuttle.getShuttle(shuttleId)
	if(!istype(M))
		CRASH("ert shuttle computer used with non-ert shuttle")
	var/list/valid_destination_ids = list()
	for(var/i in M.get_destinations())
		var/obj/docking_port/stationary/ert/target/target_dock = i
		valid_destination_ids += target_dock.shuttle_id
	return valid_destination_ids

/obj/machinery/computer/shuttle/ert/ui_interact(mob/user)
	. = ..()
	var/obj/docking_port/mobile/ert/M = SSshuttle.getShuttle(shuttleId)
	if(!istype(M))
		CRASH("ert shuttle computer used with non-ert shuttle")
	var/dat = "Status: [M ? M.getStatusText() : "*Missing*"]<br><br>"
	if(M?.mode == SHUTTLE_IDLE)
		if(is_reserved_level(M.z))
			for(var/obj/docking_port/stationary/S in M.get_destinations())
				dat += "<A href='byond://?src=[REF(src)];move=[S.shuttle_id]'>Send to [S.name]</A><br>"
		else
			dat += "<A href='byond://?src=[REF(src)];depart=1'>Depart.</A><br>"

	var/datum/browser/popup = new(user, "computer", M ? M.name : "shuttle", 300, 200)
	popup.set_content("<center>[dat]</center>")
	popup.open()

/obj/machinery/computer/shuttle/ert/Topic(href, href_list)
	. = ..()
	if(.)
		return

	if(href_list["depart"])
		var/obj/docking_port/mobile/ert/M = SSshuttle.getShuttle(shuttleId)

		if(M.departing)
			playsound(loc, 'sound/machines/twobeep.ogg', 25, 1)
			visible_message(span_warning("ERROR: Launch protocols already in process. Please standby."), 3)
			return

		log_game("[key_name(usr)] has departed an ERT shuttle")
		M.on_ignition()
		addtimer(VARSET_CALLBACK(M, departing, TRUE), M.ignitionTime)

	updateUsrDialog()


/obj/docking_port/mobile/ert/check()
	if(departing)
		intoTheSunset()
		return
	return ..()

