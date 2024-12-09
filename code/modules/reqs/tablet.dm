/obj/item/supplytablet
	name = "ASRS tablet"
	desc = "A tablet for an Automated Storage and Retrieval System"
	icon = 'icons/Marine/marine-navigation.dmi'
	icon_state = "req_tablet_off"
	req_access = list(ACCESS_MARINE_CARGO)
	flags_equip_slot = ITEM_SLOT_POCKET
	w_class = WEIGHT_CLASS_NORMAL
	var/datum/supply_ui/supply_ui
	///Id of the shuttle controlled
	var/shuttle_id = SHUTTLE_SUPPLY
	/// Id of the home docking port
	var/home_id = "supply_home"
	/// Faction of the tablet
	var/faction = FACTION_TERRAGOV

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
