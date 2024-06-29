/obj/item/clothing/suit/modular/xenonauten/light
	soft_armor = list(MELEE = 35, BULLET = 55, LASER = 55, ENERGY = 50, BOMB = 40, BIO = 45, FIRE = 45, ACID = 45)
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT

/obj/item/clothing/suit/modular/xenonauten //medium
	soft_armor = list(MELEE = 45, BULLET = 65, LASER = 65, ENERGY = 55, BOMB = 45, BIO = 50, FIRE = 50, ACID = 50)

/obj/item/clothing/suit/modular/xenonauten/heavy
	soft_armor = list(MELEE = 55, BULLET = 70, LASER = 70, ENERGY = 60, BOMB = 50, BIO = 50, FIRE = 50, ACID = 60)
	slowdown = SLOWDOWN_ARMOR_VERY_HEAVY

/obj/item/clothing/head/modular/m10x
	soft_armor = list(MELEE = 45, BULLET = 65, LASER = 65, ENERGY = 55, BOMB = 45, BIO = 50, FIRE = 50, ACID = 50)

/obj/item/clothing/head/modular/m10x/leader
	soft_armor = list(MELEE = 55, BULLET = 70, LASER = 70, ENERGY = 60, BOMB = 50, BIO = 50, FIRE = 50, ACID = 55)

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

/obj/item/clothing/suit/modular/xenonauten/pilot
	attachments_allowed = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/module/fire_proof,
		/obj/item/armor_module/module/tyr_extra_armor,
		/obj/item/armor_module/module/tyr_extra_armor/mark1,
		/obj/item/armor_module/module/mimir_environment_protection,
		/obj/item/armor_module/module/mimir_environment_protection/mark1,
		/obj/item/armor_module/module/hlin_explosive_armor,
		/obj/item/armor_module/module/ballistic_armor,
		/obj/item/armor_module/module/chemsystem,
		/obj/item/armor_module/module/eshield,

		/obj/item/armor_module/storage/general,
		/obj/item/armor_module/storage/ammo_mag,
		/obj/item/armor_module/storage/engineering,
		/obj/item/armor_module/storage/medical,
		/obj/item/armor_module/storage/injector,
		/obj/item/armor_module/storage/integrated,
		/obj/item/armor_module/armor/badge,
	)
