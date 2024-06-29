//TE Standard Laser rifle

/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle
	icon_state = "ter"
	item_state = "ter"
	greyscale_config = null
	colorable_allowed = NONE
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',
		)

/datum/lasrifle/energy_rifle_mode/standard
	icon_state = "ter"

/datum/lasrifle/energy_rifle_mode/overcharge
	icon_state = "ter"

/datum/lasrifle/energy_rifle_mode/weakening
	icon_state = "ter"

/datum/lasrifle/energy_rifle_mode/microwave
	icon_state = "ter"

///TE Standard Laser Pistol

/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol
	icon_state = "tep"
	item_state = "tep"
	greyscale_config = null
	colorable_allowed = NONE
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',
		)

/datum/lasrifle/energy_pistol_mode/standard
	icon_state = "tep"

/datum/lasrifle/energy_pistol_mode/disabler
	icon_state = "tep"

/datum/lasrifle/energy_pistol_mode/heat
	icon_state = "tep"

//TE Standard Laser Carbine

/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_carbine
	icon_state = "tec"
	item_state = "tec"
	greyscale_config = null
	colorable_allowed = NONE
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',
		)
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_ENERGY|GUN_AMMO_COUNTER|GUN_NO_PITCH_SHIFT_NEAR_EMPTY|GUN_AMMO_COUNT_BY_SHOTS_REMAINING|GUN_WIELDED_FIRING_ONLY

/datum/lasrifle/energy_carbine_mode/auto_burst
	icon_state = "tec"

/datum/lasrifle/energy_carbine_mode/base/spread
	icon_state = "tec"

/datum/lasrifle/energy_carbine_mode/base/impact
	icon_state = "tec"

/datum/lasrifle/energy_carbine_mode/base/cripple
	icon_state = "tec"

//TE Standard Sniper

/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_sniper
	desc = "The T-ES, a Terra Experimental standard issue laser sniper rifle, it has an integrated charge selector for normal, heat, and overcharge settings. Uses standard Terra Experimental (abbreviated as TE) power cells. As with all TE Laser weapons, they use a lightweight alloy combined without the need for bullets any longer decreases their weight and aiming speed quite some vs their ballistic counterparts."
	windup_sound = 'modular_RUtgmc/sound/weapons/guns/fire/Laser Sniper Overcharge Charge.ogg'
	icon = 'modular_RUtgmc/icons/Marine/gun64.dmi'
	icon_state = "tes"
	item_state = "tes"
	greyscale_config = null
	colorable_allowed = NONE
	item_icons = list(
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/items_lefthand_64.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/items_righthand_64.dmi',
		slot_s_store_str = 'modular_RUtgmc/icons/mob/suit_slot.dmi',
		slot_back_str = 'modular_RUtgmc/icons/mob/clothing/back.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	max_shots = 20 //codex stuff
	rounds_per_shot = 30
	actions_types = list(/datum/action/item_action/aim_mode)
	scatter = 0
	scatter_unwielded = 15
	recoil_unwielded = 2
	fire_delay = 0.8 SECONDS
	accuracy_mult = 1.2
	accuracy_mult_unwielded = 0.5
	movement_acc_penalty_mult = 6
	aim_fire_delay = 1 SECONDS

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_ENERGY|GUN_AMMO_COUNTER|GUN_NO_PITCH_SHIFT_NEAR_EMPTY|GUN_AMMO_COUNT_BY_SHOTS_REMAINING|GUN_WIELDED_FIRING_ONLY

	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope/unremovable/laser_sniper_scope,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/buildasentry,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/gyro,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/foldable/bipod,
	)

	attachable_offset = list("muzzle_x" = 49, "muzzle_y" = 15,"rail_x" = 21, "rail_y" = 21, "under_x" = 28, "under_y" = 11, "stock_x" = 22, "stock_y" = 12)
	starting_attachment_types = list(/obj/item/attachable/scope/unremovable/laser_sniper_scope)

	mode_list = list(
		"Standard" = /datum/lasrifle/energy_sniper_mode/standard,
		"Heat" = /datum/lasrifle/energy_sniper_mode/heat,
		"Overcharge" = /datum/lasrifle/energy_sniper_mode/overcharge,
		"Shatter" = /datum/lasrifle/energy_sniper_mode/shatter,
		"Ricochet" = /datum/lasrifle/energy_sniper_mode/ricochet,
	)

/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_sniper/unique_action(mob/user)
	. = ..()
	if(HAS_TRAIT(src, TRAIT_GUN_IS_AIMING))
		modify_fire_delay(aim_fire_delay)
		modify_auto_burst_delay(aim_fire_delay)

/datum/lasrifle/energy_sniper_mode/standard
	icon_state = "tes"

/datum/lasrifle/energy_sniper_mode/heat
	icon_state = "tes"

/datum/lasrifle/energy_sniper_mode/shatter
	icon_state = "tes"

/datum/lasrifle/energy_sniper_mode/ricochet
	icon_state = "tes"

/datum/lasrifle/energy_sniper_mode/overcharge
	rounds_per_shot = 200
	fire_delay = 3 SECONDS
	windup_delay = 1.5 SECONDS
	ammo_datum_type = /datum/ammo/energy/lasgun/marine/sniper_overcharge
	fire_sound = 'modular_RUtgmc/sound/weapons/guns/fire/Laser Sniper Overcharge Fire.ogg'
	message_to_user = "You set the sniper rifle's charge mode to overcharge."
	fire_mode = GUN_FIREMODE_SEMIAUTO
	icon_state = "tes"
	radial_icon_state = "laser_sniper_overcharge"
	radial_icon = 'modular_RUtgmc/icons/mob/radial.dmi'

/obj/item/weapon/gun/energy/lasgun/lasrifle/xray
	fire_delay = 0.4 SECONDS

// TE Standard MG

/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_mlaser
	icon_state = "tem"
	item_state = "tem"
	greyscale_config = null
	colorable_allowed = NONE
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',
		)

/datum/lasrifle/energy_mg_mode/standard
	icon_state = "tem"

/datum/lasrifle/energy_mg_mode/standard/burst
	icon_state = "tem"

/datum/lasrifle/heavy_laser/burst
	icon_state = "heavylaser"

/datum/lasrifle/heavy_laser/ricochet
	icon_state = "heavylaser"

/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam
	name = "\improper pocket beam"
	desc = "A Terra Experimental underbarrel laser system. Has multiple firemodes for tactical flexibility. Uses standard Terra Experimental (abbreviated as TE) power cells."
	reload_sound = 'sound/weapons/guns/interact/standard_laser_rifle_reload.ogg'
	fire_sound = 'sound/weapons/guns/fire/Laser Rifle Standard.ogg'
	icon = 'modular_RUtgmc/icons/Marine/marine-weapons.dmi'
	icon_state = "p_beam"
	max_shots = 4
	ammo_datum_type = /datum/ammo/energy/lasgun/marine/pistol/heat/pocket
	rounds_per_shot = 150
	gun_firemode = GUN_FIREMODE_AUTOMATIC
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attach_delay = 1 SECONDS
	detach_delay = 1 SECONDS
	ammo_level_icon = "te"
	attachable_allowed = list()
	starting_attachment_types = list()
	slot = ATTACHMENT_SLOT_UNDER
	flags_gun_features = GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_ATTACHMENT_FIRE_ONLY|GUN_IS_ATTACHMENT|GUN_CAN_POINTBLANK|GUN_ENERGY|GUN_AMMO_COUNTER|GUN_NO_PITCH_SHIFT_NEAR_EMPTY|GUN_AMMO_COUNT_BY_SHOTS_REMAINING
	wield_delay = 0.5 SECONDS
	scatter = 0
	fire_delay = 2 SECONDS
	accuracy_mult_unwielded = 0.55
	damage_falloff_mult = 0.2
	mode_list = list(
		"Heat" = /datum/lasrifle/energy_pistol_mode/heat/pocket,
		"Impact" = /datum/lasrifle/energy_carbine_mode/base/impact/pocket,
		"Weakening" = /datum/lasrifle/energy_rifle_mode/weakening/pocket,
	)

	wield_delay_mod = 0.2 SECONDS

	pixel_shift_x = 14
	pixel_shift_y = 18

/datum/lasrifle/energy_pistol_mode/heat/pocket
	rounds_per_shot = 150
	icon_state = "p_beam"
	fire_delay = 2 SECONDS
	ammo_datum_type = /datum/ammo/energy/lasgun/marine/pistol/heat/pocket

/datum/ammo/energy/lasgun/marine/pistol/heat/pocket
	flags_ammo_behavior = AMMO_ENERGY|AMMO_INCENDIARY|AMMO_SUNDERING|AMMO_HITSCAN
	incendiary_strength = 15
	hitscan_effect_icon = "beam_incen"
	bullet_color = COLOR_LASER_RED

/datum/lasrifle/energy_carbine_mode/base/impact/pocket
	rounds_per_shot = 60
	icon_state = "p_beam"
	fire_delay = 1.8 SECONDS

/datum/lasrifle/energy_rifle_mode/weakening/pocket
	rounds_per_shot = 100
	icon_state = "p_beam"
	fire_delay = 1.8 SECONDS
	ammo_datum_type = /datum/ammo/energy/lasgun/marine/weakening/pocket

/datum/ammo/energy/lasgun/marine/weakening/pocket
	plasma_drain = 80
