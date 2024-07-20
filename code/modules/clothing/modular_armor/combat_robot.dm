//Robot armour
/obj/item/clothing/suit/modular/robot
	name = "XR-1 armor plating"
	desc = "Medium armor plating designed for self mounting on TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside."

	item_icons = list(slot_wear_suit_str = 'icons/mob/modular/robot_armor.dmi')
	icon_state = "chest"
	item_state = "chest"
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 45, BULLET = 65, LASER = 65, ENERGY = 55, BOMB = 45, BIO = 50, FIRE = 50, ACID = 55)
	slowdown = SLOWDOWN_ARMOR_MEDIUM

	colorable_colors = ARMOR_PALETTES_LIST
	colorable_allowed = PRESET_COLORS_ALLOWED
	greyscale_config = /datum/greyscale_config/robot
	greyscale_colors = ARMOR_PALETTE_DRAB

	attachments_allowed = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/module/fire_proof,
		/obj/item/armor_module/module/tyr_extra_armor,
		/obj/item/armor_module/module/tyr_extra_armor/mark1,
		/obj/item/armor_module/module/hlin_explosive_armor,
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

/obj/item/clothing/suit/modular/robot/light
	name = "XR-1-L armor plating"
	desc = "Light armor plating designed for self mounting on TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside."
	soft_armor = list(MELEE = 35, BULLET = 55, LASER = 55, ENERGY = 50, BOMB = 40, BIO = 45, FIRE = 45, ACID = 45)
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	greyscale_config = /datum/greyscale_config/robot/light

/obj/item/clothing/suit/modular/robot/heavy
	name = "XR-1-H armor plating"
	desc = "Heavy armor plating designed for self mounting on TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside."
	soft_armor = list(MELEE = 55, BULLET = 70, LASER = 70, ENERGY = 55, BOMB = 50, BIO = 50, FIRE = 50, ACID = 60)
	slowdown = SLOWDOWN_ARMOR_VERY_HEAVY
	greyscale_config = /datum/greyscale_config/robot/heavy

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
		/obj/item/armor_module/module/fire_proof_helmet,
		/obj/item/armor_module/module/hod_head,
		/obj/item/armor_module/module/binoculars,
		/obj/item/armor_module/module/binoculars/artemis_mark_two,
		/obj/item/armor_module/module/artemis,
		/obj/item/armor_module/module/antenna,
		/obj/item/armor_module/module/night_vision,
		/obj/item/armor_module/storage/helmet,
		/obj/item/armor_module/armor/badge,
		/obj/item/armor_module/armor/visor/marine/robot,
		/obj/item/armor_module/armor/visor/marine/robot/light,
		/obj/item/armor_module/armor/visor/marine/robot/heavy,
		//RUTGMC EDIT ADDITION  BEGIN - MOTION_DETECTOR
		/obj/item/armor_module/module/motion_detector,
		//RUTGMC EDIT ADDITION  END
	)
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot)
	flags_item_map_variant = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT


/obj/item/clothing/head/modular/robot/mob_can_equip(mob/user, slot, warning = TRUE, override_nodrop = FALSE, bitslot = FALSE)
	. = ..()
	if(!isrobot(user))
		to_chat(user, span_warning("You can't equip this as it requires mounting bolts on your body!"))
		return FALSE

/obj/item/clothing/head/modular/robot/light
	name = "XN-1-L upper armor plating"
	desc = "Light armor plating designed for self mounting on the upper half of TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside."
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/light)
	soft_armor = list(MELEE = 40, BULLET = 55, LASER = 55, ENERGY = 50, BOMB = 40, BIO = 45, FIRE = 45, ACID = 50)
	greyscale_config = /datum/greyscale_config/robot/light

/obj/item/clothing/head/modular/robot/heavy
	name = "XN-1-H upper armor plating"
	desc = "Heavy armor plating designed for self mounting on the upper half of TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside."
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/heavy)
	soft_armor = list(MELEE = 55, BULLET = 70, LASER = 70, ENERGY = 55, BOMB = 50, BIO = 50, FIRE = 50, ACID = 55)
	greyscale_config = /datum/greyscale_config/robot/heavy

/obj/item/clothing/head/modular/robot/heavy/tyr
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/heavy, /obj/item/armor_module/module/tyr_head)

/obj/item/clothing/head/helmet/marine/robot/advanced
	flags_item_map_variant = NONE
	icon = 'icons/obj/clothing/headwear/marine_helmets.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/robot_helmets.dmi',
	)
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/helmet/marine/robot/advanced/mob_can_equip(mob/user, slot, warning = TRUE, override_nodrop = FALSE, bitslot = FALSE)
	. = ..()
	if(!isrobot(user))
		to_chat(user, span_warning("You can't equip this as it requires mounting bolts on your body!"))
		return FALSE

/obj/item/clothing/suit/storage/marine/robot/advanced
	flags_item_map_variant = NONE
	icon = 'icons/obj/clothing/suits/marine_armor.dmi'
	item_icons = list(
		slot_wear_suit_str = 'icons/mob/clothing/suits/robot_armor.dmi',
	)
	species_exception = list(/datum/species/robot)

/obj/item/clothing/suit/storage/marine/robot/advanced/mob_can_equip(mob/user, slot, warning = TRUE, override_nodrop = FALSE, bitslot = FALSE)
	. = ..()
	if(!isrobot(user))
		to_chat(user, span_warning("You can't equip this as it requires mounting bolts on your body!"))
		return FALSE

/obj/item/clothing/head/helmet/marine/robot/advanced/acid
	name = "\improper Exidobate upper armor plating"
	desc = "Heavy armor plating designed for self mounting on the upper half of TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside. It was created for the survival of robots in places with high acid concentration. Uses the already known technology of nickel-gold plates to protect important modules in the upper part of the robot"
	soft_armor = list(MELEE = 50, BULLET = 60, LASER = 65, ENERGY = 65, BOMB = 50, BIO = 65, FIRE = 40, ACID = 75)
	icon_state = "robo_helm_acid"
	item_state = "robo_helm_acid"

/obj/item/clothing/suit/storage/marine/robot/advanced/acid
	name = "\improper Exidobate armor plating"
	desc = "Heavy armor plating designed for self mounting on TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside. It was created for the survival of robots in places with high acid concentration. Armor uses nickel and golden plate technology for perfect protection against acids."
	soft_armor = list(MELEE = 50, BULLET = 70, LASER = 80, ENERGY = 80, BOMB = 50, BIO = 80, FIRE = 60, ACID = 75)
	slowdown = 0.7

	icon_state = "robo_armor_acid"
	item_state = "robo_armor_acid"

/obj/item/clothing/head/helmet/marine/robot/advanced/physical
	name = "\improper Cingulata upper armor plating"
	desc = "Heavy armor plating designed for self mounting on the upper half of TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside. It was based on the Colonial Police Special Forces helmet and redesigned by engineers for robots. The helmet received a reinforced lining as well as a base, which added protection from aggressive fauna and firearms."
	soft_armor = list(MELEE = 75, BULLET = 80, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 50, FIRE = 20, ACID = 50)

	icon_state = "robo_helm_physical"
	item_state = "robo_helm_physical"

/obj/item/clothing/suit/storage/marine/robot/advanced/physical
	name = "\improper Cingulata armor plating"
	desc = "Heavy armor plating designed for self mounting on TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside. Originally it was created as a police plate armor for robots  anti-terrorist operations, but later the chief engineers remade it for the needs of the TGMC. The armor received additional plates to protect against aggressive fauna and firearms."
	soft_armor = list(MELEE = 75, BULLET = 85, LASER = 70, ENERGY = 70, BOMB = 50, BIO = 50, FIRE = 50, ACID = 60)
	slowdown = 0.7

	icon_state = "robo_armor_physical"
	item_state = "robo_armor_physical"

/obj/item/clothing/head/helmet/marine/robot/advanced/bomb
	name = "\improper Tardigrada upper armor plating"
	desc = "Heavy armor plating designed for self mounting on the upper half of TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside.The upper part of the armor was specially designed for robots, as cases of head loss in robots due to mine and grenade explosions have become more frequent. Helmet  has a reinforced attachment to the main part, which, according to scientists, will lead to a decrease in cases of loss of important modules. It has increased protection against shock waves and explosions."
	soft_armor = list(MELEE = 60, BULLET = 60, LASER = 50, ENERGY = 50, BOMB = 90, BIO = 50, FIRE = 20, ACID = 50)

	icon_state = "robo_helm_bomb"
	item_state = "robo_helm_bomb"

/obj/item/clothing/suit/storage/marine/robot/advanced/bomb
	name = "\improper Tardigrada armor plating"
	desc = "Heavy armor plating designed for self mounting on TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside. This armor was specially designed to work with explosives and mines. Often it was installed on old robots of sappers and engineers to increase their survival rate. The armor is equipped with reinforced protection against shock waves and explosions."
	soft_armor = list(MELEE = 60, BULLET = 70, LASER = 70, ENERGY = 70, BOMB = 90, BIO = 50, FIRE = 50, ACID = 60)
	slowdown = 0.7

	icon_state = "robo_armor_bomb"
	item_state = "robo_armor_bomb"

/obj/item/clothing/head/helmet/marine/robot/advanced/fire
	name = "\improper Urodela upper armor plating"
	desc = "Heavy armor plating designed for self mounting on the upper half of TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside.The top armor made from fireproof glass-like material. This is done in order not to reduce the effectiveness of the robot's tracking modules. The glass itself can withstand high temperatures and a short stay in lava."
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 80, ENERGY = 50, BOMB = 50, BIO = 50, FIRE = 100, ACID = 50)
	hard_armor = list(FIRE = 200)

	icon_state = "robo_helm_fire"
	item_state = "robo_helm_fire"

/obj/item/clothing/suit/storage/marine/robot/advanced/fire
	name = "\improper Urodela armor plating"
	desc = "Heavy armor plating designed for self mounting on TerraGov combat robotics. It has self-sealing bolts for mounting on robotic owners inside. The armor is inspired by the mining exosuits used on lava planets. Upgraded by TeraGova engineers for robots that use a flamethrower and work in an environment of elevated temperatures. Armor protects important modules and wiring from fire and lava, which gives robots high survivability in fire."
	soft_armor = list(MELEE = 50, BULLET = 60, LASER = 80, ENERGY = 70, BOMB = 50, BIO = 50, FIRE = 100, ACID = 60)
	hard_armor = list(FIRE = 200)
	slowdown = 0.5

	icon_state = "robo_armor_fire"
	item_state = "robo_armor_fire"
