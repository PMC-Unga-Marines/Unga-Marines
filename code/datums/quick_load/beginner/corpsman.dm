/datum/outfit/quick/beginner/corpsman
	jobtype = SQUAD_CORPSMAN

	w_uniform = /obj/item/clothing/under/marine/corpsman/corpman_vest
	glasses = /obj/item/clothing/glasses/hud/health
	r_hand = /obj/item/medevac_beacon

/datum/outfit/quick/beginner/corpsman/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_HEAD)
	human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_HEAD)

/datum/outfit/quick/beginner/corpsman/lifesaver
	name = "Standard Lifesaver"
	desc = "Miracle in progress. \
	Wields the bolt action Leicaster Repeater, and is equipped with a large variety of medicine for keeping the entire corps topped up and in the fight."

	suit_store = /obj/item/weapon/gun/shotgun/pump/lever/repeater/beginner
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/mimirinjector
	gloves = /obj/item/defibrillator/gloves
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/m10x/mimir
	r_store = /obj/item/storage/pouch/medkit/medic
	l_store = /obj/item/storage/pouch/shotgun
	back = /obj/item/storage/backpack/marine/corpsman
	belt = /obj/item/storage/belt/lifesaver/beginner
	l_hand = /obj/item/paper/tutorial/lifesaver

/datum/outfit/quick/beginner/corpsman/lifesaver/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	human.equip_to_slot_or_del(new /obj/item/roller, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/bodybag/cryobag, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/oxycodone, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/nanoblood, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/roller/medevac, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/tweezers, SLOT_IN_ACCESSORY)

	for(var/i in 1 to 8)
		human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/combat_advanced, SLOT_IN_SUIT)
	for(var/i in 1 to 2)
		human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/dexalinplus, SLOT_IN_SUIT)
	for(var/i in 1 to 2)
		human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclot, SLOT_IN_SUIT)
	for(var/i in 1 to 2)
		human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon, SLOT_IN_SUIT)

	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)

	for(var/i in 1 to 7)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p4570, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_BACKPACK)

	for(var/i in 1 to 7)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/repeater, SLOT_IN_L_POUCH)

/datum/outfit/quick/beginner/corpsman/hypobelt
	name = "Standard Hypobelt"
	desc = "Putting the combat in combat medic. \
	Wields the pump action SH-35 shotgun, and is equipped with a belt full of hyposprays for rapidly treating patients in bad condition."

	suit_store = /obj/item/weapon/gun/shotgun/pump/t35/beginner
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/light/lightmedical
	gloves = /obj/item/healthanalyzer/gloves
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/m10x/antenna
	r_store = /obj/item/storage/pouch/medkit/medic
	l_store = /obj/item/storage/pouch/shotgun
	back = /obj/item/storage/backpack/marine/corpsman
	belt = /obj/item/storage/belt/hypospraybelt/beginner
	l_hand = /obj/item/paper/tutorial/hypobelt

/datum/outfit/quick/beginner/corpsman/hypobelt/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	for(var/i in 1 to 6)
		human.equip_to_slot_or_del(new /obj/item/stack/medical/splint, SLOT_IN_ACCESSORY)

	human.equip_to_slot_or_del(new /obj/item/roller, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/bodybag/cryobag, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/oxycodone, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/roller/medevac, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/tweezers, SLOT_IN_SUIT)

	for(var/i in 1 to 7)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/slug, SLOT_IN_L_POUCH)

	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/defibrillator/advanced, SLOT_IN_BACKPACK)
	for(var/i in 1 to 4)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/shotgun, SLOT_IN_BACKPACK)
