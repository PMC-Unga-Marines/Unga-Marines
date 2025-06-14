// Xenonauten suits

/obj/item/clothing/suit/modular/xenonauten
	name = "\improper Xenonauten-M pattern armored vest"
	desc = "A XN-M vest, also known as Xenonauten, a set vest with modular attachments made to work in many enviroments. This one seems to be a medium variant. Alt-Click to remove attached items. Use it to toggle the built-in flashlight."
	icon_state = "chest"
	worn_icon_state = "chest"
	icon = null
	worn_icon_list = list(slot_wear_suit_str = 'icons/mob/modular/modular_armor.dmi')
	soft_armor = MARINE_ARMOR_MEDIUM
	slowdown = SLOWDOWN_ARMOR_MEDIUM

	item_map_variant_flags = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT
	greyscale_config = /datum/greyscale_config/xenonaut
	colorable_allowed = PRESET_COLORS_ALLOWED
	colorable_colors = ARMOR_PALETTES_LIST
	greyscale_colors = ARMOR_PALETTE_DRAB

	allowed_uniform_type = /obj/item/clothing/under

/obj/item/clothing/suit/modular/xenonauten/generate_attachments_allowed()
	attachments_allowed = general_list_of_marine_modules.Copy()

/obj/item/clothing/suit/modular/xenonauten/hodgrenades
	starting_attachments = list(
		/obj/item/armor_module/module/ballistic_armor,
		/obj/item/armor_module/storage/grenade,
	)

/obj/item/clothing/suit/modular/xenonauten/engineer
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/engineering,
	)

/obj/item/clothing/suit/modular/xenonauten/lightmedical
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/lightgeneral
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/modular/xenonauten/mimir
	starting_attachments = list(
		/obj/item/armor_module/module/mimir_environment_protection/mark1,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/modular/xenonauten/mimirinjector
	starting_attachments = list(
		/obj/item/armor_module/module/mimir_environment_protection/mark1,
		/obj/item/armor_module/storage/injector,
	)

/obj/item/clothing/suit/modular/xenonauten/shield
	starting_attachments = list(
		/obj/item/armor_module/module/eshield,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/valk
	starting_attachments = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/light
	name = "\improper Xenonauten-L pattern armored vest"
	desc = "A XN-L vest, also known as Xenonauten, a set vest with modular attachments made to work in many enviroments. This one seems to be a light variant. Alt-Click to remove attached items. Use it to toggle the built-in flashlight."
	soft_armor = MARINE_ARMOR_LIGHT
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	greyscale_config = /datum/greyscale_config/xenonaut/light

/obj/item/clothing/suit/modular/xenonauten/light/shield
	starting_attachments = list(
		/obj/item/armor_module/module/eshield,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/light/lightmedical
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy
	name = "\improper Xenonauten-H pattern armored vest"
	desc = "A XN-H vest, also known as Xenonauten, a set vest with modular attachments made to work in many enviroments. This one seems to be a heavy variant. Alt-Click to remove attached items. Use it to toggle the built-in flashlight."
	soft_armor = MARINE_ARMOR_HEAVY
	slowdown = SLOWDOWN_ARMOR_HEAVY
	greyscale_config = /datum/greyscale_config/xenonaut/heavy

/obj/item/clothing/suit/modular/xenonauten/heavy/mimirengi
	starting_attachments = list(
		/obj/item/armor_module/module/mimir_environment_protection/mark1,
		/obj/item/armor_module/storage/engineering,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/leader
	starting_attachments = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/tyr_onegeneral
	starting_attachments = list(
		/obj/item/armor_module/module/tyr_extra_armor/mark1,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/tyr_one
	starting_attachments = list(
		/obj/item/armor_module/module/tyr_extra_armor/mark1,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/tyr_two
	starting_attachments = list(
		/obj/item/armor_module/module/tyr_extra_armor,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/grenadier //Literally grenades
	starting_attachments = list(
		/obj/item/armor_module/module/ballistic_armor,
		/obj/item/armor_module/storage/grenade,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/surt
	starting_attachments = list(
		/obj/item/armor_module/module/fire_proof,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/shield
	starting_attachments = list(
		/obj/item/armor_module/module/eshield,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/pilot
	name = "\improper TerraGov standard flak jacket"
	desc = "A flak jacket used by dropship pilots to protect themselves while flying in the cockpit. Excels in protecting the wearer against high-velocity solid projectiles."
	item_flags = NONE
	soft_armor = MARINE_ARMOR_HEAVY
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	greyscale_config = /datum/greyscale_config/xenonaut/pilot

	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/weapon/baton,
		/obj/item/restraints/handcuffs,
		/obj/item/explosive/grenade,
		/obj/item/binoculars,
		/obj/item/weapon/combat_knife,
		/obj/item/attachable/bayonetknife,
		/obj/item/storage/belt/sparepouch,
		/obj/item/storage/holster/blade,
		/obj/item/storage/holster/belt,
		/obj/item/weapon/energy/sword,
	)

/obj/item/clothing/suit/storage/ballistic
	name = "\improper Crasher multi-threat ballistic armor"
	desc = "A reused design of a old body armor system from the 21st century."
	soft_armor = list(MELEE = 30, BULLET = 50, LASER = 20, ENERGY = 25, BOMB = 30, BIO = 5, FIRE = 25, ACID = 30)
	slowdown = SLOWDOWN_ARMOR_LIGHT
	armor_protection_flags = CHEST|GROIN
	icon = 'icons/mob/clothing/suits/marine_armor.dmi'
	icon_state = "ballistic_vest"
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/clothing/suits/marine_armor.dmi'
	)
	equip_delay_self = 2 SECONDS

	icon_state_variants = list(
		"urban",
		"jungle",
		"desert",
		"snow",
	)
	colorable_allowed = ICON_STATE_VARIANTS_ALLOWED
	current_variant = "urban"

	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/weapon/baton,
		/obj/item/restraints/handcuffs,
		/obj/item/explosive/grenade,
		/obj/item/binoculars,
		/obj/item/weapon/combat_knife,
		/obj/item/attachable/bayonetknife,
		/obj/item/storage/belt/sparepouch,
		/obj/item/storage/holster/blade,
		/obj/item/storage/holster/belt,
		/obj/item/weapon/energy/sword,
	)

//Xenonauten helmets
/obj/item/clothing/head/modular/m10x
	name = "\improper M10X pattern marine helmet"
	desc = "A standard M10 Pattern Helmet with attach points. It reads on the label, 'The difference between an open-casket and closed-casket funeral. Wear on head for best results.'."
	worn_icon_state_worn = TRUE
	soft_armor = MARINE_ARMOR_MEDIUM
	starting_attachments = list(/obj/item/armor_module/storage/helmet)
	item_map_variant_flags = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT

	greyscale_config = /datum/greyscale_config/xenonaut/helm
	greyscale_colors = ARMOR_PALETTE_DRAB

	visorless_offset_y = 0

/obj/item/clothing/head/modular/m10x/hod
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/hod_head)

/obj/item/clothing/head/modular/m10x/freyr
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/artemis)

/obj/item/clothing/head/modular/m10x/antenna
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/antenna)

/obj/item/clothing/head/modular/m10x/welding
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/welding)

/obj/item/clothing/head/modular/m10x/superiorwelding
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/welding/superior)

/obj/item/clothing/head/modular/m10x/mimir
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/mimir_environment_protection/mimir_helmet/mark1)

/obj/item/clothing/head/modular/m10x/tyr
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/tyr_head)

/obj/item/clothing/head/modular/m10x/surt
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/fire_proof_helmet)

/obj/item/clothing/head/modular/m10x/heavy
	name = "\improper M10XE pattern marine helmet"
	desc = "A standard M10XE Pattern Helmet. This is a modified version of the M10X helmet, offering an enclosed visor apparatus."
	worn_icon_state = "helm"
	greyscale_config = /datum/greyscale_config/xenonaut/helm/heavy
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/xenonaut, /obj/item/armor_module/storage/helmet)

/obj/item/clothing/head/modular/m10x/leader
	name = "\improper M11X pattern leader helmet"
	desc = "A slightly fancier helmet for marine leaders. This one has cushioning to project your fragile brain."
	soft_armor = MARINE_ARMOR_HEAVY

/obj/item/clothing/suit/modular/xenonauten/light/mk1
	name = "\improper Xenonauten-L-MK1 pattern armored vest"
	greyscale_config = /datum/greyscale_config/xenonaut/mk1/light

/obj/item/clothing/suit/modular/xenonauten/mk1
	name = "\improper Xenonauten-M-MK1 pattern armored vest"
	greyscale_config = /datum/greyscale_config/xenonaut/mk1/medium

/obj/item/clothing/suit/modular/xenonauten/heavy/mk1
	name = "\improper Xenonauten-H-MK1 pattern armored vest"
	greyscale_config = /datum/greyscale_config/xenonaut/mk1/heavy

/obj/item/clothing/head/modular/m10x/mk1
	name = "\improper M10X1 pattern marine helmet"
	greyscale_config = /datum/greyscale_config/xenonaut/helm/mk1
