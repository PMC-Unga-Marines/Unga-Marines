/obj/item/storage/briefcase
	name = "briefcase"
	desc = "It's made of AUTHENTIC faux-leather and has a price-tag still attached. Its owner must be a real professional."
	icon_state = "briefcase"
	item_state = "briefcase"
	atom_flags = CONDUCT
	force = 8
	throw_speed = 1
	throw_range = 4
	w_class = WEIGHT_CLASS_BULKY
	max_w_class = WEIGHT_CLASS_NORMAL
	max_storage_space = 16

/obj/item/storage/briefcase/standard_magnum
	name = "R-76 Magnum case"
	desc = "A well made, expensive looking case, made to fit an R-76 Magnum and its accessories. For the discerning gun owner."
	icon_state = "magnum_case"
	item_state = "briefcase"
	atom_flags = CONDUCT
	force = 12
	throw_speed = 1
	throw_range = 4
	w_class = WEIGHT_CLASS_BULKY
	max_w_class = WEIGHT_CLASS_NORMAL
	max_storage_space = 15
	storage_slots = 9
	storage_type_limits = list(/obj/item/weapon/gun = 1)
	can_hold = list(
		/obj/item/weapon/gun/revolver/standard_magnum,
		/obj/item/attachable/scope/standard_magnum,
		/obj/item/ammo_magazine/revolver/standard_magnum,
	)

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
