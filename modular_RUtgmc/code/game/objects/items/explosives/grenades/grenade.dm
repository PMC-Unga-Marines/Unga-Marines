/obj/item/explosive/grenade
	/// Power of the explosion
	var/power = 105
	/// Falloff of our explosion, aka distance, by the formula of power / falloff
	var/falloff = 30

/obj/item/explosive/grenade/prime()
	cell_explosion(loc, power = src.power, falloff = src.falloff)
	qdel(src)

///Adjusts det time, used for grenade launchers
/obj/item/explosive/grenade/launched_det_time()
	det_time = min(12, det_time)
