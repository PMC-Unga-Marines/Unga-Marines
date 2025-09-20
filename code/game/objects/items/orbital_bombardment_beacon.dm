/obj/item/orbital_bombardment_beacon
	name = "orbital beacon"
	desc = "A bulky device that fires a beam up to an orbiting vessel to send local coordinates."
	icon = 'icons/obj/items/beacon.dmi'
	icon_state = "motion4"
	w_class = WEIGHT_CLASS_SMALL
	/// If this beacon is activated
	var/activated = FALSE
	/// How long to activate this beacon
	var/activation_time = 8 SECONDS
	/// The icon when acticated
	var/icon_activated = "motion1"
	/// The camera attached to the beacon
	var/obj/machinery/camera/beacon_cam = null
	///The squad this OB beacon belongs to
	var/datum/squad/squad = null

/obj/item/orbital_bombardment_beacon/update_icon_state()
	. = ..()
	icon_state = activated ? icon_activated : initial(icon_state)

/obj/item/orbital_bombardment_beacon/attack_self(mob/living/carbon/human/H)
	if(!istype(H))
		return
	activate(H)

/obj/item/orbital_bombardment_beacon/attack_hand(mob/living/carbon/human/H)
	if(!ishuman(H))
		return ..()
	if(activated)
		deactivate(H)
		return
	return ..()

/// Set this beacon on the ground and activate it
/obj/item/orbital_bombardment_beacon/proc/activate(mob/living/carbon/human/H)
	if(!is_ground_level(H.z))
		to_chat(H, span_warning("You have to be on the planet to use this or it won't transmit."))
		return FALSE
	var/area/A = get_area(H)
	if(A && istype(A) && A.ceiling >= CEILING_DEEP_UNDERGROUND)
		to_chat(H, span_warning("This won't work if you're standing deep underground."))
		return FALSE
	if(istype(A, /area/shuttle/dropship))
		to_chat(H, span_warning("You have to be outside the dropship to use this or it won't transmit."))
		return FALSE
	var/delay = max(1.5 SECONDS, activation_time - 2 SECONDS * H.skills.getRating(SKILL_LEADERSHIP))
	H.visible_message(span_notice("[H] starts setting up [src] on the ground."),
	span_notice("You start setting up [src] on the ground and inputting all the data it needs."))
	if(!do_after(H, delay, NONE, src, BUSY_ICON_GENERIC))
		return FALSE
	beacon_cam = new(src, "[H.get_paygrade()] [H.name] [src]")
	H.transferItemToLoc(src, H.loc)
	message_admins("[ADMIN_TPMONTY(usr)] set up a supply beacon.")
	name = "transmitting orbital beacon - [get_area(src)] - [H]"
	activated = TRUE
	anchored = TRUE
	w_class = WEIGHT_CLASS_GIGANTIC
	layer = ABOVE_OBJ_LAYER
	set_light(2, 1)
	playsound(src, 'sound/machines/twobeep.ogg', 15, 1)
	H.visible_message(span_warning("[H] activates [src]."), span_warning("You activate [src]."))
	message_admins("[ADMIN_TPMONTY(usr)] set up an orbital strike beacon.")

	var/marker_flags = GLOB.faction_to_minimap_flag[H.faction]
	if(!marker_flags)
		marker_flags = MINIMAP_FLAG_MARINE
	SSminimaps.add_marker(src, marker_flags, image('icons/UI_icons/map_blips.dmi', null, "ob_beacon", MINIMAP_BLIPS_LAYER))
	update_icon()
	if(H.assigned_squad)
		squad = H.assigned_squad
		name += " ([squad.name])"
		squad.squad_orbital_beacons += src
	name += " ([H])"
	GLOB.active_orbital_beacons += src
	return TRUE

/// Deactivate this beacon and put it in the hand of the human
/obj/item/orbital_bombardment_beacon/proc/deactivate(mob/living/carbon/human/H)
	var/delay = max(1 SECONDS, activation_time * 0.5 - 2 SECONDS * H.skills.getRating(SKILL_LEADERSHIP)) //Half as long as setting it up.
	H.visible_message(span_notice("[H] starts removing [src] from the ground."), span_notice("You start removing [src] from the ground, deactivating it."))
	if(!do_after(H, delay, NONE, src, BUSY_ICON_GENERIC))
		return FALSE
	QDEL_NULL(beacon_cam)
	activated = FALSE
	anchored = FALSE
	w_class = initial(w_class)
	layer = initial(layer)
	name = initial(name)
	set_light(0)
	playsound(src, 'sound/machines/twobeep.ogg', 15, 1)
	H.visible_message(span_warning("[H] deactivates [src]."), span_warning("You deactivate [src]."))
	H.put_in_active_hand(src)
	SSminimaps.remove_marker(src)
	update_icon()
	squad?.squad_orbital_beacons -= src
	squad = null
	GLOB.active_orbital_beacons -= src
	return TRUE

/obj/item/orbital_bombardment_beacon/Destroy()
	if(beacon_cam)
		qdel(beacon_cam)
		beacon_cam = null
	squad?.squad_orbital_beacons -= src
	squad = null
	GLOB.active_orbital_beacons -= src
	return ..()
