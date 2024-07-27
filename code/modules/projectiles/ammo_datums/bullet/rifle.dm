/datum/ammo/bullet/rifle
	name = "rifle bullet"
	hud_state = "rifle"
	hud_state_empty = "rifle_empty"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING
	accurate_range = 12
	damage = 25
	penetration = 5
	sundering = 0.5

/datum/ammo/bullet/rifle/T25
	name = "smartmachinegun bullet"
	bullet_color = COLOR_SOFT_RED //Red bullets to indicate friendly fire restriction
	hud_state = "smartgun"
	hud_state_empty = "smartgun_empty"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING
	accurate_range = 20
	damage = 20
	penetration = 10
	sundering = 1.5

/datum/ammo/bullet/rifle/ap
	name = "armor-piercing rifle bullet"
	hud_state = "rifle_ap"
	damage = 20
	penetration = 25
	sundering = 3

/datum/ammo/bullet/rifle/hv
	name = "high-velocity rifle bullet"
	hud_state = "hivelo"
	damage = 20
	penetration = 20
	sundering = 1.25

/datum/ammo/bullet/rifle/heavy
	name = "heavy rifle bullet"
	hud_state = "rifle_heavy"
	damage = 30
	penetration = 10
	sundering = 1.25

/datum/ammo/bullet/rifle/heavy/ap
	name = "heavy rifle bullet"
	damage = 25
	penetration = 25
	sundering = 3.5

/datum/ammo/bullet/rifle/repeater
	name = "heavy impact rifle bullet"
	hud_state = "sniper"
	damage = 70
	penetration = 20
	sundering = 1.25

/datum/ammo/bullet/rifle/repeater/on_hit_mob(mob/M, obj/projectile/P)
	staggerstun(M, P, max_range = 3, slowdown = 2, stagger = 1 SECONDS)

/datum/ammo/bullet/rifle/incendiary
	name = "incendiary rifle bullet"
	hud_state = "rifle_fire"
	damage_type = BURN
	shrapnel_chance = 0
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_INCENDIARY
	accuracy = -10

/datum/ammo/bullet/rifle/machinegun
	name = "machinegun bullet"
	hud_state = "rifle_heavy"
	damage = 25
	penetration = 10
	sundering = 0.75

/datum/ammo/bullet/rifle/som_machinegun
	name = "machinegun bullet"
	hud_state = "rifle_heavy"
	damage = 28
	penetration = 12.5
	sundering = 1

/datum/ammo/bullet/rifle/som_machinegun/on_hit_mob(mob/M, obj/projectile/P)
	staggerstun(M, P, max_range = 20, slowdown = 0.5)

/datum/ammo/bullet/rifle/tx8
	name = "A19 high velocity bullet"
	hud_state = "hivelo"
	hud_state_empty = "hivelo_empty"
	damage_falloff = 0
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING
	accurate_range = 15
	damage = 40
	penetration = 20
	sundering = 10
	bullet_color = COLOR_SOFT_RED

/datum/ammo/bullet/rifle/tx8/incendiary
	name = "high velocity incendiary bullet"
	hud_state = "hivelo_fire"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_INCENDIARY|AMMO_SUNDERING|AMMO_PASS_THROUGH_MOB
	damage = 25
	penetration = 20
	sundering = 2.5
	bullet_color = LIGHT_COLOR_FIRE

/datum/ammo/bullet/rifle/tx8/impact
	name = "high velocity impact bullet"
	hud_state = "hivelo_impact"
	damage = 30
	penetration = 10
	sundering = 12.5

/datum/ammo/bullet/rifle/tx8/impact/on_hit_mob(mob/M, obj/projectile/P)
	staggerstun(M, P, max_range = 14, slowdown = 1, knockback = 1)

/datum/ammo/bullet/rifle/mpi_km
	name = "crude heavy rifle bullet"
	hud_state = "rifle_crude"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING
	damage = 30
	penetration = 15
	sundering = 1.75

/datum/ammo/bullet/rifle/standard_dmr
	name = "marksman bullet"
	hud_state = "hivelo"
	hud_state_empty = "hivelo_empty"
	damage_falloff = 0.5
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING
	accurate_range = 25
	accurate_range_min = 6
	max_range = 40
	damage = 65
	penetration = 15
	sundering = 2

/datum/ammo/bullet/rifle/garand
	name = "heavy marksman bullet"
	hud_state = "sniper"
	damage = 75
	penetration = 25
	sundering = 1.25

/datum/ammo/bullet/rifle/standard_br
	name = "light marksman bullet"
	hud_state = "hivelo"
	hud_state_empty = "hivelo_empty"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING
	penetration = 15
	damage = 32.5
	sundering = 1.25

/datum/ammo/bullet/rifle/standard_br/ap
	name = "light marksman armor piercing bullet"
	penetration = 25
	damage = 27.5
	sundering = 3.25

/datum/ammo/bullet/rifle/icc_confrontationrifle
	name = "armor-piercing heavy rifle bullet"
	hud_state = "rifle_ap"
	damage = 50
	penetration = 40
	sundering = 3.5

/datum/ammo/bullet/smarttargetrifle
	name = "smart marksman bullet"
	bullet_color = COLOR_SOFT_RED //Red bullets to indicate friendly fire restriction
	hud_state = "smartgun"
	hud_state_empty = "smartgun_empty"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING
	damage = 40
	max_range = 40
	penetration = 30
	sundering = 3
	shell_speed = 4
	damage_falloff = 0.5
	accurate_range = 25
	accurate_range_min = 3

/datum/ammo/bullet/spottingrifle
	name = "smart spotting bullet"
	bullet_color = COLOR_SOFT_RED //Red bullets to indicate friendly fire restriction
	hud_state = "spotrifle"
	hud_state_empty = "smartgun_empty"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING
	damage = 50
	penetration = 25
	sundering = 5
	shell_speed = 4
	accurate_range = 12
	max_range = 12

/datum/ammo/bullet/spottingrifle/highimpact
	name = "smart high-impact spotting bullet"
	hud_state = "spotrifle_impact"
	damage = 10
	sundering = 0.5

/datum/ammo/bullet/spottingrifle/highimpact/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, stagger = 1 SECONDS, slowdown = 1, max_range = 12)

/datum/ammo/bullet/spottingrifle/heavyrubber
	name = "smart heavy-rubber spotting bullet"
	hud_state = "spotrifle_rubber"
	damage = 10
	sundering = 0.5

/datum/ammo/bullet/spottingrifle/heavyrubber/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, slowdown = 3, max_range = 12)

/datum/ammo/bullet/spottingrifle/plasmaloss
	name = "smart tanglefoot spotting bullet"
	hud_state = "spotrifle_plasmaloss"
	damage = 10
	sundering = 0.5
	var/datum/effect_system/smoke_spread/smoke_system

/datum/ammo/bullet/spottingrifle/plasmaloss/on_hit_mob(mob/living/victim, obj/projectile/proj)
	if(isxeno(victim))
		var/mob/living/carbon/xenomorph/X = victim
		X.use_plasma(20 + 0.2 * X.xeno_caste.plasma_max * X.xeno_caste.plasma_regen_limit) // This is draining 20%+20 flat per hit.
	var/datum/effect_system/smoke_spread/plasmaloss/S = new
	S.set_up(0, victim, 3)
	S.start()

/datum/ammo/bullet/spottingrifle/plasmaloss/on_hit_obj(obj/O, obj/projectile/P)
	var/turf/T = get_turf(O)
	drop_tg_smoke(T.density ? P.loc : T)

/datum/ammo/bullet/spottingrifle/plasmaloss/on_hit_turf(turf/T, obj/projectile/P)
	drop_tg_smoke(T.density ? P.loc : T)

/datum/ammo/bullet/spottingrifle/plasmaloss/do_at_max_range(turf/T, obj/projectile/P)
	drop_tg_smoke(T.density ? P.loc : T)

/datum/ammo/bullet/spottingrifle/plasmaloss/set_smoke()
	smoke_system = new /datum/effect_system/smoke_spread/plasmaloss()

/datum/ammo/bullet/spottingrifle/plasmaloss/proc/drop_tg_smoke(turf/T)
	if(T.density)
		return

	set_smoke()
	smoke_system.set_up(0, T, 3)
	smoke_system.start()
	smoke_system = null

/datum/ammo/bullet/spottingrifle/tungsten
	name = "smart tungsten spotting bullet"
	hud_state = "spotrifle_tungsten"
	damage = 10
	sundering = 0.5

/datum/ammo/bullet/spottingrifle/tungsten/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, weaken = 2 SECONDS, stagger = 0.5 SECONDS, knockback = 1, max_range = 12)

/datum/ammo/bullet/spottingrifle/flak
	name = "smart flak spotting bullet"
	hud_state = "spotrifle_flak"
	damage = 60
	sundering = 0.5
	airburst_multiplier = 0.5

/datum/ammo/bullet/spottingrifle/flak/on_hit_mob(mob/victim, obj/projectile/proj)
	airburst(victim, proj)

/datum/ammo/bullet/spottingrifle/incendiary
	name = "smart incendiary spotting  bullet"
	hud_state = "spotrifle_incend"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_INCENDIARY
	damage_type = BURN
	damage = 10
	sundering = 0.5

/datum/ammo/bullet/railgun
	name = "armor piercing railgun slug"
	hud_state = "railgun_ap"
	icon_state = "blue_bullet"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING|AMMO_PASS_THROUGH_TURF|AMMO_PASS_THROUGH_MOVABLE
	shell_speed = 4
	max_range = 14
	damage = 150
	penetration = 100
	sundering = 20
	bullet_color = COLOR_PULSE_BLUE
	on_pierce_multiplier = 0.85

/datum/ammo/bullet/railgun/on_hit_mob(mob/M, obj/projectile/P)
	staggerstun(M, P, weaken = 2 SECONDS, stagger = 4 SECONDS, slowdown = 2, knockback = 2)

/datum/ammo/bullet/railgun/hvap
	name = "high velocity railgun slug"
	hud_state = "railgun_hvap"
	shell_speed = 5
	max_range = 21
	damage = 100
	penetration = 30
	sundering = 50

/datum/ammo/bullet/railgun/hvap/on_hit_mob(mob/M, obj/projectile/P)
	staggerstun(M, P, stagger = 2 SECONDS, knockback = 3)

/datum/ammo/bullet/railgun/smart
	name = "smart armor piercing railgun slug"
	hud_state = "railgun_smart"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING|AMMO_PASS_THROUGH_TURF|AMMO_PASS_THROUGH_MOVABLE|AMMO_IFF
	damage = 100
	penetration = 20
	sundering = 20

/datum/ammo/bullet/railgun/smart/on_hit_mob(mob/M, obj/projectile/P)
	staggerstun(M, P, stagger = 3 SECONDS, slowdown = 3)

/datum/ammo/bullet/coilgun
	name = "high-velocity tungsten slug"
	hud_state = "railgun_ap"
	icon_state = "blue_bullet"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING|AMMO_PASS_THROUGH_MOVABLE
	shell_speed = 5
	max_range = 31
	damage = 70
	penetration = 35
	sundering = 5
	bullet_color = COLOR_PULSE_BLUE
	on_pierce_multiplier = 0.85

/datum/ammo/bullet/coilgun/on_hit_mob(mob/M, obj/projectile/P)
	staggerstun(M, P, weaken = 0.2 SECONDS, slowdown = 1, knockback = 3)
