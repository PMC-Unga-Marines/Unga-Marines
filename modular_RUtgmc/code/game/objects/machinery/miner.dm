/obj/machinery/miner
	var/obj/machinery/camera/miner/camera

/obj/machinery/miner/Initialize(mapload)
	. = ..()
	camera = new /obj/machinery/camera/miner(src)

/obj/machinery/miner/proc/set_miner_status()
	var/health_percent = round((miner_integrity / max_miner_integrity) * 100)
	switch(health_percent)
		if(-INFINITY to 0)
			miner_status = MINER_DESTROYED
			stored_mineral = 0
			camera.toggle_cam(null, FALSE)
		if(1 to 50)
			stored_mineral = 0
			miner_status = MINER_MEDIUM_DAMAGE
		if(51 to 99)
			stored_mineral = 0
			miner_status = MINER_SMALL_DAMAGE
		if(100 to INFINITY)
			start_processing()
			SSminimaps.remove_marker(src)
			var/marker_icon = "miner_[mineral_value >= PLATINUM_CRATE_SELL_AMOUNT ? "platinum" : "phoron"]_on"
			SSminimaps.add_marker(src, MINIMAP_FLAG_ALL, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, marker_icon))
			miner_status = MINER_RUNNING
			if(!camera.status)
				camera.toggle_cam(null, FALSE)
	update_icon()

/obj/machinery/miner/Destroy()
	qdel(camera)
	camera = null
	return ..()

/obj/machinery/miner/attack_ai(mob/user)
	return attack_hand(user)
