/obj/item/circuitboard/computer

/obj/item/circuitboard/computer/card
	name = "ID Console (Computer Board)"
	icon_state = "command"
	build_path = /obj/machinery/computer/marine_card

/obj/item/circuitboard/computer/card/centcom
	name = "CentCom ID Console (Computer Board)"
	build_path = /obj/item/circuitboard/computer/card/centcom

//TODO: Move these into computer/camera.dm
/obj/item/circuitboard/computer/security
	name = "Circuit board (Security Camera Monitor)"
	build_path = /obj/machinery/computer/security
	var/network = list("military")
	req_access = list(ACCESS_MARINE_BRIG)
	var/locked = 1

/obj/item/circuitboard/computer/security/construct(obj/machinery/computer/security/C)
	if(..(C))
		C.network = network

/obj/item/circuitboard/computer/security/decon(obj/machinery/computer/security/C)
	if(..(C))
		network = C.network

/obj/item/circuitboard/computer/security/engineering
	name = "Circuit board (Engineering Camera Monitor)"
	build_path = /obj/machinery/computer/security/engineering
	network = list("Engineering","Power Alarms","Atmosphere Alarms","Fire Alarms")
	req_access = list()
/obj/item/circuitboard/computer/security/mining
	name = "Circuit board (Mining Camera Monitor)"
	build_path = /obj/machinery/computer/security/mining
	network = list("MINE")
	req_access = list()

/obj/item/circuitboard/computer/cryopodcontrol
	name = "Circuit board (Cryogenic Oversight Console)"
	build_path = /obj/machinery/computer/cryopod

/obj/item/circuitboard/computer/med_data
	name = "Circuit board (Medical Records)"
	build_path = /obj/machinery/computer/med_data

/obj/item/circuitboard/computer/pandemic
	name = "Circuit board (PanD.E.M.I.C. 2200)"
	build_path = /obj/machinery/computer/pandemic

/obj/item/circuitboard/computer/communications
	name = "Circuit board (Communications)"
	build_path = /obj/machinery/computer/communications

/obj/item/circuitboard/computer/marine_card
	name = "Circuit board (ID Computer)"
	build_path = /obj/machinery/computer/marine_card

/obj/item/circuitboard/computer/supplycomp
	name = "Circuit board (Requisitions ASRS Computer)"
	build_path = /obj/machinery/computer/supplycomp

/obj/item/circuitboard/computer/ordercomp
	name = "Circuit board (Requisitions Ordering Computer)"
	build_path = /obj/machinery/computer/ordercomp

/obj/item/circuitboard/computer/supplyoverwatch
	name = "Circuit board (Requisitions Overwatch Computer)"
	build_path = /obj/machinery/computer/camera_advanced/overwatch/req

/obj/item/circuitboard/computer/supplydrop
	name = "Circuit board (Requisitions Targeting Computer)"
	build_path = /obj/machinery/computer/supplydrop_console

/obj/item/circuitboard/computer/marine_card/centcom
	name = "Circuit board (CentCom ID Computer)"
	build_path = /obj/machinery/computer/marine_card/centcom

/obj/item/circuitboard/computer/teleporter
	name = "Circuit board (Teleporter)"
	build_path = /obj/machinery/computer/teleporter

/obj/item/circuitboard/computer/secure_data
	name = "Circuit board (Security Records)"
	build_path = /obj/machinery/computer/secure_data

/obj/item/circuitboard/computer/skills
	name = "Circuit board (Employment Records)"
	build_path = /obj/machinery/computer/skills

/obj/item/circuitboard/computer/stationalert
	name = "Circuit board (Station Alerts)"
	build_path = /obj/machinery/computer/station_alert



/obj/item/circuitboard/computer/air_management
	name = "Circuit board (Atmospheric Monitor)"
	build_path = /obj/machinery/computer/general_air_control
	var/frequency = 1439

/obj/item/circuitboard/computer/air_management/tank_control
	name = "Circuit board (Tank Control)"
	build_path = /obj/machinery/computer/general_air_control/large_tank_control
	frequency = 1441

/obj/item/circuitboard/computer/air_management/supermatter_core
	name = "Circuit board (Core Control)"
	build_path = /obj/machinery/computer/general_air_control/supermatter_core
	frequency = 1438

/obj/item/circuitboard/computer/air_management/injector_control
	name = "Circuit board (Injector Control)"
	build_path = /obj/machinery/computer/general_air_control/fuel_injection

/obj/item/circuitboard/computer/atmos_alert
	name = "Circuit board (Atmospheric Alert)"
	build_path = /obj/machinery/computer/atmos_alert
/obj/item/circuitboard/computer/pod
	name = "Circuit board (Massdriver control)"
	build_path = /obj/machinery/computer/pod
/obj/item/circuitboard/computer/arcade
	name = "Circuit board (Arcade)"
	build_path = /obj/machinery/computer/arcade

/obj/item/circuitboard/computer/powermonitor
	name = "Circuit board (Power Monitor)"
	build_path = /obj/machinery/power/monitor
/obj/item/circuitboard/computer/olddoor
	name = "Circuit board (DoorMex)"
	build_path = /obj/machinery/computer/pod/old
/obj/item/circuitboard/computer/syndicatedoor
	name = "Circuit board (ProComp Executive)"
	build_path = /obj/machinery/computer/pod/old/syndicate
/obj/item/circuitboard/computer/swfdoor
	name = "Circuit board (Magix)"
	build_path = /obj/machinery/computer/pod/old/swf
/obj/item/circuitboard/computer/prisoner
	name = "Circuit board (Prisoner Management)"
	build_path = /obj/machinery/computer/prisoner
/obj/item/circuitboard/computer/crew
	name = "Circuit board (Crew monitoring computer)"
	build_path = /obj/machinery/computer/crew
/obj/item/circuitboard/computer/operating
	name = "Circuit board (Operating Computer)"
	build_path = /obj/machinery/computer/operating

/obj/item/circuitboard/computer/comm_monitor
	name = "Circuit board (Telecommunications Monitor)"
	build_path = /obj/machinery/computer/telecomms/monitor

/obj/item/circuitboard/computer/comm_server
	name = "Circuit board (Telecommunications Server Monitor)"
	build_path = /obj/machinery/computer/telecomms/server

/obj/item/circuitboard/computer/area_atmos
	name = "Circuit board (Area Air Control)"
	build_path = /obj/machinery/computer/area_atmos

/obj/item/circuitboard/computer/security/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/card/id))
		if(!check_access(I))
			to_chat(user, span_warning("Access denied."))
			return

		locked = !locked
		to_chat(user, span_notice("You [locked ? "" : "un"]lock the circuit controls."))

	else if(ismultitool(I))
		if(locked)
			to_chat(user, span_warning("Circuit controls are locked."))
			return

		var/existing_networks = jointext(network, ",")
		var/input = strip_html(input(user, "Which networks would you like to connect this camera console circuit to? Seperate networks with a comma. No Spaces!\nFor example: military,Security,Secret ", "Multitool-Circuitboard interface", existing_networks))
		if(!input)
			to_chat(user, "No input found please hang up and try your call again.")
			return

		var/list/tempnetwork = splittext(input, ",")
		tempnetwork = difflist(tempnetwork, GLOB.restricted_camera_networks, 1)
		if(!length(tempnetwork))
			to_chat(user, "No network found please hang up and try your call again.")
			return

		network = tempnetwork
