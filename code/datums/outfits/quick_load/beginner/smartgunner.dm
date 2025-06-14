/datum/outfit/quick/beginner/smartgunner
	jobtype = SQUAD_SMARTGUNNER

	w_uniform = /obj/item/clothing/under/marine/black_vest
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/lightgeneral
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/m10x/antenna
	belt = /obj/item/belt_harness/marine
	glasses = /obj/item/clothing/glasses/night/m56_goggles

	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/inaprovaline = 2,
	)

/datum/outfit/quick/beginner/smartgunner/sg29
	name = "Standard Smartmachinegun"
	desc = "Tactical support fire. \
	Uses the SG-29, a specialist light machine gun that will shoot through your allies, \
	equipped with a tactical sensor to detect enemies through smoke, walls, and darkness."

	suit_store = /obj/item/weapon/gun/rifle/sg29/pmc
	l_hand = /obj/item/paper/tutorial/smartmachinegunner

	suit_contents = list(
		/obj/item/tool/extinguisher = 1,
		/obj/item/weapon/gun/pistol/plasma_pistol = 1,
	)

	webbing_contents = list(
		/obj/item/storage/box/m94 = 3,
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
	)

	backpack_contents = list(
		/obj/item/ammo_magazine/sg29 = 4,
		/obj/item/explosive/grenade = 1,
	)

/datum/outfit/quick/beginner/smartgunner/sg85
	name = "Standard Smartminigun"
	desc = "Lead wall! Wields the SG-85, a specialist minigun that holds one thousand rounds and can shoot through your allies, \
	equipped with a tactical sensor to detect enemies through smoke, walls, and darkness."

	suit_store = /obj/item/weapon/gun/minigun/smart_minigun/motion_detector
	back = /obj/item/ammo_magazine/minigun_powerpack/smartgun
	l_hand = /obj/item/paper/tutorial/smartminigunner

	suit_contents = list(
		/obj/item/ammo_magazine/packet/smart_minigun = 2,
	)

	webbing_contents = list(
		/obj/item/storage/box/m94 = 3,
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
	)
