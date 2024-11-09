//Base TGMC engineer outfit
/datum/outfit/quick/tgmc/engineer
	name = "TGMC Squad Engineer"
	jobtype = SQUAD_ENGINEER

	ears = /obj/item/radio/headset/mainship/marine
	glasses = /obj/item/clothing/glasses/meson
	w_uniform = /obj/item/clothing/under/marine/engineer/black_vest
	shoes = /obj/item/clothing/shoes/marine/full
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/engineer
	gloves = /obj/item/clothing/gloves/marine/insulated
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/m10x/welding
	r_store = /obj/item/storage/pouch/firstaid/combat_patrol
	l_store = /obj/item/storage/pouch/tools/full
	back = /obj/item/storage/backpack/marine/engineerpack

/datum/outfit/quick/tgmc/engineer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_HEAD)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_HEAD)

	H.equip_to_slot_or_del(new /obj/item/circuitboard/apc, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/cell/high, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/stack/sheet/plasteel/medium_stack, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/stack/barbed_wire/half_stack, SLOT_IN_SUIT)

/datum/outfit/quick/tgmc/engineer/rrengineer
	name = "Rocket Specialist"
	desc = "Bringing the big guns. Equipped with a AR-18 carbine and RL-160 along with the standard engineer kit. Excellent against groups of enemy infantry or light armor, but only has limited ammunition."
	quantity = 2

	suit_store = /obj/item/weapon/gun/rifle/ar18/engineer
	back = /obj/item/storage/holster/backholster/rpg/low_impact
	belt = /obj/item/storage/belt/marine/ar18

/datum/outfit/quick/tgmc/engineer/rrengineer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/dylovene, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/stack/cable_coil, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/chem_grenade/razorburn_large, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/engineer/sentry
	name = "Sentry Technician"
	desc = "Firing more guns than you have hands. Equipped with a AR-12 assault rifle with miniflamer, and two minisentries along with the standard engineer kit. Allows the user to quickly setup strong points and lock areas down, with some sensible placement."

	suit_store = /obj/item/weapon/gun/rifle/ar12/engineer
	belt = /obj/item/storage/belt/marine/ar12

/datum/outfit/quick/tgmc/engineer/sentry/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/sentry/mini/combat_patrol, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/sentry/mini/combat_patrol, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/minisentry, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/minisentry, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/dylovene, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/mini, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/stack/cable_coil, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/chem_grenade/razorburn_large, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/engineer/demolition
	name = "Demolition Specialist"
	desc = "Boom boom, shake the room. Equipped with a SH-15 auto shotgun and UGL and an impressive array of mines, detpacks and grenades, along with the standard engineer kit. Excellent for blasting through any obstacle, and mining areas to restrict enemy movement."

	suit_store = /obj/item/weapon/gun/rifle/sh15/engineer
	back = /obj/item/storage/backpack/marine/tech
	belt = /obj/item/storage/belt/marine/auto_shotgun

/datum/outfit/quick/tgmc/engineer/demolition/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/minelayer, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/explosive_mines/large, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/explosive_mines, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/stack/cable_coil, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/detpack, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/detpack, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/detpack, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/dylovene, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/assembly/signaler, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
