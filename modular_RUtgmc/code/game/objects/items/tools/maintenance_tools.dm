/obj/item/tool/weldingtool
	var/datum/looping_sound/weldingtool/soundloop

/obj/item/tool/weldingtool/Initialize(mapload)
	. = ..()
	create_reagents(max_fuel, null, list(/datum/reagent/fuel = max_fuel))
	soundloop = new(list(src), active)

/obj/item/tool/weldingtool/Destroy()
	if(welding)
		STOP_PROCESSING(SSobj, src)
	QDEL_NULL(soundloop)
	return ..()

/obj/item/tool/weldingtool/proc/toggle(message = 0)
	var/mob/M
	if(ismob(loc))
		M = loc
	if(!welding)
		if(get_fuel() > 0)
			soundloop.start()
			welding = 1
			if(M)
				balloon_alert(M, "Turns on")
			set_light(1, LIGHTER_LUMINOSITY)
			weld_tick += 8 //turning the tool on does not consume fuel directly, but it advances the process that regularly consumes fuel.
			force = 15
			damtype = BURN
			icon_state = "welder1"
			w_class = WEIGHT_CLASS_BULKY
			heat = 3800
			START_PROCESSING(SSobj, src)
		else
			if(M)
				balloon_alert(M, "Out of fuel")
			return
	else
		soundloop.stop()
		force = 3
		damtype = BRUTE
		icon_state = "welder"
		welding = 0
		w_class = initial(w_class)
		heat = 0
		if(M)
			if(!message)
				balloon_alert(M, "Switches off")
			else
				balloon_alert(M, "Out of fuel")
			if(M.r_hand == src)
				M.update_inv_r_hand()
			if(M.l_hand == src)
				M.update_inv_l_hand()
		set_light(0)
		STOP_PROCESSING(SSobj, src)

