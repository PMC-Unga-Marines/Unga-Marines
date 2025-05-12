// See code\game\objects\items\storage\backpack.dm
/datum/storage/backpack
	max_w_class = WEIGHT_CLASS_NORMAL
	storage_slots = null
	max_storage_space = 24
	access_delay = 1.5 SECONDS

/datum/storage/backpack/should_access_delay(obj/item/item, mob/user, taking_out)
	if(!taking_out) // Always allow items to be tossed in instantly
		return FALSE
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(human_user.back == parent)
			return TRUE
	return FALSE

/datum/storage/backpack/holding
	max_w_class = WEIGHT_CLASS_BULKY
	max_storage_space = 28

/datum/storage/backpack/santabag
	max_w_class = WEIGHT_CLASS_NORMAL
	max_storage_space = 400 // can store a ton of shit!

/datum/storage/backpack/satchel //Smaller, but no delay
	max_storage_space = 15
	access_delay = 0

/datum/storage/backpack/tech/New(atom/parent)
	. = ..()
	set_holdable(storage_type_limits_list = list(
		/obj/item/weapon/gun/sentry/basic,
		/obj/item/weapon/gun/sentry/mini,
		/obj/item/weapon/gun/hsg102,
		/obj/item/ammo_magazine/hsg102,
		/obj/item/ammo_magazine/sentry,
		/obj/item/ammo_magazine/minisentry,
		/obj/item/mortal_shell,
		/obj/item/mortar_kit,
		/obj/item/stack/razorwire,
		/obj/item/stack/sandbags,
	))

/datum/storage/backpack/satchel/tech/New(atom/parent)
	. = ..()
	set_holdable(storage_type_limits_list = list(
		/obj/item/weapon/gun/sentry/mini,
		/obj/item/ammo_magazine/hsg102,
		/obj/item/ammo_magazine/sentry,
		/obj/item/ammo_magazine/minisentry,
		/obj/item/mortal_shell,
		/obj/item/stack/razorwire,
		/obj/item/stack/sandbags,
	))

/datum/storage/backpack/no_delay //Backpack sized with no draw delay
	access_delay = 0

/datum/storage/backpack/commando
	max_storage_space = 40
	access_delay = 0

/datum/storage/backpack/captain
	max_storage_space = 30

/datum/storage/backpack/dispenser
	max_w_class = WEIGHT_CLASS_GIGANTIC
	max_storage_space = 48

/datum/storage/backpack/dispenser/open(mob/user)
	var/obj/item/dispenser = parent
	if(CHECK_BITFIELD(dispenser.item_flags, IS_DEPLOYED))
		return ..()

/datum/storage/backpack/dispenser/attempt_draw_object(mob/living/user)
	to_chat(user, span_notice("You can't grab anything out of [parent] while it's not deployed."))

/datum/storage/backpack/duffelbag
	access_delay = 0

/datum/storage/backpack/duffelbag/put_storage_in_hand(datum/source, obj/over_object, mob/living/carbon/human/user)
	//Taking off the duffelbag has a channel
	if(user.back != parent || !do_after(user, 3 SECONDS))
		return

	switch(over_object.name)
		if("r_hand")
			INVOKE_ASYNC(src, PROC_REF(put_item_in_r_hand), source, user)
		if("l_hand")
			INVOKE_ASYNC(src, PROC_REF(put_item_in_l_hand), source, user)

/datum/storage/backpack/duffelbag/open(mob/user)
	if(!iscarbon(user))
		return TRUE
	var/mob/living/carbon/carbon_user = user
	if(carbon_user.back == parent && !do_after(carbon_user, 2 SECONDS))
		return TRUE
	return ..()

/datum/storage/backpack/duffelbag/attempt_draw_object(mob/living/carbon/user, start_from_left)
	if(user.back == parent && user.active_storage != src)
		to_chat(user, span_notice("You can't grab anything out of [parent] while it's on your back."))
		return
	return ..()

/datum/storage/backpack/duffelbag/saddle
	max_storage_space = 18
