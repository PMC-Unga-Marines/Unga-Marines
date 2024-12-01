/datum/outfit/quick/beginner/engineer
	jobtype = SQUAD_ENGINEER

	w_uniform = /obj/item/clothing/under/marine/brown_vest
	gloves = /obj/item/clothing/gloves/marine/insulated
	l_store = /obj/item/storage/pouch/tools/engineer

/datum/outfit/quick/beginner/engineer/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()

	human.equip_to_slot_or_del(new /obj/item/explosive/grenade/chem_grenade/razorburn_smol, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/circuitboard/apc, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/tool/handheld_charger/hicapcell, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_ACCESSORY)

	human.equip_to_slot_or_del(new /obj/item/stack/sheet/plasteel/medium_stack, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, SLOT_IN_SUIT)

	human.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_HEAD)
	human.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_HEAD)

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

/datum/outfit/quick/beginner/engineer/builder/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, SLOT_IN_SUIT)

	for(var/i in 1 to 7)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/vector, SLOT_IN_BELT)

	human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/small_stack, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/stack/sandbags_empty/full, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/weapon/gun/sentry/basic, SLOT_IN_BACKPACK)
	for(var/i in 1 to 4)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/acp, SLOT_IN_BACKPACK)

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
	human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/medium_stack, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/circuitboard/apc, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/tool/multitool, SLOT_IN_SUIT)

	human.equip_to_slot_or_del(new /obj/item/weapon/gun/flamer/big_flamer/marinestandard/engineer/beginner(human), SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/storage/box/explosive_mines/large, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/weapon/gun/sentry/basic, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool, SLOT_IN_BACKPACK)

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

/datum/outfit/quick/beginner/engineer/pcenjoyer/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()

	human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/small_stack, SLOT_IN_SUIT)

	human.equip_to_slot_or_del(new /obj/item/weapon/gun/revolver/r44(human), SLOT_IN_BACKPACK)
	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/r44, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/weapon/gun/sentry/basic, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/magnum, SLOT_IN_BACKPACK)
