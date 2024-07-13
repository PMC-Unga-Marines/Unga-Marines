///Handles the actual explosion effects
/obj/item/explosive/plastique/detonate()
	if(QDELETED(plant_target))
		playsound(plant_target, 'sound/weapons/ring.ogg', 100, FALSE, 25)
		explosion(plant_target, flash_range = 1) //todo: place as abuse of explosion
		qdel(src)
		return
	cell_explosion(plant_target, 95, 45, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL)
	playsound(plant_target, sound(get_sfx("explosion_small")), 100, FALSE, 25)
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	smoke.set_up(smokeradius, plant_target, 2)
	smoke.start()
	plant_target.plastique_act()
	qdel(src)
