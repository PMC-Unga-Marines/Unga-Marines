/datum/ammo/bullet/sniper
	name = "sniper bullet"
	hud_state = "sniper"
	hud_state_empty = "sniper_empty"
	damage_falloff = 0
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SNIPER
	accurate_range_min = 7
	shell_speed = 4
	accurate_range = 30
	max_range = 40
	damage = 90
	penetration = 50
	sundering = 15

/datum/ammo/bullet/sniper/incendiary
	name = "incendiary sniper bullet"
	hud_state = "sniper_fire"
	accuracy = 0
	damage_type = BURN
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_INCENDIARY|AMMO_SNIPER
	accuracy_var_high = 7
	max_range = 20
	damage = 70
	penetration = 30
	sundering = 5

/datum/ammo/bullet/sniper/flak
	name = "flak sniper bullet"
	hud_state = "sniper_flak"
	damage = 90
	penetration = 0
	sundering = 15
	airburst_multiplier = 0.5

/datum/ammo/bullet/sniper/flak/on_hit_mob(mob/victim, obj/projectile/proj)
	staggerstun(victim, proj,  max_range = 30, slowdown = 2)
	airburst(victim, proj)

/datum/ammo/bullet/sniper/svd
	name = "crude sniper bullet"
	handful_icon_state = "crude sniper bullet"
	hud_state = "sniper_crude"
	handful_amount = 5
	damage = 70
	penetration = 35
	sundering = 0
	additional_xeno_penetration = 15
	///shatter effection duration when hitting mobs
	var/shatter_duration = 8 SECONDS

/datum/ammo/bullet/sniper/svd/on_hit_mob(mob/M, obj/projectile/proj)
	if(!isliving(M))
		return

	var/mob/living/living_victim = M
	living_victim.apply_status_effect(STATUS_EFFECT_SHATTER, shatter_duration)

/datum/ammo/bullet/sniper/martini
	name = "crude heavy sniper bullet"
	handful_icon_state = "crude heavy sniper bullet"
	hud_state = "sniper_crude"
	handful_amount = 5
	flags_ammo_behavior = AMMO_BALLISTIC
	damage = 100
	penetration = 20
	additional_xeno_penetration = 30
	sundering = 0
	accurate_range_min = 0

/datum/ammo/bullet/sniper/martini/on_hit_mob(mob/M, obj/projectile/P)
	staggerstun(M, P, weaken = 0.5 SECONDS, stagger = 1 SECONDS, knockback = 2, slowdown = 0.5, max_range = 12)

/datum/ammo/bullet/sniper/martini/white
	handful_icon_state = "crude heavy sniper bullet white"
	///shatter effection duration when hitting mobs
	var/shatter_duration = 8 SECONDS

/datum/ammo/bullet/sniper/martini/white/on_hit_mob(mob/M, obj/projectile/proj)
	if(!isliving(M))
		return

	var/mob/living/living_victim = M
	living_victim.apply_status_effect(STATUS_EFFECT_SHATTER, shatter_duration)

/datum/ammo/bullet/sniper/elite
	name = "supersonic sniper bullet"
	hud_state = "sniper_supersonic"
	flags_ammo_behavior = AMMO_BALLISTIC
	accuracy = 20
	damage = 100
	penetration = 60
	sundering = 50

/datum/ammo/bullet/sniper/pfc
	name = "high caliber rifle bullet"
	hud_state = "sniper_heavy"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SNIPER
	damage = 80
	penetration = 30
	sundering = 0
	additional_xeno_penetration = 0
	damage_falloff = 0.25

/datum/ammo/bullet/sniper/pfc/on_hit_mob(mob/M, obj/projectile/P)
	staggerstun(M, P, slowdown = 1, max_range = 17)

/datum/ammo/bullet/sniper/pfc/flak
	name = "high caliber flak rifle bullet"
	hud_state = "sniper_heavy_flak"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SNIPER
	damage = 40
	penetration = 10
	additional_xeno_penetration = 0
	sundering = 10
	damage_falloff = 0.25

/datum/ammo/bullet/sniper/pfc/flak/on_hit_mob(mob/M, obj/projectile/P)
	staggerstun(M, P, knockback = 4, slowdown = 1.5, stagger = 2 SECONDS, max_range = 17)

/datum/ammo/bullet/sniper/auto
	name = "high caliber rifle bullet"
	hud_state = "sniper_auto"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SNIPER
	damage = 50
	penetration = 30
	sundering = 2
	damage_falloff = 0.25

/datum/ammo/bullet/sniper/clf_heavyrifle
	name = "high velocity incendiary sniper bullet"
	handful_icon_state = "ptrs"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_INCENDIARY|AMMO_SNIPER
	hud_state = "sniper_fire"
	accurate_range_min = 4
	shell_speed = 5
	damage = 120
	penetration = 60
	sundering = 20
