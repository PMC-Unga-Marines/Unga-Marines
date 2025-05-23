/*
*	These absorb the functionality of the plant bag, ore satchel, etc.
*	They use the use_to_pickup, quick_gather, and quick_empty functions
*	that were already defined in weapon/storage, but which had been
*	re-implemented in other classes.
*
*	Contains:
*		Trash Bag
*		Mining Satchel
*		Plant Bag
*		Sheet Snatcher
*		Cash Bag
*
*	-Sayu
*/

//  Generic non-item
/obj/item/storage/bag
	icon = 'icons/obj/items/storage/bag.dmi'
	storage_type = /datum/storage/bag
	equip_slot_flags = ITEM_SLOT_BELT

// -----------------------------
//          Trash bag
// -----------------------------
/obj/item/storage/bag/trash
	name = "trash bag"
	desc = "It's the heavy-duty black polymer kind. Time to take out the trash!"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "trash0"
	worn_icon_state = "trashbag"

	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/bag/trash

/obj/item/storage/bag/trash/update_icon_state()
	. = ..()
	if(length(contents) == 0)
		icon_state = "trash0"
	else if(length(contents) < 12)
		icon_state = "trash1"
	else if(length(contents) < 21)
		icon_state = "trash2"
	else
		icon_state = "trash3"

// -----------------------------
//        Plastic Bag
// -----------------------------

/obj/item/storage/bag/plasticbag
	name = "plastic bag"
	desc = "It's a very flimsy, very noisy alternative to a bag."
	icon = 'icons/obj/items/trash.dmi'
	icon_state = "plasticbag"
	worn_icon_state = "plasticbag"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/bag/plastic

// -----------------------------
//        Mining Satchel
// -----------------------------

/obj/item/storage/bag/ore
	name = "Mining Satchel"
	desc = "This little bugger can be used to store and transport ores."
	icon = 'icons/obj/mining.dmi'
	icon_state = "satchel"
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_POCKET
	w_class = WEIGHT_CLASS_NORMAL
	storage_type = /datum/storage/bag/ore

// -----------------------------
//          Plant bag
// -----------------------------

/obj/item/storage/bag/plants
	icon_state = "plant"
	name = "Plant Bag"
	w_class = WEIGHT_CLASS_SMALL
	storage_type = /datum/storage/bag/plants

// -----------------------------
//        Sheet Snatcher
// -----------------------------
// Because it stacks stacks, this doesn't operate normally.
// However, making it a storage/bag allows us to reuse existing code in some places. -Sayu

/obj/item/storage/bag/sheetsnatcher
	icon = 'icons/obj/mining.dmi'
	icon_state = "sheetsnatcher"
	name = "Sheet Snatcher"
	desc = "A patented Nanotrasen storage system designed for any kind of mineral sheet."
	w_class = WEIGHT_CLASS_NORMAL
	storage_type = /datum/storage/bag/sheetsnatcher
	///the number of sheets it can carry.
	var/capacity = 300

/obj/item/storage/bag/cash
	icon_state = "cash"
	name = "Cash bag"
	desc = "A bag for carrying lots of cash. It's got a big dollar sign printed on the front."
	w_class = WEIGHT_CLASS_SMALL
	storage_type = /datum/storage/bag/cash
