/**
 * Light weight representation of an obj/item
 * This allow us to manipulate and store a lot of item-like objects, without it costing a ton of memory or having to instantiate all items
 * This also allow to save loadouts with jatum, because it doesn't accept obj/item
 */
/datum/item_representation
	/// The type of the object represented, to allow us to create the object when needed
	var/obj/item/item_type
	///If the item has greyscale colors, they are saved here
	var/colors
	///If the item has an icon_state variant, save it.
	var/variant
	/// If it's allowed to bypass the vendor check
	var/bypass_vendor_check = FALSE
	///If the item has hair concealing changed, save it.
	var/hair_concealing_option
	/// The contents in the storage (If there is storage)
	var/list/contents = list()

/datum/item_representation/New(obj/item/item_to_copy)
	if(!item_to_copy && !isobj(item_to_copy))
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

/**
 * This will attempt to instantiate an object.
 * First, it tries to find that object in a vendor with enough supplies.
 * If it finds one vendor with that item in reserve, it sells it and instantiate that item.
 * If it fails to find a vendor, it will add that item to a list on seller to warns him that it failed
 ** Seller: The datum in charge of checking for points and buying_flags
 ** Master: used for modules, when the item need to be installed on master. Can be null
 ** User: The human trying to equip this item
 ** Return the instantatiated item if it was successfully sold, and return null otherwise
 */
/datum/item_representation/proc/instantiate_object(datum/loadout_seller/seller, master = null, mob/living/user)
	if(!bypass_vendor_check && seller && !buy_item_in_vendor(item_type, seller, user))
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
	if(item.storage_datum)
		instantiate_current_storage_datum(seller, item, user)
	return item

/**
 * This is in charge of generating a visualisation of the item, that will then be gave to TGUI
 */
/datum/item_representation/proc/get_tgui_data()
	var/list/tgui_data = list()
	var/icon/icon_to_convert
	var/icon_state = initial(item_type.icon_state) + (variant ? "_[GLOB.loadout_variant_keys[variant]]" : "")
	if(initial(item_type.greyscale_config))
		icon_to_convert = icon(SSgreyscale.GetColoredIconByType(initial(item_type.greyscale_config), colors), icon_state,  dir = SOUTH)
	else
		icon_to_convert = icon(initial(item_type.icon), icon_state, SOUTH)
	tgui_data["icons"] = list(list(
		"icon" = icon2base64(icon_to_convert),
		"translateX" = NO_OFFSET,
		"translateY" = NO_OFFSET,
		"scale" = 1,
	))
	tgui_data["name"] = initial(item_type.name)
	return tgui_data

/**
 * Allow to representate a storage
 * This is only able to represent /obj/item/storage
 */
/datum/item_representation/storage

/datum/item_representation/storage/New(obj/item/item_to_copy)
	if(!item_to_copy)
		return
	if(!isobj(item_to_copy))
		CRASH("/datum/item_representation/storage called New([item_to_copy]), when [item_to_copy] is not an obj")
	. = ..()
	//Internal storage are not in vendors. They should always be available for the loadout vendors, because they are instantiated like any other object
	if(istype(item_to_copy, /obj/item/storage/internal))
		bypass_vendor_check = TRUE
	for(var/atom/thing_in_content AS in item_to_copy.contents)
		if(!isitem(thing_in_content))
			continue
		var/item_representation_type = item2representation_type(thing_in_content.type)
		if(item_representation_type == /datum/item_representation/storage) //Storage nested in storage tends to be erased by jatum, so just give the default content
			item_representation_type = /datum/item_representation
		contents += new item_representation_type(thing_in_content)

///Like instantiate_object(), but returns a /datum instead of a /item, master is REQUIRED and it must be at least an atom
/datum/item_representation/proc/instantiate_current_storage_datum(datum/loadout_seller/seller, atom/master = null, mob/living/user)
	if(!master)
		CRASH("instantiate_current_storage_datum called with null master")
	item_type = master
	if(!isatom(item_type))
		CRASH("[item_type] is not a /atom, it cannot have storage")

	if(is_type_in_typecache(item_type, GLOB.loadout_instantiate_default_contents)) //Some storage cannot handle custom contents
		return
	var/datum/storage/current_storage_datum = item_type.storage_datum
	var/list/obj/item/starting_items = list()
	for(var/obj/item/item_in_contents AS in current_storage_datum.parent.contents)
		starting_items[item_in_contents.type] = starting_items[item_in_contents.type] + get_item_stack_number(item_in_contents)
	current_storage_datum.delete_contents()
	for(var/datum/item_representation/item_representation AS in contents)
		if(!item_representation.bypass_vendor_check && starting_items[item_representation.item_type] > 0)
			var/amount_to_remove = get_item_stack_representation_amount(item_representation)
			if(starting_items[item_representation.item_type] < amount_to_remove)
				amount_to_remove = starting_items[item_representation.item_type]
				var/datum/item_representation/stack/stack_representation = item_representation
				stack_representation.amount = amount_to_remove
			starting_items[item_representation.item_type] = starting_items[item_representation.item_type] - amount_to_remove
			item_representation.bypass_vendor_check = TRUE
		var/obj/item/item_to_insert = item_representation.instantiate_object(seller, item_representation.item_type, user)
		if(!item_to_insert)
			continue
		if(current_storage_datum.can_be_inserted(item_to_insert, user))
			current_storage_datum.handle_item_insertion(item_to_insert)
			continue
		item_to_insert.forceMove(get_turf(user))

/**
 * Allow to representate stacks of item of type /obj/item/stack
 */
/datum/item_representation/stack
	///Amount of items in the stack
	var/amount = 0

/datum/item_representation/stack/New(obj/item/item_to_copy)
	if(!item_to_copy)
		return
	if(!isitemstack(item_to_copy))
		CRASH("/datum/item_representation/stack created from an item that is not a stack of items")
	. = ..()
	var/obj/item/stack/stack_to_copy = item_to_copy
	amount = stack_to_copy.amount

/datum/item_representation/stack/instantiate_object(datum/loadout_seller/seller, master = null, mob/living/user)
	if(seller && !bypass_vendor_check && !buy_stack(item_type, seller, user, amount) && !buy_item_in_vendor(item_type, seller, user))
		return
	var/obj/item/stack/stack = new item_type(master)
	stack.amount = amount
	stack.update_weight()
	stack.update_icon()
	return stack

/**
 * Allow to representate an id card (/obj/item/card/id)
 */
/datum/item_representation/id
	/// the access of the id
	var/list/access = list()
	/// the iff signal registered on the id
	var/iff_signal = NONE

/datum/item_representation/id/New(obj/item/item_to_copy)
	if(!item_to_copy)
		return
	if(!isidcard(item_to_copy))
		CRASH("/datum/item_representation/id created from an item that is not an id card")
	. = ..()
	var/obj/item/card/id/id_to_copy = item_to_copy
	access = id_to_copy.access
	iff_signal = id_to_copy.iff_signal

/datum/item_representation/id/instantiate_object(datum/loadout_seller/seller, master = null, mob/living/user)
	. = ..()
	if(!.)
		return
	var/obj/item/card/id/id = .
	id.access = access
	id.iff_signal = iff_signal
	return id

/datum/item_representation/boot
	///List of attachments on the boot.
	var/list/datum/item_representation/armor_module/attachments = list()

/datum/item_representation/boot/New(obj/item/item_to_copy)
	if(!item_to_copy)
		return
	if(!istype(item_to_copy, /obj/item/clothing/shoes))
		CRASH("/datum/item_representation/boot created from an item that is not a shoe")
	. = ..()
	var/obj/item/clothing/shoes/footwear = item_to_copy

	for(var/key in footwear.attachments_by_slot)
		if(!isitem(footwear.attachments_by_slot[key]))
			continue
		if(istype(footwear.attachments_by_slot[key], /obj/item/armor_module/storage))
			attachments += new /datum/item_representation/armor_module/storage(footwear.attachments_by_slot[key])
			continue
		attachments += new /datum/item_representation/armor_module(footwear.attachments_by_slot[key])

/datum/item_representation/boot/instantiate_object(datum/loadout_seller/seller, master = null, mob/living/user)
	. = ..()
	if(!.)
		return
	var/obj/item/clothing/shoes/footwear = .
	for(var/datum/item_representation/armor_module/armor_attachement AS in attachments)
		armor_attachement.install_on_armor(seller, footwear, user)
