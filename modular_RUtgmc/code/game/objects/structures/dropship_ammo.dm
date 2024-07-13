/obj/structure/ship_ammo/cas/rocket/widowmaker/detonate_on(turf/impact, attackdir = NORTH)
	impact.ceiling_debris_check(3)
	cell_explosion(impact, 320, 80)
	qdel(src)

/obj/structure/ship_ammo/cas/rocket/banshee/detonate_on(turf/impact, attackdir = NORTH)
	impact.ceiling_debris_check(3)
	cell_explosion(impact, 320, 100) //more spread out, with flames
	flame_radius(7, impact)
	qdel(src)

/obj/structure/ship_ammo/cas/rocket/keeper/detonate_on(turf/impact, attackdir = NORTH)
	impact.ceiling_debris_check(3)
	cell_explosion(impact, 450, 120) //tighter blast radius, but more devastating near center
	qdel(src)

/obj/structure/ship_ammo/cas/rocket/fatty/detonate_on(turf/impact, attackdir = NORTH)
	impact.ceiling_debris_check(2)
	cell_explosion(impact, 250, 90) //first explosion is small to trick xenos into thinking its a minirocket.
	addtimer(CALLBACK(src, PROC_REF(delayed_detonation), impact), 3 SECONDS)

/obj/structure/ship_ammo/cas/rocket/fatty/delayed_detonation(turf/impact)
	var/list/impact_coords = list(list(-3,3),list(0,4),list(3,3),list(-4,0),list(4,0),list(-3,-3),list(0,-4), list(3,-3))
	for(var/i = 1 to 8)
		var/list/coords = impact_coords[i]
		var/turf/detonation_target = locate(impact.x+coords[1],impact.y+coords[2],impact.z)
		detonation_target.ceiling_debris_check(2)
		cell_explosion(detonation_target, 250, 90, adminlog = FALSE)
	qdel(src)

/obj/structure/ship_ammo/cas/rocket/napalm/detonate_on(turf/impact, attackdir = NORTH)
	impact.ceiling_debris_check(3)
	cell_explosion(impact, 250, 90)
	flame_radius(fire_range, impact, 60, 30) //cooking for a long time
	var/datum/effect_system/smoke_spread/phosphorus/warcrime = new
	warcrime.set_up(fire_range + 1, impact, 7)
	warcrime.start()
	qdel(src)

/obj/structure/ship_ammo/cas/minirocket/detonate_on(turf/impact, attackdir = NORTH)
	impact.ceiling_debris_check(2)
	cell_explosion(impact, 120, 50, adminlog = FALSE)//no messaging admin, that'd spam them.
	if(!ammo_count)
		QDEL_IN(src, travelling_time) //deleted after last minirocket has fired and impacted the ground.

/obj/structure/ship_ammo/cas/minirocket/tangle/detonate_on(turf/impact, attackdir = NORTH)
	impact.ceiling_debris_check(2)
	cell_explosion(impact, 30, 15)
	var/datum/effect_system/smoke_spread/plasmaloss/S = new
	S.set_up(9, impact, 9)// Between grenade and mortar
	S.start()

/obj/structure/ship_ammo/railgun/detonate_on(turf/impact, attackdir = NORTH)
	impact.ceiling_debris_check(2)
	cell_explosion(impact, 200, 75, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL, color = COLOR_CYAN, adminlog = FALSE)//no messaging admin, that'd spam them.
	if(!ammo_count)
		QDEL_IN(src, travelling_time) //deleted after last railgun has fired and impacted the ground.
