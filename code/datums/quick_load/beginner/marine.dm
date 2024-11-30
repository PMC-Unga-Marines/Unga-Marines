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

/datum/outfit/quick/beginner/marine/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_HEAD)
	human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_HEAD)

/datum/outfit/quick/beginner/marine/rifleman/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_BACKPACK)
	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x24mm, SLOT_IN_BACKPACK)

	for(var/i in 1 to 6)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar12, SLOT_IN_BELT)

	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/p23/beginner(human), SLOT_IN_ACCESSORY)

	for(var/i in 1 to 6)
		human.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_SUIT)

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

/datum/outfit/quick/beginner/marine/machinegunner/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	for(var/i in 1 to 8)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/mg60, SLOT_IN_BACKPACK)

	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/mg60, SLOT_IN_BELT)

	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_ACCESSORY)

	human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/plasma_pistol, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_SUIT)

/datum/outfit/quick/beginner/marine/marksman
	name = "Marksman"
	desc = "Quality over quantity. Equipped with the DMR-37, an accurate long-range designated marksman rifle with a scope attached. \
	While subpar in close quarters, the precision of the DMR is unmatched, exceeding at taking out threats from afar."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/lightmedical
	head = /obj/item/clothing/head/modular/m10x/tyr
	w_uniform = /obj/item/clothing/under/marine/holster
	belt = /obj/item/belt_harness/marine
	l_store = /obj/item/storage/pouch/magazine/large
	r_store = /obj/item/storage/pouch/magazine/large
	suit_store = /obj/item/weapon/gun/rifle/dmr37/beginner
	mask = /obj/item/clothing/mask/breath
	l_hand = /obj/item/paper/tutorial/beginner_marksman

/datum/outfit/quick/beginner/marine/marksman/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_BACKPACK)
	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x27mm, SLOT_IN_BACKPACK)

	for(var/i in 1 to 6)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/dmr37, SLOT_IN_L_POUCH)

	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70/beginner(human), SLOT_IN_ACCESSORY)

	human.equip_to_slot_or_del(new /obj/item/storage/pill_bottle/bicaridine, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/storage/pill_bottle/kelotane, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/storage/pill_bottle/tricordrazine, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/storage/pill_bottle/tramadol, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/storage/pill_bottle/dylovene, SLOT_IN_SUIT)

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

/datum/outfit/quick/beginner/marine/shotgunner/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/ammo_magazine/shotgun, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/ammo_magazine/shotgun, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/inaprovaline, SLOT_IN_BACKPACK)

	for(var/i in 1 to 14)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/slug, SLOT_IN_BELT)

	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/plasma_pistol, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/plasma_pistol/beginner(human), SLOT_IN_ACCESSORY)

	human.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_SUIT)

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
	r_store = /obj/item/cell/lasgun/volkite/powerpack/marine
	w_uniform = /obj/item/clothing/under/marine/corpman_vest
	l_hand = /obj/item/paper/tutorial/beginner_shocktrooper

/datum/outfit/quick/beginner/marine/shocktrooper/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	for(var/i in 1 to 5)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/mini, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_BACKPACK)

	human.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/powerpack/marine, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_SUIT)

	human.equip_to_slot_or_del(new /obj/item/storage/pill_bottle/bicaridine, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/storage/pill_bottle/kelotane, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/storage/pill_bottle/tricordrazine, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/storage/pill_bottle/tramadol, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/storage/pill_bottle/dylovene, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/inaprovaline, SLOT_IN_ACCESSORY)

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

/datum/outfit/quick/beginner/marine/hazmat/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/groza, SLOT_IN_BACKPACK)
	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_BACKPACK)

	for(var/i in 1 to 6)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type71, SLOT_IN_BELT)

	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_ACCESSORY)

	human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/plasma_pistol, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_SUIT)

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

/datum/outfit/quick/beginner/marine/cqc/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	for(var/i in 1 to 6)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar18, SLOT_IN_BELT)

	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x24mm, SLOT_IN_BACKPACK)
	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_BACKPACK)

	human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/plasma_pistol, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_SUIT)

	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_ACCESSORY)
