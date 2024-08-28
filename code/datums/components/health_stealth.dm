/datum/component/health_stealth
	var/mob/living/carbon/human/wearer
	///Instant analyzer for the suit
	var/obj/item/healthanalyzer/integrated/analyzer
	///Actions that the component provides
	var/list/datum/action/component_actions = list(
		/datum/action/suit_autodoc/scan = PROC_REF(scan_user)
	)

/datum/component/health_stealth/Initialize()
	. = ..()
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	analyzer = new
	var/list/new_actions = list()
	for(var/action_type in component_actions)
		var/new_action = new action_type(src, FALSE)
		new_actions += new_action
		RegisterSignal(new_action, COMSIG_ACTION_TRIGGER, component_actions[action_type])
	component_actions = new_actions

/datum/component/health_stealth/Destroy(force, silent)
	for(var/action in component_actions)
		QDEL_NULL(action)
	QDEL_NULL(analyzer)
	wearer = null
	return ..()

///Used to scan the person
/datum/component/health_stealth/proc/scan_user(datum/source)
	SIGNAL_HANDLER
	INVOKE_ASYNC(analyzer, TYPE_PROC_REF(/obj/item/healthanalyzer, attack), wearer, wearer, TRUE)

/datum/component/health_stealth/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED_TO_SLOT, PROC_REF(equipped_to_slot))
	RegisterSignals(parent, list(COMSIG_ITEM_EQUIPPED_NOT_IN_SLOT, COMSIG_ITEM_DROPPED), PROC_REF(removed_from_slot))

/datum/component/health_stealth/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(COMSIG_ITEM_EQUIPPED_TO_SLOT, COMSIG_ITEM_EQUIPPED_NOT_IN_SLOT, COMSIG_ITEM_DROPPED))

/datum/component/health_stealth/proc/equipped_to_slot(datum/source, mob/user, slot)
	SIGNAL_HANDLER
	wearer = user
	for(var/datum/action/current_action AS in component_actions)
		current_action.give_action(wearer)
	RegisterSignal(user, COMSIG_LIVING_HEALTH_STEALTH, PROC_REF(hide_health))

/datum/component/health_stealth/proc/hide_health()
	return COMPONENT_HIDE_HEALTH

/datum/component/health_stealth/proc/removed_from_slot(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!iscarbon(user))
		return

	if(!wearer)
		return

	for(var/datum/action/current_action AS in component_actions)
		current_action.remove_action(wearer)
	wearer = null
	UnregisterSignal(user, COMSIG_LIVING_HEALTH_STEALTH)
