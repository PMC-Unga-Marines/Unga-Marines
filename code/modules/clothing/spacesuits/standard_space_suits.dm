/obj/item/clothing/head/helmet/space/tgmc
	name = "\improper TGMC Compression Helmet"
	desc = "A high tech, TGMC designed, dark red space suit helmet. Used for maintenance in space."
	icon_state = "void_helm"
	anti_hug = 3

/obj/item/clothing/suit/space/tgmc
	name = "\improper TGMC Compression Suit"
	icon_state = "void"
	desc = "A high tech, TGMC designed, dark red Space suit. Used for maintenance in space."
	slowdown = 1

//Space santa outfit suit
/obj/item/clothing/head/helmet/space/dedmoroz
	name = "Ded Moroz hat"
	desc = "Happy New Year!"
	icon_state = "dedmoroz"
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/head_0.dmi',
	)
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEYES|HIDETOPHAIR
	flags_armor_protection = HEAD
	soft_armor = list(MELEE = 15, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 10, BIO = 10, FIRE = 10, ACID = 10)
	flags_item_map_variant = NONE
	flags_armor_features = ARMOR_NO_DECAP
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/helmet/space/snowman
	name = "snowman hat"
	desc = "A slightly floppy hat worn by snow man, a careful look reveals a tag with the words 'Made on Mars' inside."
	icon_state = "snowmanhat"
	soft_armor = list(MELEE = 20, BULLET = 25, LASER = 25, ENERGY = 20, BOMB = 85, BIO = 15, FIRE = 15, ACID = 15)
	flags_armor_features = ARMOR_NO_DECAP
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/helmet/space/snowman/regular
	soft_armor = list(MELEE = 15, BULLET = 10, LASER = 10, ENERGY = 15, BOMB = 15, BIO = 15, FIRE = 10, ACID = 10)

/obj/item/clothing/head/helmet/space/snowman/special
	soft_armor = list(MELEE = 20, BULLET = 25, LASER = 25, ENERGY = 20, BOMB = 85, BIO = 15, FIRE = 15, ACID = 15)

/obj/item/clothing/head/helmet/space/snowman/special/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_SNOW_MAN)

/obj/item/clothing/head/helmet/space/dedmoroz/special
	name = "Ded Moroz hat"
	desc = "Ho ho ho. Merrry X-mas to all! Now you're all gonna die!"
	soft_armor = list(MELEE = 85, BULLET = 90, LASER = 90, ENERGY = 85, BOMB = 120, BIO = 85, FIRE = 75, ACID = 40)
	flags_item = DELONDROP
	flags_inventory = COVEREYES|COVERMOUTH|BLOCKSHARPOBJ|BLOCKGASEFFECT

/obj/item/clothing/head/helmet/space/dedmoroz/special/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_DED_MOROZ)
