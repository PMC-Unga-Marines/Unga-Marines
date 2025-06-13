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
	r_pocket = /obj/item/storage/pouch/firstaid/combat_patrol
	l_pocket = /obj/item/storage/pouch/tools/full
	back = /obj/item/storage/backpack/marine/engineerpack

	head_contents = list(
		/obj/item/explosive/plastique = 2,
	)
	suit_contents = list(
		/obj/item/circuitboard/apc = 1,
		/obj/item/cell/high = 1,
		/obj/item/stack/sheet/plasteel/medium_stack = 1,
		/obj/item/stack/sheet/metal/large_stack = 1,
		/obj/item/stack/barbed_wire/half_stack = 1,
	)

/datum/outfit/quick/tgmc/engineer/rrengineer
	name = "Rocket Specialist"
	desc = "Bringing the big guns. Equipped with a AR-18 carbine and RL-160 along with the standard engineer kit. Excellent against groups of enemy infantry or light armor, but only has limited ammunition."
	quantity = 2

	suit_store = /obj/item/weapon/gun/rifle/ar18/engineer
	back = /obj/item/storage/holster/backholster/rpg/low_impact
	belt = /obj/item/storage/belt/marine/ar18

	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/grenade/chem_grenade/razorburn_large = 1,
		/obj/item/explosive/grenade/smokebomb = 1,
	)

/datum/outfit/quick/tgmc/engineer/sentry
	name = "Sentry Technician"
	desc = "Firing more guns than you have hands. Equipped with a AR-12 assault rifle with miniflamer, and two minisentries along with the standard engineer kit. Allows the user to quickly setup strong points and lock areas down, with some sensible placement."

	suit_store = /obj/item/weapon/gun/rifle/ar12/engineer
	belt = /obj/item/storage/belt/marine/ar12

	backpack_contents = list(
		/obj/item/weapon/gun/sentry/mini/combat_patrol = 2,
		/obj/item/ammo_magazine/minisentry = 2,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
	)
	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/flamer_tank/mini = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/grenade/chem_grenade/razorburn_large = 1,
		/obj/item/explosive/grenade/smokebomb = 1,
	)

/datum/outfit/quick/tgmc/engineer/demolition
	name = "Demolition Specialist"
	desc = "Boom boom, shake the room. Equipped with a SH-15 auto shotgun and UGL and an impressive array of mines, detpacks and grenades, along with the standard engineer kit. Excellent for blasting through any obstacle, and mining areas to restrict enemy movement."

	suit_store = /obj/item/weapon/gun/rifle/sh15/engineer
	back = /obj/item/storage/backpack/marine/tech
	belt = /obj/item/storage/belt/marine/auto_shotgun

	backpack_contents = list(
		/obj/item/minelayer = 1,
		/obj/item/storage/box/explosive_mines/large = 1,
		/obj/item/storage/box/explosive_mines = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/detpack = 3,
		/obj/item/explosive/plastique = 2,
		/obj/item/storage/box/mre = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/explosive/grenade/smokebomb = 1,
	)
	webbing_contents = list(
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/assembly/signaler = 1,
		/obj/item/explosive/grenade/sticky = 3,
	)
