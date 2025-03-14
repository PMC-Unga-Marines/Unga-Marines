/obj/structure/closet/emcloset
	name = "emergency closet"
	desc = "It's a storage unit for emergency breathmasks."
	icon_state = "emergency"
	icon_closed = "emergency"
	icon_opened = "emergencyopen"

/obj/structure/closet/emcloset/PopulateContents()
	switch(pickweight(list("small" = 55, "aid" = 25, "mask" = 10, "both" = 10, "nothing" = 0, "delete" = 0)))
		if("small")
			new /obj/item/clothing/mask/breath(src)
			new /obj/item/clothing/mask/breath(src)
			new /obj/item/clothing/mask/gas(src)
			new /obj/item/clothing/mask/gas(src)
		if("aid")
			new /obj/item/storage/toolbox/emergency(src)
			new /obj/item/storage/firstaid/o2(src)
			new /obj/item/clothing/mask/gas(src)
		if("mask")
			new /obj/item/clothing/mask/breath(src)
			new /obj/item/clothing/mask/gas(src)
		if("both")
			new /obj/item/storage/toolbox/emergency(src)
			new /obj/item/clothing/mask/gas(src)
			new /obj/item/clothing/mask/gas(src)
			new /obj/item/storage/firstaid/o2(src)

		// teehee - Ah, tg coders...
		if("delete")
			qdel(src)

		//If you want to re-add fire, just add "fire" = 15 to the pick list.
		/*if ("fire")
			new /obj/structure/closet/firecloset(src.loc)
			qdel(src)*/

/obj/structure/closet/emcloset/legacy/PopulateContents()
	new /obj/item/clothing/mask/gas(src)

/obj/structure/closet/firecloset
	name = "fire-safety closet"
	desc = "It's a storage unit for fire-fighting supplies."
	icon_state = "firecloset"
	icon_closed = "firecloset"
	icon_opened = "fireclosetopen"

/obj/structure/closet/firecloset/PopulateContents()
	new /obj/item/clothing/suit/fire(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/tool/extinguisher(src)
	new /obj/item/clothing/head/hardhat/red(src)

/obj/structure/closet/firecloset/full/PopulateContents()
	new /obj/item/clothing/suit/fire(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/flashlight(src)
	new /obj/item/tool/extinguisher(src)
	new /obj/item/clothing/head/hardhat/red(src)

/obj/structure/closet/firecloset/update_icon_state()
	. = ..()
	if(!opened)
		icon_state = icon_closed
	else
		icon_state = icon_opened

/obj/structure/closet/toolcloset
	name = "tool closet"
	desc = "It's a storage unit for tools."
	icon_state = "toolcloset"
	icon_closed = "toolcloset"
	icon_opened = "toolclosetopen"

/obj/structure/closet/toolcloset/PopulateContents()
	new /obj/item/clothing/suit/storage/hazardvest(src)
	new /obj/item/clothing/suit/storage/hazardvest/lime(src)
	new /obj/item/clothing/suit/storage/hazardvest/blue(src)
	new /obj/item/flashlight(src)
	new /obj/item/t_scanner(src)
	new /obj/item/storage/belt/utility/full(src)
	new /obj/item/clothing/head/hardhat(src)
	if(prob(10))
		new /obj/item/clothing/gloves/insulated(src)

/obj/structure/closet/radiation
	name = "radiation suit closet"
	desc = "It's a storage unit for rad-protective suits."
	icon_state = "radsuitcloset"
	icon_opened = "radsuitclosetopen"
	icon_closed = "radsuitcloset"

/obj/structure/closet/radiation/PopulateContents()
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)

/obj/structure/closet/bombcloset
	name = "\improper EOD closet"
	desc = "It's a storage unit for explosion-protective suits."
	icon_state = "bombsuit"
	icon_closed = "bombsuit"
	icon_opened = "bombsuitopen"

/obj/structure/closet/bombcloset/PopulateContents()
	new /obj/item/clothing/suit/bomb_suit(src)
	new /obj/item/clothing/under/color/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/head/bomb_hood(src)

/obj/structure/closet/bombclosetsecurity
	name = "\improper EOD closet"
	desc = "It's a storage unit for explosion-protective suits."
	icon_state = "bombsuitsec"
	icon_closed = "bombsuitsec"
	icon_opened = "bombsuitsecopen"

/obj/structure/closet/bombclosetsecurity/PopulateContents()
	new /obj/item/clothing/suit/bomb_suit/security(src)
	new /obj/item/clothing/under/rank/security(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/head/bomb_hood/security(src)
