/obj/machinery/computer/supplycomp
	name = "ASRS console"
	desc = "A console for an Automated Storage and Retrieval System"
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer"
	screen_overlay = "supply"
	req_access = list(ACCESS_MARINE_CARGO)
	circuit = /obj/item/circuitboard/computer/supplycomp
	faction = FACTION_TERRAGOV
	var/datum/supply_ui/supply_ui
	///Id of the shuttle controlled
	var/shuttle_id = SHUTTLE_SUPPLY
	/// Id of the home docking port
	var/home_id = "supply_home"
/obj/machinery/computer/supplycomp/crash
	req_access = list() //So marines can access cargo stuff without relying on synth spawn
	desc = "A console for an Automated Storage and Retrieval System. This version somehow does not require special access."
	resistance_flags = RESIST_ALL

/obj/machinery/computer/supplycomp/interact(mob/user)
	. = ..()
	if(.)
		return
	if(isliving(user) && !allowed(user))
		return
	if(!supply_ui)
		supply_ui = new(src)
		supply_ui.shuttle_id = shuttle_id
		supply_ui.home_id = home_id
		supply_ui.faction = faction
	return supply_ui.interact(user)

/obj/machinery/computer/ordercomp
	name = "Supply ordering console"
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer"
	screen_overlay = "request"
	broken_icon = "computer_orange_broken"
	circuit = /obj/item/circuitboard/computer/ordercomp
	var/datum/supply_ui/requests/supply_ui

/obj/machinery/computer/ordercomp/interact(mob/user)
	. = ..()
	if(.)
		return
	if(!allowed(user))
		return
	if(!supply_ui)
		supply_ui = new(src)
	return supply_ui.interact(user)
