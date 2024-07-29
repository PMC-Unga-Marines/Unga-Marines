/datum/ammo/energy
	ping = "ping_s"
	sound_hit 	 = "energy_hit"
	sound_armor = "ballistic_armor"
	sound_miss	 = "ballistic_miss"
	sound_bounce = "ballistic_bounce"

	damage_type = BURN
	flags_ammo_behavior = AMMO_ENERGY|AMMO_SOUND_PITCH
	armor_type = ENERGY
	accuracy = 15 //lasers fly fairly straight
	bullet_color = COLOR_LASER_RED
	barricade_clear_distance = 2

/datum/ammo/energy/emitter //Damage is determined in emitter.dm
	name = "emitter bolt"
	icon_state = "emitter"
	flags_ammo_behavior = AMMO_ENERGY|AMMO_IGNORE_ARMOR
	accurate_range = 10
	max_range = 10
	bullet_color = COLOR_VIBRANT_LIME

/datum/ammo/energy/taser
	name = "taser bolt"
	icon_state = "stun"
	hud_state = "taser"
	hud_state_empty = "battery_empty"
	damage = 10
	penetration = 100
	damage_type = STAMINA
	flags_ammo_behavior = AMMO_ENERGY|AMMO_SKIPS_ALIENS
	max_range = 15
	accurate_range = 10
	bullet_color = COLOR_VIVID_YELLOW
/datum/ammo/energy/taser/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, stun = 20 SECONDS)

/datum/ammo/energy/tesla
	name = "energy ball"
	icon_state = "tesla"
	hud_state = "taser"
	hud_state_empty = "battery_empty"
	flags_ammo_behavior = AMMO_ENERGY|AMMO_SPECIAL_PROCESS
	shell_speed = 0.1
	damage = 20
	penetration = 20
	bullet_color = COLOR_TESLA_BLUE

/datum/ammo/energy/tesla/ammo_process(obj/projectile/proj, damage)
	zap_beam(proj, 4, damage)

/datum/ammo/energy/tesla/focused
	flags_ammo_behavior = AMMO_ENERGY|AMMO_SPECIAL_PROCESS|AMMO_IFF
	shell_speed = 0.1
	damage = 10
	penetration = 10
	bullet_color = COLOR_TESLA_BLUE

/datum/ammo/energy/tesla/focused/ammo_process(obj/projectile/proj, damage)
	zap_beam(proj, 3, damage)

/datum/ammo/energy/tesla/on_hit_mob(mob/M,obj/projectile/P)
	if(isxeno(M)) //need 1 second more than the actual effect time
		var/mob/living/carbon/xenomorph/X = M
		X.use_plasma(0.3 * X.xeno_caste.plasma_max * X.xeno_caste.plasma_regen_limit) //Drains 30% of max plasma on hit

/datum/ammo/energy/lasgun
	name = "laser bolt"
	icon_state = "laser"
	hud_state = "laser"
	armor_type = LASER
	flags_ammo_behavior = AMMO_ENERGY|AMMO_SUNDERING
	shell_speed = 4
	accurate_range = 15
	damage = 20
	penetration = 10
	max_range = 30
	accuracy_var_low = 3
	accuracy_var_high = 3
	sundering = 2.5

/datum/ammo/energy/lasgun/M43
	icon_state = "laser2"

/datum/ammo/energy/lasgun/M43/overcharge
	name = "overcharged laser bolt"
	icon_state = "overchargedlaser"
	hud_state = "laser_sniper"
	damage = 40
	max_range = 40
	penetration = 50
	sundering = 5

/datum/ammo/energy/lasgun/M43/heat
	name = "microwave heat bolt"
	icon_state = "microwavelaser"
	hud_state = "laser_heat"
	damage = 12 //requires mod with -0.15 multiplier should math out to 10
	penetration = 100 // It's a laser that burns the skin! The fire stacks go threw anyway.
	flags_ammo_behavior = AMMO_ENERGY|AMMO_INCENDIARY|AMMO_SUNDERING
	sundering = 1

/datum/ammo/energy/lasgun/M43/blast
	name = "wide range laser blast"
	icon_state = "heavylaser2"
	hud_state = "laser_spread"
	bonus_projectiles_type = /datum/ammo/energy/lasgun/M43/spread
	bonus_projectiles_amount = 2
	bonus_projectiles_scatter = 10
	accuracy_var_low = 9
	accuracy_var_high = 9
	accurate_range = 5
	max_range = 5
	damage = 42
	damage_falloff = 10
	penetration = 0
	sundering = 5

/datum/ammo/energy/lasgun/M43/spread
	name = "additional laser blast"
	icon_state = "laser2"
	shell_speed = 2
	accuracy_var_low = 9
	accuracy_var_high = 9
	accurate_range = 5
	max_range = 5
	damage = 35
	damage_falloff = 10
	penetration = 0

/datum/ammo/energy/lasgun/M43/disabler
	name = "disabler bolt"
	icon_state = "disablershot"
	hud_state = "laser_disabler"
	damage = 45
	penetration = 0
	damage_type = STAMINA
	bullet_color = COLOR_DISABLER_BLUE

/datum/ammo/energy/lasgun/M43/disabler/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, stagger = 1 SECONDS, slowdown = 0.75)

/datum/ammo/energy/lasgun/pulsebolt
	name = "pulse bolt"
	icon_state = "pulse2"
	hud_state = "pulse"
	damage = 45 // this is gotta hurt...
	max_range = 40
	penetration = 100
	sundering = 100
	bullet_color = COLOR_PULSE_BLUE

/datum/ammo/energy/lasgun/M43/practice
	name = "practice laser bolt"
	icon_state = "disablershot"
	hud_state = "laser_disabler"
	damage = 45
	penetration = 0
	damage_type = STAMINA
	flags_ammo_behavior = AMMO_ENERGY
	bullet_color = COLOR_DISABLER_BLUE

/datum/ammo/energy/lasgun/M43/practice/on_hit_mob(mob/living/carbon/C, obj/projectile/P)
	if(!istype(C) || C.stat == DEAD || C.issamexenohive(P.firer) )
		return

	if(isnestedhost(C))
		return

	staggerstun(C, P, stagger = 2 SECONDS, slowdown = 1) //Staggers and slows down briefly

	return ..()

// TE Lasers //

/datum/ammo/energy/lasgun/marine
	flags_ammo_behavior = AMMO_ENERGY|AMMO_SUNDERING|AMMO_HITSCAN
	damage = 20
	penetration = 10
	sundering = 1.5
	max_range = 30
	hitscan_effect_icon = "beam"

/datum/ammo/energy/lasgun/marine/sniper_overcharge
	name = "sniper overcharge bolt"
	icon_state = "overchargedlaser"
	hud_state = "laser_sniper_overcharge"
	shell_speed = 2.5
	damage = 100
	penetration = 80
	accurate_range_min = 6
	flags_ammo_behavior = AMMO_ENERGY|AMMO_SUNDERING|AMMO_HITSCAN|AMMO_SNIPER
	sundering = 10
	hitscan_effect_icon = "beam_heavy_charge"
	bullet_color = COLOR_DISABLER_BLUE

/datum/ammo/energy/lasgun/marine/carbine
	sundering = 1
	max_range = 18

/datum/ammo/energy/lasgun/marine/overcharge
	name = "overcharged laser bolt"
	icon_state = "overchargedlaser"
	hud_state = "laser_sniper"
	damage = 40
	penetration = 20
	sundering = 2
	hitscan_effect_icon = "beam_heavy"

/datum/ammo/energy/lasgun/marine/weakening
	name = "weakening laser bolt"
	icon_state = "overchargedlaser"
	hud_state = "laser_sniper"
	damage = 30
	penetration = 10
	sundering = 0
	damage_type = STAMINA
	hitscan_effect_icon = "blue_beam"
	bullet_color = COLOR_DISABLER_BLUE
	///plasma drained per hit
	var/plasma_drain = 25

/datum/ammo/energy/lasgun/marine/weakening/on_hit_mob(mob/M, obj/projectile/proj)
	staggerstun(M, proj, max_range = 6, slowdown = 1)

	if(!isxeno(M))
		return
	var/mob/living/carbon/xenomorph/xeno_victim = M
	xeno_victim.use_plasma(plasma_drain * xeno_victim.xeno_caste.plasma_regen_limit)

/datum/ammo/energy/lasgun/marine/microwave
	name = "microwave laser bolt"
	icon_state = "overchargedlaser"
	hud_state = "laser_sniper"
	damage = 20
	penetration = 20
	sundering = 2
	hitscan_effect_icon = "beam_grass"
	bullet_color = LIGHT_COLOR_GREEN
	///number of microwave stacks to apply when hitting mobvs
	var/microwave_stacks = 1

/datum/ammo/energy/lasgun/marine/microwave/on_hit_mob(mob/M, obj/projectile/proj)
	if(!isliving(M))
		return

	var/mob/living/living_victim = M
	var/datum/status_effect/stacking/microwave/debuff = living_victim.has_status_effect(STATUS_EFFECT_MICROWAVE)

	if(debuff)
		debuff.add_stacks(microwave_stacks)
	else
		living_victim.apply_status_effect(STATUS_EFFECT_MICROWAVE, microwave_stacks)

/datum/ammo/energy/lasgun/marine/blast
	name = "wide range laser blast"
	icon_state = "heavylaser2"
	hud_state = "laser_spread"
	bonus_projectiles_type = /datum/ammo/energy/lasgun/marine/blast/spread
	bonus_projectiles_amount = 2
	bonus_projectiles_scatter = 5
	accuracy_var_low = 9
	accuracy_var_high = 9
	accurate_range = 5
	max_range = 8
	damage = 35
	penetration = 20
	sundering = 1
	hitscan_effect_icon = "pu_laser"
	bullet_color = LIGHT_COLOR_PURPLE

/datum/ammo/energy/lasgun/marine/blast/spread
	name = "additional laser blast"

/datum/ammo/energy/lasgun/marine/impact
	name = "impact laser blast"
	icon_state = "overchargedlaser"
	hud_state = "laser_sniper"
	damage = 35
	penetration = 10
	sundering = 0
	hitscan_effect_icon = "pu_laser"
	bullet_color = LIGHT_COLOR_PURPLE

/datum/ammo/energy/lasgun/marine/impact/on_hit_mob(mob/M, obj/projectile/proj)
	var/knockback_dist = round(LERP(3, 1, proj.distance_travelled / 6), 1)
	staggerstun(M, proj, max_range = 6, knockback = knockback_dist)

/datum/ammo/energy/lasgun/marine/cripple
	name = "impact laser blast"
	icon_state = "overchargedlaser"
	hud_state = "laser_sniper"
	damage = 20
	penetration = 10
	sundering = 0
	hitscan_effect_icon = "blue_beam"
	bullet_color = COLOR_DISABLER_BLUE

/datum/ammo/energy/lasgun/marine/cripple/on_hit_mob(mob/M, obj/projectile/proj)
	staggerstun(M, proj, slowdown = 1.5)

/datum/ammo/energy/lasgun/marine/autolaser
	name = "machine laser bolt"
	damage = 18
	penetration = 15
	sundering = 1

/datum/ammo/energy/lasgun/marine/autolaser/burst
	name = "burst machine laser bolt"
	hud_state = "laser_efficiency"
	damage = 12

/datum/ammo/energy/lasgun/marine/autolaser/charge
	name = "charged machine laser bolt"
	hud_state = "laser_efficiency"
	damage = 50
	penetration = 30
	sundering = 3
	hitscan_effect_icon = "beam_heavy"
	flags_ammo_behavior = AMMO_ENERGY|AMMO_SUNDERING|AMMO_HITSCAN|AMMO_PASS_THROUGH_MOB

/datum/ammo/energy/lasgun/marine/autolaser/charge/on_hit_turf(turf/T, obj/projectile/proj)
	if(istype(T, /turf/closed/wall))
		var/turf/closed/wall/wall_victim = T
		wall_victim.take_damage(proj.damage, proj.damtype, proj.armor_type)

/datum/ammo/energy/lasgun/marine/autolaser/melting
	name = "melting machine laser bolt"
	hud_state = "laser_efficiency"
	damage = 15
	penetration = 20
	sundering = 0
	hitscan_effect_icon = "beam_solar"
	bullet_color = LIGHT_COLOR_YELLOW
	///number of melting stacks to apply when hitting mobs
	var/melt_stacks = 2

/datum/ammo/energy/lasgun/marine/autolaser/melting/on_hit_mob(mob/M, obj/projectile/proj)
	if(!isliving(M))
		return

	var/mob/living/living_victim = M
	var/datum/status_effect/stacking/melting/debuff = living_victim.has_status_effect(STATUS_EFFECT_MELTING)

	if(debuff)
		debuff.add_stacks(melt_stacks)
	else
		living_victim.apply_status_effect(STATUS_EFFECT_MELTING, melt_stacks)

/datum/ammo/energy/lasgun/marine/sniper
	name = "sniper laser bolt"
	hud_state = "laser_sniper"
	damage = 60
	penetration = 30
	accurate_range_min = 5
	flags_ammo_behavior = AMMO_ENERGY|AMMO_SUNDERING|AMMO_HITSCAN|AMMO_SNIPER
	sundering = 5
	max_range = 40
	damage_falloff = 0
	hitscan_effect_icon = "beam_heavy"

/datum/ammo/energy/lasgun/marine/sniper_heat
	name = "sniper heat bolt"
	icon_state = "microwavelaser"
	hud_state = "laser_heat"
	damage = 40
	penetration = 30
	accurate_range_min = 5
	flags_ammo_behavior = AMMO_ENERGY|AMMO_INCENDIARY|AMMO_SUNDERING|AMMO_HITSCAN|AMMO_SNIPER
	sundering = 1
	hitscan_effect_icon = "beam_incen"
	bullet_color = COLOR_RED_LIGHT

/datum/ammo/energy/lasgun/marine/shatter
	name = "sniper shattering bolt"
	icon_state = "microwavelaser"
	hud_state = "laser_heat"
	damage = 40
	penetration = 30
	accurate_range_min = 5
	sundering = 10
	hitscan_effect_icon = "pu_laser"
	bullet_color = LIGHT_COLOR_PURPLE
	///shatter effection duration when hitting mobs
	var/shatter_duration = 5 SECONDS

/datum/ammo/energy/lasgun/marine/shatter/on_hit_mob(mob/M, obj/projectile/proj)
	if(!isliving(M))
		return

	var/mob/living/living_victim = M
	living_victim.apply_status_effect(STATUS_EFFECT_SHATTER, shatter_duration)

/datum/ammo/energy/lasgun/marine/shatter/heavy_laser
	sundering = 1
	accurate_range_min = 0

/datum/ammo/energy/lasgun/marine/ricochet
	name = "sniper laser bolt"
	icon_state = "microwavelaser"
	hud_state = "laser_heat"
	damage = 100
	penetration = 30
	flags_ammo_behavior = AMMO_ENERGY|AMMO_SUNDERING|AMMO_HITSCAN|AMMO_SNIPER
	sundering = 1
	hitscan_effect_icon = "u_laser_beam"
	bonus_projectiles_scatter = 0
	bullet_color = COLOR_DISABLER_BLUE

/datum/ammo/energy/lasgun/marine/ricochet/one
	damage = 80
	bonus_projectiles_type = /datum/ammo/energy/lasgun/marine/ricochet

/datum/ammo/energy/lasgun/marine/ricochet/two
	damage = 65
	bonus_projectiles_type = /datum/ammo/energy/lasgun/marine/ricochet/one

/datum/ammo/energy/lasgun/marine/ricochet/three
	damage = 50
	bonus_projectiles_type = /datum/ammo/energy/lasgun/marine/ricochet/two

/datum/ammo/energy/lasgun/marine/ricochet/four
	damage = 40
	bonus_projectiles_type = /datum/ammo/energy/lasgun/marine/ricochet/three

/datum/ammo/energy/lasgun/marine/ricochet/on_hit_turf(turf/T, obj/projectile/proj)
	reflect(T, proj, 5)

/datum/ammo/energy/lasgun/marine/ricochet/on_hit_obj(obj/O, obj/projectile/proj)
	reflect(get_turf(O), proj, 5)

/datum/ammo/energy/lasgun/marine/pistol
	name = "pistol laser bolt"
	damage = 20
	penetration = 5
	sundering = 1
	hitscan_effect_icon = "beam_particle"
	bullet_color = COLOR_DISABLER_BLUE

/datum/ammo/energy/lasgun/marine/pistol/disabler
	name = "disabler bolt"
	icon_state = "disablershot"
	hud_state = "laser_disabler"
	damage = 70
	penetration = 0
	damage_type = STAMINA
	hitscan_effect_icon = "beam_stun"
	bullet_color = LIGHT_COLOR_YELLOW

/datum/ammo/energy/lasgun/marine/pistol/heat
	name = "microwave heat bolt"
	icon_state = "microwavelaser"
	hud_state = "laser_heat"
	damage = 20
	shell_speed = 2.5
	penetration = 10
	flags_ammo_behavior = AMMO_ENERGY|AMMO_INCENDIARY|AMMO_SUNDERING|AMMO_HITSCAN
	sundering = 0.5
	hitscan_effect_icon = "beam_incen"
	bullet_color = COLOR_LASER_RED

/datum/ammo/energy/lasgun/pistol/disabler/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, stagger = 1 SECONDS, slowdown = 0.75)

/datum/ammo/energy/lasgun/marine/xray
	name = "xray heat bolt"
	hud_state = "laser_xray"
	icon_state = "u_laser"
	flags_ammo_behavior = AMMO_ENERGY|AMMO_INCENDIARY|AMMO_SUNDERING|AMMO_HITSCAN
	damage = 25
	penetration = 5
	sundering = 1
	max_range = 15
	hitscan_effect_icon = "u_laser_beam"

/datum/ammo/energy/lasgun/marine/xray/piercing
	name = "xray piercing bolt"
	icon_state = "xray"
	flags_ammo_behavior = AMMO_ENERGY|AMMO_HITSCAN|AMMO_PASS_THROUGH_TURF|AMMO_PASS_THROUGH_MOVABLE
	damage = 25
	penetration = 100
	max_range = 10
	hitscan_effect_icon = "xray_beam"

/datum/ammo/energy/lasgun/marine/heavy_laser
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_ENERGY|AMMO_SUNDERING|AMMO_HITSCAN|AMMO_INCENDIARY
	hud_state = "laser_overcharge"
	damage = 60
	penetration = 10
	sundering = 1
	max_range = 30
	hitscan_effect_icon = "beam_incen"

/datum/ammo/energy/lasgun/marine/heavy_laser/drop_nade(turf/T, radius = 1)
	if(!T || !isturf(T))
		return
	playsound(T, 'sound/weapons/guns/fire/flamethrower2.ogg', 50, 1, 4)
	flame_radius(radius, T, 3, 3, 3, 3)

/datum/ammo/energy/lasgun/marine/heavy_laser/on_hit_mob(mob/M, obj/projectile/P)
	drop_nade(get_turf(M))

/datum/ammo/energy/lasgun/marine/heavy_laser/on_hit_obj(obj/O, obj/projectile/P)
	drop_nade(O.density ? get_step_towards(O, P) : O, P)

/datum/ammo/energy/lasgun/marine/heavy_laser/on_hit_turf(turf/T, obj/projectile/P)
	drop_nade(T.density ? get_step_towards(T, P) : T)

/datum/ammo/energy/lasgun/marine/heavy_laser/do_at_max_range(turf/T, obj/projectile/P)
	drop_nade(T.density ? get_step_towards(T, P) : T)

/datum/ammo/energy/xeno
	barricade_clear_distance = 0
	///Plasma cost to fire this projectile
	var/ability_cost
	///Particle type used when this ammo is used
	var/particles/channel_particle
	///The colour the xeno glows when using this ammo type
	var/glow_color

/datum/ammo/energy/xeno/psy_blast
	name = "psychic blast"
	flags_ammo_behavior = AMMO_XENO|AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_ENERGY|AMMO_SUNDERING|AMMO_HITSCAN|AMMO_SKIPS_ALIENS
	damage = 35
	penetration = 10
	sundering = 1
	max_range = 7
	accurate_range = 7
	hitscan_effect_icon = "beam_cult"
	icon_state = "psy_blast"
	ability_cost = 230
	channel_particle = /particles/warlock_charge/psy_blast
	glow_color = "#9e1f1f"
	///The AOE for drop_nade
	var/aoe_range = 2

/datum/ammo/energy/xeno/psy_blast/drop_nade(turf/T, obj/projectile/P)
	if(!T || !isturf(T))
		return
	playsound(T, 'sound/effects/EMPulse.ogg', 50)
	var/aoe_damage = 25
	if(isxeno(P.firer))
		var/mob/living/carbon/xenomorph/xeno_firer = P.firer
		aoe_damage = xeno_firer.xeno_caste.blast_strength

	var/list/throw_atoms = list()
	var/list/turf/target_turfs = generate_true_cone(T, aoe_range, -1, 359, 0, air_pass = TRUE)
	for(var/turf/target_turf AS in target_turfs)
		for(var/atom/movable/target AS in target_turf)
			if(isliving(target))
				var/mob/living/living_victim = target
				if(living_victim.stat == DEAD)
					continue
				if(!isxeno(living_victim))
					living_victim.apply_damage(aoe_damage, BURN, null, ENERGY, FALSE, FALSE, TRUE, penetration)
					staggerstun(living_victim, P, 10, slowdown = 1)
			else if(isobj(target))
				var/obj/obj_victim = target
				if(!(obj_victim.resistance_flags & XENO_DAMAGEABLE))
					continue
				obj_victim.take_damage(aoe_damage, BURN, ENERGY, TRUE, armour_penetration = penetration)
			if(target.anchored)
				continue
			throw_atoms += target

	for(var/atom/movable/target AS in throw_atoms)
		var/throw_dir = get_dir(T, target)
		if(T == get_turf(target))
			throw_dir = get_dir(P.starting_turf, T)
		target.safe_throw_at(get_ranged_target_turf(T, throw_dir, 5), 3, 1, spin = TRUE)

	new /obj/effect/temp_visual/shockwave(T, aoe_range + 2)

/datum/ammo/energy/xeno/psy_blast/on_hit_mob(mob/M, obj/projectile/P)
	drop_nade(get_turf(M), P)

/datum/ammo/energy/xeno/psy_blast/on_hit_obj(obj/O, obj/projectile/P)
	drop_nade(O.density ? get_step_towards(O, P) : O, P)

/datum/ammo/energy/xeno/psy_blast/on_hit_turf(turf/T, obj/projectile/P)
	drop_nade(T.density ? get_step_towards(T, P) : T, P)

/datum/ammo/energy/xeno/psy_blast/do_at_max_range(turf/T, obj/projectile/P)
	drop_nade(T.density ? get_step_towards(T, P) : T, P)

/datum/ammo/energy/xeno/psy_blast/psy_lance
	name = "psychic lance"
	flags_ammo_behavior = AMMO_XENO|AMMO_ENERGY|AMMO_SUNDERING|AMMO_HITSCAN|AMMO_PASS_THROUGH_MOVABLE
	damage = 60
	penetration = 50
	accuracy = 100
	sundering = 5
	max_range = 16
	hitscan_effect_icon = "beam_hcult"
	icon_state = "psy_lance"
	ability_cost = 300
	channel_particle = /particles/warlock_charge/psy_blast/psy_lance
	glow_color = "#CB0166"

/datum/ammo/energy/xeno/psy_blast/psy_lance/on_hit_obj(obj/O, obj/projectile/P)
	if(isvehicle(O))
		var/obj/vehicle/veh_victim = O
		veh_victim.take_damage(200, BURN, ENERGY, TRUE, armour_penetration = penetration)

/datum/ammo/energy/xeno/psy_blast/psy_lance/on_hit_mob(mob/M, obj/projectile/P)
	if(isxeno(M))
		return
	staggerstun(M, P, 9, stagger = 4 SECONDS, slowdown = 2, knockback = 1)

/datum/ammo/energy/xeno/psy_blast/psy_lance/on_hit_turf(turf/T, obj/projectile/P)
	return

/datum/ammo/energy/xeno/psy_blast/psy_lance/do_at_max_range(turf/T, obj/projectile/P)
	return

// Plasma //
/datum/ammo/energy/plasma
	name = "plasma bolt"
	icon_state = "pulse2"
	hud_state = "plasma"
	armor_type = LASER
	shell_speed = 4
	accurate_range = 15
	damage = 40
	penetration = 15
	max_range = 30
	accuracy_var_low = 3
	accuracy_var_high = 3

/datum/ammo/energy/plasma_pistol
	name = "ionized plasma bolt"
	icon_state = "overchargedlaser"
	hud_state = "electrothermal"
	hud_state_empty = "electrothermal_empty"
	damage = 40
	max_range = 14
	penetration = 5
	shell_speed = 1.5
	flags_ammo_behavior = AMMO_ENERGY|AMMO_INCENDIARY|AMMO_EXPLOSIVE
	bullet_color = LIGHT_COLOR_ELECTRIC_GREEN
	///Fire burn time
	var/heat = 12
	///Fire damage
	var/burn_damage = 9
	///Fire color
	var/fire_color = "green"

/datum/ammo/energy/plasma_pistol/proc/drop_fire(atom/target, obj/projectile/proj)
	var/turf/target_turf = get_turf(target)
	var/burn_mod = 1
	if(istype(target_turf, /turf/closed/wall))
		burn_mod = 3
	target_turf.ignite(heat, burn_damage * burn_mod, fire_color)

	for(var/mob/living/mob_caught in target_turf)
		if(mob_caught.stat == DEAD || mob_caught == target)
			continue
		mob_caught.adjust_fire_stacks(burn_damage)
		mob_caught.IgniteMob()

/datum/ammo/energy/plasma_pistol/on_hit_turf(turf/T, obj/projectile/proj)
	drop_fire(T, proj)

/datum/ammo/energy/plasma_pistol/on_hit_mob(mob/M, obj/projectile/proj)
	drop_fire(M, proj)

/datum/ammo/energy/plasma_pistol/on_hit_obj(obj/O, obj/projectile/proj)
	drop_fire(O, proj)

/datum/ammo/energy/plasma_pistol/do_at_max_range(turf/T, obj/projectile/proj)
	drop_fire(T, proj)

//volkite
/datum/ammo/energy/volkite
	name = "thermal energy bolt"
	icon_state = "overchargedlaser"
	hud_state = "laser_heat"
	hud_state_empty = "battery_empty_flash"
	flags_ammo_behavior = AMMO_ENERGY|AMMO_SUNDERING|AMMO_SOUND_PITCH
	bullet_color = COLOR_TAN_ORANGE
	armor_type = ENERGY
	max_range = 14
	accurate_range = 5 //for charger
	shell_speed = 4
	accuracy_var_low = 5
	accuracy_var_high = 5
	accuracy = 5
	point_blank_range = 2
	damage = 20
	penetration = 10
	sundering = 2
	fire_burst_damage = 15

	//inherited, could use some changes
	ping = "ping_s"
	sound_hit = "energy_hit"
	sound_armor = "ballistic_armor"
	sound_miss = "ballistic_miss"
	sound_bounce = "ballistic_bounce"

/datum/ammo/energy/volkite/on_hit_mob(mob/M,obj/projectile/P)
	deflagrate(M, P)

/datum/ammo/energy/volkite/medium
	max_range = 25
	accurate_range = 12
	damage = 30
	accuracy_var_low = 3
	accuracy_var_high = 3
	fire_burst_damage = 20

/datum/ammo/energy/volkite/medium/custom
	deflagrate_multiplier = 2

/datum/ammo/energy/volkite/heavy
	max_range = 35
	accurate_range = 12
	damage = 25
	fire_burst_damage = 20

/datum/ammo/energy/volkite/light
	max_range = 25
	accurate_range = 12
	accuracy_var_low = 3
	accuracy_var_high = 3
	penetration = 5
