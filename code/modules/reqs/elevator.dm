GLOBAL_LIST_INIT(blacklisted_cargo_types, typecacheof(list(
	/mob/living,
	/obj/item/disk/nuclear,
	/obj/item/radio/beacon,
	/obj/vehicle,
)))

/obj/docking_port/stationary/supply
	shuttle_id = "supply_home"
	roundstart_template = /datum/map_template/shuttle/supply
	width = 5
	dwidth = 2
	dheight = 2
	height = 5

/obj/docking_port/mobile/supply
	name = "supply shuttle"
	shuttle_id = SHUTTLE_SUPPLY
	callTime = 15 SECONDS

	dir = WEST
	port_direction = EAST
	width = 5
	dwidth = 2
	dheight = 2
	height = 5
	movement_force = list("KNOCKDOWN" = 0, "THROW" = 0)
	use_ripples = FALSE
	faction = FACTION_TERRAGOV
	var/list/gears = list()
	var/list/obj/machinery/door/poddoor/railing/railings = list()
	/// Id of the home docking port
	var/home_id = "supply_home"
	///prefix for railings and gear todo should probbaly be defines instead?
	var/railing_gear_name = "supply"

/obj/docking_port/mobile/supply/Destroy(force)
	for(var/i in railings)
		var/obj/machinery/door/poddoor/railing/railing = i
		railing.linked_pad = null
	railings.Cut()
	return ..()

/obj/docking_port/mobile/supply/after_shuttle_move()
	. = ..()
	if(getDockedId() != home_id)
		return
	for(var/j in railings)
		var/obj/machinery/door/poddoor/railing/our_railing = j
		our_railing.open()

/obj/docking_port/mobile/supply/on_ignition()
	if(getDockedId() == home_id)
		for(var/j in railings)
			var/obj/machinery/door/poddoor/railing/our_railing = j
			our_railing.close()
		for(var/i in gears)
			var/obj/machinery/gear/our_gear = i
			our_gear.start_moving(NORTH)
	else
		for(var/i in gears)
			var/obj/machinery/gear/our_gear = i
			our_gear.start_moving(SOUTH)

/obj/docking_port/mobile/supply/register()
	. = ..()
	for(var/obj/machinery/gear/our_gear in GLOB.machines)
		if(our_gear.id != (railing_gear_name + "_elevator_gear"))
			continue
		gears += our_gear
		RegisterSignal(our_gear, COMSIG_QDELETING, PROC_REF(clean_gear))
	for(var/obj/machinery/door/poddoor/railing/our_railing in GLOB.machines)
		if(our_railing.id != (railing_gear_name + "_elevator_railing"))
			continue
		railings += our_railing
		RegisterSignal(our_railing, COMSIG_QDELETING, PROC_REF(clean_railing))
		our_railing.linked_pad = src
		our_railing.open()

///Signal handler when a gear is destroyed
/obj/docking_port/mobile/supply/proc/clean_gear(datum/source)
	SIGNAL_HANDLER
	gears -= source

///Signal handler when a railing is destroyed
/obj/docking_port/mobile/supply/proc/clean_railing(datum/source)
	SIGNAL_HANDLER
	railings -= source

/obj/docking_port/mobile/supply/canMove()
	if(is_station_level(z))
		return check_blacklist(shuttle_areas)
	return ..()

/obj/docking_port/mobile/supply/proc/check_blacklist(areaInstances)
	if(!areaInstances)
		areaInstances = shuttle_areas
	for(var/place in areaInstances)
		var/area/shuttle/shuttle_area = place
		for(var/trf in shuttle_area)
			var/turf/T = trf
			for(var/a in T.GetAllContents())
				if(isxeno(a))
					var/mob/living/L = a
					if(L.stat == DEAD)
						continue
				if(ishuman(a))
					var/mob/living/carbon/human/human_to_sell = a
					if(human_to_sell.stat == DEAD && can_sell_human_body(human_to_sell, faction))
						continue
				if(is_type_in_typecache(a, GLOB.blacklisted_cargo_types))
					return FALSE
	return TRUE

/obj/docking_port/mobile/supply/request(obj/docking_port/stationary/S)
	if(mode != SHUTTLE_IDLE)
		return 2
	return ..()

/obj/docking_port/mobile/supply/proc/buy(mob/user, datum/supply_ui/supply_ui)
	if(!length(SSpoints.shoppinglist[faction]))
		return
	log_game("Supply pack orders have been purchased by [key_name(user)]")

	var/list/empty_turfs = list()
	for(var/place in shuttle_areas)
		var/area/shuttle/shuttle_area = place
		for(var/turf/open/floor/T in shuttle_area)
			if(is_blocked_turf(T))
				continue
			empty_turfs += T

	for(var/i in SSpoints.shoppinglist[faction])
		if(!length(empty_turfs))
			break
		var/datum/supply_order/our_order = LAZYACCESSASSOC(SSpoints.shoppinglist, faction, i)

		var/datum/supply_packs/firstpack = our_order.pack[1]

		var/obj/structure/crate_type = firstpack.containertype || firstpack.contains[1]

		var/obj/structure/our_structure = new crate_type(pick_n_take(empty_turfs))
		if(firstpack.containertype)
			our_structure.name = "Order #[our_order.id] for [our_order.orderer]"

		var/list/contains = list()
		//spawn the stuff, finish generating the manifest while you're at it
		for(var/P in our_order.pack)
			var/datum/supply_packs/our_pack = P
			// yes i know
			if(our_pack.access)
				our_structure.req_access = list()
				our_structure.req_access += text2num(our_pack.access)

			if(our_pack.randomised_num_contained)
				if(length(our_pack.contains))
					for(var/j in 1 to our_pack.randomised_num_contained)
						contains += pick(our_pack.contains)
			else
				contains += our_pack.contains

		for(var/typepath in contains)
			if(!typepath)
				continue
			if(!firstpack.containertype)
				break
			new typepath(our_structure)

		SSpoints.shoppinglist[faction] -= "[our_order.id]"
		SSpoints.shopping_history += our_order

/obj/docking_port/mobile/supply/proc/sell()
	for(var/place in shuttle_areas)
		var/area/shuttle/shuttle_area = place
		for(var/atom/movable/AM in shuttle_area)
			if(AM.anchored)
				continue
			var/datum/export_report = AM.supply_export(faction)
			if(export_report)
				SSpoints.export_history += export_report
			qdel(AM)

/obj/docking_port/mobile/supply/vehicle
	railing_gear_name = "vehicle"
	shuttle_id = SHUTTLE_VEHICLE_SUPPLY
	home_id = "vehicle_home"

/obj/docking_port/mobile/supply/vehicle/buy(mob/user, datum/supply_ui/supply_ui)
	var/datum/supply_ui/vehicles/veh_ui = supply_ui
	if(!veh_ui || !veh_ui.current_veh_type)
		return
	var/obj/vehicle/sealed/armored/tanktype = veh_ui.current_veh_type
	var/is_assault = initial(tanktype.armored_flags) & ARMORED_PURCHASABLE_ASSAULT
	if(GLOB.purchased_tanks[user.faction]?["[is_assault]"])
		to_chat(usr, span_danger("A vehicle of this type has already been purchased!"))
		return
	if(!GLOB.purchased_tanks[user.faction])
		GLOB.purchased_tanks[user.faction] = list()
	GLOB.purchased_tanks[user.faction]["[is_assault]"] += 1
	var/obj/vehicle/sealed/armored/tank = new tanktype(loc)
	if(veh_ui.current_primary)
		var/obj/item/armored_weapon/gun = new veh_ui.current_primary(loc)
		gun.attach(tank, TRUE)
	if(veh_ui.current_secondary)
		var/obj/item/armored_weapon/gun = new veh_ui.current_secondary(loc)
		gun.attach(tank, FALSE)
	if(veh_ui.current_driver_mod)
		var/obj/item/tank_module/mod = new veh_ui.current_driver_mod(loc)
		mod.on_equip(tank)
	if(veh_ui.current_gunner_mod)
		var/obj/item/tank_module/mod = new veh_ui.current_gunner_mod(loc)
		mod.on_equip(tank)
	if(length(veh_ui.primary_ammo))
		var/turf/dumploc = get_step(get_step(loc, NORTH), NORTH) // todo should autoload depending on tank prolly
		for(var/ammo in veh_ui.primary_ammo)
			for(var/i=1 to veh_ui.primary_ammo[ammo])
				new ammo(dumploc)
	if(length(veh_ui.secondary_ammo))
		var/turf/dumploc = get_step(get_step(loc, NORTH), NORTH) // todo should autoload depending on tank prolly
		for(var/ammo in veh_ui.secondary_ammo)
			for(var/i=1 to veh_ui.secondary_ammo[ammo])
				new ammo(dumploc)
	SStgui.close_user_uis(user, veh_ui)

/obj/docking_port/stationary/supply/vehicle
	shuttle_id = "vehicle_home"
	roundstart_template = /datum/map_template/shuttle/supply/vehicle
