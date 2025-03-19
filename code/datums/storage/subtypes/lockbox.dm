/datum/storage/lockbox
	max_w_class = WEIGHT_CLASS_NORMAL
	max_storage_space = 14
	storage_slots = 4

/datum/storage/lockbox/open(mob/user)
	var/obj/item/storage/lockbox/parent_box = parent
	if(parent_box.locked)
		user.balloon_alert(user, "closed!")
		return FALSE
	return ..()

/datum/storage/lockbox/attempt_draw_object(mob/living/user, start_from_left)
	var/obj/item/storage/lockbox/parent_box = parent
	if(parent_box.locked)
		user.balloon_alert(user, "closed!")
		return FALSE
	return ..()

/datum/storage/lockbox/can_be_inserted(obj/item/item_to_insert, mob/user, warning)
	var/obj/item/storage/lockbox/parent_box = parent
	if(parent_box.locked)
		user.balloon_alert(user, "closed!")
		return FALSE
	return ..()

/datum/storage/lockbox/dump_content_at(atom/dest_object, dump_loc, mob/user)
	var/obj/item/storage/lockbox/parent_box = parent
	if(parent_box.locked)
		user.balloon_alert(user, "closed!")
		return FALSE
	return ..()

/datum/storage/lockbox/vials
	max_storage_space = 14
	storage_slots = 6

/datum/storage/lockbox/vials/New(atom/parent)
	. = ..()
	set_holdable(can_hold_list = list(/obj/item/reagent_containers/glass/beaker/vial))

/datum/storage/secure
	max_w_class = WEIGHT_CLASS_SMALL
	max_storage_space = 14

/datum/storage/secure/safe
	max_w_class = WEIGHT_CLASS_GIGANTIC

/datum/storage/wallet/New(atom/parent)
	. = ..()
	set_holdable(cant_hold_list = list(/obj/item/storage/secure/briefcase))
