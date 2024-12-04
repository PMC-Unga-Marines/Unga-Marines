/datum/component/magazine_catcher
	var/mob/living/carbon/human/wearer
	///Parent storage in which we want to collect magazines
	var/obj/item/storage/storage

/datum/component/magazine_catcher/Initialize()
	. = ..()
	if(!isstorage(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/magazine_catcher/Destroy(force, silent)
	storage = null
	wearer = null
	return ..()

/datum/component/magazine_catcher/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED_TO_SLOT, PROC_REF(equipped_to_slot))
	RegisterSignals(parent, list(COMSIG_ITEM_EQUIPPED_NOT_IN_SLOT, COMSIG_ITEM_DROPPED), PROC_REF(removed_from_slot))
	storage = parent

/datum/component/magazine_catcher/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(COMSIG_ITEM_EQUIPPED_TO_SLOT, COMSIG_ITEM_EQUIPPED_NOT_IN_SLOT, COMSIG_ITEM_DROPPED))

/datum/component/magazine_catcher/proc/equipped_to_slot(datum/source, mob/user, slot)
	SIGNAL_HANDLER
	wearer = user
	RegisterSignal(user, COMSIG_MAGAZINE_DROP, PROC_REF(try_to_catch_magazine))

/datum/component/magazine_catcher/proc/removed_from_slot(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!iscarbon(user))
		return

	if(!wearer)
		return

	wearer = null
	UnregisterSignal(user, COMSIG_MAGAZINE_DROP)

/datum/component/magazine_catcher/proc/try_to_catch_magazine(datum/source, obj/item/mag)
	if(!storage.can_be_inserted(mag, FALSE))
		return FALSE
	return storage.handle_item_insertion(mag, TRUE)
