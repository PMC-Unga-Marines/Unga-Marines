/obj/item/explosive/mine
	var/tripwire_triggered = FALSE

/obj/item/explosive/mine/trigger_explosion()
	if(triggered)
		return
	triggered = TRUE
	create_shrapnel(tripwire_triggered ? tripwire.loc : loc, 8, dir, shrapnel_type = /datum/ammo/bullet/shrapnel/metal, on_hit_coefficient = 45)
	cell_explosion(tripwire_triggered ? tripwire.loc : loc, 50, 20)
	QDEL_NULL(tripwire)
	qdel(src)

/// When crossed the tripwire triggers the linked mine
/obj/effect/mine_tripwire/proc/on_cross(datum/source, atom/movable/AM, oldloc, oldlocs)
	SIGNAL_HANDLER
	if(!istype(AM))
		return

	if(!linked_mine)
		qdel(src)
		return

	if(CHECK_MULTIPLE_BITFIELDS(AM.pass_flags, HOVERING))
		return

	if(linked_mine.triggered) //Mine is already set to go off
		return

	if(!isliving(AM) && !(isvehicle(AM)))
		return
	linked_mine.tripwire_triggered = TRUE
	linked_mine.trip_mine(AM)
