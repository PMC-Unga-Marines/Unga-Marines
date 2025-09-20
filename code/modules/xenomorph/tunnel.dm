/obj/structure/xeno/tunnel
	name = "tunnel"
	desc = "A tunnel entrance. Looks like it was dug by some kind of clawed beast."
	icon = 'icons/Xeno/Effects.dmi'
	icon_state = "hole"

	density = FALSE
	opacity = FALSE
	anchored = TRUE
	resistance_flags = UNACIDABLE
	layer = BELOW_TABLE_LAYER

	max_integrity = 140

	xeno_structure_flags = IGNORE_WEED_REMOVAL
	///Description added by the hivelord.
	var/tunnel_desc = ""
	///What hivelord created that tunnel. Can be null
	var/mob/living/carbon/xenomorph/hivelord/creator = null

/obj/structure/xeno/tunnel/Initialize(mapload, _hivenumber)
	. = ..()
	LAZYADDASSOC(GLOB.xeno_tunnels_by_hive, hivenumber, src)
	SSminimaps.add_marker(src, MINIMAP_FLAG_XENO, image('icons/UI_icons/map_blips.dmi', null, "xenotunnel", MINIMAP_BLIPS_LAYER))

/obj/structure/xeno/tunnel/Destroy()
	var/turf/drop_loc = get_turf(src)
	for(var/atom/movable/thing AS in contents) //Empty the tunnel of contents
		thing.forceMove(drop_loc)

	if(!QDELETED(creator))
		to_chat(creator, span_xenoannounce("You sense your [name] at [tunnel_desc] has been destroyed!") ) //Alert creator

	xeno_message("Hive tunnel [name] at [tunnel_desc] has been destroyed!", "xenoannounce", 5, hivenumber) //Also alert hive because tunnels matter.

	LAZYREMOVE(GLOB.xeno_tunnels_by_hive[hivenumber], src)
	if(creator)
		creator.tunnels -= src
	creator = null

	SSminimaps.remove_marker(src)

	return ..()

///Signal handler for creator destruction to clear reference
/obj/structure/xeno/tunnel/proc/clear_creator()
	SIGNAL_HANDLER
	creator = null

/obj/structure/xeno/tunnel/examine(mob/user)
	. = ..()
	if(!isxeno(user) && !isobserver(user))
		return
	if(isxeno(user))
		. += span_info("Use right click to enter or exit the xenoden.")
	if(tunnel_desc)
		. += span_info("The Hivelord scent reads: \'[tunnel_desc]\'")

/obj/structure/xeno/tunnel/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	visible_message(span_danger("[src] suddenly collapses!") )
	return ..()

/obj/structure/xeno/tunnel/attackby(obj/item/I, mob/user, params)
	if(!isxeno(user))
		return ..()
	attack_alien(user)

/obj/structure/xeno/tunnel/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(!istype(xeno_attacker) || xeno_attacker.stat || xeno_attacker.lying_angle || xeno_attacker.status_flags & INCORPOREAL)
		return

	if(xeno_attacker.a_intent == INTENT_HARM && xeno_attacker == creator)
		balloon_alert(xeno_attacker, "Filling in tunnel...")
		if(do_after(xeno_attacker, HIVELORD_TUNNEL_DISMANTLE_TIME, IGNORE_HELD_ITEM, src, BUSY_ICON_BUILD))
			deconstruct(FALSE)
		return

	if(xeno_attacker.anchored)
		balloon_alert(xeno_attacker, "Cannot enter while immobile")
		return FALSE

	if(length(GLOB.xeno_tunnels_by_hive[hivenumber]) < 2)
		balloon_alert(xeno_attacker, "No exit tunnel")
		return FALSE

	if(isrightclick && SSticker.mode?.round_type_flags & MODE_XENO_DEN && (z == 6 || z == 2))
		pick_a_tunnel(xeno_attacker, z == 6 ? 2 : 6) //hardcoded
		return

	pick_a_tunnel(xeno_attacker)

/obj/structure/xeno/tunnel/attack_larva(mob/living/carbon/xenomorph/larva/L) //So larvas can actually use tunnels
	attack_alien(L)

/obj/structure/xeno/tunnel/attack_ghost(mob/dead/observer/user)
	. = ..()

	var/list/obj/destinations = GLOB.xeno_tunnels_by_hive[hivenumber]
	var/obj/structure/xeno/tunnel/targettunnel
	if(LAZYLEN(destinations) > 2)
		var/list/tunnel_assoc = list()
		for(var/obj/D in destinations)
			tunnel_assoc["X:[D.x], Y:[D.y] - \[[get_area(D)]\]"] = D
		destinations = list()
		for(var/d in tunnel_assoc)
			destinations += d
		var/input = tgui_input_list(user ,"Choose a tunnel to teleport to:" ,"Ghost Tunnel teleport" ,destinations ,null, 0)
		if(!input)
			return
		targettunnel = tunnel_assoc[input]
		if(!input)
			return
	else
		//There are only 2 tunnels. Pick the other one.
		for(var/P in destinations)
			if(P != src)
				targettunnel = P
	if(!targettunnel || QDELETED(targettunnel) || !targettunnel.loc)
		return
	user.forceMove(get_turf(targettunnel))

///Here we pick a tunnel to go to, then travel to that tunnel and peep out, confirming whether or not we want to emerge or go to another tunnel.
/obj/structure/xeno/tunnel/proc/pick_a_tunnel(mob/living/carbon/xenomorph/M, z_level = z)
	to_chat(M, span_notice("Select a tunnel to go to."))

	var/atom/movable/screen/minimap/map = SSminimaps.fetch_minimap_object(z_level, MINIMAP_FLAG_XENO)
	M.client.screen += map
	var/list/polled_coords = map.get_coords_from_click(M)
	M?.client?.screen -= map
	if(!polled_coords)
		return
	var/turf/clicked_turf = locate(polled_coords[1], polled_coords[2], z_level)

	///We find the tunnel, looking within 10 tiles of where the user clicked, excluding src
	var/obj/structure/xeno/tunnel/targettunnel = cheap_get_atom(clicked_turf, /obj/structure/xeno/tunnel, 10, GLOB.xeno_tunnels_by_hive[hivenumber] - src)
	if(QDELETED(src)) //Make sure we still exist in the event the player keeps the interface open
		return
	if(!M.Adjacent(src) && M.loc != src) //Make sure we're close enough to our tunnel; either adjacent to or in one
		return
	if(QDELETED(targettunnel)) //Make sure our target destination still exists in the event the player keeps the interface open
		if(M.loc == src) //If we're in the tunnel and cancelling out, spit us out.
			M.forceMove(loc)
		return
	if(targettunnel == src)
		balloon_alert(M, "We're already here")
		if(M.loc == src) //If we're in the tunnel and cancelling out, spit us out.
			M.forceMove(loc)
		return
	var/distance = get_dist(get_turf(src), get_turf(targettunnel))
	var/tunnel_time = clamp(distance, HIVELORD_TUNNEL_MIN_TRAVEL_TIME, HIVELORD_TUNNEL_SMALL_MAX_TRAVEL_TIME)

	if(M.mob_size == MOB_SIZE_BIG) //Big xenos take longer
		tunnel_time = clamp(distance * 1.5, HIVELORD_TUNNEL_MIN_TRAVEL_TIME, HIVELORD_TUNNEL_LARGE_MAX_TRAVEL_TIME)
		M.visible_message(span_xenonotice("[M] begins heaving their huge bulk down into \the [src].") , \
		span_xenonotice("We begin heaving our monstrous bulk into \the [src] to <b>[targettunnel.tunnel_desc]</b>.") )
	else
		M.visible_message(span_xenonotice("\The [M] begins crawling down into \the [src].") , \
		span_xenonotice("We begin crawling down into \the [src] to <b>[targettunnel.tunnel_desc]</b>.") )

	if(isxenolarva(M)) //Larva can zip through near-instantly, they are wormlike after all
		tunnel_time = 5

	if(!do_after(M, tunnel_time, IGNORE_HELD_ITEM, src, BUSY_ICON_GENERIC))
		balloon_alert(M, "Crawling interrupted")
		return
	if(!targettunnel || !isturf(targettunnel.loc)) //Make sure the end tunnel is still there
		balloon_alert(M, "Tunnel ended unexpectedly")
		return
	M.forceMove(targettunnel)
	var/double_check = tgui_alert(M, "Emerge here?", "Tunnel: [targettunnel]", list("Yes","Pick another tunnel"), 0)
	if(M.loc != targettunnel) //double check that we're still in the tunnel in the event it gets destroyed while we still have the interface open
		return
	if(double_check == "Pick another tunnel")
		return targettunnel.pick_a_tunnel(M)
	M.forceMove(targettunnel.loc)
	M.visible_message(span_xenonotice("\The [M] pops out of \the [src].") , \
	span_xenonotice("We pop out through the other side!") )

/obj/structure/xeno/tunnel/attack_facehugger(mob/living/carbon/xenomorph/facehugger/F, isrightclick = FALSE)
	attack_alien(F)
