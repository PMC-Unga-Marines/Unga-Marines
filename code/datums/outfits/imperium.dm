/datum/outfit/job/imperial
	name = "Imperial Standard"
	jobtype = /datum/job/imperial

	id = /obj/item/card/id
	ears = /obj/item/radio/headset/distress/imperial
	w_uniform = /obj/item/clothing/under/marine/imperial
	shoes = /obj/item/clothing/shoes/marine/imperial
	gloves = /obj/item/clothing/gloves/marine

/datum/outfit/job/imperial/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.grant_language(/datum/language/imperial)

/datum/outfit/job/imperial/guardsman
	name = "Imperial Guardsman"
	jobtype = /datum/job/imperial/guardsman

	belt = /obj/item/storage/belt/marine/te_cells
	wear_suit = /obj/item/clothing/suit/storage/marine/imperial
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle
	head = /obj/item/clothing/head/helmet/marine/imperial
	r_store = /obj/item/storage/pouch/medical_injectors/firstaid
	l_store = /obj/item/storage/holster/flarepouch/full
	back = /obj/item/storage/backpack/lightpack

/datum/outfit/job/imperial/guardsman/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/tricordrazine, SLOT_IN_HEAD)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/oxycodone, SLOT_IN_HEAD)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_SUIT)

	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/enrg_bar, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/enrg_bar, SLOT_IN_BACKPACK)


/datum/outfit/job/imperial/guardsman/sergeant
	name = "Guardsman Sergeant"
	jobtype = /datum/job/imperial/guardsman/sergeant

	wear_suit = /obj/item/clothing/suit/storage/marine/imperial/sergeant
	head = /obj/item/clothing/head/helmet/marine/imperial/sergeant
	r_store = /obj/item/storage/pouch/explosive/upp
	l_store = /obj/item/storage/pouch/field_pouch/full

/datum/outfit/job/imperial/guardsman/medicae
	name = "Guardsman Medicae"
	jobtype = /datum/job/imperial/guardsman/medicae

	belt = /obj/item/storage/belt/lifesaver/full
	wear_suit = /obj/item/clothing/suit/storage/marine/imperial/medicae
	glasses = /obj/item/clothing/glasses/hud/health
	l_store = /obj/item/storage/pouch/medkit/medic
	r_store = /obj/item/storage/pouch/medical_injectors/medic

/datum/outfit/job/imperial/guardsman/medicae/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/defibrillator, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/pill_bottle/zoom, SLOT_IN_BACKPACK) // closest thing to combat performance drugs

/datum/outfit/job/imperial/commissar
	name = "Imperial Commissar"
	jobtype = /datum/job/imperial/commissar

	belt = /obj/item/storage/holster/belt/revolver/mateba/full //Ideally this can be later replaced with a bolter
	w_uniform = /obj/item/clothing/under/marine/imperial/commissar
	wear_suit = /obj/item/clothing/suit/storage/marine/imperial/commissar
	suit_store = /obj/item/weapon/sword/commissar
	gloves = /obj/item/clothing/gloves/marine/commissar
	head = /obj/item/clothing/head/commissar
	l_store = /obj/item/storage/pouch/medkit/firstaid
	r_store = /obj/item/storage/pouch/magazine/pistol/large/mateba
	back = /obj/item/storage/backpack/lightpack

/datum/outfit/job/imperial/commissar/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_SUIT)

	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/enrg_bar, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/enrg_bar, SLOT_IN_BACKPACK)
