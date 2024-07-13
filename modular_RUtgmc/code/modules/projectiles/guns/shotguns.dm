/obj/item/weapon/gun/shotgun
	wield_sound = 'modular_RUtgmc/sound/weapons/guns/shotgun/Deploy_Wave_SHOTGUN.ogg'

//------------------------------------------------------
//SH-35 Pump shotgun

/obj/item/weapon/gun/shotgun/pump/t35
	icon_state = "t35"
	item_state = "t35"
	cock_animation = "t35_pump"
	greyscale_config = null
	colorable_allowed = NONE
	fire_sound = 		'modular_RUtgmc/sound/weapons/guns/shotgun/SH-35/SH35.ogg'
	hand_reload_sound = 'modular_RUtgmc/sound/weapons/guns/shotgun/SH-39/SH39_shell.ogg'
	cocked_sound = 		'modular_RUtgmc/sound/weapons/guns/shotgun/SH-35/SH35_pump.ogg'
	opened_sound = 		'modular_RUtgmc/sound/weapons/guns/shotgun/SH-35/SH35_pump.ogg'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',
		)

//-------------------------------------------------------
//SH-46 semi automatic shotgun.

/obj/item/weapon/gun/shotgun/combat/shq6
	name = "\improper SH-46 combat shotgun"
	desc = "The SH-46, is a semi-automatic, 12 Gauge, gas piston-operated shotgun, released for TGMC by CAU."
	force = 20 //Has a stock already
	flags_equip_slot = ITEM_SLOT_BACK
	icon = 'modular_RUtgmc/icons/Marine/gun64.dmi'
	icon_state = "shq6"
	item_state = "shq6"
	item_icons = list(
		slot_s_store_str = 'modular_RUtgmc/icons/mob/suit_slot.dmi',
		slot_back_str = 'modular_RUtgmc/icons/mob/clothing/back.dmi',
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/items_righthand_1.dmi',
		)
	fire_sound = 		'modular_RUtgmc/sound/weapons/guns/shotgun/SH-46/SH46.ogg'
	hand_reload_sound = 'modular_RUtgmc/sound/weapons/guns/shotgun/SH-46/SH46_shell.ogg'
	cocked_sound = 		'modular_RUtgmc/sound/weapons/guns/shotgun/SH-46/SH46_boltpull.ogg'
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES|GUN_WIELDED_FIRING_ONLY
	max_chamber_items = 5
	default_ammo_type = /datum/ammo/bullet/shotgun/buckshot
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
	)

	starting_attachment_types = null
	attachable_offset = list("muzzle_x" = 52, "muzzle_y" = 20,"rail_x" = 24, "rail_y" = 22, "under_x" = 35, "under_y" = 14, "stock_x" = 13, "stock_y" = 13)

	fire_delay = 3 //one shot every 0.3 seconds.
	accuracy_mult = 1.05
	scatter = 3
	damage_mult = 0.6  //40% less damage.
	recoil = 0.5
	wield_delay = 0.6 SECONDS
	aim_slowdown = 0.2

//It's very fast shogun, it's made to prevent stagger/weaken spam.
/obj/item/weapon/gun/shotgun/combat/shq6/get_ammo()
	. = ..()
	switch(ammo_datum_type)
		if(/datum/ammo/bullet/shotgun/buckshot)
			return /datum/ammo/bullet/shotgun/buckshot/shq6
		if(/datum/ammo/bullet/shotgun/slug)
			return /datum/ammo/bullet/shotgun/slug/shq6
		if(/datum/ammo/bullet/shotgun/flechette)
			return /datum/ammo/bullet/shotgun/flechette/shq6
		if(/datum/ammo/bullet/shotgun/incendiary)
			return /datum/ammo/bullet/shotgun/incendiary/shq6

//-------------------------------------------------------
//SH-39 semi automatic shotgun. Used by marines.

/obj/item/weapon/gun/shotgun/combat/standardmarine
	fire_sound = 		'modular_RUtgmc/sound/weapons/guns/shotgun/SH-39/SH39.ogg'
	hand_reload_sound = 'modular_RUtgmc/sound/weapons/guns/shotgun/SH-35/SH35_shell.ogg'
	cocked_sound = 		'modular_RUtgmc/sound/weapons/guns/shotgun/SH-39/SH39_pump.ogg'
	opened_sound = 		'modular_RUtgmc/sound/weapons/guns/shotgun/SH-39/SH39_pump.ogg'

//------------------------------------------------------
// Martini Henry

/obj/item/weapon/gun/shotgun/double/martini
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES|GUN_WIELDED_FIRING_ONLY
