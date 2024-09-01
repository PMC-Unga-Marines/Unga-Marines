/datum/ammo/bullet/revolver
	name = "revolver bullet"
	hud_state = "revolver"
	hud_state_empty = "revolver_empty"
	handful_amount = 7
	flags_ammo_behavior = AMMO_BALLISTIC
	damage = 40
	penetration = 10
	additional_xeno_penetration = 20

/datum/ammo/bullet/revolver/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, stagger = 2 SECONDS, slowdown = 0.5, knockback = 1)

/datum/ammo/bullet/revolver/rifle
	name = ".44 Long Special bullet"
	hud_state = "revolver_impact"
	handful_amount = 8
	damage = 55
	penetration = 30
	additional_xeno_penetration = 10
	damage_falloff = 0
	shell_speed = 3.5

/datum/ammo/bullet/revolver/t500
	name = ".500 Nigro Express revolver bullet"
	handful_icon_state = "nigro"
	handful_amount = 5
	damage = 100
	penetration = 40
	additional_xeno_penetration = 0

/datum/ammo/bullet/revolver/t500/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, stagger = 0, slowdown = 0, knockback = 2)

/datum/ammo/bullet/revolver/t500/slavs
	name = ".500 'Slavs' revolver bullet"
	handful_icon_state = "nigro_sv"

/datum/ammo/bullet/revolver/t500/slavs/on_hit_mob(mob/M, obj/projectile/P)
	staggerstun(M, P, weaken = 2 SECONDS, knockback = 1)

/datum/ammo/bullet/revolver/t500/qk
	name = ".500 'Queen Killer' revolver bullet"
	handful_icon_state = "nigro_qk"

/datum/ammo/bullet/revolver/t500/qk/on_hit_mob(mob/M,obj/projectile/P)
	if(isxenoqueen(M))
		var/mob/living/carbon/xenomorph/X = M
		X.apply_damage(40)
		staggerstun(M, P, stagger = 0, slowdown = 0, knockback = 0)
		to_chat(X, span_highdanger("Something burn inside you!"))
		return
	staggerstun(M, P, stagger = 0, slowdown = 0, knockback = 1)

/datum/ammo/bullet/revolver/r44
	name = "standard revolver bullet"
	damage = 35
	penetration = 15
	additional_xeno_penetration = 10

/datum/ammo/bullet/revolver/r44/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, knockback = 1)

/datum/ammo/bullet/revolver/small
	name = "small revolver bullet"
	hud_state = "revolver_small"
	damage = 30

/datum/ammo/bullet/revolver/small/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, slowdown = 0.5)

/datum/ammo/bullet/revolver/marksman
	name = "slimline revolver bullet"
	hud_state = "revolver_slim"
	shrapnel_chance = 0
	damage_falloff = 0
	accuracy = 15
	accurate_range = 15
	damage = 25
	penetration = 10
	additional_xeno_penetration = 20

/datum/ammo/bullet/revolver/judge
	name = "oversized revolver bullet"
	hud_state = "revolver_slim"
	shrapnel_chance = 0
	damage_falloff = 0
	accuracy = 15
	accurate_range = 15
	damage = 60
	penetration = 10
	additional_xeno_penetration = 15

/datum/ammo/bullet/revolver/heavy
	name = "heavy revolver bullet"
	hud_state = "revolver_heavy"
	damage = 42.5
	penetration = 5
	accuracy = -10
	additional_xeno_penetration = 17.5

/datum/ammo/bullet/revolver/t76
	name = "magnum bullet"
	handful_amount = 5
	damage = 100
	penetration = 40
	additional_xeno_penetration = 0

/datum/ammo/bullet/revolver/t76/on_hit_mob(mob/M, obj/projectile/P)
	staggerstun(M, P, weaken = 2 SECONDS, knockback = 1)

/datum/ammo/bullet/revolver/highimpact
	name = "high-impact revolver bullet"
	hud_state = "revolver_impact"
	handful_amount = 6
	damage = 45
	penetration = 20
	additional_xeno_penetration = 15

/datum/ammo/bullet/revolver/highimpact/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, weaken = 2 SECONDS, stagger = 2 SECONDS, slowdown = 1, knockback = 1)

/datum/ammo/bullet/revolver/ricochet
	bonus_projectiles_type = /datum/ammo/bullet/revolver/small
	bonus_projectiles_scatter = 0

/datum/ammo/bullet/revolver/ricochet/one
	bonus_projectiles_type = /datum/ammo/bullet/revolver/ricochet

/datum/ammo/bullet/revolver/ricochet/two
	bonus_projectiles_type = /datum/ammo/bullet/revolver/ricochet/one

/datum/ammo/bullet/revolver/ricochet/three
	bonus_projectiles_type = /datum/ammo/bullet/revolver/ricochet/two

/datum/ammo/bullet/revolver/ricochet/four
	bonus_projectiles_type = /datum/ammo/bullet/revolver/ricochet/three

/datum/ammo/bullet/revolver/ricochet/on_hit_mob(mob/M,obj/projectile/P)
	staggerstun(M, P, slowdown = 0.5)

/datum/ammo/bullet/revolver/ricochet/on_hit_turf(turf/T, obj/projectile/proj)
	reflect(T, proj, 10)
