/datum/ammo/bullet/shrapnel
	name = "shrapnel"
	icon_state = "buckshot_shrapnel"
	icon = 'icons/obj/items/projectiles.dmi'
	accurate_range_min = 5
	flags_ammo_behavior = AMMO_BALLISTIC
	accuracy = 15
	accurate_range = 32
	max_range = 8
	damage = 25
	damage_falloff = 8
	penetration = 0
	shell_speed = 3
	shrapnel_chance = 15

/datum/ammo/bullet/shrapnel/metal
	name = "metal shrapnel"
	icon_state = "shrapnelshot_bit"
	shell_speed = 1.5
	damage = 30
	shrapnel_chance = 25
	accuracy = 40
	penetration = 0

/datum/ammo/bullet/shrapnel/light // weak shrapnel
	name = "light shrapnel"
	icon_state = "shrapnel_light"
	damage = 10
	penetration = 0
	shell_speed = 2
	shrapnel_chance = 0

/datum/ammo/bullet/shrapnel/light/human
	name = "human bone fragments"
	icon_state = "shrapnel_human"
	shrapnel_chance = 50
	shrapnel_type = /obj/item/shard/shrapnel/bone_chips/human

/datum/ammo/bullet/shrapnel/light/human/var1 // sprite variants
	icon_state = "shrapnel_human1"

/datum/ammo/bullet/shrapnel/light/human/var2 // sprite variants
	icon_state = "shrapnel_human2"

/datum/ammo/bullet/shrapnel/light/xeno
	name = "alien bone fragments"
	icon_state = "shrapnel_xeno"
	shrapnel_chance = 50
	shrapnel_type = /obj/item/shard/shrapnel/bone_chips/xeno

/datum/ammo/bullet/shrapnel/spall // weak shrapnel
	name = "spall"
	icon_state = "shrapnel_light"
	damage = 10
	penetration = 0
	shell_speed = 2
	shrapnel_chance = 0

/datum/ammo/bullet/shrapnel/light/glass
	name = "glass shrapnel"
	icon_state = "shrapnel_glass"
