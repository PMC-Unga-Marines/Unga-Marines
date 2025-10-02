/datum/storage/box
	foldable = /obj/item/paper/crumpled
	storage_slots = null
	max_w_class = WEIGHT_CLASS_SMALL //Changed because of in-game abuse

/datum/storage/box/lights
	foldable = /obj/item/stack/sheet/cardboard //BubbleWrap
	max_storage_space = 42	//holds 21 items of w_class 2
	use_to_pickup = TRUE // for picking up broken bulbs, not that most people will try

/datum/storage/box/m94
	max_storage_space = 14

/datum/storage/box/mre
	storage_slots = 4
	foldable = 0
	trash_item = /obj/item/trash/mre

/datum/storage/box/mre/New(atom/parent)
	. = ..()
	set_holdable(list(/obj/item/reagent_containers/food/snacks/packaged_meal))

/datum/storage/box/mre/remove_from_storage(obj/item/item, atom/new_location, mob/user, silent = FALSE, bypass_delay = FALSE)
	. = ..()
	if(. && !length(parent.contents) && !gc_destroyed)
		qdel(parent)

/datum/storage/box/mre/som
	trash_item = /obj/item/trash/mre/som

// Do not assign this to any other than visual boxes, or there will be bloodshed
/datum/storage/box/visual
	max_w_class = WEIGHT_CLASS_BULKY
	storage_slots = 32 // 8 images x 4 items
	max_storage_space = 64
	use_to_pickup = TRUE
	/// Our parent box
	var/obj/item/storage/box/visual/parent_box

/datum/storage/box/visual/New(atom/parent)
	. = ..()
	parent_box = parent
	set_holdable(list(/obj/item)) //This box should normally be unobtainable so here we go

/datum/storage/box/visual/open(mob/user)
	if(!parent_box.deployed)
		user.balloon_alert(user, "deploy first.")
		return FALSE
	return ..()

/datum/storage/box/visual/attempt_draw_object(mob/living/user, start_from_left)
	if(!parent_box.deployed)
		user.balloon_alert(user, "deploy first.")
		return FALSE
	return ..()

/datum/storage/box/visual/can_be_inserted(obj/item/item_to_insert, mob/user, warning)
	if(!parent_box.deployed)
		user.balloon_alert(user, "deploy first.")
		return FALSE
	return ..()

/datum/storage/box/visual/magazine
	max_w_class = WEIGHT_CLASS_BULKY
	storage_slots = 32 // 8 images x 4 items
	max_storage_space = 64	//SMG and pistol sized (tiny and small) mags can fit all 32 slots, normal (LMG and AR) fit 21

/datum/storage/box/visual/magazine/New(atom/parent)
	. = ..()
	set_holdable(
		can_hold_list = list(
			/obj/item/ammo_magazine/packet,
			/obj/item/ammo_magazine/flamer_tank,
			/obj/item/ammo_magazine/handful,
			/obj/item/ammo_magazine/m412l1_hpr,
			/obj/item/ammo_magazine/pistol,
			/obj/item/ammo_magazine/railgun,
			/obj/item/ammo_magazine/revolver,
			/obj/item/ammo_magazine/rifle,
			/obj/item/ammo_magazine/shotgun,
			/obj/item/ammo_magazine/smg,
			/obj/item/ammo_magazine/sniper,
			/obj/item/ammo_magazine/mg60,
			/obj/item/ammo_magazine/hsg102,
			/obj/item/ammo_magazine/mg42,
			/obj/item/ammo_magazine/mg27,
			/obj/item/ammo_magazine/hmg08,
			/obj/item/ammo_magazine/sg29,
			/obj/item/ammo_magazine/som_mg,
			/obj/item/cell/lasgun,
		),
		cant_hold_list = list(
			/obj/item/ammo_magazine/flamer_tank/backtank,
			/obj/item/ammo_magazine/flamer_tank/backtank/X,
			/obj/item/ammo_magazine/flamer_tank/backtank/G,
			/obj/item/cell/lasgun/volkite/powerpack/marine_back,
	))

/datum/storage/box/visual/magazine/compact
	storage_slots = 40 //Same storage as the old prefilled mag boxes found in the req vendor.
	max_storage_space = 40 //Adjusted in update_stats() to fit the needs.

/datum/storage/box/visual/magazine/compact/New(atom/parent)
	. = ..()
	set_holdable(
		can_hold_list = list(/obj/item/ammo_magazine, /obj/item/cell/lasgun), //Able to hold all ammo due to this box being unobtainable. admemes beware of the rocket crate.
		cant_hold_list = list()
	)

/datum/storage/box/visual/grenade
	max_w_class = WEIGHT_CLASS_NORMAL
	storage_slots = 25
	max_storage_space = 50

/datum/storage/box/visual/grenade/New(atom/parent)
	. = ..()
	set_holdable(
		can_hold_list = list(/obj/item/explosive/grenade),
		cant_hold_list = list()
	)

/datum/storage/box/crate/sentry
	max_w_class = WEIGHT_CLASS_HUGE
	storage_slots = 6
	max_storage_space = 16

/datum/storage/box/crate/sentry/New(atom/parent)
	. = ..()
	set_holdable(
		can_hold_list = list(/obj/item/weapon/gun/sentry, /obj/item/ammo_magazine/sentry),
		storage_type_limits_list = list(/obj/item/weapon/gun/sentry, /obj/item/ammo_magazine/sentry)
	)
