/datum/outfit/quick/beginner/engineer
	jobtype = SQUAD_ENGINEER

	w_uniform = /obj/item/clothing/under/marine/brown_vest
	gloves = /obj/item/clothing/gloves/marine/insulated
	l_pocket = /obj/item/storage/pouch/tools/engineer
	webbing_contents = list(
		/obj/item/explosive/grenade/chem_grenade/razorburn_small = 1,
		/obj/item/circuitboard/apc = 1,
		/obj/item/tool/handheld_charger/hicapcell = 1,
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
	)
	suit_contents = list(
		/obj/item/stack/sheet/plasteel/medium_stack = 1,
		/obj/item/stack/sheet/metal/large_stack = 1,
	)
	head_contents = list(
		/obj/item/explosive/plastique = 2,
	)

/datum/outfit/quick/beginner/engineer/builder
	name = "Engineer Standard"
	desc = "Born to build. Equipped with a metric ton of metal, you can be certain that a lack of barricades is not a possibility with you around."

	suit_store = /obj/item/weapon/gun/smg/vector/beginner
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/heavy/mimirengi
	mask = /obj/item/clothing/mask/gas/tactical
	head = /obj/item/clothing/head/modular/m10x/mimir
	back = /obj/item/storage/backpack/marine/radiopack
	glasses = /obj/item/clothing/glasses/welding/superior
	l_hand = /obj/item/paper/tutorial/builder

	suit_contents = list(
		/obj/item/stack/sheet/plasteel/medium_stack = 1,
		/obj/item/stack/sheet/metal/large_stack = 4,
	)
	belt_contents = list(
		/obj/item/ammo_magazine/smg/vector = 7,
	)
	backpack_contents = list(
		/obj/item/stack/sheet/metal/small_stack = 1,
		/obj/item/stack/sandbags_empty/full = 1,
		/obj/item/tool/shovel/etool = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/weapon/gun/sentry/basic = 1,
		/obj/item/ammo_magazine/packet/acp = 4,
	)

/datum/outfit/quick/beginner/engineer/burnitall
	name = "Flamethrower"
	desc = "For those who truly love to watch the world burn. Equipped with a laser and a flamethrower, you can be certain that none of your enemies will be left un-burnt."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_carbine/beginner
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/engineer
	mask = /obj/item/clothing/mask/gas/tactical/coif
	head = /obj/item/clothing/head/modular/m10x/superiorwelding
	back = /obj/item/storage/holster/backholster/flamer
	belt = /obj/item/storage/belt/marine/te_cells
	glasses = /obj/item/clothing/glasses/meson
	l_hand = /obj/item/paper/tutorial/flamer

/datum/outfit/quick/beginner/engineer/burnitall/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	suit_contents = list(
		/obj/item/stack/sheet/plasteel/medium_stack = 1,
		/obj/item/stack/sheet/metal/large_stack = 1,
		/obj/item/stack/sheet/metal/medium_stack = 1,
		/obj/item/circuitboard/apc = 1,
		/obj/item/tool/multitool = 1,
	)

	backpack_contents = list(
		/obj/item/weapon/gun/flamer/big_flamer/marinestandard/engineer/beginner = 1,
		/obj/item/storage/box/explosive_mines/large = 1,
		/obj/item/weapon/gun/sentry/basic = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/tool/shovel/etool = 1,
	)

/datum/outfit/quick/beginner/engineer/pcenjoyer
	name = "Plasma Cutter"
	desc = "For the open-air enjoyers. Equipped with a plasma cutter, you will be able to cut down all types of walls and obstacles that dare exist within your vicinity."

	suit_store = /obj/item/tool/pickaxe/plasmacutter
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/engineer
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/m10x/superiorwelding
	back = /obj/item/storage/backpack/marine/engineerpack
	belt = /obj/item/belt_harness/marine
	glasses = /obj/item/clothing/glasses/meson
	l_hand = /obj/item/paper/tutorial/plasmacutter

	suit_contents = list(
		/obj/item/stack/sheet/plasteel/medium_stack = 1,
		/obj/item/stack/sheet/metal/large_stack = 3,
		/obj/item/stack/sheet/metal/small_stack = 1,
	)
	backpack_contents = list(
		/obj/item/weapon/gun/revolver/r44 = 1,
		/obj/item/ammo_magazine/revolver/r44 = 3,
		/obj/item/weapon/gun/sentry/basic = 1,
		/obj/item/ammo_magazine/packet/magnum = 1,
	)
