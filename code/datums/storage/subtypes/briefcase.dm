/datum/storage/briefcase
	max_w_class = WEIGHT_CLASS_NORMAL
	max_storage_space = 16

/datum/storage/briefcase/standard_magnum
	max_storage_space = 15
	storage_slots = 9

/datum/storage/briefcase/standard_magnum/New(atom/parent)
	. = ..()
	set_holdable(
		can_hold_list = list(
			/obj/item/weapon/gun/revolver/standard_magnum,
			/obj/item/attachable/scope/standard_magnum,
			/obj/item/ammo_magazine/revolver/standard_magnum,
		),
		storage_type_limits_list = list(/obj/item/weapon/gun)
	)
	storage_type_limits_max = list(/obj/item/weapon/gun = 1)

/datum/storage/briefcase/t500
	max_w_class = WEIGHT_CLASS_TINY
	storage_slots = 5
	max_storage_space = 1

/datum/storage/briefcase/t500/New(atom/parent)
	. = ..()
	set_holdable(
		can_hold_list = list(
			/obj/item/attachable/stock/t500,
			/obj/item/attachable/lace/t500,
			/obj/item/attachable/t500_barrel/short,
			/obj/item/attachable/t500_barrel,
			/obj/item/weapon/gun/revolver/t500,
		),
		storage_type_limits_list = list(
			/obj/item/attachable/stock/t500,
			/obj/item/attachable/lace/t500,
			/obj/item/attachable/t500_barrel/short,
			/obj/item/attachable/t500_barrel,
			/obj/item/weapon/gun/revolver/t500,
		),
	)

/datum/storage/briefcase/t312
	max_w_class = WEIGHT_CLASS_TINY
	storage_slots = 7
	max_storage_space = 1

/datum/storage/briefcase/t312/New(atom/parent)
	. = ..()
	set_holdable(
		can_hold_list = list(
			/obj/item/ammo_magazine/packet/t312/med/adrenaline,
			/obj/item/ammo_magazine/packet/t312/med/rr,
			/obj/item/ammo_magazine/packet/t312/med/md,
			/obj/item/ammo_magazine/packet/t312/med/neu,
			/obj/item/ammo_magazine/revolver/t312/med/adrenaline,
			/obj/item/ammo_magazine/revolver/t312/med/rr,
			/obj/item/ammo_magazine/revolver/t312/med/md,
			/obj/item/ammo_magazine/revolver/t312/med/neu,
			/obj/item/storage/pouch/medkit/t312,
			/obj/item/attachable/lace/t500,
			/obj/item/weapon/gun/revolver/t312,
		),
		storage_type_limits_list = list(
			/obj/item/ammo_magazine/packet/t312/med/adrenaline,
			/obj/item/ammo_magazine/packet/t312/med/rr,
			/obj/item/ammo_magazine/packet/t312/med/md,
			/obj/item/ammo_magazine/packet/t312/med/neu,
			/obj/item/ammo_magazine/revolver/t312/med/adrenaline,
			/obj/item/ammo_magazine/revolver/t312/med/rr,
			/obj/item/ammo_magazine/revolver/t312/med/md,
			/obj/item/ammo_magazine/revolver/t312/med/neu,
			/obj/item/storage/pouch/medkit/t312,
			/obj/item/attachable/lace/t500,
			/obj/item/weapon/gun/revolver/t312,
		),
	)
