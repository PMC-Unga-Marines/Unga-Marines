//Robot armour
/obj/item/clothing/suit/modular/robot
	name = "XR-1 armor plating"
	desc = "Medium armor plating designed for self mounting on TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside."

	item_icons = list(slot_wear_suit_str = 'icons/mob/modular/robot_armor.dmi')
	icon_state = "chest"
	item_state = "chest"
	species_exception = list(/datum/species/robot)
	soft_armor = MARINE_ARMOR_MEDIUM
	slowdown = SLOWDOWN_ARMOR_MEDIUM

	colorable_colors = ARMOR_PALETTES_LIST
	colorable_allowed = PRESET_COLORS_ALLOWED
	greyscale_config = /datum/greyscale_config/robot
	greyscale_colors = ARMOR_PALETTE_DRAB

	attachments_allowed = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/module/pluto,
		/obj/item/armor_module/module/fire_proof,
		/obj/item/armor_module/module/tyr_extra_armor,
		/obj/item/armor_module/module/tyr_extra_armor/mark1,
		/obj/item/armor_module/module/ballistic_armor,
		/obj/item/armor_module/module/eshield,

		/obj/item/armor_module/storage/general,
		/obj/item/armor_module/storage/ammo_mag,
		/obj/item/armor_module/storage/engineering,
		/obj/item/armor_module/storage/medical,
		/obj/item/armor_module/storage/general/som,
		/obj/item/armor_module/storage/engineering/som,
		/obj/item/armor_module/storage/medical/som,
		/obj/item/armor_module/storage/injector,
		/obj/item/armor_module/storage/grenade,
		/obj/item/armor_module/storage/integrated,
		/obj/item/armor_module/armor/badge,
	)

	allowed_uniform_type = /obj/item/clothing/under/marine/robotic

	flags_item_map_variant = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT

/obj/item/clothing/suit/modular/robot/mob_can_equip(mob/user, slot, warning = TRUE, override_nodrop = FALSE, bitslot = FALSE)
	. = ..()
	if(!isrobot(user))
		to_chat(user, span_warning("You can't equip this as it requires mounting bolts on your body!"))
		return FALSE

//---- Medium armor with attachments
/obj/item/clothing/suit/modular/robot/hodgrenades
	starting_attachments = list(
		/obj/item/armor_module/module/ballistic_armor,
		/obj/item/armor_module/storage/grenade,
	)

/obj/item/clothing/suit/modular/robot/lightgeneral
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/modular/robot/lightengineer
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/engineering,
	)

/obj/item/clothing/suit/modular/robot/lightinjector
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/injector,
	)

/obj/item/clothing/suit/modular/robot/svalinn
	starting_attachments = list(
		/obj/item/armor_module/module/eshield,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/modular/robot/light
	name = "XR-1-L armor plating"
	desc = "Light armor plating designed for self mounting on TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside."
	soft_armor = MARINE_ARMOR_LIGHT
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	greyscale_config = /datum/greyscale_config/robot/light

//---- Light armor with attachments
/obj/item/clothing/suit/modular/robot/light/baldur_medical
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/robot/light/baldur_general
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/modular/robot/heavy
	name = "XR-1-H armor plating"
	desc = "Heavy armor plating designed for self mounting on TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside."
	soft_armor = MARINE_ARMOR_HEAVY
	slowdown = SLOWDOWN_ARMOR_HEAVY
	greyscale_config = /datum/greyscale_config/robot/heavy

//---- Heavy armor with attachments
/obj/item/clothing/suit/modular/robot/heavy/tyr_onegeneral
	starting_attachments = list(
		/obj/item/armor_module/module/tyr_extra_armor/mark1,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/modular/robot/heavy/lightengineer
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/engineering,
	)

/obj/item/clothing/suit/modular/robot/heavy/tyr
	starting_attachments = list(
		/obj/item/armor_module/module/tyr_extra_armor,
		/obj/item/armor_module/storage/engineering,
	)

/obj/item/clothing/suit/modular/robot/heavy/shield
	starting_attachments = list(
		/obj/item/armor_module/module/eshield,
		/obj/item/armor_module/storage/engineering,
	)

//robot hats
/obj/item/clothing/head/modular/robot
	name = "XN-1 upper armor plating"
	desc = "Medium armor plating designed for self mounting on the upper half of TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside."
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',
	)
	icon_state = "helmet"
	item_state = "helmet"
	species_exception = list(/datum/species/robot)
	flags_item_map_variant = (ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_PRISON_VARIANT)
	soft_armor = list(MELEE = 50, BULLET = 70, LASER = 70, ENERGY = 60, BOMB = 55, BIO = 55, FIRE = 55, ACID = 60)

	colorable_colors = ARMOR_PALETTES_LIST
	colorable_allowed = PRESET_COLORS_ALLOWED
	greyscale_config = /datum/greyscale_config/robot
	greyscale_colors = ARMOR_PALETTE_DRAB

	attachments_allowed = list(
		/obj/item/armor_module/module/tyr_head,
		/obj/item/armor_module/module/tyr_head/mark2,
		/obj/item/armor_module/module/fire_proof_helmet,
		/obj/item/armor_module/module/hod_head,
		/obj/item/armor_module/module/binoculars,
		/obj/item/armor_module/module/binoculars/artemis_mark_two,
		/obj/item/armor_module/module/artemis,
		/obj/item/armor_module/module/antenna,
		/obj/item/armor_module/module/night_vision,
		/obj/item/armor_module/module/motion_detector,
		/obj/item/armor_module/storage/helmet,
		/obj/item/armor_module/armor/badge,
		/obj/item/armor_module/armor/visor/marine/robot,
		/obj/item/armor_module/armor/visor/marine/robot/light,
		/obj/item/armor_module/armor/visor/marine/robot/heavy,
	)
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot)
	flags_item_map_variant = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT

/obj/item/clothing/head/modular/robot/mob_can_equip(mob/user, slot, warning = TRUE, override_nodrop = FALSE, bitslot = FALSE)
	. = ..()
	if(!isrobot(user))
		to_chat(user, span_warning("You can't equip this as it requires mounting bolts on your body!"))
		return FALSE

//---- Medium helmets with attachments
/obj/item/clothing/head/modular/robot/hod
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot, /obj/item/armor_module/module/hod_head)

/obj/item/clothing/head/modular/robot/antenna
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/heavy, /obj/item/armor_module/module/antenna)

/obj/item/clothing/head/modular/robot/motion_detector
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/heavy, /obj/item/armor_module/module/motion_detector)

/obj/item/clothing/head/modular/robot/light
	name = "XN-1-L upper armor plating"
	desc = "Light armor plating designed for self mounting on the upper half of TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside."
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/light)
	soft_armor = list(MELEE = 40, BULLET = 55, LASER = 55, ENERGY = 50, BOMB = 40, BIO = 45, FIRE = 45, ACID = 50)
	greyscale_config = /datum/greyscale_config/robot/light

/obj/item/clothing/head/modular/robot/light/motion_detector
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/light, /obj/item/armor_module/module/motion_detector)

/obj/item/clothing/head/modular/robot/heavy
	name = "XN-1-H upper armor plating"
	desc = "Heavy armor plating designed for self mounting on the upper half of TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside."
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/heavy)
	soft_armor = list(MELEE = 55, BULLET = 70, LASER = 70, ENERGY = 55, BOMB = 50, BIO = 50, FIRE = 50, ACID = 55)
	greyscale_config = /datum/greyscale_config/robot/heavy

/obj/item/clothing/head/modular/robot/heavy/tyr
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/heavy, /obj/item/armor_module/module/tyr_head)
