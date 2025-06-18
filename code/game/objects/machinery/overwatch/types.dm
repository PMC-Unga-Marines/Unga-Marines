//Camera only overwatch
/obj/machinery/computer/camera_advanced/overwatch/req
	icon_state = "overwatch_req"
	screen_overlay = "overwatch_req_screen"
	name = "Requisition Overwatch Console"
	desc = "Big Brother Requisition demands to see money flowing into the void that is greed."
	circuit = /obj/item/circuitboard/computer/supplyoverwatch
	overwatch_title = "Requisition"

/obj/machinery/computer/camera_advanced/overwatch/medical
	screen_overlay = "overwatch_med_screen"
	name = "Medical Overwatch Console"
	desc = "Overwatching patients are one of the responsibilities of shipside medical personnel. Just make sure you don't get bored."
	req_access = list(ACCESS_MARINE_MEDBAY)
	circuit = /obj/item/circuitboard/computer/supplyoverwatch
	overwatch_title = "Medical"

//Military overwatch
/obj/machinery/computer/camera_advanced/overwatch/military/alpha
	name = "Alpha Overwatch Console"

/obj/machinery/computer/camera_advanced/overwatch/military/bravo
	name = "Bravo Overwatch Console"

/obj/machinery/computer/camera_advanced/overwatch/military/charlie
	name = "Charlie Overwatch Console"

/obj/machinery/computer/camera_advanced/overwatch/military/delta
	name = "Delta Overwatch Console"

/obj/machinery/computer/camera_advanced/overwatch/military/main
	icon_state = "overwatch_main"
	screen_overlay = "overwatch_main_screen"
	name = "Main Overwatch Console"
	desc = "State of the art machinery for general overwatch purposes."
	overwatch_title = "Main"
