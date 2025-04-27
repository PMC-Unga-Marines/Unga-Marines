/datum/supply_ui/requests
	tgui_name = "CargoRequest"

// yes these are copy pasted from above because SPEEEEEEEEEEEEED
/datum/supply_ui/requests/ui_static_data(mob/user)
	. = list()
	.["categories"] = GLOB.all_supply_groups
	.["supplypacks"] = SSpoints.supply_packs_ui
	.["supplypackscontents"] = SSpoints.supply_packs_contents

/datum/supply_ui/requests/ui_data(mob/living/user)
	. = list()
	.["currentpoints"] = round(SSpoints.supply_points[user.faction])
	.["personalpoints"] = round(SSpoints.personal_supply_points[user.ckey])
	.["requests"] = list()
	for(var/i in SSpoints.requestlist)
		var/datum/supply_order/our_order = SSpoints.requestlist[i]
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
		.["requests"] += list(list(
			"id" = our_order.id,
			"orderer" = our_order.orderer,
			"orderer_rank" = our_order.orderer_rank,
			"reason" = our_order.reason,
			"cost" = cost,
			"packs" = packs,
			"authed_by" = our_order.authorised_by
		))
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
			"cost" = cost,
			"packs" = packs,
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
			"cost" = cost,
			"packs" = packs,
			"authed_by" = our_order.authorised_by
		))
	.["awaiting_delivery"] = list()
	.["awaiting_delivery_orders"] = 0
	for(var/key in SSpoints.shoppinglist[faction])
		//only own orders
		var/datum/supply_order/our_order = LAZYACCESSASSOC(SSpoints.shoppinglist, faction, key)
		if(user.real_name != our_order.orderer)
			continue
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
	if(!SSpoints.request_shopping_cart[user.ckey])
		SSpoints.request_shopping_cart[user.ckey] = list()
	.["shopping_list_cost"] = 0
	.["shopping_list_items"] = 0
	.["shopping_list"] = list()
	for(var/i in SSpoints.request_shopping_cart[user.ckey])
		var/datum/supply_packs/our_pack = SSpoints.supply_packs[i]
		.["shopping_list_items"] += SSpoints.request_shopping_cart[user.ckey][i]
		.["shopping_list_cost"] += our_pack.cost * SSpoints.request_shopping_cart[user.ckey][our_pack.type]
		.["shopping_list"][our_pack.type] = list("count" = SSpoints.request_shopping_cart[user.ckey][our_pack.type])

	var/list/beacon_list = GLOB.supply_beacon.Copy()
	for(var/beacon_name in beacon_list)
		var/datum/supply_beacon/beacon = beacon_list[beacon_name]
		if(!is_ground_level(beacon.drop_location.z))
			beacon_list -= beacon_name
			continue // does this continue even does something?
	.["beacon"] = length(beacon_list) ? TRUE : FALSE

/datum/supply_ui/requests/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return TRUE
	switch(action)
		if("submitrequest")
			SSpoints.submit_request(ui.user, params["reason"])
			. = TRUE

/datum/supply_ui/requests/get_shopping_cart(mob/user)
	return SSpoints.request_shopping_cart[user.ckey]
