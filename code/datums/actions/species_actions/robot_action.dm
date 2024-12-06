///Lets a robot repair itself over time at the cost of being stunned and blind
/datum/action/repair_self
	name = "Activate autorepair"
	action_icon_state = "suit_configure"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_KB_ROBOT_AUTOREPAIR,
	)

/datum/action/repair_self/can_use_action()
	. = ..()
	if(!.)
		return
	return !owner.incapacitated()

/datum/action/repair_self/action_activate()
	. = ..()
	if(!. || !ishuman(owner))
		return
	var/mob/living/carbon/human/howner = owner
	howner.apply_status_effect(STATUS_EFFECT_REPAIR_MODE, 10 SECONDS)
	howner.balloon_alert_to_viewers("Repairing")
