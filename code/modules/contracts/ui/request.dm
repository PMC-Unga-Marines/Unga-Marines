/datum/delivery
	interaction_flags = INTERACT_MACHINE_TGUI
	var/atom/source_object

/datum/delivery/New(atom/source_object)
	. = ..()
	src.source_object = source_object
	RegisterSignal(source_object, COMSIG_QDELETING, PROC_REF(clean_ui))

/datum/delivery/Destroy(force)
	source_object = null
	return ..()

/datum/delivery/ui_host()
	return source_object

///Signal handler to delete the ui when the source object is deleting
/datum/delivery/proc/clean_ui()
	SIGNAL_HANDLER
	qdel(src)

/datum/delivery/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(ui)
		return
	var/mob/living/account = user
	if(!account.job.type)
		return
	ui = new(user, src, "Contracts", "Battle contracts")
	ui.open()

/datum/delivery/ui_static_data(mob/user)
	. = list()
	var/mob/living/account = user
	.["supplypacks"] = SSpoints.supply_packs_delivery_ui[account.job.type] ? SSpoints.supply_packs_delivery_ui[account.job.type] : list()
	.["supplypackscontents"] = SSpoints.supply_packs_contents

/datum/delivery/ui_data(mob/living/user)
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

/datum/delivery/proc/get_shopping_cart(mob/user)
	if(!SSpoints.delivery_shopping_cart[user.ckey])
		SSpoints.delivery_shopping_cart[user.ckey] = list()
	return SSpoints.delivery_shopping_cart[user.ckey]

/datum/delivery/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
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
			. = TRUE

		if("buycart")
			SSpoints.buy_delivery_cart(user)
			. = TRUE

		if("clearcart")
			shopping_cart.Cut()
			. = TRUE
