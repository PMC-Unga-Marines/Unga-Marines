/datum/ammo/rocket
	name = "high explosive rocket"
	icon_state = "missile"
	hud_state = "rocket_he"
	hud_state_empty = "rocket_empty"
	ping = null //no bounce off.
	sound_bounce = "rocket_bounce"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_SUNDERING
	armor_type = BOMB
	damage_falloff = 0
	shell_speed = 2
	accuracy = 40
	accurate_range = 20
	max_range = 14
	damage = 200
	penetration = 100
	sundering = 100
	bullet_color = LIGHT_COLOR_FIRE
	barricade_clear_distance = 2

/datum/ammo/rocket/drop_nade(turf/T)
	explosion(T, 0, 4, 6, 0, 2)

/datum/ammo/rocket/on_hit_mob(mob/M, obj/projectile/P)
	drop_nade(get_turf(M))

/datum/ammo/rocket/on_hit_obj(obj/O, obj/projectile/P)
	drop_nade(O.density ? P.loc : O.loc)

/datum/ammo/rocket/on_hit_turf(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T)

/datum/ammo/rocket/do_at_max_range(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T)

/datum/ammo/rocket/he
	name = "high explosive rocket"
	icon_state = "rocket_he"
	hud_state = "rocket_he"
	accurate_range = 20
	max_range = 14
	damage = 150
	penetration = 100
	sundering = 100

/datum/ammo/rocket/he/drop_nade(turf/T)
	cell_explosion(T, 150, 40)

/datum/ammo/rocket/he/unguided
	damage = 100
	flags_ammo_behavior = AMMO_ROCKET|AMMO_SUNDERING // We want this one to specifically go over onscreen range.

/datum/ammo/rocket/he/unguided/drop_nade(turf/T)
	cell_explosion(T, 200, 50)

/datum/ammo/rocket/ap
	name = "kinetic penetrator"
	icon_state = "rocket_ap"
	hud_state = "rocket_ap"
	damage = 340
	accurate_range = 15
	penetration = 200
	sundering = 0

/datum/ammo/rocket/ap/drop_nade(turf/T)
	explosion(T, flash_range = 1)

/datum/ammo/rocket/ltb
	name = "cannon round"
	icon_state = "ltb"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET
	accurate_range = 15
	max_range = 40
	penetration = 50
	damage = 200
	hud_state = "bigshell_he"

/datum/ammo/rocket/ltb/drop_nade(turf/T)
	cell_explosion(T, 200, 45)

/datum/ammo/rocket/heavy_isg
	name = "15cm round"
	icon_state = "heavyrr"
	hud_state = "bigshell_he"
	hud_state_empty = "shell_empty"
	flags_ammo_behavior = AMMO_ROCKET|AMMO_EXPLOSIVE
	damage = 50
	penetration = 200
	max_range = 30
	shell_speed = 0.75
	accuracy = 30
	accurate_range = 21
	handful_amount = 1

/datum/ammo/rocket/heavy_isg/drop_nade(turf/T)
	cell_explosion(T, 700, 200) // dodge this

/datum/ammo/rocket/heavy_isg/unguided
	hud_state = "bigshell_he_unguided"
	flags_ammo_behavior = AMMO_ROCKET

/datum/ammo/bullet/heavy_isg_apfds
	name = "15cm APFDS round"
	icon_state = "apfds"
	hud_state = "bigshell_apfds"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_PASS_THROUGH_TURF|AMMO_PASS_THROUGH_MOVABLE
	damage = 200
	penetration = 75
	shell_speed = 7
	accurate_range = 24
	accurate_range_min = 6
	max_range = 35

/datum/ammo/bullet/isg_apfds/on_hit_turf(turf/T, obj/projectile/P)
	P.proj_max_range -= 5

/datum/ammo/bullet/isg_apfds/on_hit_mob(mob/M, obj/projectile/P)
	P.proj_max_range -= 2
	staggerstun(M, P, max_range = 20, slowdown = 0.5)

/datum/ammo/bullet/isg_apfds/on_hit_obj(obj/O, obj/projectile/P)
	P.proj_max_range -= 5

/datum/ammo/rocket/wp
	name = "white phosphorous rocket"
	icon_state = "rocket_wp"
	hud_state = "rocket_fire"
	flags_ammo_behavior = AMMO_ROCKET|AMMO_INCENDIARY|AMMO_EXPLOSIVE|AMMO_SUNDERING
	armor_type = FIRE
	damage_type = BURN
	accuracy_var_low = 7
	accurate_range = 15
	damage = 200
	penetration = 75
	max_range = 20
	sundering = 100
	///The radius for the non explosion effects
	var/effect_radius = 3

/datum/ammo/rocket/wp/drop_nade(turf/T)
	if(!T || !isturf(T))
		return
	playsound(T, 'sound/weapons/guns/fire/flamethrower2.ogg', 50, 1, 4)
	flame_radius(effect_radius, T, 27, 27, 27, 17)

/datum/ammo/rocket/wp/quad
	name = "thermobaric rocket"
	hud_state = "rocket_thermobaric"
	flags_ammo_behavior = AMMO_ROCKET
	damage = 40
	penetration = 25
	max_range = 30
	sundering = 2

	///The smoke system that the WP gas uses to spread.
	var/datum/effect_system/smoke_spread/smoke_system

/datum/ammo/rocket/wp/quad/set_smoke()
	smoke_system = new /datum/effect_system/smoke_spread/phosphorus()

/datum/ammo/rocket/wp/quad/drop_nade(turf/T)
	set_smoke()
	smoke_system.set_up(effect_radius, T)
	smoke_system.start()
	smoke_system = null
	T.visible_message(span_danger("The rocket explodes into white gas!") )
	playsound(T, 'sound/weapons/guns/fire/flamethrower2.ogg', 50, 1, 4)
	flame_radius(effect_radius, T, 27, 27, 27, 17)

/datum/ammo/rocket/wp/quad/som
	name = "white phosphorous RPG"
	hud_state = "rpg_fire"
	icon_state = "rpg_incendiary"
	flags_ammo_behavior = AMMO_ROCKET
	effect_radius = 5

/datum/ammo/rocket/wp/quad/ds
	name = "super thermobaric rocket"
	hud_state = "rocket_thermobaric"
	flags_ammo_behavior = AMMO_ROCKET
	damage = 200
	penetration = 75
	max_range = 30
	sundering = 100

/datum/ammo/rocket/wp/unguided
	damage = 100
	flags_ammo_behavior = AMMO_ROCKET|AMMO_INCENDIARY|AMMO_SUNDERING
	effect_radius = 5

/datum/ammo/rocket/recoilless
	name = "high explosive shell"
	icon_state = "recoilless_rifle_he"
	hud_state = "shell_he"
	hud_state_empty = "shell_empty"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_SUNDERING
	armor_type = BOMB
	damage_falloff = 0
	shell_speed = 2
	accurate_range = 20
	max_range = 30
	damage = 100
	penetration = 50
	sundering = 50

/datum/ammo/rocket/recoilless/drop_nade(turf/T)
	cell_explosion(T, 150, 75)

/datum/ammo/rocket/recoilless/heat
	name = "HEAT shell"
	icon_state = "recoilless_rifle_heat"
	hud_state = "shell_heat"
	flags_ammo_behavior = AMMO_ROCKET|AMMO_SUNDERING
	damage = 200
	penetration = 100
	sundering = 0

/datum/ammo/rocket/recoilless/heat/drop_nade(turf/T)
	explosion(T, flash_range = 1)

/datum/ammo/rocket/recoilless/heat/mech //for anti mech use in HvH
	name = "HEAM shell"
	accuracy = -10 //Not designed for anti human use
	flags_ammo_behavior = AMMO_ROCKET|AMMO_SUNDERING|AMMO_UNWIELDY

/datum/ammo/rocket/recoilless/heat/mech/on_hit_obj(obj/O, obj/projectile/P)
	drop_nade(get_turf(O))
	if(ismecha(O))
		P.damage *= 3 //this is specifically designed to hurt mechs

/datum/ammo/rocket/recoilless/heat/mech/drop_nade(turf/T)
	cell_explosion(T, 50, 45)

/datum/ammo/rocket/recoilless/light
	name = "light explosive shell"
	icon_state = "recoilless_rifle_le"
	hud_state = "shell_le"
	flags_ammo_behavior = AMMO_ROCKET|AMMO_SUNDERING //We want this to specifically go farther than onscreen range.
	accurate_range = 15
	max_range = 20
	damage = 75
	penetration = 50
	sundering = 25

/datum/ammo/rocket/recoilless/light/drop_nade(turf/T)
	cell_explosion(T, 75, 25)

/datum/ammo/rocket/recoilless/chemical
	name = "low velocity chemical shell"
	icon_state = "recoilless_rifle_smoke"
	hud_state = "shell_le"
	flags_ammo_behavior = AMMO_ROCKET|AMMO_SUNDERING|AMMO_IFF //We want this to specifically go farther than onscreen range and pass through friendlies.
	accurate_range = 21
	max_range = 21
	damage = 10
	penetration = 0
	sundering = 0
	/// Smoke type created when projectile detonates.
	var/datum/effect_system/smoke_spread/smoketype = /datum/effect_system/smoke_spread/bad
	/// Radius this smoke will encompass on detonation.
	var/smokeradius = 7

/datum/ammo/rocket/recoilless/chemical/drop_nade(turf/T)
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	playsound(T, 'sound/effects/smoke.ogg', 25, 1, 4)
	smoke.set_up(smokeradius, T, rand(5,9))
	smoke.start()
	explosion(T, flash_range = 1)

/datum/ammo/rocket/recoilless/chemical/cloak
	name = "low velocity chemical shell"
	icon_state = "recoilless_rifle_cloak"
	hud_state = "shell_cloak"
	smoketype = /datum/effect_system/smoke_spread/tactical

/datum/ammo/rocket/recoilless/chemical/plasmaloss
	name = "low velocity chemical shell"
	icon_state = "recoilless_rifle_tanglefoot"
	hud_state = "shell_tanglefoot"
	smoketype = /datum/effect_system/smoke_spread/plasmaloss

/datum/ammo/rocket/recoilless/low_impact
	name = "low impact explosive shell"
	icon_state = "recoilless_rifle_le"
	hud_state = "shell_le"
	flags_ammo_behavior = AMMO_ROCKET|AMMO_SUNDERING //We want this to specifically go farther than onscreen range.
	accurate_range = 15
	max_range = 20
	damage = 75
	penetration = 15
	sundering = 25

/datum/ammo/rocket/recoilless/low_impact/drop_nade(turf/T)
	cell_explosion(T, 100, 15)

/datum/ammo/rocket/oneuse
	name = "explosive rocket"
	damage = 100
	penetration = 100
	sundering = 100
	max_range = 30

/datum/ammo/rocket/oneuse/drop_nade(turf/T)
	cell_explosion(T, 115, 45)

/datum/ammo/rocket/som
	name = "high explosive RPG"
	icon_state = "rpg_he"
	hud_state = "rpg_he"
	flags_ammo_behavior = AMMO_ROCKET|AMMO_SUNDERING
	accurate_range = 15
	max_range = 20
	damage = 80
	penetration = 20
	sundering = 20

/datum/ammo/rocket/som/drop_nade(turf/T)
	cell_explosion(T, 175, 35)

/datum/ammo/rocket/som/light
	name = "low impact RPG"
	icon_state = "rpg_le"
	hud_state = "rpg_le"
	flags_ammo_behavior = AMMO_ROCKET|AMMO_SUNDERING
	accurate_range = 15
	damage = 60
	penetration = 10

/datum/ammo/rocket/som/light/drop_nade(turf/T)
	cell_explosion(T, 125, 15)

/datum/ammo/rocket/som/thermobaric
	name = "thermobaric RPG"
	icon_state = "rpg_thermobaric"
	hud_state = "rpg_thermobaric"
	damage = 30

/datum/ammo/rocket/som/thermobaric/drop_nade(turf/T)
	cell_explosion(T, 175, 45)
	flame_radius(4, T)

/datum/ammo/rocket/som/heat //Anti tank, or mech
	name = "HEAT RPG"
	icon_state = "rpg_heat"
	hud_state = "rpg_heat"
	damage = 200
	penetration = 100
	sundering = 0
	accuracy = -10 //Not designed for anti human use
	flags_ammo_behavior = AMMO_ROCKET|AMMO_SUNDERING|AMMO_UNWIELDY

/datum/ammo/rocket/som/heat/on_hit_obj(obj/O, obj/projectile/P)
	drop_nade(get_turf(O))
	if(ismecha(O))
		P.damage *= 3 //this is specifically designed to hurt mechs

/datum/ammo/rocket/som/heat/drop_nade(turf/T)
	cell_explosion(T, 50, 45)

/datum/ammo/rocket/som/rad
	name = "irrad RPG"
	icon_state = "rpg_rad"
	hud_state = "rpg_rad"
	damage = 50
	penetration = 10
	///Base strength of the rad effects
	var/rad_strength = 25
	///Range for the maximum rad effects
	var/inner_range = 3
	///Range for the moderate rad effects
	var/mid_range = 5
	///Range for the minimal rad effects
	var/outer_range = 8

/datum/ammo/rocket/som/rad/drop_nade(turf/T)
	playsound(T, 'sound/effects/portal_opening.ogg', 50, 1)
	for(var/mob/living/victim in hearers(outer_range, T))
		var/strength
		var/sound_level
		if(get_dist(victim, T) <= inner_range)
			strength = rad_strength
			sound_level = 4
		else if(get_dist(victim, T) <= mid_range)
			strength = rad_strength * 0.7
			sound_level = 3
		else
			strength = rad_strength * 0.3
			sound_level = 2

		strength = victim.modify_by_armor(strength, BIO, 25)
		victim.apply_radiation(strength, sound_level)

	explosion(T, weak_impact_range = 4)

/datum/ammo/rocket/atgun_shell
	name = "high explosive ballistic cap shell"
	icon_state = "atgun"
	hud_state = "shell_heat"
	hud_state_empty = "shell_empty"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_SUNDERING|AMMO_PASS_THROUGH_TURF
	shell_speed = 2
	damage = 90
	penetration = 30
	sundering = 25
	max_range = 30
	handful_amount = 1

/datum/ammo/rocket/atgun_shell/drop_nade(turf/T)
	cell_explosion(T, 55 , 30)

/datum/ammo/rocket/atgun_shell/on_hit_turf(turf/T, obj/projectile/P) //no explosion every time it hits a turf
	P.proj_max_range -= 10

/datum/ammo/rocket/atgun_shell/apcr
	name = "tungsten penetrator"
	hud_state = "shell_apcr"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING|AMMO_PASS_THROUGH_TURF|AMMO_PASS_THROUGH_MOVABLE
	shell_speed = 4
	damage = 200
	penetration = 70
	sundering = 25

/datum/ammo/rocket/atgun_shell/apcr/drop_nade(turf/T)
	explosion(T, flash_range = 1)

/datum/ammo/rocket/atgun_shell/apcr/on_hit_mob(mob/M, obj/projectile/P)
	drop_nade(get_turf(M))
	P.proj_max_range -= 5
	staggerstun(M, P, max_range = 20, stagger = 1 SECONDS, slowdown = 0.5, knockback = 2, hard_size_threshold = 3)

/datum/ammo/rocket/atgun_shell/apcr/on_hit_obj(obj/O, obj/projectile/P)
	P.proj_max_range -= 5

/datum/ammo/rocket/atgun_shell/apcr/on_hit_turf(turf/T, obj/projectile/P)
	P.proj_max_range -= 5

/datum/ammo/rocket/atgun_shell/he
	name = "low velocity high explosive shell"
	hud_state = "shell_he"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_SUNDERING
	damage = 50
	penetration = 50
	sundering = 35

/datum/ammo/rocket/atgun_shell/he/drop_nade(turf/T)
	cell_explosion(T, 90, 30)

/datum/ammo/rocket/atgun_shell/he/on_hit_turf(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T)

/datum/ammo/rocket/atgun_shell/beehive
	name = "beehive shell"
	hud_state = "shell_le"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_SUNDERING
	shell_speed = 3
	damage = 30
	penetration = 30
	sundering = 5
	bonus_projectiles_type = /datum/ammo/bullet/atgun_spread
	bonus_projectiles_scatter = 8
	var/bonus_projectile_quantity = 10

/datum/ammo/rocket/atgun_shell/beehive/drop_nade(turf/T)
	explosion(T, flash_range = 1)

/datum/ammo/rocket/atgun_shell/beehive/on_hit_mob(mob/M, obj/projectile/proj)
	staggerstun(M, proj, slowdown = 0.2, knockback = 1)
	drop_nade(get_turf(M))
	playsound(proj, sound(get_sfx("explosion_micro")), 30, falloff = 5)
	fire_directionalburst(proj, proj.firer, proj.shot_from, bonus_projectile_quantity, 5, 3, Get_Angle(proj.firer, M) )

/datum/ammo/rocket/atgun_shell/beehive/on_hit_obj(obj/O, obj/projectile/proj)
	playsound(proj, sound(get_sfx("explosion_micro")), 30, falloff = 5)
	fire_directionalburst(proj, proj.firer, proj.shot_from, bonus_projectile_quantity, 5, 3, Get_Angle(proj.firer, O) )

/datum/ammo/rocket/atgun_shell/beehive/on_hit_turf(turf/T, obj/projectile/proj)
	playsound(proj, sound(get_sfx("explosion_micro")), 30, falloff = 5)
	fire_directionalburst(proj, proj.firer, proj.shot_from, bonus_projectile_quantity, 5, 3, Get_Angle(proj.firer, T) )

/datum/ammo/rocket/atgun_shell/beehive/do_at_max_range(turf/T, obj/projectile/proj)
	playsound(proj, sound(get_sfx("explosion_micro")), 30, falloff = 5)
	fire_directionalburst(proj, proj.firer, proj.shot_from, bonus_projectile_quantity, 5, 3, Get_Angle(proj.firer, get_turf(proj)) )

/datum/ammo/rocket/atgun_shell/beehive/incend
	name = "napalm shell"
	hud_state = "shell_heat"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_SUNDERING
	shell_speed = 3
	bonus_projectiles_type = /datum/ammo/bullet/atgun_spread/incendiary

/datum/ammo/rocket/toy
	name = "\improper toy rocket"
	damage = 1

/datum/ammo/rocket/toy/on_hit_mob(mob/M,obj/projectile/P)
	to_chat(M, "<font size=6 color=red>NO BUGS</font>")

/datum/ammo/rocket/toy/on_hit_obj(obj/O,obj/projectile/P)
	return

/datum/ammo/rocket/toy/on_hit_turf(turf/T,obj/projectile/P)
	return

/datum/ammo/rocket/toy/do_at_max_range(turf/T, obj/projectile/P)
	return
