/datum/supply_ui
	interaction_flags = INTERACT_MACHINE_TGUI
	var/atom/source_object
	var/tgui_name = "Cargo"
	///Id of the shuttle controlled
	var/shuttle_id = ""
	///Reference to the supply shuttle
	var/obj/docking_port/mobile/supply/supply_shuttle
	///Faction of the supply console linked
	var/faction = FACTION_TERRAGOV
	///Id of the home port
	var/home_id = ""

/datum/supply_ui/New(atom/source_object)
	. = ..()
	src.source_object = source_object
	RegisterSignal(source_object, COMSIG_QDELETING, PROC_REF(clean_ui))

///Signal handler to delete the ui when the source object is deleting
/datum/supply_ui/proc/clean_ui()
	SIGNAL_HANDLER
	qdel(src)

/datum/supply_ui/Destroy(force)
	source_object = null
	return ..()

/datum/supply_ui/ui_host()
	return source_object

/datum/supply_ui/can_interact(mob/user)
	. = ..()
	if(!.)
		return FALSE
	if(!user.CanReach(source_object))
		return FALSE
	return TRUE

/datum/supply_ui/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)

	if(ui)
		return
	if(shuttle_id)
		supply_shuttle = SSshuttle.getShuttle(shuttle_id)
		supply_shuttle.home_id = home_id
		supply_shuttle.faction = faction
	ui = new(user, src, tgui_name, source_object.name)
	ui.open()

/datum/supply_ui/ui_static_data(mob/user)
	. = list()
	.["categories"] = GLOB.all_supply_groups
	.["supplypacks"] = SSpoints.supply_packs_ui
	.["supplypackscontents"] = SSpoints.supply_packs_contents
	.["elevator_size"] = supply_shuttle?.return_number_of_turfs()

/datum/supply_ui/ui_data(mob/living/user)
	. = list()
	.["currentpoints"] = round(SSpoints.supply_points[user.faction])
	.["personalpoints"] = round(SSpoints.personal_supply_points[user.ckey])
	.["requests"] = list()
	for(var/key in SSpoints.requestlist)
		var/datum/supply_order/our_order = SSpoints.requestlist[key]
		if(our_order.faction != user.faction)
			continue
		var/list/packs = list()
		var/cost = 0
		for(var/P in our_order.pack)
			var/datum/supply_packs/our_pack = P
			if(packs[our_pack.type])
				packs[our_pack.type] += 1
			else
				packs[our_pack.type] = 1
			cost += our_pack.cost
		.["requests"] += list(list("id" = our_order.id, "orderer" = our_order.orderer, "orderer_rank" = our_order.orderer_rank, "reason" = our_order.reason, "cost" = cost, "packs" = packs, "authed_by" = our_order.authorised_by))
	.["deniedrequests"] = list()
	for(var/i in length(SSpoints.deniedrequests) to 1 step -1)
		var/datum/supply_order/our_order = SSpoints.deniedrequests[SSpoints.deniedrequests[i]]
		if(our_order.faction != user.faction)
			continue
		var/list/packs = list()
		var/cost = 0
		for(var/P in our_order.pack)
			var/datum/supply_packs/our_pack = P
			if(packs[our_pack.type])
				packs[our_pack.type] += 1
			else
				packs[our_pack.type] = 1
			cost += our_pack.cost
		.["deniedrequests"] += list(list(
			"id" = our_order.id,
			"orderer" = our_order.orderer,
			"orderer_rank" = our_order.orderer_rank,
			"reason" = our_order.reason,
			"cost" = cost, "packs" = packs,
			"authed_by" = our_order.authorised_by
		))
	.["approvedrequests"] = list()
	for(var/i in length(SSpoints.approvedrequests) to 1 step -1)
		var/datum/supply_order/our_order = SSpoints.approvedrequests[SSpoints.approvedrequests[i]]
		if(our_order.faction != user.faction)
			continue
		var/list/packs = list()
		var/cost = 0
		for(var/P in our_order.pack)
			var/datum/supply_packs/our_pack = P
			if(packs[our_pack.type])
				packs[our_pack.type] += 1
			else
				packs[our_pack.type] = 1
			cost += our_pack.cost
		.["approvedrequests"] += list(list(
			"id" = our_order.id,
			"orderer" = our_order.orderer,
			"orderer_rank" = our_order.orderer_rank,
			"reason" = our_order.reason,
			"cost" = cost, "packs" = packs,
			"authed_by" = our_order.authorised_by
		))
	.["awaiting_delivery"] = list()
	.["awaiting_delivery_orders"] = 0
	for(var/key in SSpoints.shoppinglist[faction])
		var/datum/supply_order/our_order = LAZYACCESSASSOC(SSpoints.shoppinglist, faction, key)
		.["awaiting_delivery_orders"]++
		var/list/packs = list()
		var/cost = 0
		for(var/P in our_order.pack)
			var/datum/supply_packs/our_pack = P
			if(packs[our_pack.type])
				packs[our_pack.type] += 1
			else
				packs[our_pack.type] = 1
			cost += our_pack.cost
		.["awaiting_delivery"] += list(list(
			"id" = our_order.id,
			"orderer" = our_order.orderer,
			"orderer_rank" = our_order.orderer_rank,
			"reason" = our_order.reason,
			"cost" = cost,
			"packs" = packs,
			"authed_by" = our_order.authorised_by
		))
	.["export_history"] = list()
	var/id = 0
	var/lastexport = ""
	for(var/datum/export_report/report AS in SSpoints.export_history)
		if(report.faction != user.faction)
			continue
		if(report.points == 0)
			continue
		if(report.export_name == lastexport)
			.["export_history"][id]["amount"] += 1
			.["export_history"][id]["total"] += report.points
		else
			.["export_history"] += list(list(
				"id" = id,
				"name" = report.export_name,
				"points" = report.points,
				"amount" = 1,
				total = report.points
			))
			id++
			lastexport = report.export_name
	.["shopping_history"] = list()
	for(var/datum/supply_order/our_order AS in SSpoints.shopping_history)
		if(our_order.faction != user.faction)
			continue
		var/list/packs = list()
		var/cost = 0
		for(var/P in our_order.pack)
			var/datum/supply_packs/our_pack = P
			if(packs[our_pack.type])
				packs[our_pack.type] += 1
			else
				packs[our_pack.type] = 1
			cost += our_pack.cost
		.["shopping_history"] += list(list(
			"id" = our_order.id,
			"orderer" = our_order.orderer,
			"orderer_rank" = our_order.orderer_rank,
			"reason" = our_order.reason,
			"cost" = cost,
			"packs" = packs,
			"authed_by" = our_order.authorised_by
		))
	.["shopping_list_cost"] = 0
	.["shopping_list_items"] = 0
	.["shopping_list"] = list()
	for(var/i in SSpoints.shopping_cart)
		var/datum/supply_packs/our_pack = SSpoints.supply_packs[i]
		.["shopping_list_items"] += SSpoints.shopping_cart[i]
		.["shopping_list_cost"] += our_pack.cost * SSpoints.shopping_cart[our_pack.type]
		.["shopping_list"][our_pack.type] = list("count" = SSpoints.shopping_cart[our_pack.type])
	if(supply_shuttle)
		if(supply_shuttle?.mode == SHUTTLE_CALL)
			if(is_mainship_level(supply_shuttle.destination.z))
				.["elevator"] = "Raising"
				.["elevator_dir"] = "up"
			else
				.["elevator"] = "Lowering"
				.["elevator_dir"] = "down"
		else if(supply_shuttle?.mode == SHUTTLE_IDLE)
			if(is_mainship_level(supply_shuttle.z))
				.["elevator"] = "Raised"
				.["elevator_dir"] = "down"
			else
				.["elevator"] = "Lowered"
				.["elevator_dir"] = "up"
		else
			if(is_mainship_level(supply_shuttle.z))
				.["elevator"] = "Lowering"
				.["elevator_dir"] = "down"
			else
				.["elevator"] = "Raising"
				.["elevator_dir"] = "up"
	else
		.["elevator"] = "MISSING!"
	var/list/beacon_list = GLOB.supply_beacon.Copy()
	for(var/beacon_name in beacon_list)
		var/datum/supply_beacon/beacon = beacon_list[beacon_name]
		if(!is_ground_level(beacon.drop_location.z))
			beacon_list -= beacon_name
			continue // does this continue even does something?
	.["beacon"] = length(beacon_list) ? TRUE : FALSE

/datum/supply_ui/proc/get_shopping_cart(mob/user)
	return SSpoints.shopping_cart

/datum/supply_ui/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("cart")
			var/datum/supply_packs/P = SSpoints.supply_packs[text2path(params["id"])]
			if(!P)
				return
			var/shopping_cart = get_shopping_cart(ui.user)
			switch(params["mode"])
				if("removeall")
					shopping_cart -= P.type
				if("removeone")
					if(shopping_cart[P.type] > 1)
						shopping_cart[P.type]--
					else
						shopping_cart -= P.type
				if("addone")
					if(shopping_cart[P.type])
						shopping_cart[P.type]++
					else
						shopping_cart[P.type] = 1
				if("addall")
					var/mob/living/ui_user = ui.user
					var/cart_cost = 0
					for(var/i in shopping_cart)
						var/datum/supply_packs/SP = SSpoints.supply_packs[i]
						cart_cost += SP.cost * shopping_cart[SP.type]
					var/excess_points = SSpoints.supply_points[ui_user.faction] - cart_cost
					var/number_to_buy = min(round(excess_points / P.cost), 20) //hard cap at 20
					if(shopping_cart[P.type])
						shopping_cart[P.type] += number_to_buy
					else
						shopping_cart[P.type] = number_to_buy
			. = TRUE
		if("send")
			if(supply_shuttle.mode != SHUTTLE_IDLE)
				return
			if(is_mainship_level(supply_shuttle.z))
				if (!supply_shuttle.check_blacklist())
					to_chat(usr, "For safety reasons, the Automated Storage and Retrieval System cannot store live, friendlies, classified nuclear weaponry or homing beacons.")
					playsound(supply_shuttle.return_center_turf(), 'sound/machines/buzz-two.ogg', 50, 0)
				else
					playsound(supply_shuttle.return_center_turf(), 'sound/machines/elevator_move.ogg', 50, 0)
					SSshuttle.moveShuttleToTransit(shuttle_id, TRUE)
					addtimer(CALLBACK(supply_shuttle, TYPE_PROC_REF(/obj/docking_port/mobile/supply, sell)), 15 SECONDS)
			else
				var/obj/docking_port/D = SSshuttle.getDock(home_id)
				supply_shuttle.buy(usr, src)
				playsound(D.return_center_turf(), 'sound/machines/elevator_move.ogg', 50, 0)
				SSshuttle.moveShuttle(shuttle_id, home_id, TRUE)
			. = TRUE
		if("approve")
			var/datum/supply_order/O = SSpoints.requestlist["[params["id"]]"]
			if(!O)
				O = SSpoints.deniedrequests["[params["id"]]"]
			if(!O)
				return
			SSpoints.approve_request(O, ui.user)
			. = TRUE
		if("deny")
			var/datum/supply_order/O = SSpoints.requestlist["[params["id"]]"]
			if(!O)
				return
			SSpoints.deny_request(O)
			. = TRUE
		if("approveall")
			for(var/i in SSpoints.requestlist)
				var/datum/supply_order/O = SSpoints.requestlist[i]
				SSpoints.approve_request(O, ui.user)
			. = TRUE
		if("denyall")
			for(var/i in SSpoints.requestlist)
				var/datum/supply_order/O = SSpoints.requestlist[i]
				SSpoints.deny_request(O)
			. = TRUE
		if("buycart")
			SSpoints.buy_cart(ui.user)
			. = TRUE
		if("clearcart")
			var/list/shopping_cart = get_shopping_cart(ui.user)
			shopping_cart.Cut()
			. = TRUE
		if("buypersonal")
			SSpoints.buy_using_psp(ui.user)
			. = TRUE
		if("delivery")
			var/datum/supply_order/O = SSpoints.shoppinglist[faction]["[params["id"]]"]
			if(!O)
				return
			SSpoints.fast_delivery(O, ui.user)
			. = TRUE
