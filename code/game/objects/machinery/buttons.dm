#define DOOR_FLAG_OPEN_ONLY (1 << 0)

/obj/machinery/button
	name = "button"
	desc = "A remote control switch."
	icon = 'icons/obj/machines/buttons.dmi'
	icon_state = "door"
	power_channel = ENVIRON
	use_power = IDLE_POWER_USE
	idle_power_usage = 2
	active_power_usage = 5
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 10, BIO = 100, FIRE = 90, ACID = 70)
	light_range = 1
	light_power = 0.3
	var/id = null
	var/next_activate = 0

/obj/machinery/button/indestructible
	resistance_flags = RESIST_ALL

/obj/machinery/button/Initialize(mapload)
	. = ..()
	set_offsets()

///Proc that sets pixel offsets on Initialize if the button doesn't have it map-edited
/obj/machinery/button/proc/set_offsets()
	if(pixel_x || pixel_y)
		return

	switch(dir)
		if(NORTH)
			pixel_y = -32
		if(SOUTH)
			pixel_y = 32
		if(EAST)
			pixel_x = -32
		if(WEST)
			pixel_x = 32

/obj/machinery/button/update_icon()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		set_light(0)
	else
		set_light(initial(light_range))

/obj/machinery/button/update_icon_state()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		icon_state = "[initial(icon_state)]_off"
	else
		icon_state = initial(icon_state)

/obj/machinery/button/update_overlays()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		return
	. += emissive_appearance(icon, "[icon_state]_emissive", src)

/obj/machinery/button/attack_ai(mob/user)
	return attack_hand(user)

/obj/machinery/button/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return

	if((machine_stat & (NOPOWER|BROKEN)))
		return

	if(!allowed(user))
		to_chat(user, span_danger("Access Denied"))
		flick("[initial(icon_state)]_denied", src)
		return

	use_power(active_power_usage)
	icon_state = "[initial(icon_state)]_on"

	pulsed()

	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, update_icon)), 1.5 SECONDS)

/obj/machinery/button/proc/pulsed()
	if(next_activate > world.time)
		return FALSE
	next_activate = world.time + 3 SECONDS
	return TRUE

/obj/machinery/button/psi_act(psi_power, mob/living/user)
	pulsed()
	return list(0.1 SECONDS, 1)

/obj/machinery/button/door
	name = "door button"
	desc = "A door remote control switch."
	var/specialfunctions = NONE

/obj/machinery/button/door/indestructible
	resistance_flags = RESIST_ALL

/obj/machinery/button/door/pulsed()
	. = ..()
	if(!.)
		return
	var/openclose
	for(var/obj/machinery/door/poddoor/M in GLOB.machines)
		if(M.id != src.id)
			continue
		if(!specialfunctions)
			openclose = M.density
		else if(CHECK_BITFIELD(specialfunctions, DOOR_FLAG_OPEN_ONLY))
			openclose = TRUE
		if(openclose)
			M.open()
			continue
		M.close()

/obj/machinery/button/door/open_only
	name = "open button"
	desc = "Opens whatever it is linked to. Does not close. Careful on what you release."
	specialfunctions = DOOR_FLAG_OPEN_ONLY

/obj/machinery/button/door/open_only/Initialize(mapload)
	. = ..()
	switch(dir)
		if(NORTH)
			pixel_y = -12
		if(SOUTH)
			pixel_y = 29
		if(EAST)
			pixel_x = -21
		if(WEST)
			pixel_x = 21

/obj/machinery/button/door/open_only/landing_zone
	name = "lockdown override"
	id = "landing_zone"
	icon_state = "shutter"
	use_power = NO_POWER_USE
	resistance_flags = RESIST_ALL
	req_one_access = list(ACCESS_MARINE_DROPSHIP)
	/// Has the shutters alarm been played?
	var/alarm_played = FALSE

/obj/machinery/button/door/open_only/landing_zone/Initialize(mapload)
	. = ..()
	var/area/area = get_area(src)
	area.area_flags |= MARINE_BASE

/obj/machinery/button/door/open_only/landing_zone/attack_hand(mob/living/user)
	if((machine_stat & (NOPOWER|BROKEN)))
		return
	#ifndef TESTING
	if(world.time < SSticker.round_start_time + SSticker.mode.deploy_time_lock)
		to_chat(user, span_notice("The containment shutters can't open yet!"))
		return
	#endif
	if(!allowed(user))
		to_chat(user, span_danger("Access Denied"))
		flick("[initial(icon_state)]_denied", src)
		return
	if(alarm_played)
		flick("[initial(icon_state)]_denied", src)
		return
	use_power(active_power_usage)
	icon_state = "[initial(icon_state)]_on"

	alarm_played = TRUE
	playsound_z(z, 'sound/effects/shutters_alarm.ogg', 15) // woop woop, shutters opening.
	log_game("[key_name(user)] has opened the LZ Containment Shutters.")
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, update_icon)), 1.5 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(pulsed)), 185)

/obj/machinery/button/door/open_only/landing_zone/pulsed()
	. = ..()
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_OPEN_SHUTTERS_EARLY)

/obj/machinery/button/door/open_only/landing_zone/lz2
	id = "landing_zone_2"

/obj/machinery/driver_button
	name = "mass driver button"
	icon = 'icons/obj/machines/buttons.dmi'
	icon_state = "launcher"
	desc = "A remote control switch for a mass driver."
	anchored = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 2
	active_power_usage = 4
	var/id = null
	var/active = 0

/obj/machinery/driver_button/attack_ai(mob/living/silicon/ai/AI)
	return attack_hand(AI)

/obj/machinery/driver_button/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/detective_scanner))
		return
	else
		return attack_hand(user)

/obj/machinery/driver_button/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(machine_stat & (NOPOWER|BROKEN))
		return
	if(active)
		return

	use_power(active_power_usage)

	active = TRUE
	icon_state = "launcher_on"

	for(var/obj/machinery/door/poddoor/M in GLOB.machines)
		if(M.id == id)
			M.open()

	sleep(5 SECONDS)

	for(var/obj/machinery/door/poddoor/M in GLOB.machines)
		if(M.id == id)
			M.close()

	icon_state = "launcher"
	active = 0

/obj/machinery/ignition_switch
	name = "ignition switch"
	icon = 'icons/obj/machines/buttons.dmi'
	icon_state = "launcher"
	desc = "A remote control switch for a mounted igniter."
	anchored = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 2
	active_power_usage = 4
	var/id = null
	var/active = 0

/obj/machinery/flasher_button
	name = "flasher button"
	desc = "A remote control switch for a mounted flasher."
	icon = 'icons/obj/machines/buttons.dmi'
	icon_state = "launcher"
	anchored = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 2
	active_power_usage = 4
	var/id = null
	var/active = 0

/obj/machinery/crema_switch
	desc = "Burn baby burn!"
	name = "crematorium igniter"
	icon = 'icons/obj/power.dmi'
	icon_state = "crema_switch"
	anchored = TRUE
	req_access = list(ACCESS_MARINE_MEDBAY)
	var/on = 0
	var/area/area = null
	var/otherarea = null
	var/id = 1

/obj/machinery/medical_help_button
	name = "Medical attention required"
	icon = 'icons/obj/machines/buttons.dmi'
	icon_state = "button"
	desc = "A button for alerting doctors that you require assistance."
	anchored = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 2
	active_power_usage = 4
	var/active = FALSE
	var/obj/item/radio/radio

/obj/machinery/medical_help_button/Initialize(mapload)
	. = ..()
	radio = new(src)

/obj/machinery/medical_help_button/Destroy()
	QDEL_NULL(radio)
	return ..()

/obj/machinery/medical_help_button/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(!istype(user))
		return
	if(machine_stat & (NOPOWER|BROKEN))
		to_chat(user, span_warning("[src] doesn't seem to be working."))
		return
	if(active)
		return
	use_power(active_power_usage)
	icon_state = "button"

	radio.talk_into(src, "<b>[user.name] is requesting medical attention at: [get_area(src)].</b>", RADIO_CHANNEL_MEDICAL)
	visible_message("Remain calm, someone will be with you shortly.")

	active = TRUE
	addtimer(CALLBACK(src, PROC_REF(icon_update_check)), 10 SECONDS)

/obj/machinery/medical_help_button/proc/icon_update_check()
	active = FALSE
	update_icon()

/obj/machinery/medical_help_button/update_icon_state()
	. = ..()
	if(machine_stat & NOPOWER)
		icon_state = "door_off"
	else
		icon_state = "door"

/obj/machinery/button/valhalla
	resistance_flags = INDESTRUCTIBLE
	///The mob created by the spawner
	var/mob/living/carbon/human/linked
	///What spawner landmark is linked with this spawner (this has to be matching with the landmark)
	var/spawn_link

/obj/machinery/button/valhalla/Destroy()
	linked = null
	return ..()

/obj/machinery/button/valhalla/proc/turf_check(mob/living/user)
	if(!get_turf(GLOB.valhalla_button_spawn_landmark[spawn_link]))
		to_chat(user, span_warning("An error occured, yell at the coders."))
		CRASH("Valhalla button linked with an improper landmark: button ID: [spawn_link].")

/obj/machinery/button/valhalla/marine_button
	name = "Xeno spawner"

/obj/machinery/button/valhalla/marine_button/attack_hand(mob/living/user)
	var/xeno_wanted = tgui_input_list(user, "What xeno do you want to spawn?", "Xeno spawn", GLOB.all_xeno_types)
	if(!xeno_wanted)
		return
	QDEL_NULL(linked)
	turf_check(user)
	linked = new xeno_wanted(get_turf(GLOB.valhalla_button_spawn_landmark[spawn_link]))

/obj/machinery/button/valhalla/xeno_button
	name = "Marine spawner"

/obj/machinery/button/valhalla/xeno_button/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount, damage_type, damage_flag, effects, armor_penetration, isrightclick)
	var/list/job_outfits = list()
	for(var/type in subtypesof(/datum/outfit/job))
		if(istype(type, /datum/outfit))
			continue
		var/datum/outfit/out = type
		job_outfits[initial(out.name)] = out

	job_outfits = sortList(job_outfits)
	job_outfits.Insert(1, "Naked")

	var/datum/outfit/selected_outfit = tgui_input_list(usr, "Which outfit do you want the human to wear?", "Human spawn", job_outfits)
	if(!selected_outfit)
		return

	QDEL_NULL(linked)
	turf_check(xeno_attacker)
	linked = new /mob/living/carbon/human(get_turf(GLOB.valhalla_button_spawn_landmark[spawn_link]))
	if(selected_outfit == "Naked" || !selected_outfit)
		return
	linked.equipOutfit(job_outfits[selected_outfit], FALSE)

/obj/machinery/button/valhalla/xeno_button/attack_hand(mob/living/user)
	var/list/job_outfits = list()
	for(var/type in subtypesof(/datum/outfit/job))
		if(istype(type, /datum/outfit))
			continue
		var/datum/outfit/out = type
		job_outfits[initial(out.name)] = out

	job_outfits = sortList(job_outfits)
	job_outfits.Insert(1, "Naked")

	var/datum/outfit/selected_outfit = tgui_input_list(usr, "Which outfit do you want the human to wear?", "Human spawn", job_outfits)
	if(!selected_outfit)
		return

	QDEL_NULL(linked)
	turf_check(user)
	linked = new /mob/living/carbon/human(get_turf(GLOB.valhalla_button_spawn_landmark[spawn_link]))
	if(selected_outfit == "Naked" || !selected_outfit)
		return
	linked.equipOutfit(job_outfits[selected_outfit], FALSE)

/obj/machinery/button/valhalla/vehicle_button
	name = "Vehicle Spawner"

/// Generates a list of vehicles to spawn
/obj/machinery/button/valhalla/vehicle_button/proc/spawn_vehicles(mob/living/user)
	var/list/spawnable_vehicles = list(
		/obj/vehicle/sealed/armored/multitile,
		/obj/vehicle/sealed/armored/multitile/apc,
		/obj/vehicle/sealed/armored/multitile/som_tank,
		/obj/vehicle/sealed/armored/multitile/campaign,
		/obj/vehicle/sealed/armored/multitile/icc_lvrt,
	)

	var/selected_vehicle = tgui_input_list(user, "Which vehicle do you want to spawn?", "Vehicle spawn", spawnable_vehicles)
	if(!selected_vehicle)
		return
	QDEL_NULL(linked)
	if(!get_turf(GLOB.valhalla_button_spawn_landmark[spawn_link]))
		to_chat(user, span_warning("An error occured, yell at the coders."))
		CRASH("Valhalla button linked with an improper landmark: button ID: [spawn_link].")
	linked = new selected_vehicle(get_turf(GLOB.valhalla_button_spawn_landmark[spawn_link]))

/obj/machinery/button/valhalla/vehicle_button/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, armor_type = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	spawn_vehicles(xeno_attacker)

/obj/machinery/button/valhalla/vehicle_button/attack_hand(mob/living/user)
	spawn_vehicles(user)

#undef DOOR_FLAG_OPEN_ONLY
