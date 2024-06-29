/obj/item/storage/box/t500case
	name = "\improper R-500 special case"
	desc = "High-tech case made by BMSS for delivery their special weapons. Label on this case says: 'This is the greatest handgun ever made. Five bullets. More than enough to kill anything that moves'."
	icon = 'modular_RUtgmc/icons/obj/items/storage/storage.dmi'
	icon_state = "t500case"
	w_class = WEIGHT_CLASS_NORMAL
	max_w_class = 1
	storage_slots = 5
	max_storage_space = 1
	can_hold = list(
		/obj/item/attachable/stock/t500stock,
		/obj/item/attachable/lace/t500,
		/obj/item/attachable/t500barrelshort,
		/obj/item/attachable/t500barrel,
		/obj/item/weapon/gun/revolver/t500,
	)
	bypass_w_limit = list(
		/obj/item/attachable/stock/t500stock,
		/obj/item/attachable/lace/t500,
		/obj/item/attachable/t500barrelshort,
		/obj/item/attachable/t500barrel,
		/obj/item/weapon/gun/revolver/t500,
	)

/obj/item/storage/box/t500case/Initialize()
	. = ..()
	new /obj/item/attachable/stock/t500stock(src)
	new /obj/item/attachable/lace/t500(src)
	new /obj/item/attachable/t500barrelshort(src)
	new /obj/item/attachable/t500barrel(src)
	new /obj/item/weapon/gun/revolver/t500(src)

/obj/item/storage/box/visual
	icon = 'modular_RUtgmc/icons/obj/items/storage/storage_boxes.dmi'

/obj/item/storage/box/visual/attack_hand(mob/living/user)
	if(loc == user)
		open(user) //Always show content when holding box
		return

	if(!deployed)
		return ..()

	else if(deployed)
		draw_mode = variety == 1? TRUE: FALSE //If only one type of item in box, then quickdraw it.
		if(draw_mode && ishuman(user) && length(contents))
			var/obj/item/I = contents[length(contents)]
			I.attack_hand(user)
			return
		open(user)

/obj/item/storage/box/visual/update_overlays()
	. = ..()

	if(!deployed)
		icon_state = "[initial(icon_state)]"
		if(closed_overlay)
			. += image('modular_RUtgmc/icons/obj/items/storage/storage_boxes.dmi', icon_state = closed_overlay)
		return

	if(open_overlay)
		. += image('modular_RUtgmc/icons/obj/items/storage/storage_boxes.dmi', icon_state = open_overlay)

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
			var/imagepixel_x = overlay_pixel_x + FLOOR((current_iteration / amt_vertical) - 0.01, 1) * shift_x
			var/imagepixel_y = overlay_pixel_y + min(amt_vertical - WRAP(current_iteration - 1, 0, amt_vertical) - 1, total_overlays - current_iteration) * shift_y
			var/obj/item/relateditem = obj_typepath

			. += image('modular_RUtgmc/icons/obj/items/items_mini.dmi', icon_state = initial(relateditem.icon_state_mini), pixel_x = imagepixel_x, pixel_y = imagepixel_y)
			current_iteration++

/obj/item/storage/box/visual/grenade/trailblazer/phosphorus
	name = "\improper M45 Phosphorus trailblazer grenade box"
	desc = "A secure box holding 25 M45 Phosphorus trailblazer grenades. Warning: VERY flammable!!!"
	spawn_type = /obj/item/explosive/grenade/sticky/trailblazer/phosphorus
	closed_overlay = "grenade_box_overlay_M45_phosphorus"
