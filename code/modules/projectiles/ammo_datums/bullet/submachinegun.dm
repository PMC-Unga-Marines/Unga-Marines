/datum/ammo/bullet/smg
	name = "submachinegun bullet"
	hud_state = "smg"
	hud_state_empty = "smg_empty"
	ammo_behavior_flags = AMMO_BALLISTIC
	accuracy_var_low = 7
	accuracy_var_high = 7
	damage = 20
	accurate_range = 4
	damage_falloff = 1
	additional_xeno_penetration = 10
	penetration = 5
	matter_cost = 2

/datum/ammo/bullet/smg/ap
	name = "armor-piercing submachinegun bullet"
	hud_state = "smg_ap"
	damage = 15
	penetration = 30
	additional_xeno_penetration = 20
	matter_cost = 0

/datum/ammo/bullet/smg/ap/hv
	name = "high velocity armor-piercing submachinegun bullet"
	shell_speed = 4

/datum/ammo/bullet/smg/hollow
	name = "hollow-point submachinegun bullet"
	hud_state = "pistol_squash"
	ammo_behavior_flags = AMMO_BALLISTIC
	damage = 35
	penetration = 0
	damage_falloff = 3
	shrapnel_chance = 45

/datum/ammo/bullet/smg/incendiary
	name = "incendiary submachinegun bullet"
	hud_state = "smg_fire"
	ammo_behavior_flags = AMMO_BALLISTIC|AMMO_INCENDIARY
	damage = 18
	penetration = 0
	matter_cost = 0

/datum/ammo/bullet/smg/rad
	name = "radioactive submachinegun bullet"
	hud_state = "smg_rad"
	damage = 15
	penetration = 15
	sundering = 1

/datum/ammo/bullet/smg/rad/on_hit_mob(mob/target_mob, atom/movable/projectile/proj)
	if(!isliving(target_mob))
		return
	var/mob/living/living_victim = target_mob
	if(!prob(living_victim.modify_by_armor(proj.damage, BIO, penetration, proj.def_zone)))
		return
	living_victim.apply_radiation(2, 2)

/datum/ammo/bullet/smg/heavy
	name = "heavy submachinegun bullet"
	damage = 27.5
	penetration = 10
	additional_xeno_penetration = 15
	matter_cost = 5

/datum/ammo/bullet/smg/squash
	name = "squash-head submachinegun bullet"
	hud_state = "pistol_squash"
	ammo_behavior_flags = AMMO_BALLISTIC
	damage = 15
	penetration = 15
	armor_type = BOMB
	additional_xeno_penetration = 15
	damage_falloff = 2
	shrapnel_chance = 0
	matter_cost = 8
	///shatter effection duration when hitting mobs
	var/shatter_duration = 3 SECONDS

/datum/ammo/bullet/smg/squash/on_hit_mob(mob/target_mob, atom/movable/proj)
	if(!isliving(target_mob))
		return

	var/mob/living/living_victim = target_mob
	living_victim.apply_status_effect(STATUS_EFFECT_SHATTER, shatter_duration)

/datum/ammo/bullet/smg/heavy/incendiary
	name = "incendiary submachinegun bullet"
	hud_state = "smg_fire"
	ammo_behavior_flags = AMMO_BALLISTIC|AMMO_INCENDIARY
	damage = 25
	penetration = 0
	matter_cost = 0
