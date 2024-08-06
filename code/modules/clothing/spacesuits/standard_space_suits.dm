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

//space santa
/obj/item/clothing/head/helmet/space/santahat
	name = "Santa's hat"
	desc = "Ho ho ho. Merrry X-mas!"
	icon_state = "santahat"
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEYES
	flags_armor_protection = HEAD

/obj/item/clothing/suit/space/santa
	name = "Santa's suit"
	desc = "Festive!"
	icon_state = "santa"
	slowdown = 0
	allowed = list(/obj/item) //for stuffing exta special presents
