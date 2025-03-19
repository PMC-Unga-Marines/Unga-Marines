/datum/component/magazine_catcher
	var/mob/living/carbon/human/wearer
	///Parent storage in which we want to collect magazines
	var/datum/storage/storage
	////Auto catching empty magazines: FALSE - disabled, TRUE - enabled
	var/auto_catch = TRUE

/datum/component/magazine_catcher/Initialize()
	. = ..()
	var/atom/atom_parent = parent
	if(!atom_parent.storage_datum)
		return COMPONENT_INCOMPATIBLE

/datum/component/magazine_catcher/Destroy(force, silent)
	storage = null
	wearer = null
	return ..()

/datum/component/magazine_catcher/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED_TO_SLOT, PROC_REF(equipped_to_slot))
	RegisterSignals(parent, list(COMSIG_ITEM_EQUIPPED_NOT_IN_SLOT, COMSIG_ITEM_DROPPED), PROC_REF(removed_from_slot))
	var/atom/atom_parent = parent
	storage = atom_parent.storage_datum
	atom_parent.verbs += /datum/component/magazine_catcher/proc/toggle_auto_catch

/datum/component/magazine_catcher/UnregisterFromParent()
	. = ..()
	if(storage)
		var/atom/atom_parent = parent
		atom_parent.verbs -= /datum/component/magazine_catcher/proc/toggle_auto_catch
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
	if(!auto_catch)
		return FALSE
	return storage.handle_item_insertion(mag, TRUE)

/datum/component/magazine_catcher/proc/toggle_auto_catch()
	set name = "Toggle Auto Catching Magazines/Speed Loaders"
	set category = "IC.Object"
	var/datum/component/magazine_catcher/comp = GetComponent(/datum/component/magazine_catcher)
	comp.auto_catch = !comp.auto_catch
	if(!comp.auto_catch)
		to_chat(usr, span_notice("Auto catching disabled."))
	else
		to_chat(usr, span_notice("Auto catching enabled."))
