/*
//================================================
					Turret
//================================================
*/

/datum/ammo/bullet/turret
	name = "autocannon bullet"
	bullet_color = COLOR_SOFT_RED
	hud_state = "rifle"
	hud_state_empty = "rifle_empty"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SENTRY
	accurate_range = 10
	damage = 20
	penetration = 20
	damage_falloff = 0.25

/datum/ammo/bullet/turret/dumb
	icon_state = "bullet"

/datum/ammo/bullet/turret/gauss
	name = "heavy gauss turret slug"
	hud_state = "rifle_heavy"
	damage = 60

/datum/ammo/bullet/turret/mini
	name = "small caliber autocannon bullet"
	damage = 12
	penetration = 10
	damage_falloff = 0.5
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SENTRY

/datum/ammo/bullet/turret/sniper
	name = "antimaterial bullet"
	bullet_color = COLOR_SOFT_RED
	accurate_range = 14
	damage = 75
	penetration = 50
	damage_falloff = 0

/datum/ammo/flamethrower/turret
	max_range = 8
	damage = 50

/datum/ammo/bullet/turret/buckshot
	name = "turret buckshot shell"
	icon_state = "buckshot"
	hud_state = "shotgun_buckshot"
	bonus_projectiles_type = /datum/ammo/bullet/turret/spread
	bonus_projectiles_amount = 6
	bonus_projectiles_scatter = 5
	max_range = 10
	damage = 20
	penetration = 20
	damage_falloff = 1

/datum/ammo/bullet/turret/buckshot/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, knockback = 1, max_range = 4)

/datum/ammo/bullet/turret/spread
	name = "additional buckshot"
	max_range = 10
	damage = 20
	penetration = 40
	damage_falloff = 1

/datum/ammo/bullet/turret/mini
	name = "small caliber autocannon bullet"
	damage = 20
	penetration = 20
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SENTRY

/*
//================================================
					tx54 and etc.
//================================================
*/

/datum/ammo/tx54
	name = "20mm airburst grenade"
	icon_state = "20mm_flight"
	hud_state = "grenade_airburst"
	hud_state_empty = "grenade_empty"
	handful_icon_state = "20mm_airburst"
	handful_amount = 3
	ping = null //no bounce off.
	sound_bounce = "rocket_bounce"
	flags_ammo_behavior = AMMO_TARGET_TURF|AMMO_SNIPER
	armor_type = BOMB
	damage_falloff = 0.5
	shell_speed = 2
	accurate_range = 12
	max_range = 15
	damage = 12			//impact damage from a grenade to the dome
	penetration = 0
	sundering = 0
	shrapnel_chance = 0
	bonus_projectiles_type = /datum/ammo/bullet/tx54_spread
	bonus_projectiles_scatter = 10
	///How many
	var/bonus_projectile_quantity = 7

	handful_greyscale_config = /datum/greyscale_config/ammo
	handful_greyscale_colors = COLOR_AMMO_AIRBURST

	projectile_greyscale_config = /datum/greyscale_config/projectile
	projectile_greyscale_colors = COLOR_AMMO_AIRBURST

/datum/ammo/tx54/on_hit_mob(mob/M, obj/projectile/proj)
	staggerstun(M, proj, slowdown = 0.5, knockback = 1)
	playsound(proj, sound(get_sfx("explosion_micro")), 30, falloff = 5)
	fire_directionalburst(proj, proj.firer, proj.shot_from, bonus_projectile_quantity, 4, 3, Get_Angle(proj.firer, M) )

/datum/ammo/tx54/on_hit_obj(obj/O, obj/projectile/proj)
	playsound(proj, sound(get_sfx("explosion_micro")), 30, falloff = 5)
	fire_directionalburst(proj, proj.firer, proj.shot_from, bonus_projectile_quantity, 4, 3, Get_Angle(proj.firer, O) )

/datum/ammo/tx54/on_hit_turf(turf/T, obj/projectile/proj)
	playsound(proj, sound(get_sfx("explosion_micro")), 30, falloff = 5)
	fire_directionalburst(proj, proj.firer, proj.shot_from, bonus_projectile_quantity, 4, 3, Get_Angle(proj.firer, T) )

/datum/ammo/tx54/do_at_max_range(turf/T, obj/projectile/proj)
	playsound(proj, sound(get_sfx("explosion_micro")), 30, falloff = 5)
	fire_directionalburst(proj, proj.firer, proj.shot_from, bonus_projectile_quantity, 4, 3, Get_Angle(proj.firer, get_turf(proj)) )

/datum/ammo/tx54/incendiary
	name = "20mm incendiary grenade"
	hud_state = "grenade_fire"
	bonus_projectiles_type = /datum/ammo/bullet/tx54_spread/incendiary
	bullet_color = LIGHT_COLOR_FIRE
	handful_greyscale_colors = COLOR_AMMO_INCENDIARY
	projectile_greyscale_colors = COLOR_AMMO_INCENDIARY

/datum/ammo/tx54/smoke
	name = "20mm tactical smoke grenade"
	hud_state = "grenade_hide"
	bonus_projectiles_type = /datum/ammo/bullet/tx54_spread/smoke
	bonus_projectiles_scatter = 24
	bonus_projectile_quantity = 5
	handful_greyscale_colors = COLOR_AMMO_TACTICAL_SMOKE
	projectile_greyscale_colors = COLOR_AMMO_TACTICAL_SMOKE

/datum/ammo/tx54/smoke/dense
	name = "20mm smoke grenade"
	hud_state = "grenade_smoke"
	bonus_projectiles_type = /datum/ammo/bullet/tx54_spread/smoke/dense
	handful_greyscale_colors = COLOR_AMMO_SMOKE
	projectile_greyscale_colors = COLOR_AMMO_SMOKE

/datum/ammo/tx54/smoke/tangle
	name = "20mm tanglefoot grenade"
	hud_state = "grenade_drain"
	bonus_projectiles_type = /datum/ammo/bullet/tx54_spread/smoke/tangle
	handful_greyscale_colors = COLOR_AMMO_TANGLEFOOT
	projectile_greyscale_colors = COLOR_AMMO_TANGLEFOOT

/datum/ammo/tx54/razor
	name = "20mm razorburn grenade"
	hud_state = "grenade_razor"
	bonus_projectiles_type = /datum/ammo/bullet/tx54_spread/razor
	bonus_projectiles_scatter = 50
	bonus_projectile_quantity = 3
	handful_greyscale_colors = COLOR_AMMO_RAZORBURN
	projectile_greyscale_colors = COLOR_AMMO_RAZORBURN

/datum/ammo/tx54/he
	name = "20mm HE grenade"
	hud_state = "grenade_he"
	bonus_projectiles_type = null
	max_range = 12
	handful_greyscale_colors = COLOR_AMMO_HIGH_EXPLOSIVE
	projectile_greyscale_colors = COLOR_AMMO_HIGH_EXPLOSIVE

/datum/ammo/tx54/he/drop_nade(turf/T)
	cell_explosion(T, 45, 25)

/datum/ammo/tx54/he/on_hit_mob(mob/M, obj/projectile/P)
	drop_nade(get_turf(M))

/datum/ammo/tx54/he/on_hit_obj(obj/O, obj/projectile/P)
	drop_nade(get_turf(O))

/datum/ammo/tx54/he/on_hit_turf(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T)

/datum/ammo/tx54/he/do_at_max_range(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T)

//The secondary projectiles
/datum/ammo/bullet/tx54_spread
	name = "Shrapnel"
	icon_state = "flechette"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_PASS_THROUGH_MOB
	accuracy_var_low = 5
	accuracy_var_high = 5
	max_range = 4
	damage = 20
	penetration = 20
	damage_falloff = 0

/datum/ammo/bullet/tx54_spread/on_hit_mob(mob/M, obj/projectile/proj)
	staggerstun(M, proj, max_range = 3, stagger = 0.6 SECONDS, slowdown = 0.3)

/datum/ammo/bullet/tx54_spread/incendiary
	name = "incendiary flechette"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_PASS_THROUGH_MOB|AMMO_INCENDIARY|AMMO_LEAVE_TURF
	damage = 15
	penetration = 10

/datum/ammo/bullet/tx54_spread/incendiary/on_hit_mob(mob/M, obj/projectile/proj)
	return

/datum/ammo/bullet/tx54_spread/incendiary/drop_flame(turf/T)
	if(!istype(T))
		return
	T.ignite(5, 10)

/datum/ammo/bullet/tx54_spread/incendiary/on_leave_turf(turf/T, obj/projectile/proj)
	drop_flame(T)

/datum/ammo/bullet/tx54_spread/smoke
	name = "chemical bomblet"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_PASS_THROUGH_MOB|AMMO_LEAVE_TURF
	max_range = 3
	damage = 5
	penetration = 0
	sundering = 0
	///The smoke type loaded in this ammo
	var/datum/effect_system/smoke_spread/trail_spread_system = /datum/effect_system/smoke_spread/tactical

/datum/ammo/bullet/tx54_spread/smoke/New()
	. = ..()

	trail_spread_system = new trail_spread_system(only_once = FALSE)

/datum/ammo/bullet/tx54_spread/smoke/Destroy()
	if(trail_spread_system)
		QDEL_NULL(trail_spread_system)
	return ..()

/datum/ammo/bullet/tx54_spread/smoke/on_hit_mob(mob/M, obj/projectile/proj)
	return

/datum/ammo/bullet/tx54_spread/smoke/on_leave_turf(turf/T, obj/projectile/proj)
	trail_spread_system.set_up(0, T)
	trail_spread_system.start()

/datum/ammo/bullet/tx54_spread/smoke/dense
	trail_spread_system = /datum/effect_system/smoke_spread/bad

/datum/ammo/bullet/tx54_spread/smoke/tangle
	trail_spread_system = /datum/effect_system/smoke_spread/plasmaloss

/datum/ammo/bullet/tx54_spread/razor
	name = "chemical bomblet"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_PASS_THROUGH_MOB|AMMO_LEAVE_TURF
	max_range = 4
	damage = 5
	penetration = 0
	sundering = 0
	///The foam type loaded in this ammo
	var/datum/effect_system/foam_spread/chemical_payload
	///The reagent content of the projectile
	var/datum/reagents/reagent_list

/datum/ammo/bullet/tx54_spread/razor/New()
	. = ..()

	chemical_payload = new
	reagent_list = new
	reagent_list.add_reagent(/datum/reagent/foaming_agent = 1)
	reagent_list.add_reagent(/datum/reagent/toxin/nanites = 7)

/datum/ammo/bullet/tx54_spread/razor/Destroy()
	if(chemical_payload)
		QDEL_NULL(chemical_payload)
	return ..()

/datum/ammo/bullet/tx54_spread/razor/on_hit_mob(mob/M, obj/projectile/proj)
	return

/datum/ammo/bullet/tx54_spread/razor/on_leave_turf(turf/T, obj/projectile/proj)
	chemical_payload.set_up(0, T, reagent_list, RAZOR_FOAM)
	chemical_payload.start()

//10-gauge Micro rail shells - aka micronades
/datum/ammo/bullet/micro_rail
	hud_state_empty = "grenade_empty_flash"
	handful_icon_state = "micro_grenade_airburst"
	flags_ammo_behavior = AMMO_BALLISTIC
	shell_speed = 2
	handful_amount = 3
	max_range = 3 //failure to detonate if the target is too close
	damage = 15
	bonus_projectiles_scatter = 12
	///How many bonus projectiles to generate. New var so it doesn't trigger on firing
	var/bonus_projectile_quantity = 5
	///Max range for the bonus projectiles
	var/bonus_projectile_range = 7
	///projectile speed for the bonus projectiles
	var/bonus_projectile_speed = 3

/datum/ammo/bullet/micro_rail/do_at_max_range(turf/T, obj/projectile/proj)
	playsound(proj, sound(get_sfx("explosion_micro")), 30, falloff = 5)
	var/datum/effect_system/smoke_spread/smoke = new
	smoke.set_up(0, get_turf(proj), 1)
	smoke.start()
	fire_directionalburst(proj, proj.firer, proj.shot_from, bonus_projectile_quantity, bonus_projectile_range, bonus_projectile_speed, Get_Angle(proj.firer, get_turf(proj)) )

//piercing scatter shot
/datum/ammo/bullet/micro_rail/airburst
	name = "micro grenade"
	handful_icon_state = "micro_grenade_airburst"
	hud_state = "grenade_airburst"
	bonus_projectiles_type = /datum/ammo/bullet/micro_rail_spread

//incendiary piercing scatter shot
/datum/ammo/bullet/micro_rail/dragonbreath
	name = "micro grenade"
	handful_icon_state = "micro_grenade_incendiary"
	hud_state = "grenade_fire"
	bonus_projectiles_type = /datum/ammo/bullet/micro_rail_spread/incendiary
	bonus_projectile_range = 6

//cluster grenade. Bomblets explode in a rough cone pattern
/datum/ammo/bullet/micro_rail/cluster
	name = "micro grenade"
	handful_icon_state = "micro_grenade_cluster"
	hud_state = "grenade_he"
	bonus_projectiles_type = /datum/ammo/micro_rail_cluster
	bonus_projectile_quantity = 7
	bonus_projectile_range = 6
	bonus_projectile_speed = 2

//creates a literal smokescreen
/datum/ammo/bullet/micro_rail/smoke_burst
	name = "micro grenade"
	handful_icon_state = "micro_grenade_smoke"
	hud_state = "grenade_smoke"
	bonus_projectiles_type = /datum/ammo/smoke_burst
	bonus_projectiles_scatter = 20
	bonus_projectile_range = 6
	bonus_projectile_speed = 2

//submunitions for micro grenades
/datum/ammo/bullet/micro_rail_spread
	name = "Shrapnel"
	icon_state = "flechette"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_PASS_THROUGH_MOB
	accuracy_var_low = 5
	accuracy_var_high = 5
	max_range = 7
	damage = 20
	penetration = 20
	sundering = 3
	damage_falloff = 1

/datum/ammo/bullet/micro_rail_spread/on_hit_mob(mob/M, obj/projectile/proj)
	staggerstun(M, proj, stagger = 1 SECONDS, slowdown = 0.5)

/datum/ammo/bullet/micro_rail_spread/incendiary
	name = "incendiary flechette"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_PASS_THROUGH_MOB|AMMO_INCENDIARY|AMMO_LEAVE_TURF
	damage = 15
	penetration = 5
	sundering = 1.5
	max_range = 6

/datum/ammo/bullet/micro_rail_spread/incendiary/on_hit_mob(mob/M, obj/projectile/proj)
	staggerstun(M, proj, stagger = 0.4 SECONDS, slowdown = 0.2)

/datum/ammo/bullet/micro_rail_spread/incendiary/drop_flame(turf/T)
	if(!istype(T))
		return
	T.ignite(5, 10)

/datum/ammo/bullet/micro_rail_spread/incendiary/on_leave_turf(turf/T, obj/projectile/proj)
	if(prob(40))
		drop_flame(T)

/datum/ammo/micro_rail_cluster
	name = "bomblet"
	icon_state = "bullet"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_LEAVE_TURF
	sound_hit 	 = "ballistic_hit"
	sound_armor = "ballistic_armor"
	sound_miss	 = "ballistic_miss"
	sound_bounce = "ballistic_bounce"
	shell_speed = 2
	damage = 5
	accuracy = -60 //stop you from just emptying all the bomblets into one guys face for big damage
	shrapnel_chance = 0
	max_range = 6
	bullet_color = COLOR_VERY_SOFT_YELLOW
	///the smoke effect at the point of detonation
	var/datum/effect_system/smoke_spread/smoketype = /datum/effect_system/smoke_spread
	///Total damage applied to victims by the exploding bomblet
	var/explosion_damage = 20
	///Amount of stagger applied by the exploding bomblet
	var/stagger_amount = 2 SECONDS
	///Amount of slowdown applied by the exploding bomblet
	var/slow_amount = 1
	///range of bomblet explosion
	var/explosion_range = 2

///handles the actual bomblet detonation
/datum/ammo/micro_rail_cluster/proc/detonate(turf/T, obj/projectile/P)
	playsound(T, sound(get_sfx("explosion_micro")), 30, falloff = 5)
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	smoke.set_up(0, T, rand(1,2))
	smoke.start()

	var/list/turf/target_turfs = generate_true_cone(T, explosion_range, -1, 359, 0, air_pass = TRUE)
	for(var/turf/target_turf AS in target_turfs)
		for(var/target in target_turf)
			if(isliving(target))
				var/mob/living/living_target = target
				living_target.visible_message(span_danger("[living_target] is hit by the bomblet blast!"),
					isxeno(living_target) ? span_xenodanger("We are hit by the bomblet blast!") : span_highdanger("you are hit by the bomblet blast!"))
				living_target.apply_damages(explosion_damage * 0.5, explosion_damage * 0.5, 0, 0, 0, blocked = BOMB, updating_health = TRUE)
				staggerstun(living_target, P, stagger = stagger_amount, slowdown = slow_amount)
			else if(isobj(target))
				var/obj/obj_victim = target
				obj_victim.take_damage(explosion_damage, BRUTE, BOMB)

/datum/ammo/micro_rail_cluster/on_leave_turf(turf/T, obj/projectile/proj)
	///chance to detonate early, scales with distance and capped, to avoid lots of immediate detonations, and nothing reach max range respectively.
	var/detonate_probability = min(proj.distance_travelled * 4, 16)
	if(prob(detonate_probability))
		proj.proj_max_range = proj.distance_travelled

/datum/ammo/micro_rail_cluster/on_hit_mob(mob/M, obj/projectile/P)
	detonate(get_turf(P), P)

/datum/ammo/micro_rail_cluster/on_hit_obj(obj/O, obj/projectile/P)
	detonate(get_turf(P), P)

/datum/ammo/micro_rail_cluster/on_hit_turf(turf/T, obj/projectile/P)
	detonate(T.density ? P.loc : T, P)

/datum/ammo/micro_rail_cluster/do_at_max_range(turf/T, obj/projectile/P)
	detonate(T.density ? P.loc : T, P)

/datum/ammo/smoke_burst
	name = "micro smoke canister"
	icon_state = "bullet"
	flags_ammo_behavior = AMMO_BALLISTIC
	sound_hit 	 = "ballistic_hit"
	sound_armor = "ballistic_armor"
	sound_miss	 = "ballistic_miss"
	sound_bounce = "ballistic_bounce"
	shell_speed = 2
	damage = 5
	shrapnel_chance = 0
	max_range = 6
	bullet_color = COLOR_VERY_SOFT_YELLOW
	/// smoke type created when the projectile detonates
	var/datum/effect_system/smoke_spread/smoketype = /datum/effect_system/smoke_spread/bad
	///radius this smoke will encompass
	var/smokeradius = 1

/datum/ammo/smoke_burst/drop_nade(turf/T)
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	playsound(T, 'sound/effects/smoke.ogg', 25, 1, 4)
	smoke.set_up(smokeradius, T, rand(5,9))
	smoke.start()

/datum/ammo/smoke_burst/on_hit_mob(mob/M, obj/projectile/P)
	drop_nade(get_turf(P))

/datum/ammo/smoke_burst/on_hit_obj(obj/O, obj/projectile/P)
	drop_nade(get_turf(P))

/datum/ammo/smoke_burst/on_hit_turf(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T)

/datum/ammo/smoke_burst/do_at_max_range(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T)

/*
//================================================
					pepperball
//================================================
*/

/datum/ammo/bullet/pepperball
	name = "pepperball"
	hud_state = "pepperball"
	hud_state_empty = "pepperball_empty"
	flags_ammo_behavior = AMMO_BALLISTIC
	accurate_range = 15
	damage_type = STAMINA
	armor_type = BIO
	damage = 1
	damage_falloff = 0
	penetration = 0
	shrapnel_chance = 0
	///percentage of xenos total plasma to drain when hit by a pepperball
	var/drain_multiplier = 0.05
	///Flat plasma to drain, unaffected by caste plasma amount.
	var/plasma_drain = 25

/datum/ammo/bullet/pepperball/on_hit_mob(mob/living/victim, obj/projectile/proj)
	if(isxeno(victim))
		var/mob/living/carbon/xenomorph/X = victim
		X.use_plasma(drain_multiplier * X.xeno_caste.plasma_max * X.xeno_caste.plasma_regen_limit)
		X.use_plasma(plasma_drain)

/datum/ammo/bullet/pepperball/pepperball_mini
	damage = 1
	drain_multiplier = 0.03
	plasma_drain = 15
