/obj/structure/morgue
	name = "morgue"
	desc = "Used to keep bodies in untill someone fetches them."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "morgue1"
	dir = EAST
	density = TRUE
	anchored = TRUE
	coverage = 20
	max_integrity = 250
	var/obj/structure/morgue_tray/connected = null
	var/morgue_type = "morgue"
	var/tray_path = /obj/structure/morgue_tray
	var/morgue_open = 0

/obj/structure/morgue/Initialize(mapload)
	. = ..()
	connected = new tray_path(src)

/obj/structure/morgue/Destroy()
	QDEL_NULL(connected)
	return ..()

/obj/structure/morgue/update_icon_state()
	. = ..()
	if (morgue_open)
		icon_state = "[morgue_type]0"
	else
		if (length(contents) > 1) //not counting the morgue tray
			icon_state = "[morgue_type]2"
		else
			icon_state = "[morgue_type]1"

/obj/structure/morgue/ex_act(severity)
	if(prob(severity * 0.25))
		for(var/atom/movable/A in src)
			A.forceMove(loc)
			ex_act(severity)
		qdel(src)

/obj/structure/morgue/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	toggle_morgue(user)

/atom/movable/proc/can_be_morgue_trayed()
	return TRUE

/mob/living/can_be_morgue_trayed()
	return stat == DEAD

/obj/structure/closet/bodybag/can_be_morgue_trayed()
	. = ..()
	for(var/atom/movable/AM in contents)
		if(!AM.can_be_morgue_trayed())
			return FALSE

/obj/structure/morgue/proc/toggle_morgue(mob/user)
	if(!connected) return
	if(morgue_open)
		for(var/atom/movable/A in connected.loc)
			if(!A.anchored && A.can_be_morgue_trayed())
				A.forceMove(src)
		connected.loc = src
	else
		if(step(connected, dir))
			connected.setDir(dir)
			for(var/atom/movable/A in src)
				A.forceMove(connected.loc)
		else
			connected.loc = src
			return
	morgue_open = !morgue_open
	playsound(loc, 'sound/items/deconstruct.ogg', 25, 1)
	update_icon()

/obj/structure/morgue/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/tool/pen))
		var/t = copytext(stripped_input(user, "What would you like the label to be?", name, null), 1, MAX_MESSAGE_LEN)
		if(!t)
			return

		if(user.get_active_held_item() != I)
			return

		if((!in_range(src, user) && loc != user))
			return

		name = "[initial(name)] - '[t]'"

/obj/structure/morgue/relaymove(mob/user)
	if(user.incapacitated(TRUE))
		return
	toggle_morgue(user)

/obj/structure/morgue_tray
	name = "morgue tray"
	desc = "Apply corpse before closing."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "morguet"
	density = TRUE
	layer = OBJ_LAYER
	anchored = TRUE
	var/obj/structure/morgue/linked_morgue = null

/obj/structure/morgue_tray/Initialize(mapload, obj/structure/morgue/morgue_source)
	. = ..()
	if(morgue_source)
		linked_morgue = morgue_source

/obj/structure/morgue_tray/Destroy()
	linked_morgue = null
	return ..()

/obj/structure/morgue_tray/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(linked_morgue)
		linked_morgue.toggle_morgue(user)

/obj/structure/morgue_tray/MouseDrop_T(atom/movable/O, mob/user)
	. = ..()
	if (!istype(O) || O.anchored || !isturf(O.loc))
		return
	if (!ismob(O) && !istype(O, /obj/structure/closet/bodybag))
		return
	if (!istype(user) || user.incapacitated())
		return
	O.forceMove(loc)
	if (user != O)
		visible_message(span_warning("[user] stuffs [O] into [src]!"), null, null, 3)

/*
* Crematorium
*/

/obj/structure/morgue/crematorium
	name = "crematorium"
	desc = "A human incinerator. Works well on barbeque nights."
	icon_state = "crema1"
	dir = SOUTH
	tray_path = /obj/structure/morgue_tray/crematorium
	morgue_type = "crema"
	var/cremating = 0
	var/id = 1

/obj/structure/morgue/crematorium/toggle_morgue(mob/user)
	if(cremating)
		to_chat(user, span_warning("It's locked."))
		return
	return ..()

/obj/structure/morgue/crematorium/relaymove(mob/user)
	if(cremating)
		return
	return ..()

/obj/structure/morgue/crematorium/update_icon()
	. = ..()
	if(cremating)
		icon_state = "[morgue_type]_active"

/obj/structure/morgue/crematorium/proc/cremate(mob/user)
	set waitfor = 0
	if(cremating)
		return

	if(length(contents) <= 1) //1 because the tray is inside.
		visible_message(span_warning(" You hear a hollow crackle."))
	else
		visible_message(span_warning(" You hear a roar as the crematorium activates."))

		cremating = 1

		update_icon()

		for(var/mob/living/M in contents)
			if (M.stat!=DEAD)
				if (!iscarbon(M))
					M.emote("scream")
				else
					var/mob/living/carbon/C = M
					if (!(C.species && (C.species.species_flags & NO_PAIN)))
						C.emote("scream")

			log_combat(user, M, "creamated", src)
			M.death(TRUE)

		for(var/obj/O in contents)
			if(istype(O, /obj/structure/morgue_tray)) continue
			qdel(O)

		new /obj/effect/decal/cleanable/ash(src)
		sleep(3 SECONDS)
		cremating = 0
		update_icon()
		playsound(src.loc, 'sound/machines/ding.ogg', 25, 1)

/*
* Crematorium tray
*/

/obj/structure/morgue_tray/crematorium
	name = "crematorium tray"
	desc = "Apply body before burning."
	icon_state = "cremat"

/*
* Crematorium switch
*/

/obj/machinery/crema_switch/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(allowed(user))
		for (var/obj/structure/morgue/crematorium/C in range(7,src))
			if (C.id == id)
				if(!C.cremating)
					C.cremate(user)
	else
		to_chat(user, span_warning("Access denied."))

/*
* Sarcophagus
*/

/obj/structure/morgue/sarcophagus
	name = "sarcophagus"
	desc = "Used to store mummies."
	icon_state = "sarcophagus1"
	morgue_type = "sarcophagus"
	tray_path = /obj/structure/morgue_tray/sarcophagus
/*
* Sarcophagus tray
*/

/obj/structure/morgue_tray/sarcophagus
	name = "sarcophagus tray"
	desc = "Apply corpse before closing."
	icon_state = "sarcomat"
