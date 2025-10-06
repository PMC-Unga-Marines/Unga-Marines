#define BOX_OVERLAY_SHIFT_X 6
#define BOX_OVERLAY_SHIFT_Y 4 //one less than the 6x5 sprite to make them overlap on each other a bit.

#define BOX_MAGAZINE_OFFSET_X 5
#define BOX_MAGAZINE_OFFSET_Y 11
#define BOX_MAGAZINE_COLUMNS 4
#define BOX_MAGAZINE_ROWS 2

#define BOX_MAGAZINE_COMPACT_OFFSET_X 7
#define BOX_MAGAZINE_COMPACT_OFFSET_Y 10
#define BOX_MAGAZINE_COMPACT_COLUMNS 3
#define BOX_MAGAZINE_COMPACT_ROWS 2

#define BOX_GRENADE_OFFSET_X 7
#define BOX_GRENADE_OFFSET_Y 10
#define BOX_GRENADE_COLUMNS 3
#define BOX_GRENADE_ROWS 2

/**
 * # fillable box
 *
 * Deployable box with fancy visuals of its contents
 * Visual content defined in the icon_state_mini var in /obj/item
 * All other visuals that do not have a icon_state_mini defined are in var/assoc_overlay
 */
/obj/item/storage/box/visual
	name = "generic box"
	desc = "This box is able to hold a wide variety of supplies."
	icon = 'icons/obj/items/storage/storage_boxes.dmi'
	icon_state = "mag_box"
	worn_icon_state = "mag_box"
	w_class = WEIGHT_CLASS_HUGE
	slowdown = 0.4 // Big unhandly box
	storage_type = /datum/storage/box/visual
	///Assoc list of how much weight every item type takes. Used to determine how many overlays to make.
	var/list/contents_weight = list()
	///Initial pixel_x offset of the overlays.
	var/overlay_pixel_x = BOX_MAGAZINE_OFFSET_X
	///Initial pixel_y offset of the overlays.
	var/overlay_pixel_y = BOX_MAGAZINE_OFFSET_Y
	///Amount of columns in the overlay grid.
	var/amt_horizontal = BOX_MAGAZINE_COLUMNS
	///Amount of rows in the overlay grid.
	var/amt_vertical = BOX_MAGAZINE_ROWS
	///Amount of pixels to shift each overlay for each column.
	var/shift_x = BOX_OVERLAY_SHIFT_X
	///Amount of pixels to shift each overlay for each row.
	var/shift_y = BOX_OVERLAY_SHIFT_Y
	///Whether or not the box is deployed on the ground
	var/deployed = FALSE
	///Amount of different items in the box.
	var/variety = 0
	///Amount of weight a single overlay can cover.
	var/overlay_w_class = 0
	///Total max amount of overlay spaces
	var/max_overlays = 0
	///Overlay icon_state to display on the box when it is closed
	var/closed_overlay
	///Overlay icon_state to display on the box when it is open
	var/open_overlay

/obj/item/storage/box/visual/Initialize(mapload, ...)
	. = ..()
	update_stats()

/obj/item/storage/box/visual/Destroy()
	contents_weight = null
	return ..()

/// Updates certain vars used primarily (but not exclusively) for the creation of the overlays.
/obj/item/storage/box/visual/proc/update_stats()
	SHOULD_CALL_PARENT(TRUE)
	max_overlays = amt_horizontal * amt_vertical
	overlay_w_class = FLOOR(storage_datum.max_storage_space / max_overlays, 1)
	update_icon() //Getting the closed_overlay onto it

/obj/item/storage/box/visual/examine(mob/user, distance, infix, suffix)
	. = ..()
	if (!deployed && !(loc == user)) //Closed and not in your possession
		return
	if(variety > max_overlays) //Too much shit inside, a literal clusterfuck of supplies
		. += "It's too cluttered with all of these supplies inside."
		return
	if(variety <= 0) //empy
		. += "It is empty!"
		return
	. += "It contains:"
	for(var/obj/item/I AS in contents_weight)
		if(contents_weight[I] < overlay_w_class)
			. += "A bit of: [initial(I.name)]."
		else if(contents_weight[I] < 3 * overlay_w_class)
			. += "Some of: [initial(I.name)]."
		else
			. += "A lot of: [initial(I.name)]."

/obj/item/storage/box/visual/attack_self(mob/user)
	deployed = TRUE
	user.dropItemToGround(src)
	update_icon()
	pixel_x = 0 //Big sprite so lets not shift it around.
	pixel_y = 0

/obj/item/storage/box/visual/attack_hand(mob/living/user)
	if(loc == user)
		storage_datum.open(user) //Always show content when holding box
		return

	if(!deployed)
		return ..()

	else if(deployed)
		storage_datum.draw_mode = variety == 1? TRUE: FALSE //If only one type of item in box, then quickdraw it.
		if(storage_datum.draw_mode && ishuman(user) && length(contents))
			var/obj/item/I = contents[length(contents)]
			I.attack_hand(user)
			return
		storage_datum.open(user)

/obj/item/storage/box/visual/MouseDrop(atom/over_object)
	if(!deployed)
		return

	if(!ishuman(over_object))
		return

	var/mob/living/carbon/human/H = over_object
	if(H == usr && !H.incapacitated() && Adjacent(H) && H.put_in_hands(src))
		pickup(H)
		deployed = FALSE
		update_icon()

/obj/item/storage/box/visual/update_icon_state()
	. = ..()

	variety = 0

	//Fill assoc list of every item type in the crate and have it's value be the total weight it takes up.
	contents_weight = list()
	for(var/obj/item/I AS in contents)
		if(!contents_weight[I.type])
			contents_weight[I.type] = 0
			variety++
		contents_weight[I.type] += I.w_class

	if(!deployed)
		icon_state = "[initial(icon_state)]"
		return
	if(variety > max_overlays) // Too many items inside so lets make it cluttered
		icon_state = "[initial(icon_state)]_mixed"
		return

	icon_state = "[initial(icon_state)]_open"

/obj/item/storage/box/visual/update_overlays()
	. = ..()

	if(!deployed)
		icon_state = "[initial(icon_state)]"
		if(closed_overlay)
			. += mutable_appearance('icons/obj/items/storage/storage_boxes.dmi', closed_overlay)
		return

	if(open_overlay)
		. += mutable_appearance('icons/obj/items/storage/storage_boxes.dmi', open_overlay)

	if(variety > max_overlays)
		return

	var/total_overlays = 0
	for(var/object in contents_weight)
		total_overlays += 1 + FLOOR(contents_weight[object] / overlay_w_class, 1)

	var/overlay_overflow = max(0, total_overlays - max_overlays)

	var/current_iteration = 1

	for(var/obj_typepath in contents_weight)
		var/overlays_to_draw = 1 + FLOOR(contents_weight[obj_typepath] / overlay_w_class, 1)
		if(overlay_overflow)
			var/adjustment = min(overlay_overflow, overlays_to_draw - 1)
			overlay_overflow -= adjustment
			overlays_to_draw -= adjustment
			total_overlays -= adjustment

		for(var/i = 1 to overlays_to_draw)
			var/imagepixel_w = overlay_pixel_x + FLOOR((current_iteration / amt_vertical) - 0.01, 1) * shift_x
			var/imagepixel_z = overlay_pixel_y + min(amt_vertical - WRAP(current_iteration - 1, 0, amt_vertical) - 1, total_overlays - current_iteration) * shift_y
			var/obj/item/relateditem = obj_typepath

			var/mutable_appearance/new_overlay = mutable_appearance('icons/obj/items/items_mini.dmi', initial(relateditem.icon_state_mini))
			new_overlay.pixel_w = imagepixel_w
			new_overlay.pixel_z = imagepixel_z
			. += new_overlay
			current_iteration++

// --MAG BOXES--
/obj/item/storage/box/visual/magazine
	name = "ammunition box"
	desc = "This box is able to hold a wide variety of supplies, mainly military-grade ammunition."
	icon_state = "mag_box"
	storage_type = /datum/storage/box/visual/magazine

/obj/item/storage/box/visual/magazine/compact
	name = "compact magazine box"
	desc = "A magnifically designed box specifically designed to hold a large quantity of ammo."
	icon_state = "mag_box_small"
	storage_type = /datum/storage/box/visual/magazine/compact
	overlay_pixel_x = BOX_MAGAZINE_COMPACT_OFFSET_X
	overlay_pixel_y = BOX_MAGAZINE_COMPACT_OFFSET_Y
	amt_horizontal = BOX_MAGAZINE_COMPACT_COLUMNS
	amt_vertical = BOX_MAGAZINE_COMPACT_ROWS

/obj/item/storage/box/visual/magazine/compact/update_stats()
	for(var/item_path in storage_datum.can_hold)
		var/obj/item/I = item_path
		if(I)
			storage_datum.max_storage_space = max(initial(I.w_class) * storage_datum.storage_slots, storage_datum.max_storage_space)
			storage_datum.max_w_class = max(initial(I.w_class), storage_datum.max_w_class)
	return ..()

// --PREFILLED MAG BOXES--

// -Pistol-

/obj/item/storage/box/visual/magazine/compact/p14
	name = "P-14 magazine box"
	desc = "A box specifically designed to hold a large amount of P-14 magazines."
	closed_overlay = "mag_box_small_overlay_p14"

/obj/item/storage/box/visual/magazine/compact/p14/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/pistol/p14,
	))

/obj/item/storage/box/visual/magazine/compact/p14/full
	spawn_number = 40
	spawn_type = /obj/item/ammo_magazine/pistol/p14

/obj/item/storage/box/visual/magazine/compact/p23
	name = "P-23 magazine box"
	desc = "A box specifically designed to hold a large amount of P-23 magazines."
	closed_overlay = "mag_box_small_overlay_p23"
/obj/item/storage/box/visual/magazine/compact/p23/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/pistol/p23,
	))

/obj/item/storage/box/visual/magazine/compact/p23/full
	spawn_number = 40
	spawn_type = /obj/item/ammo_magazine/pistol/p23

/obj/item/storage/box/visual/magazine/compact/r44
	name = "R-44 speedloader box"
	desc = "A box specifically designed to hold a large amount of R-44 speedloaders."
	closed_overlay = "mag_box_small_overlay_r44"

/obj/item/storage/box/visual/magazine/compact/r44/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/revolver/r44,
	))

/obj/item/storage/box/visual/magazine/compact/r44/full
	spawn_number = 40
	spawn_type = /obj/item/ammo_magazine/revolver/r44

/obj/item/storage/box/visual/magazine/compact/p17
	name = "P-17 magazine box"
	desc = "A box specifically designed to hold a large amount of P-17 magazines."
	closed_overlay = "mag_box_small_overlay_p17"

/obj/item/storage/box/visual/magazine/compact/p17/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/pistol/p17,
	))

/obj/item/storage/box/visual/magazine/compact/p17/full
	spawn_number = 40
	spawn_type = /obj/item/ammo_magazine/pistol/p17

/obj/item/storage/box/visual/magazine/compact/vp70
	name = "88M4 magazine box"
	desc = "A box specifically designed to hold a large amount of 88M4 magazines."
	closed_overlay = "mag_box_small_overlay_88m4"

/obj/item/storage/box/visual/magazine/compact/vp70/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/pistol/vp70,
	))

/obj/item/storage/box/visual/magazine/compact/vp70/full
	spawn_number = 40
	spawn_type = /obj/item/ammo_magazine/pistol/vp70

/obj/item/storage/box/visual/magazine/compact/derringer
	name = ".40 rimfire ammo packet box"
	desc = "A box specifically designed to hold a large amount of .40 rimfire ammo packets."
	closed_overlay = "mag_box_small_overlay_derringer"

/obj/item/storage/box/visual/magazine/compact/derringer/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/pistol/derringer,
	))

/obj/item/storage/box/visual/magazine/compact/derringer/full
	spawn_number = 40
	spawn_type = /obj/item/ammo_magazine/pistol/derringer

/obj/item/storage/box/visual/magazine/compact/plasma_pistol
	name = "PP-7 plasma cell box"
	desc = "A box specifically designed to hold a large amount of PP-7 plasma cells."
	closed_overlay = "mag_box_small_overlay_pp7"

/obj/item/storage/box/visual/magazine/compact/plasma_pistol/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/pistol/plasma_pistol,
	))

/obj/item/storage/box/visual/magazine/compact/plasma_pistol/full
	spawn_number = 40
	spawn_type = /obj/item/ammo_magazine/pistol/plasma_pistol

// -SMG-

/obj/item/storage/box/visual/magazine/compact/pepperball
	name = "Pepperball canister box"
	desc = "A box specifically designed to hold a large amount of Pepperball canisters."
	closed_overlay = "mag_box_small_overlay_pepperball"

/obj/item/storage/box/visual/magazine/compact/pepperball/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/rifle/pepperball,
	))

/obj/item/storage/box/visual/magazine/compact/pepperball/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/rifle/pepperball

// -Rifle-

/obj/item/storage/box/visual/magazine/compact/ar12
	name = "AR-12 magazine box"
	desc = "A box specifically designed to hold a large amount of AR-12 magazines."
	closed_overlay = "mag_box_small_overlay_ar12"

/obj/item/storage/box/visual/magazine/compact/ar12/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/rifle/ar12,
	))

/obj/item/storage/box/visual/magazine/compact/ar12/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/rifle/ar12

/obj/item/storage/box/visual/magazine/compact/martini
	name = "Martini Henry ammo packet box"
	desc = "A box specifically designed to hold a large amount of Martini ammo packets."
	closed_overlay = "mag_box_small_overlay_martini"

/obj/item/storage/box/visual/magazine/compact/martini/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/rifle/martini,
	))

/obj/item/storage/box/visual/magazine/compact/martini/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/rifle/martini

/obj/item/storage/box/visual/magazine/compact/sh15
	name = "SH-15 magazine box"
	desc = "A box specifically designed to hold a large amount of SH-15 magazines."
	closed_overlay = "mag_box_small_overlay_sh15"

/obj/item/storage/box/visual/magazine/compact/sh15/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/rifle/sh15_flechette,
		/obj/item/ammo_magazine/rifle/sh15_slug,
	))

/obj/item/storage/box/visual/magazine/compact/sh15/flechette
	name = "SH-15 flechette magazine box"
	closed_overlay = "mag_box_small_overlay_sh15_flechette"

/obj/item/storage/box/visual/magazine/compact/sh15/flechette/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/rifle/sh15_flechette

/obj/item/storage/box/visual/magazine/compact/sh15/slug
	name = "SH-15 slug magazine box"
	closed_overlay = "mag_box_small_overlay_sh15_slug"

/obj/item/storage/box/visual/magazine/compact/sh15/slug/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/rifle/sh15_slug

/obj/item/storage/box/visual/magazine/compact/sectoid_rifle
	name = "Suspicious glowing box"
	desc = "A purple glowing box with a big TOP SECRET label as well as conspiracy talkpoints printed topside. What a load of gibberish!"
	closed_overlay = "mag_box_small_overlay_sectoid_rifle"
	open_overlay = "mag_box_small_overlay_sectoid_rifle_open"

/obj/item/storage/box/visual/magazine/compact/sectoid_rifle/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/rifle/sectoid_rifle,
	))

/obj/item/storage/box/visual/magazine/compact/sectoid_rifle/examine(mob/user, distance, infix, suffix)
	. = ..()
	if(deployed)
		. += "The inside is smeared with some purple glowy goo. Better not touch it."

/obj/item/storage/box/visual/magazine/compact/sectoid_rifle/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/rifle/sectoid_rifle

// -Energy-

/obj/item/storage/box/visual/magazine/compact/lasrifle
	name = "LR-73 cell box"
	desc = "A box specifically designed to hold a large amount of TX-73 cells."
	closed_overlay = "mag_box_small_overlay_lr73"

/obj/item/storage/box/visual/magazine/compact/lasrifle/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/cell/lasgun/lasrifle,
	))

/obj/item/storage/box/visual/magazine/compact/lasrifle/full
	spawn_number = 30
	spawn_type = /obj/item/cell/lasgun/lasrifle

/obj/item/storage/box/visual/magazine/compact/lasrifle/marine
	name = "Terra Experimental cell box"
	desc = "A box specifically designed to hold a large amount of Terra Experimental cells."
	closed_overlay = "mag_box_small_overlay_te"

/obj/item/storage/box/visual/magazine/compact/lasrifle/marine/full
	spawn_number = 30
	spawn_type = /obj/item/cell/lasgun/lasrifle

// -Marksmen-

/obj/item/storage/box/visual/magazine/compact/dmr37
	name = "DMR-37 magazine box"
	desc = "A box specifically designed to hold a large amount of DMR-37 magazines."
	closed_overlay = "mag_box_small_overlay_dmr37"

/obj/item/storage/box/visual/magazine/compact/dmr37/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/rifle/dmr37,
	))

/obj/item/storage/box/visual/magazine/compact/dmr37/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/rifle/dmr37

/obj/item/storage/box/visual/magazine/compact/br64
	name = "BR-64 magazine box"
	desc = "A box specifically designed to hold a large amount of BR-64 magazines."
	closed_overlay = "mag_box_small_overlay_br64"

/obj/item/storage/box/visual/magazine/compact/br64/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/rifle/br64,
	))

/obj/item/storage/box/visual/magazine/compact/br64/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/rifle/br64

/obj/item/storage/box/visual/magazine/compact/sr127
	name = "SR-127 magazine box"
	desc = "A box specifically designed to hold a large amount of SR-127 magazines."
	closed_overlay = "mag_box_small_overlay_sr127"

/obj/item/storage/box/visual/magazine/compact/sr127/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/rifle/sr127,
	))

/obj/item/storage/box/visual/magazine/compact/sr127/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/rifle/sr127

/obj/item/storage/box/visual/magazine/compact/mosin
	name = "mosin packet box"
	desc = "A box specifically designed to hold a large amount of mosin packets."
	closed_overlay = "mag_box_small_overlay_mosin"

/obj/item/storage/box/visual/magazine/compact/mosin/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/rifle/bolt,
		/obj/item/ammo_magazine/rifle/boltclip,
	))

/obj/item/storage/box/visual/magazine/compact/mosin/packet/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/rifle/bolt

/obj/item/storage/box/visual/magazine/compact/mosin/clip/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/rifle/boltclip

// -Machinegun-

/obj/item/storage/box/visual/magazine/compact/mg42
	name = "MG-42 drum magazine box"
	desc = "A box specifically designed to hold a large amount of MG-42 drum magazines."
	closed_overlay = "mag_box_small_overlay_mg42"

/obj/item/storage/box/visual/magazine/compact/mg42/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/mg42,
	))

/obj/item/storage/box/visual/magazine/compact/mg42/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/mg42

/obj/item/storage/box/visual/magazine/compact/mg60
	name = "MG-60 magazine box"
	desc = "A box specifically designed to hold a large amount of MG-60 box magazines."
	closed_overlay = "mag_box_small_overlay_mg60"

/obj/item/storage/box/visual/magazine/compact/mg60/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/mg60,
	))

/obj/item/storage/box/visual/magazine/compact/mg60/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/mg60

/obj/item/storage/box/visual/magazine/compact/mg27
	name = "MG-27 magazine box"
	desc = "A box specifically designed to hold a large amount of MG-27 box magazines."
	closed_overlay = "mag_box_small_overlay_mg27"

/obj/item/storage/box/visual/magazine/compact/mg27/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/mg27,
	))

/obj/item/storage/box/visual/magazine/compact/mg27/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/mg27

/obj/item/storage/box/visual/magazine/compact/hmg08
	name = "HMG-08 drum box"
	desc = "A box specifically designed to hold a large amount of HMG-08 drum."
	closed_overlay = "mag_box_small_overlay_mg08"

/obj/item/storage/box/visual/magazine/compact/hmg08/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/hmg08,
	))

/obj/item/storage/box/visual/magazine/compact/hmg08/full
	spawn_number = 10
	spawn_type = /obj/item/ammo_magazine/hmg08

// --GRENADE BOXES--
/obj/item/storage/box/visual/grenade
	name = "grenade box"
	desc = "This box is able to hold a wide variety of grenades."
	icon_state = "grenade_box"
	storage_type = /datum/storage/box/visual/grenade
	overlay_pixel_x = BOX_GRENADE_OFFSET_X
	overlay_pixel_y = BOX_GRENADE_OFFSET_Y
	amt_horizontal = BOX_GRENADE_COLUMNS
	amt_vertical = BOX_GRENADE_ROWS

/obj/item/storage/box/visual/grenade/m15
	name = "\improper M15 grenade box"
	desc = "A secure box holding 25 M15 fragmentation grenades."
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/m15
	closed_overlay = "grenade_box_overlay_m15"

/obj/item/storage/box/visual/grenade/frag
	name = "\improper M40 HEDP grenade box"
	desc = "A secure box holding 25 M40 HEDP grenades. High explosive, don't store near the flamer fuel."
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade
	closed_overlay = "grenade_box_overlay_hedp"

/obj/item/storage/box/visual/grenade/incendiary
	name = "\improper M40 HIDP grenade box"
	desc = "A secure box holding 25 M40 HIDP incendiary grenades. Warning: highly flammable!!."
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/incendiary
	closed_overlay = "grenade_box_overlay_hidp"

/obj/item/storage/box/visual/grenade/cloaker
	name = "\improper M45 Cloaker grenade box"
	desc = "A secure box holding 25 M45 Cloaker greandes. Warning: causes cancer!!!"
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/sticky/cloaker
	closed_overlay = "grenade_box_overlay_cloaker"

/obj/item/storage/box/visual/grenade/trailblazer
	name = "\improper M45 Trailblazer grenade box"
	desc = "A secure box holding 25 M45 Trailblazer grenades. Warning: highly flammable!!!"
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/sticky/trailblazer
	closed_overlay = "grenade_box_overlay_M45"

/obj/item/storage/box/visual/grenade/trailblazer/phosphorus
	name = "\improper M45 Phosphorus trailblazer grenade box"
	desc = "A secure box holding 25 M45 Phosphorus trailblazer grenades. Warning: VERY flammable!!!"
	spawn_type = /obj/item/explosive/grenade/sticky/trailblazer/phosphorus
	closed_overlay = "grenade_box_overlay_M45_phosphorus"

/obj/item/storage/box/visual/grenade/sticky
	name = "\improper M40 adhesive charge grenade box"
	desc = "A secure box holding 25 M40 adhesive charge grenades. Highly explosive and sticky."
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/sticky
	closed_overlay = "grenade_box_overlay_sticky"

/obj/item/storage/box/visual/grenade/phosphorus
	name = "\improper M40 HPDP grenade box"
	desc = "A secure box holding 15 M40 HPDP white phosphorous grenades. War crimes for the entire platoon!"
	spawn_number = 15
	spawn_type = /obj/item/explosive/grenade/phosphorus
	closed_overlay = "grenade_box_overlay_phosphorus"

/obj/item/storage/box/visual/grenade/phosphorus/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 15
	storage_datum.max_storage_space = 30

/obj/item/storage/box/visual/grenade/impact
	name = "\improper M40 IMDP grenade box"
	desc = "A secure box holding 25 M40 IMDP impact grenades. High explosive, don't store near the flamer fuel."
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/impact
	closed_overlay = "grenade_box_overlay_impact"

/obj/item/storage/box/visual/grenade/cloak
	name = "\improper M40-2 SCDP grenade box"
	desc = "A secure box holding 25 M40-2 SCDP cloak grenades. Don't blindly shoot into the smoke."
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/smokebomb/cloak
	closed_overlay = "grenade_box_overlay_cloak"

/obj/item/storage/box/visual/grenade/smokebomb
	name = "\improper M40 HSDP grenade box"
	desc = "A secure box holding 25 M40 HSDP smoke grenades. Don't blindly shoot into the smoke."
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/smokebomb
	closed_overlay = "grenade_box_overlay_smokebomb"

/obj/item/storage/box/visual/grenade/drain
	name = "\improper M40-T grenade box"
	desc = "A secure box holding 25 M40-T gas grenades. 100% safe to use around masked marines."
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/smokebomb/drain
	closed_overlay = "grenade_box_overlay_drain"

/obj/item/storage/box/visual/grenade/drain/sticky
	name = "\improper M45-T grenade box"
	desc = "A secure box holding 25 M40-T gas grenades. 100% safe to use around masked marines."
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/sticky/cloaker/tangle
	closed_overlay = "grenade_box_overlay_drain"

/obj/item/storage/box/visual/grenade/antigas
	name = "\improper M40-AG grenade box"
	desc = "A secure box holding 25 M40-AG gas grenades. Quickly clears out hostile smoke."
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/smokebomb/antigas
	closed_overlay = "grenade_box_overlay_antigas"

/obj/item/storage/box/visual/grenade/razorburn
	name = "razorburn grenade box"
	desc = "A secure box holding 15 razor burn grenades. Used for quick flank coverage."
	spawn_number = 15
	spawn_type = /obj/item/explosive/grenade/chem_grenade/razorburn_small
	closed_overlay = "grenade_box_overlay_razorburn"

/obj/item/storage/box/visual/grenade/razorburn/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 15
	storage_datum.max_storage_space = 30

/obj/item/storage/box/visual/grenade/razorburn_large
	name = "razorburn canister box"
	desc = "A secure box holding 10 razorburn canisters. Used for quick flank coverage."
	spawn_number = 10
	spawn_type = /obj/item/explosive/grenade/chem_grenade/razorburn_large
	closed_overlay = "grenade_box_overlay_razorburn_large"

/obj/item/storage/box/visual/grenade/razorburn_large/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 10
	storage_datum.max_storage_space = 20

/obj/item/storage/box/visual/grenade/teargas
	name = "\improper M66 teargas grenade box"
	desc = "A secure box holding 25 M66 tear gas grenades. Used for riot control."
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/chem_grenade/teargas
	closed_overlay = "grenade_box_overlay_teargas"

/obj/item/storage/box/visual/grenade/lasburster
	name = "\improper M80 lasburster grenade box"
	desc = "A secure box holding 25 M80 lasburster grenades."
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/bullet/laser
	closed_overlay = "grenade_box_overlay_grenade_lasburster"

/obj/item/storage/box/visual/grenade/hefa
	name = "\improper M25 HEFA grenade box"
	desc = "A secure box holding 25 M25 high explosive fragmentation grenades. Keep very far away from extreme heat and flame."
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/bullet/hefa
	closed_overlay = "grenade_box_overlay_grenade_hefa"

/obj/item/storage/box/visual/grenade/training
	name = "\improper M07 training grenade box"
	desc = "A secure box holding 25 M07 training grenades. Harmless and reusable."
	spawn_number = 25
	spawn_type = /obj/item/explosive/grenade/training
	closed_overlay = "grenade_box_overlay_training"

#undef BOX_OVERLAY_SHIFT_X
#undef BOX_OVERLAY_SHIFT_Y

#undef BOX_MAGAZINE_OFFSET_X
#undef BOX_MAGAZINE_OFFSET_Y
#undef BOX_MAGAZINE_COLUMNS
#undef BOX_MAGAZINE_ROWS

#undef BOX_MAGAZINE_COMPACT_OFFSET_X
#undef BOX_MAGAZINE_COMPACT_OFFSET_Y
#undef BOX_MAGAZINE_COMPACT_COLUMNS
#undef BOX_MAGAZINE_COMPACT_ROWS

#undef BOX_GRENADE_OFFSET_X
#undef BOX_GRENADE_OFFSET_Y
#undef BOX_GRENADE_COLUMNS
#undef BOX_GRENADE_ROWS
