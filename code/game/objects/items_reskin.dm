/**
 * Reskins object based on a user's choice
 *
 * Arguments:
 * * user The mob choosing a reskin option
 */
/obj/item/proc/reskin_obj(obj/item/facepaint/paint, mob/user)
	if(!LAZYLEN(unique_reskin))
		return

	var/list/items = list()
	for(var/reskin_option in unique_reskin)
		var/image/item_image = image(icon = src.icon, icon_state = unique_reskin[reskin_option])
		items += list("[reskin_option]" = item_image)
	sort_list(items)

	var/pick = show_radial_menu(user, src, items, custom_check = CALLBACK(src, PROC_REF(check_reskin_menu), user), radius = 38, require_near = TRUE)
	if(!pick)
		return
	if(!unique_reskin[pick])
		return
	current_skin = unique_reskin[pick]
	icon_state = unique_reskin[pick]
	//this may not be the right way to do it but..
	if(base_icon_state)
		base_icon_state = unique_reskin[pick]
	to_chat(user, "[src] is now skinned as '[pick].'")
	SEND_SIGNAL(src, COMSIG_OBJ_RESKIN, user, pick)
	//correctly display item in hands
	update_icon()
	if(paint)
		user.temporarilyRemoveItemFromInventory(paint)
		user.update_inv_l_hand(0)
		user.update_inv_r_hand()
		qdel(paint)

/**
 * Checks if we are allowed to interact with a radial menu for reskins
 *
 * Arguments:
 * * user The mob interacting with the menu
 */
/obj/item/proc/check_reskin_menu(mob/user)
	if(QDELETED(src))
		return FALSE
	if(current_skin)
		return FALSE
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE
