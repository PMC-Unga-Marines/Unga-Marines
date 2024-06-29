/datum/item_representation
	///If the item has hair concealing changed, save it.
	var/hair_concealing_option

/datum/item_representation/New(obj/item/item_to_copy)
	if(!item_to_copy)
		return
	item_type = item_to_copy.type
	if(item_to_copy.current_variant && item_to_copy.colorable_allowed & ICON_STATE_VARIANTS_ALLOWED)
		for(var/key in GLOB.loadout_variant_keys)
			var/val = GLOB.loadout_variant_keys[key]
			if(val != item_to_copy.current_variant)
				continue
			variant = key
			break

	if(item_to_copy.current_hair_concealment && item_to_copy.colorable_allowed & HAIR_CONCEALING_CHANGE_ALLOWED)
		hair_concealing_option = item_to_copy.current_hair_concealment

	if(!item_to_copy.greyscale_config)
		return
	colors = item_to_copy.greyscale_colors

/datum/item_representation/instantiate_object(datum/loadout_seller/seller, master = null, mob/living/carbon/human/user)
	if(seller && !bypass_vendor_check && !buy_item_in_vendor(item_type, seller, user))
		return
	if(!text2path("[item_type]"))
		to_chat(user, span_warning("[item_type] in your loadout is an invalid item, it has probably been changed or removed."))
		return
	var/obj/item/item = new item_type(master)
	if(item.greyscale_config)
		item.set_greyscale_colors(colors)
	if(item.current_variant && item.colorable_allowed & ICON_STATE_VARIANTS_ALLOWED)
		item.current_variant = GLOB.loadout_variant_keys[variant]
		item.update_icon()
	if(item.colorable_allowed & HAIR_CONCEALING_CHANGE_ALLOWED)
		item.current_hair_concealment = hair_concealing_option
		item.switch_hair_concealment_flags(user)
	return item
