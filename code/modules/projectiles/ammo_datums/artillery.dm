/datum/ammo/mortar
	name = "80mm shell"
	icon_state = "mortar"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_PASS_THROUGH_TURF|AMMO_PASS_THROUGH_MOVABLE
	shell_speed = 0.75
	damage = 0
	penetration = 0
	sundering = 0
	accuracy = 1000
	max_range = 1000
	ping = null
	bullet_color = COLOR_VERY_SOFT_YELLOW

/datum/ammo/mortar/drop_nade(turf/T)
	cell_explosion(T, 90, 30)

/datum/ammo/mortar/do_at_max_range(turf/T, obj/projectile/P)
	drop_nade(T)

/datum/ammo/mortar/incend/drop_nade(turf/T)
	cell_explosion(T, 45, 20)
	flame_radius(4, T)
	playsound(T, 'sound/weapons/guns/fire/flamethrower2.ogg', 35, 1, 4)

/datum/ammo/mortar/knee
	name = "50mm shell"
	icon_state = "howi"
	shell_speed = 0.75

/datum/ammo/mortar/knee/drop_nade(turf/T)
	cell_explosion(T, 80, 30)

/datum/ammo/mortar/smoke
	///the smoke effect at the point of detonation
	var/datum/effect_system/smoke_spread/smoketype = /datum/effect_system/smoke_spread/tactical

/datum/ammo/mortar/smoke/drop_nade(turf/T)
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	explosion(T, 0, 0, 1, 0, 3, throw_range = 0)
	playsound(T, 'sound/effects/smoke.ogg', 25, 1, 4)
	smoke.set_up(10, T, 11)
	smoke.start()

/datum/ammo/mortar/smoke/plasmaloss
	smoketype = /datum/effect_system/smoke_spread/plasmaloss

/datum/ammo/mortar/flare/drop_nade(turf/T)
	new /obj/effect/temp_visual/above_flare(T)
	playsound(T, 'sound/weapons/guns/fire/flare.ogg', 50, 1, 4)

/datum/ammo/mortar/howi
	name = "150mm shell"
	icon_state = "howi"

/datum/ammo/mortar/howi/drop_nade(turf/T)
	cell_explosion(T, 175, 50)

/datum/ammo/mortar/howi/incend/drop_nade(turf/T)
	cell_explosion(T, 45, 30)
	flame_radius(5, T)
	playsound(T, 'sound/weapons/guns/fire/flamethrower2.ogg', 35, 1, 4)

/datum/ammo/mortar/smoke/howi
	name = "150mm shell"
	icon_state = "howi"

/datum/ammo/mortar/smoke/howi/wp
	smoketype = /datum/effect_system/smoke_spread/phosphorus

/datum/ammo/mortar/smoke/howi/wp/drop_nade(turf/T)
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	explosion(T, 0, 0, 1, 0, 0, throw_range = 0)
	playsound(T, 'sound/effects/smoke.ogg', 25, 1, 4)
	smoke.set_up(6, T, 7)
	smoke.start()
	flame_radius(4, T)
	flame_radius(1, T, burn_intensity = 45, burn_duration = 75, burn_damage = 15, fire_stacks = 75)

/datum/ammo/mortar/smoke/howi/plasmaloss
	smoketype = /datum/effect_system/smoke_spread/plasmaloss

/datum/ammo/mortar/smoke/howi/plasmaloss/drop_nade(turf/T)
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	explosion(T, 0, 0, 5, 0, 0, throw_range = 0)
	playsound(T, 'sound/effects/smoke.ogg', 25, 1, 4)
	smoke.set_up(10, T, 11)
	smoke.start()

/datum/ammo/mortar/rocket
	name = "rocket"
	icon_state = "rocket"
	shell_speed = 1.5

/datum/ammo/mortar/rocket/drop_nade(turf/T)
	cell_explosion(T, 175, 75)

/datum/ammo/mortar/rocket/incend/drop_nade(turf/T)
	cell_explosion(T, 50, 20)
	flame_radius(5, T)
	playsound(T, 'sound/weapons/guns/fire/flamethrower2.ogg', 35, 1, 4)

/datum/ammo/mortar/rocket/minelayer/drop_nade(turf/T)
	var/obj/item/explosive/mine/mine = new /obj/item/explosive/mine(T)
	mine.deploy_mine(null, TGMC_LOYALIST_IFF)

/datum/ammo/mortar/rocket/smoke
	///the smoke effect at the point of detonation
	var/datum/effect_system/smoke_spread/smoketype = /datum/effect_system/smoke_spread/tactical

/datum/ammo/mortar/rocket/smoke/drop_nade(turf/T)
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	explosion(T, 0, 0, 1, 0, 3, throw_range = 0)
	playsound(T, 'sound/effects/smoke.ogg', 25, 1, 4)
	smoke.set_up(10, T, 11)
	smoke.start()

/datum/ammo/mortar/rocket/mlrs
	shell_speed = 2.5

/datum/ammo/mortar/rocket/mlrs/drop_nade(turf/T)
	cell_explosion(T, 70, 25)

/datum/ammo/mortar/rocket/smoke/mlrs
	shell_speed = 2.5
	smoketype = /datum/effect_system/smoke_spread/mustard

/datum/ammo/mortar/rocket/smoke/mlrs/drop_nade(turf/T)
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	explosion(T, 0, 0, 2, 0, 0, throw_range = 0)
	playsound(T, 'sound/effects/smoke.ogg', 25, 1, 4)
	smoke.set_up(5, T, 6)
	smoke.start()

/datum/ammo/bullet/atgun_spread
	name = "Shrapnel"
	icon_state = "flechette"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING|AMMO_PASS_THROUGH_MOB
	accuracy_var_low = 15
	accuracy_var_high = 5
	max_range = 6
	damage = 30
	penetration = 20
	sundering = 3
	damage_falloff = 0

/datum/ammo/bullet/atgun_spread/incendiary
	name = "incendiary flechette"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING|AMMO_PASS_THROUGH_MOB|AMMO_INCENDIARY|AMMO_LEAVE_TURF
	damage = 20
	penetration = 10
	sundering = 1.5

/datum/ammo/bullet/atgun_spread/incendiary/on_hit_mob(mob/M, obj/projectile/proj)
	return

/datum/ammo/bullet/atgun_spread/incendiary/drop_flame(turf/T)
	if(!istype(T))
		return
	T.ignite(5, 10)

/datum/ammo/bullet/atgun_spread/incendiary/on_leave_turf(turf/T, atom/firer, obj/projectile/proj)
	drop_flame(T)

/datum/ammo/ags_shrapnel
	name = "fragmentation grenade"
	icon_state = "grenade_projectile"
	hud_state = "grenade_frag"
	hud_state_empty = "grenade_empty"
	handful_icon_state = "40mm_grenade"
	handful_amount = 1
	ping = null //no bounce off.
	sound_bounce = "rocket_bounce"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_IFF
	armor_type = BOMB
	damage_falloff = 0.5
	shell_speed = 2
	accurate_range = 12
	max_range = 21
	damage = 15
	shrapnel_chance = 0
	bonus_projectiles_type = /datum/ammo/bullet/ags_spread
	bonus_projectiles_scatter = 20
	var/bonus_projectile_quantity = 15

/datum/ammo/ags_shrapnel/on_hit_mob(mob/M, obj/projectile/proj)
	playsound(proj, sound(get_sfx("explosion_micro")), 30, falloff = 5)
	fire_directionalburst(proj, proj.firer, proj.shot_from, bonus_projectile_quantity, 2, 3, Get_Angle(proj.firer, M) )

/datum/ammo/ags_shrapnel/on_hit_obj(obj/O, obj/projectile/proj)
	playsound(proj, sound(get_sfx("explosion_micro")), 30, falloff = 5)
	fire_directionalburst(proj, proj.firer, proj.shot_from, bonus_projectile_quantity, 2, 3, Get_Angle(proj.firer, O) )

/datum/ammo/ags_shrapnel/on_hit_turf(turf/T, obj/projectile/proj)
	playsound(proj, sound(get_sfx("explosion_micro")), 30, falloff = 5)
	fire_directionalburst(proj, proj.firer, proj.shot_from, bonus_projectile_quantity, 2, 3, Get_Angle(proj.firer, T) )

/datum/ammo/ags_shrapnel/do_at_max_range(turf/T, obj/projectile/proj)
	playsound(proj, sound(get_sfx("explosion_micro")), 30, falloff = 5)
	fire_directionalburst(proj, proj.firer, proj.shot_from, bonus_projectile_quantity, 2, 3, Get_Angle(proj.firer, get_turf(proj)) )

/datum/ammo/ags_shrapnel/incendiary
	name = "white phosphorous grenade"
	bonus_projectiles_type = /datum/ammo/bullet/ags_spread/incendiary

/datum/ammo/bullet/ags_spread
	name = "Shrapnel"
	icon_state = "flechette"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING|AMMO_PASS_THROUGH_MOB
	accuracy_var_low = 15
	accuracy_var_high = 5
	max_range = 6
	damage = 30
	penetration = 20
	sundering = 3
	damage_falloff = 0

/datum/ammo/bullet/ags_spread/incendiary
	name = "White phosphorous shrapnel"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING|AMMO_INCENDIARY
	damage = 20
	penetration = 10
	sundering = 1.5
	damage_falloff = 0

/datum/ammo/bullet/ags_spread/incendiary/on_hit_mob(mob/M, obj/projectile/P)
	drop_flame(get_turf(M))

/datum/ammo/bullet/ags_spread/incendiary/on_hit_obj(obj/O, obj/projectile/P)
	drop_flame(get_turf(O))

/datum/ammo/bullet/ags_spread/incendiary/on_hit_turf(turf/T, obj/projectile/P)
	drop_flame(get_turf(T))

/datum/ammo/bullet/ags_spread/incendiary/do_at_max_range(turf/T, obj/projectile/P)
	drop_flame(get_turf(T))

/datum/ammo/bullet/ags_spread/incendiary/drop_flame(turf/T)
	if(!istype(T))
		return
	T.ignite(5, 10)

/datum/ammo/grenade_container
	name = "grenade shell"
	ping = null
	damage_type = BRUTE
	var/nade_type = /obj/item/explosive/grenade
	icon_state = "grenade"
	armor_type = BOMB
	damage = 15
	accuracy = 15
	max_range = 10

/datum/ammo/grenade_container/on_hit_mob(mob/M, obj/projectile/P)
	drop_nade(get_turf(P))

/datum/ammo/grenade_container/on_hit_obj(obj/O, obj/projectile/P)
	drop_nade(O.density ? P.loc : O.loc)

/datum/ammo/grenade_container/on_hit_turf(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T)

/datum/ammo/grenade_container/do_at_max_range(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T)

/datum/ammo/grenade_container/drop_nade(turf/T)
	var/obj/item/explosive/grenade/G = new nade_type(T)
	G.visible_message(span_warning("\A [G] lands on [T]!"))
	G.det_time = 10
	G.activate()

/datum/ammo/grenade_container/smoke
	name = "smoke grenade shell"
	nade_type = /obj/item/explosive/grenade/smokebomb
	icon_state = "smoke_shell"

/datum/ammo/grenade_container/ags_grenade
	name = "grenade shell"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_IFF
	icon_state = "grenade_projectile"
	hud_state = "grenade_he"
	hud_state_empty = "grenade_empty"
	handful_icon_state = "40mm_grenade"
	handful_amount = 1
	max_range = 21
	nade_type = /obj/item/explosive/grenade/ags

/datum/ammo/grenade_container/ags_grenade/flare
	hud_state = "grenade_dummy"
	nade_type = /obj/item/explosive/grenade/flare

/datum/ammo/grenade_container/ags_grenade/cloak
	hud_state = "grenade_hide"
	nade_type = /obj/item/explosive/grenade/smokebomb/cloak/ags

/datum/ammo/grenade_container/ags_grenade/tanglefoot
	hud_state = "grenade_drain"
	nade_type = /obj/item/explosive/grenade/smokebomb/drain/agls
