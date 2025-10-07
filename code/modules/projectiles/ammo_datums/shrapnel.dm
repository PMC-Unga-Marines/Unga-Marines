/datum/ammo/bullet/shrapnel
	name = "shrapnel"
	icon_state = "buckshot_shrapnel"
	accuracy = 15
	max_range = 8
	damage = 25
	damage_falloff = 5
	shrapnel_chance = 15

/datum/ammo/bullet/shrapnel/metal
	name = "metal shrapnel"
	icon_state = "shrapnelshot_bit"
	shell_speed = 2
	damage = 30
	shrapnel_chance = 25
	accuracy = 40

/datum/ammo/bullet/shrapnel/light // weak shrapnel
	name = "light shrapnel"
	icon_state = "shrapnel_light"
	damage = 10
	shell_speed = 2.5
	shrapnel_chance = 0

/datum/ammo/bullet/shrapnel/light/human
	name = "human bone fragments"
	icon_state = "shrapnel_human"
	shrapnel_chance = 50
	shrapnel_type = /obj/item/shard/shrapnel/bone_chips/human

/datum/ammo/bullet/shrapnel/light/human/New()
	. = ..()
	icon_state = pick("shrapnel_human", "shrapnel_human1", "shrapnel_human2")

/datum/ammo/bullet/shrapnel/light/xeno
	name = "alien bone fragments"
	icon_state = "shrapnel_xeno"
	shrapnel_chance = 50
	shrapnel_type = /obj/item/shard/shrapnel/bone_chips/xeno

/datum/ammo/bullet/shrapnel/light/glass
	name = "glass shrapnel"
	icon_state = "shrapnel_glass"
