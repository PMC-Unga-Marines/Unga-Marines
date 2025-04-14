/obj/item/storage/briefcase
	name = "briefcase"
	desc = "It's made of AUTHENTIC faux-leather and has a price-tag still attached. Its owner must be a real professional."
	icon_state = "briefcase"
	worn_icon_state = "briefcase"
	icon = 'icons/obj/items/storage/briefcase.dmi'
	atom_flags = CONDUCT
	force = 8
	throw_speed = 1
	throw_range = 4
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/briefcase

/obj/item/storage/briefcase/standard_magnum
	name = "R-76 Magnum case"
	desc = "A well made, expensive looking case, made to fit an R-76 Magnum and its accessories. For the discerning gun owner."
	icon_state = "magnum_case"
	worn_icon_state = "briefcase"
	atom_flags = CONDUCT
	force = 12
	throw_speed = 1
	throw_range = 4
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/briefcase/standard_magnum

/obj/item/storage/briefcase/standard_magnum/PopulateContents()
	new /obj/item/weapon/gun/revolver/standard_magnum(src)
	new /obj/item/attachable/scope/standard_magnum(src)
	for(var/i in 1 to 15)
		new /obj/item/ammo_magazine/revolver/standard_magnum(src)

/obj/item/storage/briefcase/standard_magnum/gold/PopulateContents()
	new /obj/item/weapon/gun/revolver/standard_magnum/fancy/gold(src)
	new /obj/item/attachable/scope/standard_magnum(src)
	for(var/i in 1 to 15)
		new /obj/item/ammo_magazine/revolver/standard_magnum(src)

/obj/item/storage/briefcase/standard_magnum/silver/PopulateContents()
	new /obj/item/weapon/gun/revolver/standard_magnum/fancy/silver(src)
	new /obj/item/attachable/scope/standard_magnum(src)
	for(var/i in 1 to 15)
		new /obj/item/ammo_magazine/revolver/standard_magnum(src)

/obj/item/storage/briefcase/standard_magnum/nickle/PopulateContents()
	new /obj/item/weapon/gun/revolver/standard_magnum/fancy/nickle(src)
	new /obj/item/attachable/scope/standard_magnum(src)
	for(var/i in 1 to 15)
		new /obj/item/ammo_magazine/revolver/standard_magnum(src)

/obj/item/storage/briefcase/t500
	name = "\improper R-500 'Nigredo' special case"
	desc = "High-tech case made by BMSS for delivery their special weapons. Label on this case says: 'This is the greatest handgun ever made. Five bullets. More than enough to kill anything that moves'."
	icon_state = "t500case"
	w_class = WEIGHT_CLASS_NORMAL
	storage_type = /datum/storage/briefcase/t500

/obj/item/storage/briefcase/t500/PopulateContents()
	new /obj/item/attachable/stock/t500(src)
	new /obj/item/attachable/lace/t500(src)
	new /obj/item/attachable/t500_barrel/short(src)
	new /obj/item/attachable/t500_barrel(src)
	new /obj/item/weapon/gun/revolver/t500(src)

/obj/item/storage/briefcase/t312
	name = "R-312 'Albedo' Revolver special case"
	desc = "High-tech case made by BMSS for delivery their special weapons. Label on this case says: 'Since we have already called Nigredo death, within the same metaphor we can call Albedo life. It is time to shoot at people legally.'"
	icon_state = "med_case"
	w_class = WEIGHT_CLASS_NORMAL
	storage_type = /datum/storage/briefcase/t312

/obj/item/storage/briefcase/t312/PopulateContents()
	new /obj/item/ammo_magazine/packet/t312/med/adrenaline(src)
	new /obj/item/ammo_magazine/packet/t312/med/rr(src)
	new /obj/item/ammo_magazine/packet/t312/med/md(src)
	new /obj/item/ammo_magazine/packet/t312/med/neu(src)
	new /obj/item/ammo_magazine/revolver/t312/med/adrenaline(src)
	new /obj/item/ammo_magazine/revolver/t312/med/rr(src)
	new /obj/item/ammo_magazine/revolver/t312/med/md(src)
	new /obj/item/ammo_magazine/revolver/t312/med/neu(src)
	new /obj/item/storage/pouch/medkit/t312(src)
	new /obj/item/attachable/lace/t500(src)
	new /obj/item/weapon/gun/revolver/t312(src)

/obj/item/storage/briefcase/inflatable
	name = "inflatable barrier box"
	desc = "Contains inflatable walls and doors."
	icon_state = "inf_box"
	worn_icon_state = "syringe_kit"

/obj/item/storage/briefcase/inflatable/Initialize(mapload, ...)
	. = ..()
	storage_datum.max_storage_space = 21

/obj/item/storage/briefcase/inflatable/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/inflatable/door(src)
	for(var/i in 1 to 4)
		new /obj/item/inflatable/wall(src)
