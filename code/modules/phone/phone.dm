GLOBAL_LIST_EMPTY_TYPED(transmitters, /obj/structure/transmitter)

/obj/structure/transmitter
	name = "telephone receiver"
	icon = 'icons/obj/structures/structures.dmi'
	icon_state = "wall_phone"
	desc = "It is a wall mounted telephone. The fine text reads: To log your details with the mainframe please insert your keycard into the slot below. Unfortunately the slot is jammed. You can still use the phone, however."

	var/phone_category = "Uncategorised"
	var/phone_color = "white"
	var/phone_id = "Telephone"
	var/phone_icon

	var/obj/item/phone/attached_to

	var/obj/structure/transmitter/calling
	var/obj/structure/transmitter/caller

	var/next_ring = 0

	var/phone_type = /obj/item/phone

	var/range = 3

	var/enabled = TRUE
	/// Whether or not the phone is receiving calls or not. Varies between on/off or forcibly on/off.
	var/do_not_disturb = PHONE_DND_OFF
	/// The Phone_ID of the last person to call this telephone.
	var/last_caller

	var/timeout_timer_id
	var/timeout_duration = 30 SECONDS

	var/list/networks_receive = list(FACTION_TERRAGOV)
	var/list/networks_transmit = list(FACTION_TERRAGOV)

	var/datum/looping_sound/telephone/busy/busy_loop
	var/datum/looping_sound/telephone/hangup/hangup_loop
	var/datum/looping_sound/telephone/ring/outring_loop

/obj/structure/transmitter/hidden
	do_not_disturb = PHONE_DND_FORCED

/obj/structure/transmitter/Initialize(mapload, ...)
	. = ..()
	base_icon_state = icon_state

	attached_to = new phone_type(src)
	update_icon()

	if(!get_turf(src))
		return

	outring_loop = new(attached_to)
	busy_loop = new(attached_to)
	hangup_loop = new(attached_to)

	GLOB.transmitters += src

/obj/structure/transmitter/update_icon()
	. = ..()
	SEND_SIGNAL(src, COMSIG_TRANSMITTER_UPDATE_ICON)
	if(attached_to.loc != src)
		icon_state = "[base_icon_state]_ear"
		return

	if(caller)
		icon_state = "[base_icon_state]_ring"
	else
		icon_state = base_icon_state

#define TRANSMITTER_UNAVAILABLE(T) (\
	T.get_calling_phone() \
	|| !T.attached_to \
	|| T.attached_to.loc != T \
	|| !T.enabled\
)

/obj/structure/transmitter/proc/get_transmitters()
	var/list/phone_list = list()

	for(var/possible_phone in GLOB.transmitters)
		var/obj/structure/transmitter/target_phone = possible_phone
		var/current_dnd = FALSE
		switch(target_phone.do_not_disturb)
			if(PHONE_DND_ON, PHONE_DND_FORCED)
				current_dnd = TRUE
		if(TRANSMITTER_UNAVAILABLE(target_phone) || current_dnd) // Phone not available
			continue
		var/net_link = FALSE
		for(var/network in networks_transmit)
			if(network in target_phone.networks_receive)
				net_link = TRUE
				continue
		if(!net_link)
			continue

		var/id = target_phone.phone_id
		var/num_id = 1
		while(id in phone_list)
			id = "[target_phone.phone_id] [num_id]"
			num_id++

		target_phone.phone_id = id
		phone_list[id] = target_phone

	return phone_list

/obj/structure/transmitter/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	if(TRANSMITTER_UNAVAILABLE(src))
		return UI_CLOSE

/obj/structure/transmitter/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(TRANSMITTER_UNAVAILABLE(src))
		return

	if(!ishuman(usr))
		return

	var/mob/living/carbon/human/user = usr

	switch(action)
		if("call_phone")
			call_phone(user, params["phone_id"])
			. = TRUE
			SStgui.close_uis(src)
		if("toggle_dnd")
			toggle_dnd(user)

	update_icon()

/obj/structure/transmitter/ui_data(mob/user)
	var/list/data = list()

	data["availability"] = do_not_disturb
	data["last_caller"] = last_caller

	return data

/obj/structure/transmitter/ui_static_data(mob/user)
	. = list()

	.["available_transmitters"] = get_transmitters() - list(phone_id)
	var/list/transmitters = list()
	for(var/i in GLOB.transmitters)
		var/obj/structure/transmitter/transmitter = i
		transmitters += list(list(
			"phone_category" = transmitter.phone_category,
			"phone_color" = transmitter.phone_color,
			"phone_id" = transmitter.phone_id,
			"phone_icon" = transmitter.phone_icon
		))

	.["transmitters"] = transmitters

/obj/structure/transmitter/proc/call_phone(mob/living/carbon/human/user, calling_phone_id)
	var/list/transmitters = get_transmitters()
	transmitters -= phone_id

	if(!length(transmitters) || !(calling_phone_id in transmitters))
		to_chat(user, span_red("[icon2html(src, user)] No transmitters could be located to call!"))
		return

	var/obj/structure/transmitter/transmitter = transmitters[calling_phone_id]
	if(!istype(transmitter) || QDELETED(transmitter))
		transmitters -= transmitter
		CRASH("Qdelled/improper atom inside transmitters list! (istype returned: [istype(transmitter)], QDELETED returned: [QDELETED(transmitter)])")

	if(TRANSMITTER_UNAVAILABLE(transmitter))
		return

	calling = transmitter
	transmitter.caller = src
	transmitter.last_caller = src.phone_id
	transmitter.update_icon()

	to_chat(user, span_red("[icon2html(src, user)] Dialing [calling_phone_id].."))
	playsound(get_turf(user), "rtb_handset")
	timeout_timer_id = addtimer(CALLBACK(src, PROC_REF(reset_call), TRUE), timeout_duration, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)
	outring_loop.start()

	START_PROCESSING(SSobj, src)
	START_PROCESSING(SSobj, transmitter)

	user.put_in_hands(attached_to)

/obj/structure/transmitter/proc/toggle_dnd(mob/living/carbon/human/user)
	switch(do_not_disturb)
		if(PHONE_DND_ON)
			do_not_disturb = PHONE_DND_OFF
			to_chat(user, span_notice("Do Not Disturb has been disabled. You can now receive calls."))
		if(PHONE_DND_OFF)
			do_not_disturb = PHONE_DND_ON
			to_chat(user, span_warning("Do Not Disturb has been enabled. No calls will be received."))
		else
			return FALSE
	return TRUE

/obj/structure/transmitter/attack_hand(mob/user)
	. = ..()

	if(!attached_to || attached_to.loc != src)
		return

	if(!ishuman(user))
		return

	if(!enabled)
		return

	if(!get_calling_phone())
		ui_interact(user)
		return

	var/obj/structure/transmitter/transmitter = get_calling_phone()

	if(transmitter.attached_to && ismob(transmitter.attached_to.loc))
		var/mob/M = transmitter.attached_to.loc
		to_chat(M, span_red("[icon2html(src, M)] [phone_id] has picked up."))
		playsound(transmitter.attached_to.loc, 'sound/machines/telephone/remote_pickup.ogg', 20)
		if(transmitter.timeout_timer_id)
			deltimer(transmitter.timeout_timer_id)
			transmitter.timeout_timer_id = null

	to_chat(user, span_red("[icon2html(src, user)] Picked up a call from [transmitter.phone_id]."))
	playsound(get_turf(user), "rtb_handset")

	transmitter.outring_loop.stop()
	user.put_in_active_hand(attached_to)
	update_icon()


#undef TRANSMITTER_UNAVAILABLE

/obj/structure/transmitter/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PhoneMenu", phone_id)
		ui.open()

/obj/structure/transmitter/proc/reset_call(timeout = FALSE)
	var/obj/structure/transmitter/transmitter = get_calling_phone()
	if(transmitter)
		if(transmitter.attached_to && ismob(transmitter.attached_to.loc))
			var/mob/M = transmitter.attached_to.loc
			to_chat(M, span_red("[icon2html(src, M)] [phone_id] has hung up on you."))
			transmitter.hangup_loop.start()

		if(attached_to && ismob(attached_to.loc))
			var/mob/M = attached_to.loc
			if(timeout)
				to_chat(M, span_red("[icon2html(src, M)] Your call to [transmitter.phone_id] has reached voicemail, nobody picked up the phone."))
				busy_loop.start()
				outring_loop.stop()
			else
				to_chat(M, span_red("[icon2html(src, M)] You have hung up on [transmitter.phone_id]."))

	if(calling)
		calling.caller = null
		calling = null

	if(caller)
		caller.calling = null
		caller = null

	if(timeout_timer_id)
		deltimer(timeout_timer_id)
		timeout_timer_id = null

	if(transmitter)
		if(transmitter.timeout_timer_id)
			deltimer(transmitter.timeout_timer_id)
			transmitter.timeout_timer_id = null

		transmitter.update_icon()
		STOP_PROCESSING(SSobj, transmitter)

	outring_loop.stop()

	STOP_PROCESSING(SSobj, src)

/obj/structure/transmitter/process()
	if(caller)
		if(!attached_to)
			STOP_PROCESSING(SSobj, src)
			return

		if(attached_to.loc == src)
			if(next_ring < world.time)
				playsound(loc, 'sound/machines/telephone/telephone_ring.ogg', 75)
				visible_message(span_warning("[src] rings vigorously!"))
				next_ring = world.time + 3 SECONDS

	else if(calling)
		var/obj/structure/transmitter/transmitter = get_calling_phone()
		if(!transmitter)
			STOP_PROCESSING(SSobj, src)
			return

		var/obj/item/phone/P = transmitter.attached_to

		if(P && attached_to.loc == src && P.loc == transmitter && next_ring < world.time)
			playsound(get_turf(attached_to), 'sound/machines/telephone/telephone_ring.ogg', 20, FALSE, 14)
			visible_message(span_warning("[src] rings vigorously!"))
			next_ring = world.time + 3 SECONDS

	else
		STOP_PROCESSING(SSobj, src)
		return


/obj/structure/transmitter/proc/recall_phone()
	if(ismob(attached_to.loc))
		var/mob/M = attached_to.loc
		M.drop_held_item(attached_to)
		playsound(get_turf(M), "rtb_handset", 100, FALSE, 7)
		hangup_loop.stop()

	attached_to.forceMove(src)
	reset_call()
	busy_loop.stop()
	outring_loop.stop()

	update_icon()

/obj/structure/transmitter/proc/get_calling_phone()
	if(calling)
		return calling
	else if(caller)
		return caller

	return

/obj/structure/transmitter/proc/handle_speak(mob/living/carbon/speaking, list/speech_args)
	var/obj/structure/transmitter/transmitter = get_calling_phone()
	if(!istype(transmitter))
		return

	var/obj/item/phone/P = transmitter.attached_to

	if(!P || !attached_to)
		return

	P.handle_hear(speaking, speech_args)
	attached_to.handle_hear(speaking, speech_args)

	playsound(P, "talk_phone", 5)
	log_say("TELEPHONE: [key_name(speaking)] on Phone '[phone_id]' to '[transmitter.phone_id]' said '[speech_args[SPEECH_MESSAGE]]'")

/obj/structure/transmitter/attackby(obj/item/W, mob/user)
	if(W == attached_to)
		recall_phone()
	else
		. = ..()

/obj/structure/transmitter/Destroy()
	if(attached_to)
		if(attached_to.loc == src)
			UnregisterSignal(attached_to, COMSIG_PREQDELETED)
			qdel(attached_to)
		else
			attached_to.attached_to = null
		attached_to = null

	GLOB.transmitters -= src
	SStgui.close_uis(src)

	reset_call()
	return ..()

/obj/item/phone
	name = "red phone"
	desc = "Should anything ever go wrong..."
	icon_state = "rpb_phone"

	force = 3
	throwforce = 2
	throw_speed = 1
	throw_range = 4

	w_class = WEIGHT_CLASS_SMALL

	attack_verb = list("called", "rang")
	hitsound = 'sound/weapons/ring.ogg'

	var/obj/structure/transmitter/attached_to

	var/raised = FALSE
	var/zlevel_transfer = FALSE
	var/zlevel_transfer_timer = TIMER_ID_NULL
	var/zlevel_transfer_timeout = 5 SECONDS

/obj/item/phone/Initialize(mapload)
	. = ..()
	if(istype(loc, /obj/structure/transmitter))
		attach_to(loc)

/obj/item/phone/Destroy()
	remove_attached()
	return ..()

/obj/item/phone/proc/handle_speak(mob/living/carbon/speaking, list/speech_args)
	SIGNAL_HANDLER

	if(!attached_to || loc == attached_to)
		UnregisterSignal(speaking, COMSIG_MOB_SAY)
		return

	attached_to.handle_speak(speaking, speech_args)

/obj/item/phone/proc/handle_hear(mob/living/carbon/speaking, list/speech_args)
	if(!attached_to)
		return

	var/obj/structure/transmitter/transmitter = attached_to.get_calling_phone()

	if(!transmitter)
		return

	if(!ismob(loc))
		return

	var/mob/M = loc

	var/rendered = compose_message(speaking, speech_args[SPEECH_LANGUAGE], speech_args[SPEECH_MESSAGE], FREQ_PHONE, raised ? list(SPAN_COMMAND) : null)
	to_chat(M, rendered)

/obj/item/phone/proc/attach_to(obj/structure/transmitter/to_attach)
	if(!istype(to_attach))
		return
	remove_attached()
	attached_to = to_attach

/obj/item/phone/proc/remove_attached()
	attached_to = null

/obj/item/phone/attack_hand(mob/user)
	if(attached_to && get_dist(user, attached_to) > attached_to.range)
		return FALSE
	return ..()

/obj/item/phone/attack_self(mob/user)
	..()
	if(raised)
		set_raised(FALSE, user)
		to_chat(user, span_notice("You lower [src]."))
	else
		set_raised(TRUE, user)
		to_chat(user, span_notice("You raise [src] to your ear."))


/obj/item/phone/proc/set_raised(to_raise, mob/living/carbon/human/H)
	if(!istype(H))
		return

	if(!to_raise)
		raised = FALSE
		item_state = "rpb_phone"

		var/obj/item/radio/R = istype(H.wear_ear, /obj/item/radio) ? H.wear_ear : null
		R?.on = TRUE
	else
		raised = TRUE
		item_state = "rpb_phone_ear"

		var/obj/item/radio/R = istype(H.wear_ear, /obj/item/radio) ? H.wear_ear : null
		R?.on = FALSE

	H.update_inv_r_hand()
	H.update_inv_l_hand()

/obj/item/phone/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_SAY)

	set_raised(FALSE, user)

	if(attached_to)
		attached_to.recall_phone()

/obj/item/phone/on_enter_storage(obj/item/storage/S)
	. = ..()
	if(attached_to)
		attached_to.recall_phone()

/obj/item/phone/pickup(mob/user)
	. = ..()
	RegisterSignal(user, COMSIG_MOB_SAY, PROC_REF(handle_speak))

/obj/item/phone/equipped(mob/user, slot)
	. = ..()
	RegisterSignal(user, COMSIG_MOB_SAY, PROC_REF(handle_speak))

/obj/item/phone/proc/do_zlevel_check()
	if(!attached_to || !loc.z || !attached_to.z)
		return FALSE

	if(zlevel_transfer)
		if(loc.z == attached_to.z)
			zlevel_transfer = FALSE
			if(zlevel_transfer_timer)
				deltimer(zlevel_transfer_timer)
			UnregisterSignal(attached_to, COMSIG_MOVABLE_MOVED)
			return FALSE
		return TRUE

	if(attached_to && loc.z != attached_to.z)
		zlevel_transfer = TRUE
		RegisterSignal(attached_to, COMSIG_MOVABLE_MOVED, PROC_REF(transmitter_move_handler))
		return TRUE
	return FALSE

/obj/item/phone/proc/transmitter_move_handler(datum/source)
	SIGNAL_HANDLER
	zlevel_transfer = FALSE
	if(zlevel_transfer_timer)
		deltimer(zlevel_transfer_timer)
	UnregisterSignal(attached_to, COMSIG_MOVABLE_MOVED)
