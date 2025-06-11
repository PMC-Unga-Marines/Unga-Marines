/datum/outfit/quick/beginner/smartgunner
	jobtype = SQUAD_SMARTGUNNER

	w_uniform = /obj/item/clothing/under/marine/black_vest
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/lightgeneral
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/m10x/antenna
	belt = /obj/item/belt_harness/marine
	glasses = /obj/item/clothing/glasses/night/m56_goggles

/datum/outfit/quick/beginner/smartgunner/post_equip(mob/living/carbon/human/human, visualsOnly)
	human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/inaprovaline, SLOT_IN_HEAD)
	human.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/inaprovaline, SLOT_IN_HEAD)

/datum/outfit/quick/beginner/smartgunner/sg29
	name = "Standard Smartmachinegun"
	desc = "Tactical support fire. \
	Uses the SG-29, a specialist light machine gun that will shoot through your allies, \
	equipped with a tactical sensor to detect enemies through smoke, walls, and darkness."

	suit_store = /obj/item/weapon/gun/rifle/sg29/pmc
	l_hand = /obj/item/paper/tutorial/smartmachinegunner

/datum/outfit/quick/beginner/smartgunner/sg29/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	human.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/plasma_pistol, SLOT_IN_SUIT)

	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_ACCESSORY)

	for(var/i in 1 to 4)
		human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sg29, SLOT_IN_BACKPACK)
	human.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_BACKPACK)

/datum/outfit/quick/beginner/smartgunner/sg85
	name = "Standard Smartminigun"
	desc = "Lead wall! Wields the SG-85, a specialist minigun that holds one thousand rounds and can shoot through your allies, \
	equipped with a tactical sensor to detect enemies through smoke, walls, and darkness."

	suit_store = /obj/item/weapon/gun/minigun/smart_minigun/motion_detector
	back = /obj/item/ammo_magazine/minigun_powerpack/smartgun
	l_hand = /obj/item/paper/tutorial/smartminigunner

/datum/outfit/quick/beginner/smartgunner/sg85/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	human.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/smart_minigun, SLOT_IN_SUIT)
	human.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/smart_minigun, SLOT_IN_SUIT)

	for(var/i in 1 to 3)
		human.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_ACCESSORY)
	human.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_ACCESSORY)
