/obj/structure/ob_ammo/warhead/proc/impact_message(turf/target, impact_time = 10 SECONDS)
	var/relative_dir
	for(var/mob/living/our_mob in range(30, target))
		if(get_turf(our_mob) == target)
			relative_dir = 0
		else
			relative_dir = get_dir(our_mob, target)
		our_mob.show_message(span_highdanger("The sky erupts into flames <u>[relative_dir ? ("to the " + dir2text(relative_dir)) : "right above you"]</u>!"), EMOTE_VISIBLE,
			span_highdanger("You hear a very loud sound coming from above to the <u>[relative_dir ? ("to the " + dir2text(relative_dir)) : "right above you"]</u>!"), EMOTE_AUDIBLE)

	sleep(impact_time / 3)
	for(var/mob/living/our_mob in range(25, target))
		if(get_turf(our_mob) == target)
			relative_dir = 0
		else
			relative_dir = get_dir(our_mob, target)
		our_mob.show_message(span_highdanger("The sky roars louder <u>[relative_dir ? ("to the " + dir2text(relative_dir)) : "right above you"]</u>!"), EMOTE_VISIBLE,
			span_highdanger("The sound becomes louder <u>[relative_dir ? ("to the " + dir2text(relative_dir)) : "right above you"]</u>!"), EMOTE_AUDIBLE)

	sleep(impact_time / 3)
	for(var/mob/living/our_mob in range(15, target))
		our_mob.show_message(span_highdanger("OH GOD THE SKY WILL EXPLODE!!!"), EMOTE_VISIBLE,
			span_highdanger("YOU SHOULDN'T BE HERE!"), EMOTE_AUDIBLE)

/obj/structure/ob_ammo/warhead/explosive
	var/explosion_power = 1425
	var/explosion_falloff = 90

/obj/structure/ob_ammo/warhead/explosive/warhead_impact(turf/target, inaccuracy_amt = 0)
	cell_explosion(target, explosion_power, explosion_falloff + (inaccuracy_amt * 10)) // inaccuracy adds up fallof in result range decreases

/obj/structure/ob_ammo/warhead/incendiary
	var/flame_range_num
	var/flame_intensity = 36
	var/flame_duration = 40
	var/flame_colour = "blue"
	var/smoke_radius = 17
	var/smoke_duration = 20

/obj/structure/ob_ammo/warhead/incendiary/warhead_impact(turf/target, inaccuracy_amt = 0)
	flame_range_num = max(15 - inaccuracy_amt, 12)
	flame_radius(flame_range_num, target, flame_intensity, flame_duration, colour = flame_colour)
	var/datum/effect_system/smoke_spread/phosphorus/warcrime = new
	warcrime.set_up(smoke_radius, target, smoke_duration)
	warcrime.start()

/obj/structure/ob_ammo/warhead/cluster
	var/cluster_amount = 25
	var/cluster_power = 240
	var/cluster_falloff = 40
	var/cluster_range

/obj/structure/ob_ammo/warhead/cluster/warhead_impact(turf/target, inaccuracy_amt = 0)
	set waitfor = FALSE
	cluster_range = max(9 - inaccuracy_amt, 6)
	var/list/turf_list = list()
	for(var/turf/T in range(cluster_range, target))
		turf_list += T
	var/clusters_to_shoot = max(cluster_amount - inaccuracy_amt, cluster_amount - 5)
	for(var/i = 1 to clusters_to_shoot)
		var/turf/U = pick_n_take(turf_list)
		cell_explosion(U, cluster_power, cluster_falloff, adminlog = FALSE) //rocket barrage
		sleep(0.1 SECONDS)

/obj/structure/ob_ammo/warhead/plasmaloss
	var/smoke_radius = 25
	var/smoke_duration = 3 SECONDS

/obj/structure/ob_ammo/warhead/plasmaloss/warhead_impact(turf/target, inaccuracy_amt = 0)
	var/datum/effect_system/smoke_spread/plasmaloss/smoke = new
	smoke.set_up(smoke_radius, target, smoke_duration)//Vape nation
	smoke.start()
