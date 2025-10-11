/datum/storage/holster
	max_w_class = WEIGHT_CLASS_BULKY // normally the special item will be larger than what should fit. Child items will have lower limits and an override
	storage_slots = 1
	max_storage_space = 4
	draw_mode = 1
	allow_drawing_method = TRUE

/datum/storage/holster/New(atom/parent)
	. = ..()
	set_holdable(storage_type_limits_list = list(/obj/item/weapon))
	storage_type_limits_max = list(/obj/item/weapon = 1)

/datum/storage/holster/should_access_delay(obj/item/item, mob/user, taking_out) //defaults to 0
	if(!taking_out) // Always allow items to be tossed in instantly
		return FALSE
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(human_user.back == parent)
			return TRUE
	return FALSE

/datum/storage/holster/handle_item_insertion(obj/item/item, prevent_warning = 0)
	. = ..()
	var/obj/item/storage/holster/holster = parent
	if(!. || !is_type_in_list(item, holster.holsterable_allowed)) //check to see if the item being inserted is the snowflake item
		return
	holster.holstered_item = item
	holster.update_icon() //So that the icon actually updates after we've assigned our holstered_item
	playsound(parent, sheathe_sound, 15, 1)

/datum/storage/holster/remove_from_storage(obj/item/item, atom/new_location, mob/user, silent = FALSE, bypass_delay = FALSE)
	. = ..()
	var/obj/item/storage/holster/holster = parent
	if(!. || !is_type_in_list(item, holster.holsterable_allowed)) //check to see if the item being removed is the snowflake item
		return
	holster.holstered_item = null
	holster.update_icon() //So that the icon actually updates after we've assigned our holstered_item
	if(silent)
		return
	playsound(parent, draw_sound, 15, 1)

/datum/storage/holster/blade/officer
	draw_sound = 'sound/items/unsheath.ogg'
	sheathe_sound = 'sound/items/sheath.ogg'

/datum/storage/holster/blade/officer/New(atom/parent)
	. = ..()
	set_holdable(can_hold_list = list(/obj/item/weapon/sword/officer))

/datum/storage/holster/backholster
	max_w_class = WEIGHT_CLASS_NORMAL //normal items
	max_storage_space = 24
	access_delay = 1.5 SECONDS ///0 out for satchel types

/datum/storage/holster/backholster/rpg
	storage_slots = 5
	max_w_class = WEIGHT_CLASS_BULKY
	access_delay = 0.5 SECONDS

/datum/storage/holster/backholster/rpg/New(atom/parent)
	. = ..()
	set_holdable(
		can_hold_list = list(
			/obj/item/ammo_magazine/rocket,
			/obj/item/weapon/gun/launcher/rocket/recoillessrifle,
		),
		storage_type_limits_list = list(/obj/item/weapon/gun/launcher/rocket/recoillessrifle) //only one RR per bag
	)
	storage_type_limits_max = list(/obj/item/weapon/gun/launcher/rocket/recoillessrifle = 1)

/datum/storage/holster/backholster/rpg/som/New(atom/parent)
	. = ..()
	set_holdable(
		can_hold_list = list(
			/obj/item/ammo_magazine/rocket,
			/obj/item/weapon/gun/launcher/rocket/som,
		),
		storage_type_limits_list = list(/obj/item/weapon/gun/launcher/rocket/som)
	)

/datum/storage/holster/backholster/mortar
	max_w_class = WEIGHT_CLASS_NORMAL
	storage_slots = null
	max_storage_space = 30
	access_delay = 0

/datum/storage/holster/backholster/mortar/New(atom/parent)
	. = ..()
	set_holdable(
		can_hold_list = list(
		/obj/item/mortal_shell/he,
		/obj/item/mortal_shell/incendiary,
		/obj/item/mortal_shell/smoke,
		/obj/item/mortal_shell/flare,
		/obj/item/mortal_shell/plasmaloss,
		/obj/item/mortar_kit,
		/obj/item/hud_tablet/artillery,
	),
		storage_type_limits_list = list(/obj/item/mortar_kit)
	)
	storage_type_limits_max = list(/obj/item/mortar_kit = 1)

/datum/storage/holster/backholster/flamer
	storage_slots = null
	max_storage_space = 16
	max_w_class = WEIGHT_CLASS_NORMAL
	access_delay = 0

/datum/storage/holster/backholster/flamer/New(atom/parent)
	. = ..()
	set_holdable(storage_type_limits_list = list(/obj/item/weapon/gun/flamer/big_flamer/marinestandard/engineer))
	storage_type_limits_max = list(/obj/item/weapon/gun/flamer/big_flamer/marinestandard/engineer = 1)

/datum/storage/holster/backholster/flamer/handle_item_insertion(obj/item/item, prevent_warning = 0, mob/user)
	. = ..()
	var/obj/item/storage/holster/backholster/flamer/holster = parent
	if(holster.holstered_item == item)
		var/obj/item/weapon/gun/flamer/big_flamer/marinestandard/engineer/flamer = item
		if(flamer.chamber_items.len == 0)
			return
		holster.refuel(flamer.chamber_items[1], user)
		flamer.update_ammo_count()

/datum/storage/holster/backholster/sadar
	storage_slots = 5
	max_w_class = WEIGHT_CLASS_HUGE
	access_delay = 0.5 SECONDS

/datum/storage/holster/backholster/sadar/New(atom/parent)
	. = ..()
	set_holdable(
		can_hold_list = list(
			/obj/item/weapon/gun/launcher/rocket/sadar,
			/obj/item/ammo_magazine/rocket/sadar,
		),
		storage_type_limits_list = list(/obj/item/weapon/gun/launcher/rocket/sadar),
	)
	storage_type_limits_max = list(/obj/item/weapon/gun/launcher/rocket/sadar = 1)

/datum/storage/holster/backholster/rlquad
	storage_slots = 3
	max_w_class = WEIGHT_CLASS_HUGE
	access_delay = 0.5 SECONDS

/datum/storage/holster/backholster/rlquad/New(atom/parent)
	. = ..()
	set_holdable(
		can_hold_list = list(
			/obj/item/ammo_magazine/rocket/m57a4,
		),
		storage_type_limits_list = list(/obj/item/weapon/gun/launcher/rocket/m57a4/t57),
	)
	storage_type_limits_max = list(/obj/item/weapon/gun/launcher/rocket/m57a4/t57 = 1)

/datum/storage/holster/t19
	storage_slots = 4
	max_storage_space = 10
	max_w_class = WEIGHT_CLASS_BULKY

/datum/storage/holster/t19/New(atom/parent)
	. = ..()
	set_holdable(can_hold_list = list(
		/obj/item/weapon/gun/smg/mp19,
		/obj/item/ammo_magazine/smg/mp19,
	))

/datum/storage/holster/ar18
	storage_slots = 3
	max_storage_space = 9

/datum/storage/holster/ar18/New(atom/parent)
	. = ..()
	set_holdable(can_hold_list = list(
		/obj/item/weapon/gun/rifle/ar18,
		/obj/item/ammo_magazine/rifle/ar18,
	))

/datum/storage/holster/flarepouch
	storage_slots = 28
	max_storage_space = 28
	refill_types = list(/obj/item/storage/box/m94)
	refill_sound = "rustle"

/datum/storage/holster/flarepouch/New(atom/parent)
	. = ..()
	set_holdable(can_hold_list = list(
		/obj/item/explosive/grenade/flare/civilian,
		/obj/item/weapon/gun/grenade_launcher/single_shot/flare,
		/obj/item/explosive/grenade/flare,
	))
	storage_type_limits_max = list(/obj/item/weapon/gun/grenade_launcher/single_shot/flare = 1)

/datum/storage/holster/icc_mg
	storage_slots = 5
	max_storage_space = 16

/datum/storage/holster/icc_mg/New(atom/parent)
	. = ..()
	set_holdable(can_hold_list = list(
		/obj/item/weapon/gun/rifle/icc_mg,
		/obj/item/ammo_magazine/icc_mg/packet,
	))

/datum/storage/holster/belt
	use_sound = null
	storage_slots = 9
	max_storage_space = 19
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/storage/holster/belt/New(atom/parent)
	. = ..()
	set_holdable(can_hold_list = list(
		/obj/item/weapon/gun/pistol,
		/obj/item/ammo_magazine/pistol,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol,
		/obj/item/cell/lasgun/plasma,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta,
		/obj/item/cell/lasgun/lasrifle,
		/obj/item/cell/lasgun/volkite/small,
	))

/datum/storage/holster/belt/t500/New(atom/parent)
	. = ..()
	set_holdable(can_hold_list = list(
		/obj/item/weapon/gun/revolver/t500,
		/obj/item/weapon/gun/revolver/t312,
		/obj/item/ammo_magazine/revolver/t500,
		/obj/item/ammo_magazine/revolver/t500/slavs,
		/obj/item/ammo_magazine/packet/t500,
		/obj/item/ammo_magazine/revolver/t312,
		/obj/item/ammo_magazine/packet/t312,
		/obj/item/ammo_magazine/handful
	))

/datum/storage/holster/belt/m44
	max_storage_space = 16
	max_w_class = WEIGHT_CLASS_BULKY

/datum/storage/holster/belt/m44/New(atom/parent)
	. = ..()
	set_holdable(
		can_hold_list = list(
			/obj/item/weapon/gun/revolver,
			/obj/item/ammo_magazine/revolver,
		),
		cant_hold_list = list(
			/obj/item/weapon/gun/revolver/coltrifle,
		)
	)

/datum/storage/holster/belt/mateba
	max_storage_space = 16

/datum/storage/holster/belt/mateba/New(atom/parent)
	. = ..()
	set_holdable(can_hold_list = list(
		/obj/item/weapon/gun/revolver/mateba,
		/obj/item/ammo_magazine/revolver/mateba,
	))

/datum/storage/holster/belt/korovin/New(atom/parent)
	. = ..()
	set_holdable(can_hold_list = list(
		/obj/item/weapon/gun/pistol/c99,
		/obj/item/ammo_magazine/pistol/c99,
		/obj/item/ammo_magazine/pistol/c99t,
		/obj/item/weapon/gun/pistol/xmdivider,
		/obj/item/ammo_magazine/pistol/xmdivider,
	))

/datum/storage/holster/belt/ts34
	storage_slots = 3
	max_storage_space = 8

/datum/storage/holster/belt/ts34/New(atom/parent)
	. = ..()
	set_holdable(
		can_hold_list = list(
			/obj/item/ammo_magazine/handful,
		),
		storage_type_limits_list = list(
			/obj/item/weapon/gun/shotgun/double/marine,
			/obj/item/ammo_magazine/shotgun,
		)
	)
