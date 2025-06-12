/datum/outfit/quick/beginner/marine
	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 2,
	)

/datum/outfit/quick/beginner/marine/rifleman
	name = "Rifleman"
	desc = "A typical rifleman for the marines. \
	Wields the AR-12, a versatile all-rounder assault rifle with a powerful underbarrel grenade launcher attached. \
	Also carries the strong P-23 sidearm and a variety of flares, medical equipment, and more for every situation."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/hodgrenades
	head = /obj/item/clothing/head/modular/m10x/hod
	w_uniform = /obj/item/clothing/under/marine/holster
	suit_store = /obj/item/weapon/gun/rifle/ar12/medic
	l_hand = /obj/item/paper/tutorial/beginner_rifleman

	backpack_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/ammo_magazine/packet/p10x24mm = 3,
	)

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/ar12 = 6,
	)

	webbing_contents = list(
		/obj/item/ammo_magazine/pistol/p23 = 3,
		/obj/item/weapon/gun/pistol/p23/beginner = 1,
	)

	suit_contents = list(
		/obj/item/explosive/grenade = 6,
	)

/datum/outfit/quick/beginner/marine/machinegunner
	name = "Machinegunner"
	desc = "The king of suppressive fire. Uses the MG-60, a fully automatic 200 round machine gun with a bipod attached. \
	Excels at denying large areas to the enemy and eliminating those who refuse to leave."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/heavy/tyr_onegeneral
	head = /obj/item/clothing/head/modular/m10x/tyr
	w_uniform = /obj/item/clothing/under/marine/black_vest
	back = /obj/item/storage/backpack/marine/standard
	belt = /obj/item/storage/belt/sparepouch
	suit_store = /obj/item/weapon/gun/rifle/mg60/beginner
	mask = /obj/item/clothing/mask/rebreather
	l_hand = /obj/item/paper/tutorial/beginner_machinegunner

	backpack_contents = list(
		/obj/item/ammo_magazine/mg60 = 8,
	)
	belt_contents = list(
		/obj/item/ammo_magazine/mg60 = 3,\
	)
	webbing_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/storage/box/m94 = 2,
	)
	suit_contents = list(
		/obj/item/weapon/gun/pistol/plasma_pistol = 1,
		/obj/item/tool/extinguisher = 1,
	)

/datum/outfit/quick/beginner/marine/marksman
	name = "Marksman"
	desc = "Quality over quantity. Equipped with the DMR-37, an accurate long-range designated marksman rifle with a scope attached. \
	While subpar in close quarters, the precision of the DMR is unmatched, exceeding at taking out threats from afar."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/lightmedical
	head = /obj/item/clothing/head/modular/m10x/tyr
	w_uniform = /obj/item/clothing/under/marine/holster
	belt = /obj/item/belt_harness/marine
	l_pocket = /obj/item/storage/pouch/magazine/large
	r_pocket = /obj/item/storage/pouch/magazine/large
	suit_store = /obj/item/weapon/gun/rifle/dmr37/beginner
	mask = /obj/item/clothing/mask/breath
	l_hand = /obj/item/paper/tutorial/beginner_marksman

	backpack_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/ammo_magazine/packet/p10x27mm = 3,
	)
	l_pocket_contents = list(
		/obj/item/ammo_magazine/rifle/dmr37 = 6,
	)

	webbing_contents = list(
		/obj/item/ammo_magazine/pistol/vp70 = 3,
		/obj/item/weapon/gun/pistol/vp70/beginner = 1,
	)

	suit_contents = list(
		/obj/item/storage/pill_bottle/bicaridine = 1,
		/obj/item/storage/pill_bottle/kelotane = 1,
		/obj/item/storage/pill_bottle/tricordrazine = 1,
		/obj/item/storage/pill_bottle/tramadol = 1,
		/obj/item/storage/pill_bottle/dylovene = 1,
	)

/datum/outfit/quick/beginner/marine/shotgunner
	name = "Shotgunner"
	desc = "Up close and personal. Wields the SH-39, a semi-automatic shotgun loaded with slugs. \
	An absolute monster at short to mid range, the shotgun will do heavy damage to any target hit, as well as stunning them briefly, staggering them, and knocking them back."

	w_uniform = /obj/item/clothing/under/marine/holster
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/lightgeneral
	suit_store = /obj/item/weapon/gun/shotgun/combat/standardmarine/beginner
	belt = /obj/item/storage/belt/shotgun
	head = /obj/item/clothing/head/modular/m10x/freyr
	gloves = /obj/item/clothing/gloves/marine/fingerless
	mask = /obj/item/clothing/mask/gas/tactical/coif
	l_hand = /obj/item/paper/tutorial/beginner_shotgunner

	backpack_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/ammo_magazine/shotgun = 2,
		/obj/item/reagent_containers/hypospray/autoinjector/inaprovaline = 1,
	)

	belt_contents = list(
		/obj/item/ammo_magazine/handful/slug = 14,
	)

	webbing_contents = list(
		/obj/item/ammo_magazine/pistol/plasma_pistol = 3,
		/obj/item/weapon/gun/pistol/plasma_pistol/beginner = 1,
	)
	suit_contents = list(
		/obj/item/storage/box/m94 = 2,
	)

/datum/outfit/quick/beginner/marine/shocktrooper
	name = "Shocktrooper"
	desc = "The bleeding edge of the corps. \
	Equipped with the experimental battery-fed laser rifle, featuring four different modes that can be freely swapped between, with an underbarrel flamethrower for area denial and clearing mazes."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle/medic
	belt = /obj/item/storage/belt/marine/te_cells
	glasses = /obj/item/clothing/glasses/sunglasses/fake/big
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/lightgeneral
	head = /obj/item/clothing/head/modular/m10x/freyr
	mask = /obj/item/clothing/mask/gas/tactical/coif
	r_pocket = /obj/item/cell/lasgun/volkite/powerpack/marine
	w_uniform = /obj/item/clothing/under/marine/corpman_vest
	l_hand = /obj/item/paper/tutorial/beginner_shocktrooper

	backpack_contents = list(
		/obj/item/ammo_magazine/flamer_tank/mini = 5,
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
	)

	suit_contents = list(
		/obj/item/cell/lasgun/volkite/powerpack/marine = 1,
		/obj/item/storage/box/m94 = 1,
	)

	webbing_contents = list(
		/obj/item/storage/pill_bottle/bicaridine = 1,
		/obj/item/storage/pill_bottle/kelotane = 1,
		/obj/item/storage/pill_bottle/tricordrazine = 1,
		/obj/item/storage/pill_bottle/tramadol = 1,
		/obj/item/storage/pill_bottle/dylovene = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/inaprovaline = 1,
	)

/datum/outfit/quick/beginner/marine/hazmat
	name = "Hazmat"
	desc = "Designed for danger. \
	Wields the Type 71 'GROZA', a powerful yet innacurate assault rifle that fires auto-bursts. \
	Wears Mimir combat armor, rendering the user immune to the dangerous toxic gas possessed by many xenomorphs."

	head = /obj/item/clothing/head/modular/m10x/mimir
	suit_store = /obj/item/weapon/gun/rifle/type71/beginner
	w_uniform = /obj/item/clothing/under/marine/black_vest
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/mimir
	mask = /obj/item/clothing/mask/rebreather/scarf
	l_hand = /obj/item/paper/tutorial/beginner_hazmat

	backpack_contents = list(
		/obj/item/ammo_magazine/packet/groza = 3,
		/obj/item/explosive/grenade/m15 = 3,
	)

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/type71 = 6,
	)

	webbing_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/storage/box/m94 = 2,
	)

	suit_contents = list(
		/obj/item/weapon/gun/pistol/plasma_pistol = 1,
		/obj/item/tool/extinguisher = 1,
	)

/datum/outfit/quick/beginner/marine/cqc
	name = "CQC"
	desc = "Swift and lethal. \
	Equipped with the AR-18, a lightweight carbine with a rapid-fire burst mode. Designed for maximum mobility, soldiers are able to rush in, assault the enemy, and retreat before they can respond."

	suit_store = /obj/item/weapon/gun/rifle/ar18/beginner
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/lightgeneral
	w_uniform = /obj/item/clothing/under/marine/black_vest
	head = /obj/item/clothing/head/modular/m10x/freyr
	glasses = /obj/item/clothing/glasses/mgoggles
	l_hand = /obj/item/paper/tutorial/beginner_cqc
	belt_contents = list(
		/obj/item/ammo_magazine/rifle/ar18 = 6,
	)
	backpack_contents = list(
		/obj/item/ammo_magazine/packet/p10x24mm = 3,
		/obj/item/explosive/grenade/m15 = 3,
	)
	suit_contents = list(
		/obj/item/weapon/gun/pistol/plasma_pistol = 1,
		/obj/item/tool/extinguisher = 1,
	)
	webbing_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/storage/box/m94 = 2,
	)
