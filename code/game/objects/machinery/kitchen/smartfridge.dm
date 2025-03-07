/obj/machinery/smartfridge
	name = "\improper SmartFridge"
	icon = 'icons/obj/machines/vending.dmi'
	icon_state = "smartfridge"
	layer = BELOW_OBJ_LAYER
	density = TRUE
	anchored = TRUE
	allow_pass_flags = PASS_AIR
	use_power = IDLE_POWER_USE
	idle_power_usage = 5
	active_power_usage = 100
	interaction_flags = INTERACT_MACHINE_TGUI
	/// Sorry but the BYOND infinite loop detector doesn't look things over 1000.
	var/static/max_n_of_items = 999
	var/icon_on = "smartfridge"
	var/icon_off = "smartfridge-off"
	var/icon_panel = "smartfridge-panel"
	///Maps stripped item names to stored count
	var/item_quants = list()
	var/is_secure_fridge = 0
	var/seconds_electrified = 0;
	var/shoot_inventory = 0
	var/locked = 0
	var/visible_contents = TRUE

/obj/machinery/smartfridge/Initialize(mapload)
	. = ..()
	create_reagents(100, NO_REACT)

/obj/machinery/smartfridge/proc/accept_check(obj/item/O as obj)
	if(istype(O,/obj/item/reagent_containers/food/snacks/grown/) || istype(O,/obj/item/seeds/))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/process()
	if(machine_stat & NOPOWER)
		return
	if(seconds_electrified > 0)
		seconds_electrified--
	if(shoot_inventory && prob(2))
		throw_item()

/obj/machinery/smartfridge/update_icon_state()
	. = ..()
	if(!(machine_stat & NOPOWER))
		icon_state = icon_on
	else
		icon_state = icon_off

/*******************
*   Item Adding
********************/

/obj/machinery/smartfridge/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(machine_stat & NOPOWER)
		to_chat(user, span_notice("\The [src] is unpowered and useless."))
		return

	if(accept_check(I))
		if(length(contents) >= max_n_of_items)
			to_chat(user, span_notice("\The [src] is full."))
			return TRUE
		else if(!user.drop_held_item())
			return TRUE

		I.forceMove(src)

		item_quants[strip_improper(I.name)]++

		user.visible_message(span_notice("[user] has added \the [I] to \the [src]."), \
							span_notice("You add \the [I] to \the [src]."))
		updateUsrDialog()

	else if(istype(I, /obj/item/storage/bag/plants))
		var/obj/item/storage/bag/plants/P = I
		var/plants_loaded = 0
		for(var/obj/G in P.contents)
			if(!accept_check(G))
				continue

			if(length(contents) >= max_n_of_items)
				to_chat(user, span_notice("\The [src] is full."))
				return TRUE

			P.storage_datum.remove_from_storage(G, src, user)
			item_quants[strip_improper(G.name)]++
			plants_loaded++

		if(plants_loaded)
			user.visible_message(span_notice("[user] loads \the [src] with \the [P]."), \
				span_notice("You load \the [src] with \the [P]."))

			if(length(P.contents) > 0)
				to_chat(user, span_notice("Some items are refused."))

		updateUsrDialog()

	else
		to_chat(user, span_notice("\The [src] smartly refuses [I]."))
		return TRUE

/obj/machinery/smartfridge/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	TOGGLE_BITFIELD(machine_stat, PANEL_OPEN)
	to_chat(user, "You [CHECK_BITFIELD(machine_stat, PANEL_OPEN) ? "open" : "close"] the maintenance panel.")
	overlays.Cut()
	if(CHECK_BITFIELD(machine_stat, PANEL_OPEN))
		overlays += image(icon, icon_panel)
	updateUsrDialog()

/obj/machinery/smartfridge/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	if(!CHECK_BITFIELD(machine_stat, PANEL_OPEN))
		return

	attack_hand(user)

/obj/machinery/smartfridge/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	if(!CHECK_BITFIELD(machine_stat, PANEL_OPEN))
		return

	attack_hand(user)

/obj/machinery/smartfridge/can_interact(mob/user)
	. = ..()
	if(!.)
		return FALSE
	if(is_secure_fridge && !allowed(usr) && locked != -1)
		return FALSE
	return TRUE

///Really simple proc, just moves the object "O" into the hands of mob "M" if able, done so I could modify the proc a little for the organ fridge
/obj/machinery/smartfridge/proc/dispense(obj/item/O, mob/M)
	var/stripped_name = strip_improper(O.name)
	item_quants[stripped_name]--
	if(!item_quants[stripped_name])
		item_quants -= stripped_name
	if(!M.put_in_hands(O))
		O.forceMove(drop_location())
		adjust_item_drop_location(O)

/obj/machinery/smartfridge/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SmartVend", name)
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/machinery/smartfridge/ui_data(mob/user)
	. = list()

	.["contents"] = item_quants
	.["name"] = name
	.["isdryer"] = FALSE

/obj/machinery/smartfridge/handle_atom_del(atom/A) // Update the UIs in case something inside gets deleted
	. = ..()
	SStgui.update_uis(src)

/obj/machinery/smartfridge/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	switch(action)
		if("Release")
			var/desired = 0

			if(params["amount"])
				desired = text2num(params["amount"])
			else
				desired = tgui_input_number(usr, "How many items?", "How many items would you like to take out?", 1)

			if(QDELETED(src) || QDELETED(usr) || !usr.Adjacent(src)) // Sanity checkin' in case stupid stuff happens while we wait for input()
				return FALSE

			if(desired == 1 && Adjacent(usr) && !issilicon(usr))
				for(var/obj/item/O in src)
					if(strip_improper(O.name) == params["name"])
						dispense(O, usr)
						break
				if(visible_contents)
					update_icon()
				return TRUE

			for(var/obj/item/O in src)
				if(desired <= 0)
					break
				if(strip_improper(O.name) == params["name"])
					dispense(O, usr)
					desired--
			if(visible_contents)
				update_icon()
			return TRUE
	return FALSE

/obj/machinery/smartfridge/proc/throw_item()
	var/obj/throw_item = null
	var/mob/living/target = locate() in view(7, src)
	if(!target)
		return FALSE

	for(var/O in item_quants)
		if(item_quants[O] <= 0) //Try to use a record that actually has something to dump.
			continue

		item_quants[O]--
		for(var/obj/T in contents)
			if(T.name != O)
				continue
			T.loc = loc
			throw_item = T
			break
		break
	if(!throw_item)
		return FALSE
	INVOKE_ASYNC(throw_item, TYPE_PROC_REF(/atom/movable, throw_at), target, 16, 3, src)
	visible_message(span_danger("[src] launches [throw_item.name] at [target.name]!"))
	return TRUE

/********************
*	Smartfridge types
*********************/

/obj/machinery/smartfridge/seeds
	name = "\improper MegaSeed Servitor"
	desc = "When you need seeds fast!"
	icon = 'icons/obj/machines/vending.dmi'
	icon_state = "seeds"
	icon_on = "seeds"
	icon_off = "seeds-off"

/obj/machinery/smartfridge/seeds/accept_check(obj/item/O as obj)
	if(istype(O,/obj/item/seeds/))
		return TRUE
	return FALSE

//the secure subtype does nothing, I'm only keeping it to avoid conflicts with maps.
/obj/machinery/smartfridge/secure/medbay
	name = "\improper Refrigerated Medicine Storage"
	desc = "A refrigerated storage unit for storing medicine and chemicals."
	icon_state = "smartfridge" //To fix the icon in the map editor.
	icon_on = "smartfridge"
	icon_off = "smartfridge-off"
	is_secure_fridge = TRUE
	req_one_access = list(ACCESS_MARINE_CMO, ACCESS_CIVILIAN_MEDICAL)

/obj/machinery/smartfridge/secure/medbay/accept_check(obj/item/O as obj)
	if(istype(O,/obj/item/reagent_containers/glass/))
		return TRUE
	if(istype(O,/obj/item/storage/pill_bottle/))
		return TRUE
	if(istype(O,/obj/item/reagent_containers/pill/))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/secure/virology
	name = "\improper Refrigerated Virus Storage"
	desc = "A refrigerated storage unit for storing viral material."
	is_secure_fridge = TRUE
	req_access = list(ACCESS_CIVILIAN_MEDICAL)
	icon_state = "smartfridge"
	icon_on = "smartfridge"
	icon_off = "smartfridge-off"

/obj/machinery/smartfridge/secure/virology/accept_check(obj/item/O as obj)
	if(istype(O,/obj/item/reagent_containers/glass/beaker/vial/))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/chemistry
	name = "\improper Smart Chemical Storage"
	desc = "A refrigerated storage unit for medicine and chemical storage."
	is_secure_fridge = TRUE

/obj/machinery/smartfridge/chemistry/accept_check(obj/item/O as obj)
	if(istype(O,/obj/item/storage/pill_bottle) || istype(O,/obj/item/reagent_containers))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/chemistry/virology
	name = "\improper Smart Virus Storage"
	desc = "A refrigerated storage unit for volatile sample storage."


/obj/machinery/smartfridge/drinks
	name = "\improper Drink Showcase"
	desc = "A refrigerated storage unit for tasty tasty alcohol."

/obj/machinery/smartfridge/drinks/accept_check(obj/item/O as obj)
	if(istype(O,/obj/item/reagent_containers/glass) || istype(O,/obj/item/reagent_containers/food/drinks) || istype(O,/obj/item/reagent_containers/food/condiment))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/nopower
	use_power = NO_POWER_USE

/obj/machinery/smartfridge/chemistry/virology/nopower
	use_power = NO_POWER_USE

/obj/machinery/smartfridge/drinks/nopower
	use_power = NO_POWER_USE

/obj/machinery/smartfridge/secure/medbay/nopower
	use_power = NO_POWER_USE

/obj/machinery/smartfridge/chemistry/nopower
	use_power = NO_POWER_USE

/obj/machinery/smartfridge/seeds/nopower
	use_power = NO_POWER_USE
