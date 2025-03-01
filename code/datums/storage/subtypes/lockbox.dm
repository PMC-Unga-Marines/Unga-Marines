/datum/storage/lockbox
	max_w_class = WEIGHT_CLASS_NORMAL
	max_storage_space = 14
	storage_slots = 4

/datum/storage/lockbox/show_to(mob/user)
	var/obj/item/storage/lockbox/parent_box = parent
	if(parent_box.locked)
		to_chat(user, span_warning("Its locked!"))
		return
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
