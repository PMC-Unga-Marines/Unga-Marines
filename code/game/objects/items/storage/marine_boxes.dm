/obj/item/storage/box/crate
	name = "crate"
	desc = "It's just an ordinary wooden crate."
	icon = 'icons/obj/items/storage/box.dmi'
	icon_state = "case"

/obj/item/storage/box/crate/Initialize(mapload, ...)
	. = ..()
	storage_datum.foldable = /obj/item/stack/sheet/wood

/obj/item/storage/box/crate/update_icon_state()
	. = ..()
	icon_state = length(contents) ? initial(icon_state) : "empty_case"

/obj/item/storage/box/crate/m42c_system
	name = "\improper antimaterial scoped rifle system (recon set)"
	desc = "A large case containing your very own long-range sniper rifle. Drag this sprite into you to open it up!\nNOTE: You cannot put items back inside this case."
	icon_state = "sniper_case"
	w_class = WEIGHT_CLASS_HUGE
	slowdown = 1

/obj/item/storage/box/crate/m42c_system/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 12
	storage_datum.max_storage_space = 0

/obj/item/storage/box/crate/m42c_system/PopulateContents()
	new /obj/item/clothing/suit/modular/xenonauten/light(src)
	new /obj/item/clothing/head/modular/m10x(src)
	new /obj/item/clothing/glasses/night/m42_night_goggles(src)
	new /obj/item/ammo_magazine/sniper(src)
	new /obj/item/ammo_magazine/sniper/incendiary(src)
	new /obj/item/ammo_magazine/sniper/flak(src)
	new /obj/item/binoculars/tactical(src)
	new /obj/item/storage/backpack/marine/smock(src)
	new /obj/item/weapon/gun/pistol/vp70(src)
	new /obj/item/ammo_magazine/pistol/vp70(src)
	new /obj/item/ammo_magazine/pistol/vp70(src)
	new /obj/item/weapon/gun/rifle/sniper/antimaterial(src)
	new /obj/item/bodybag/tarp(src)

/obj/item/storage/box/crate/m42c_system_Jungle
	name = "\improper antimaterial scoped rifle system (marksman set)"
	desc = "A large case containing your very own long-range sniper rifle. Drag this sprite into you to open it up!\nNOTE: You cannot put items back inside this case."
	icon_state = "sniper_case"
	w_class = WEIGHT_CLASS_HUGE
	slowdown = 1

/obj/item/storage/box/crate/m42c_system_Jungle/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 9
	storage_datum.max_storage_space = 0

/obj/item/storage/box/crate/m42c_system_Jungle/PopulateContents()
	new /obj/item/clothing/suit/modular/xenonauten/light(src)
	new /obj/item/clothing/head/modular/m10x(src)
	new /obj/item/clothing/glasses/m42_goggles(src)
	new /obj/item/ammo_magazine/sniper(src)
	new /obj/item/ammo_magazine/sniper(src)
	new /obj/item/ammo_magazine/sniper/incendiary(src)
	new /obj/item/weapon/gun/rifle/sniper/antimaterial(src)
	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new /obj/item/clothing/under/marine/camo/snow(src)
		new /obj/item/storage/backpack/marine/satchel(src)
		new /obj/item/bodybag/tarp/snow(src)
	else
		new /obj/item/facepaint/sniper(src)
		new /obj/item/storage/backpack/marine/smock(src)
		new /obj/item/bodybag/tarp(src)

/obj/item/storage/box/crate/sentry
	name = "\improper ST-571 sentry crate"
	desc = "A large case containing all you need to set up an automated sentry."
	icon_state = "sentry_case"
	w_class = WEIGHT_CLASS_HUGE
	storage_type = /datum/storage/box/crate/sentry

/obj/item/storage/box/crate/sentry/PopulateContents()
	new /obj/item/weapon/gun/sentry/basic(src)
	new /obj/item/ammo_magazine/sentry(src)
