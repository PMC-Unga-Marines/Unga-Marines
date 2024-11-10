/*!
 * Any loadout that is intended for the new player loadout vendor
 */

///When making new loadouts, remember to also add the typepath to the list under init_beginner_loadouts() or else it won't show up in the vendor

/datum/outfit/quick/beginner
	name = "Beginner loadout base"
	desc = "The base loadout for beginners. You shouldn't be able to see this"
	jobtype = SQUAD_MARINE

	w_uniform = /obj/item/clothing/under/marine
	shoes = /obj/item/clothing/shoes/marine/full
	wear_suit = /obj/item/clothing/suit/modular/xenonauten
	gloves = /obj/item/clothing/gloves/marine
	mask = /obj/item/clothing/mask/bandanna
	head = /obj/item/clothing/head/modular/m10x
	r_store = /obj/item/storage/pouch/medkit/firstaid
	l_store = /obj/item/storage/holster/flarepouch/full
	back = /obj/item/storage/backpack/marine/satchel
	belt = /obj/item/storage/belt/marine
	ears = /obj/item/radio/headset/mainship/marine

/datum/outfit/quick/beginner/post_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	human.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BOOT)
