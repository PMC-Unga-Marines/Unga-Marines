//Only when things screw up do we use this as a placeholder.
/datum/ammo/bullet
	name = "default bullet"
	icon_state = "bullet"
	ammo_behavior_flags = AMMO_BALLISTIC
	sound_hit = SFX_BALLISTIC_HIT
	sound_armor = SFX_BALLISTIC_ARMOR
	sound_miss = SFX_BALLISTIC_MISS
	sound_bounce = SFX_BALLISTIC_BOUNCE
	point_blank_range = 2
	accurate_range_min = 0
	shell_speed = 3
	damage = 10
	shrapnel_chance = 10
	bullet_color = COLOR_VERY_SOFT_YELLOW
	barricade_clear_distance = 2
