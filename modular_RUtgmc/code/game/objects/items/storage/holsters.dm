///RL SADAR bag
/obj/item/storage/holster/backholster/rlsadar
	name = "TGMC RL-152 bag"
	icon = 'modular_RUtgmc/icons/obj/items/storage/storage.dmi'
	desc = "This backpack can hold 4 40mm shells, in addition to a SADAR launcher."
	item_icons = list(
		slot_back_str = 'modular_RUtgmc/icons/mob/clothing/back.dmi'
	)
	icon_state = "marine_sadar"
	item_state = "marine_sadar"
	w_class = WEIGHT_CLASS_HUGE
	storage_slots = 5
	max_w_class = 5
	access_delay = 0.5 SECONDS
	holsterable_allowed = list(
		/obj/item/weapon/gun/launcher/rocket/sadar
	)
	bypass_w_limit = /obj/item/weapon/gun/launcher/rocket/sadar
	storage_type_limits = list()
	can_hold = list(
		/obj/item/weapon/gun/launcher/rocket/sadar,
		/obj/item/ammo_magazine/rocket/sadar,
	)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Bravada Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Charlit Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Alpharii Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Deltad Combat Robot" = 'icons/mob/species/robot/backpack.dmi') //robots have their own snowflake back sprites

///RL Quad bag
/obj/item/storage/holster/backholster/rlquad
	name = "TGMC RL-57 bag"
	icon = 'modular_RUtgmc/icons/obj/items/storage/storage.dmi'
	desc = "This backpack can hold 2 rocket arrays, in addition to a thermobaric launcher."
	item_icons = list(
		slot_back_str = 'modular_RUtgmc/icons/mob/clothing/back.dmi'
	)
	icon_state = "marine_quad"
	item_state = "marine_quad"
	w_class = WEIGHT_CLASS_HUGE
	storage_slots = 3
	max_w_class = 5
	access_delay = 0.5 SECONDS
	holsterable_allowed = list(
		/obj/item/weapon/gun/launcher/rocket/m57a4/t57
	)
	bypass_w_limit = /obj/item/weapon/gun/launcher/rocket/m57a4/t57
	storage_type_limits = list()
	can_hold = list(
		/obj/item/weapon/gun/launcher/rocket/m57a4/t57,
		/obj/item/ammo_magazine/rocket/m57a4,
	)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Bravada Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Charlit Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Alpharii Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Deltad Combat Robot" = 'icons/mob/species/robot/backpack.dmi') //robots have their own snowflake back sprites

/obj/item/storage/holster/backholster/rlquad/full/Initialize()
	. = ..()
	new /obj/item/ammo_magazine/rocket/m57a4(src)
	new /obj/item/ammo_magazine/rocket/m57a4(src)
	var/obj/item/new_item = new /obj/item/weapon/gun/launcher/rocket/m57a4/t57(src)
	INVOKE_ASYNC(src, PROC_REF(handle_item_insertion), new_item)

/obj/item/storage/holster/backholster/rlsadar/full/Initialize()
	. = ..()
	new /obj/item/ammo_magazine/rocket/sadar(src)
	new /obj/item/ammo_magazine/rocket/sadar(src)
	new /obj/item/ammo_magazine/rocket/sadar/ap(src)
	new /obj/item/ammo_magazine/rocket/sadar/ap(src)
	var/obj/item/new_item = new /obj/item/weapon/gun/launcher/rocket/sadar(src)
	INVOKE_ASYNC(src, PROC_REF(handle_item_insertion), new_item)

/obj/item/storage/holster/blade/officer
	draw_sound = 'modular_RUtgmc/sound/items/unsheath.ogg'
	sheathe_sound = 'modular_RUtgmc/sound/items/sheath.ogg'
	worn_layer = CAPE_LAYER
	holsterable_allowed = list(/obj/item/weapon/claymore/mercsword/officersword)
	can_hold = list(/obj/item/weapon/claymore/mercsword/officersword)

/obj/item/storage/holster/blade/officer/full/Initialize(mapload)
	. = ..()
	var/obj/item/new_item = new /obj/item/weapon/claymore/mercsword/officersword(src)
	INVOKE_ASYNC(src, PROC_REF(handle_item_insertion), new_item)

/obj/item/storage/holster/blade/officer/valirapier
	name = "\improper HP-C vali rapier sheath"
	desc = "An exquisite ceremonial sheath for an even more expensive rapier."
	icon = 'modular_RUtgmc/icons/obj/items/storage/storage.dmi'
	item_icons = list(
		slot_s_store_str = 'modular_RUtgmc/icons/mob/suit_slot.dmi',
		slot_belt_str = 'modular_RUtgmc/icons/mob/belt.dmi',
	)
	icon_state = "rapier_holster"
	holsterable_allowed = list(/obj/item/weapon/claymore/mercsword/officersword/valirapier)
	can_hold = list(/obj/item/weapon/claymore/mercsword/officersword/valirapier)

/obj/item/storage/holster/blade/officer/valirapier/full/Initialize()
	. = ..()
	var/obj/item/new_item = new /obj/item/weapon/claymore/mercsword/officersword/valirapier(src)
	INVOKE_ASYNC(src, PROC_REF(handle_item_insertion), new_item)

/obj/item/storage/holster/blade/officer/sabre
	name = "\improper officer sabre sheath"
	desc = "An exquisite ceremonial sheath of a high ranking command personel."
	icon = 'modular_RUtgmc/icons/obj/items/storage/storage.dmi'
	item_icons = list(
		slot_s_store_str = 'modular_RUtgmc/icons/mob/suit_slot.dmi',
		slot_belt_str = 'modular_RUtgmc/icons/mob/belt.dmi',
	)
	icon_state = "saber_holster"
	holsterable_allowed = list(/obj/item/weapon/claymore/mercsword/officersword/sabre)
	can_hold = list(/obj/item/weapon/claymore/mercsword/officersword/sabre)

/obj/item/storage/holster/blade/officer/sabre/full/Initialize()
	. = ..()
	var/obj/item/new_item = new /obj/item/weapon/claymore/mercsword/officersword/sabre(src)
	INVOKE_ASYNC(src, PROC_REF(handle_item_insertion), new_item)

/obj/item/storage/holster/belt
	icon = 'modular_RUtgmc/icons/obj/clothing/belts.dmi'
	item_icons = list(
		slot_s_store_str = 'modular_RUtgmc/icons/mob/suit_slot.dmi',
		slot_belt_str = 'modular_RUtgmc/icons/mob/clothing/belt.dmi',
	)
	storage_slots = 9
	max_storage_space = 19

/obj/item/storage/holster/backholster/mortar
	can_hold = list(
		/obj/item/mortal_shell/he,
		/obj/item/mortal_shell/incendiary,
		/obj/item/mortal_shell/smoke,
		/obj/item/mortal_shell/flare,
		/obj/item/mortal_shell/plasmaloss,
		/obj/item/mortar_kit,
		/obj/item/hud_tablet/artillery,
	)

/obj/item/storage/holster/blade //new sounds
	draw_sound = 'modular_RUtgmc/sound/weapons/melee/knife_out.ogg'
	sheathe_sound = 'modular_RUtgmc/sound/weapons/melee/knife_in.ogg'

/obj/item/storage/holster/blade/machete
	icon = 'modular_RUtgmc/icons/obj/items/storage/storage.dmi'

/obj/item/storage/holster/blade/machete/full_harvester
	icon = 'icons/obj/items/storage/storage.dmi'

// Tactical Tomahawk Holster

/obj/item/storage/holster/blade/tomahawk
	name = "\improper Tactical H23 Tomahawk scabbard"
	desc = "A large leather scabbard used to carry a H23 tomahawk. It can be strapped to the back, waist or armor."
	icon = 'modular_RUtgmc/icons/obj/items/storage/storage.dmi'
	icon_state = "tomahawk_holster"
	item_state = "tomahawk_holster"
	item_icons = list(
		slot_back_str = 'modular_RUtgmc/icons/mob/clothing/back.dmi',
		slot_belt_str = 'modular_RUtgmc/icons/mob/clothing/belt.dmi',
		slot_s_store_str = 'modular_RUtgmc/icons/mob/suit_slot.dmi'
	)
	flags_equip_slot = ITEM_SLOT_BELT|ITEM_SLOT_BACK
	holsterable_allowed = list(
		/obj/item/weapon/claymore/tomahawk
	)
	can_hold = list(
		/obj/item/weapon/claymore/tomahawk
	)

/obj/item/storage/holster/blade/tomahawk/full/Initialize(mapload)
	. = ..()
	var/obj/item/new_item = new /obj/item/weapon/claymore/tomahawk(src)
	INVOKE_ASYNC(src, PROC_REF(handle_item_insertion), new_item)
