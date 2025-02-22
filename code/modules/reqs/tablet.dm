/obj/item/supplytablet
	name = "ASRS tablet"
	desc = "A tablet for an Automated Storage and Retrieval System"
	icon_state = "req_tablet_off"
	req_access = list(ACCESS_MARINE_CARGO)
	equip_slot_flags = ITEM_SLOT_POCKET
	w_class = WEIGHT_CLASS_NORMAL
	faction = FACTION_TERRAGOV
	var/datum/supply_ui/supply_ui
	///Id of the shuttle controlled
	var/shuttle_id = SHUTTLE_SUPPLY
	/// Id of the home docking port
	var/home_id = "supply_home"

/obj/item/supplytablet/interact(mob/user)
	. = ..()
	if(.)
		return
	if(!allowed(user))
		return
	if(!supply_ui)
		supply_ui = new(src)
		supply_ui.shuttle_id = shuttle_id
		supply_ui.home_id = home_id
		supply_ui.faction = faction
	return supply_ui.interact(user)
