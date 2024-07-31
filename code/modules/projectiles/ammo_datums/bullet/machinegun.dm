/datum/ammo/bullet/machinegun //Adding this for the MG Nests (~Art)
	name = "machinegun bullet"
	icon_state = "bullet" // Keeping it bog standard with the turret but allows it to be changed.
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING
	hud_state = "minigun"
	hud_state_empty = "smartgun_empty"
	accurate_range = 12
	damage = 40 //Reduced damage due to vastly increased mobility
	penetration = 40 //Reduced penetration due to vastly increased mobility
	accuracy = 5
	barricade_clear_distance = 2
	sundering = 5

/datum/ammo/bullet/minigun
	name = "minigun bullet"
	hud_state = "minigun"
	hud_state_empty = "smartgun_empty"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING
	accuracy_var_low = 3
	accuracy_var_high = 3
	accurate_range = 5
	damage = 25
	penetration = 15
	shrapnel_chance = 25
	sundering = 2.5

/datum/ammo/bullet/minigun/ltaap
	name = "chaingun bullet"
	damage = 30
	penetration = 10
	sundering = 0
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_IFF
	damage_falloff = 2
	accuracy = 80

/datum/ammo/bullet/auto_cannon
	name = "autocannon high-velocity bullet"
	hud_state = "minigun"
	hud_state_empty = "smartgun_empty"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING|AMMO_PASS_THROUGH_TURF|AMMO_PASS_THROUGH_MOVABLE
	accurate_range_min = 6
	accuracy_var_low = 3
	accuracy_var_high = 3
	damage = 30
	penetration = 50
	sundering = 1
	max_range = 35
	///Bonus flat damage to walls, balanced around resin walls.
	var/autocannon_wall_bonus = 20

/datum/ammo/bullet/auto_cannon/on_hit_turf(turf/T, obj/projectile/P)
	P.proj_max_range -= 20

	if(istype(T, /turf/closed/wall))
		var/turf/closed/wall/wall_victim = T
		wall_victim.take_damage(autocannon_wall_bonus, P.damtype, P.armor_type)

/datum/ammo/bullet/auto_cannon/on_hit_mob(mob/M, obj/projectile/P)
	P.proj_max_range -= 5
	staggerstun(M, P, max_range = 20, slowdown = 1)

/datum/ammo/bullet/auto_cannon/on_hit_obj(obj/O, obj/projectile/P)
	P.proj_max_range -= 5

/datum/ammo/bullet/auto_cannon/flak
	name = "autocannon smart-detonating bullet"
	hud_state = "sniper_flak"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING|AMMO_EXPLOSIVE
	damage = 50
	penetration = 30
	sundering = 5
	max_range = 30
	airburst_multiplier = 1
	autocannon_wall_bonus = 5

/datum/ammo/bullet/auto_cannon/flak/on_hit_mob(mob/victim, obj/projectile/proj)
	airburst(victim, proj)

/datum/ammo/bullet/auto_cannon/do_at_max_range(turf/T, obj/projectile/proj)
	airburst(T, proj)

/datum/ammo/bullet/cupola
	name = "cupola bullet"
	bullet_color = COLOR_SOFT_RED //Red bullets to indicate friendly fire restriction
	hud_state = "smartgun"
	hud_state_empty = "smartgun_empty"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING|AMMO_IFF
	accurate_range = 12
	damage = 30
	penetration = 10
	sundering = 1

/datum/ammo/bullet/smartmachinegun
	name = "smartmachinegun bullet"
	bullet_color = COLOR_SOFT_RED //Red bullets to indicate friendly fire restriction
	hud_state = "smartgun"
	hud_state_empty = "smartgun_empty"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING
	accurate_range = 12
	damage = 20
	penetration = 15
	sundering = 2

/datum/ammo/bullet/smart_minigun
	name = "smartminigun bullet"
	bullet_color = COLOR_SOFT_RED //Red bullets to indicate friendly fire restriction
	hud_state = "smartgun_minigun"
	hud_state_empty = "smartgun_empty"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SUNDERING
	accurate_range = 12
	damage = 10
	penetration = 25
	sundering = 1
	damage_falloff = 0.1
