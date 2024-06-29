/datum/keybinding/mob/drop_item/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.drop_item_v()
	return TRUE
