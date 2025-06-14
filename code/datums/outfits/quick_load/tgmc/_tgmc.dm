//Base TGMC outfit
/datum/outfit/quick/tgmc
	name = "TGMC base"
	desc = "This is the base typepath for all TGMC quick vendor outfits. You shouldn't see this."

//Base TGMC marine outfit
/datum/outfit/quick/tgmc/marine
	name = "TGMC Squad Marine"
	jobtype = SQUAD_MARINE

	ears = /obj/item/radio/headset/mainship/marine
	w_uniform = /obj/item/clothing/under/marine/black_vest
	shoes = /obj/item/clothing/shoes/marine/full
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/heavy/shield
	gloves = /obj/item/clothing/gloves/marine
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/m10x
	r_pocket = /obj/item/storage/pouch/firstaid/combat_patrol
	l_pocket = /obj/item/storage/pouch/grenade/combat_patrol
	back = /obj/item/storage/backpack/marine/satchel

	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/combat = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
	)
	suit_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/isotonic = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
	)
