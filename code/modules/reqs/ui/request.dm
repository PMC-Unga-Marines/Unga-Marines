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

//// delivery.dm (полная реализация)
/datum/supply_ui/delivery
	tgui_name = "Delivery"

/datum/supply_ui/delivery/ui_static_data(mob/user)
	. = list()
	var/mob/living/account = user
	.["supplypacks"] = SSpoints.supply_packs_delivery_ui[account.job]
	.["supplypackscontents"] = SSpoints.supply_packs_contents

/datum/supply_ui/delivery/ui_data(mob/living/user)
	. = list()
	.["personalpoints"] = round(SSpoints.personal_supply_points[user.ckey])

	if(!SSpoints.delivery_shopping_cart[user.ckey])
		SSpoints.delivery_shopping_cart[user.ckey] = list()

	.["shopping_list_cost"] = 0
	.["shopping_list_items"] = 0
	.["shopping_list"] = list()

	for(var/i in SSpoints.delivery_shopping_cart[user.ckey])
		var/datum/supply_packs/our_pack = SSpoints.supply_packs[i]
		.["shopping_list_items"] += SSpoints.delivery_shopping_cart[user.ckey][i]
		.["shopping_list_cost"] += our_pack.cost * SSpoints.delivery_shopping_cart[user.ckey][our_pack.type]
		.["shopping_list"][our_pack.type] = list("count" = SSpoints.delivery_shopping_cart[user.ckey][our_pack.type])

/datum/supply_ui/delivery/get_shopping_cart(mob/user)
	if(!SSpoints.delivery_shopping_cart[user.ckey])
		SSpoints.delivery_shopping_cart[user.ckey] = list()
	return SSpoints.delivery_shopping_cart[user.ckey]

/datum/supply_ui/delivery/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return TRUE

	var/mob/user = ui.user
	var/list/shopping_cart = get_shopping_cart(user)

	switch(action)
		if("cart")
			var/datum/supply_packs/P = SSpoints.supply_packs[text2path(params["id"])]
			if(!P)
				return

			switch(params["mode"])
				if("removeall")
					shopping_cart -= P.type
				if("removeone")
					if(shopping_cart[P.type] > 1)
						shopping_cart[P.type]--
					else
						shopping_cart -= P.type
				if("addone")
					var/can_afford = P.cost <= SSpoints.personal_supply_points[user.ckey]
					if(can_afford && shopping_cart[P.type])
						shopping_cart[P.type]++
					else if(can_afford)
						shopping_cart[P.type] = 1
				if("addall")
					var/current_points = SSpoints.personal_supply_points[user.ckey]
					var/cart_cost = 0
					for(var/i in shopping_cart)
						var/datum/supply_packs/SP = SSpoints.supply_packs[i]
						cart_cost += SP.cost * shopping_cart[SP.type]
					var/excess_points = current_points - cart_cost
					var/number_to_buy = min(round(excess_points / P.cost), 20)
					if(number_to_buy > 0)
						if(shopping_cart[P.type])
							shopping_cart[P.type] += number_to_buy
						else
							shopping_cart[P.type] = number_to_buy
			. = TRUE

		if("buycart")
			SSpoints.buy_delivery_cart(user)
			. = TRUE

		if("clearcart")
			shopping_cart.Cut()
			. = TRUE
