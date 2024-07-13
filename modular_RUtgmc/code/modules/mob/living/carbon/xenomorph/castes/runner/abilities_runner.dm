// ***************************************
// *********** Runner's Pounce
// ***************************************
/datum/action/ability/activable/xeno/pounce/runner/process()
	if(!owner)
		return PROCESS_KILL
	return ..()

// ***************************************
// *********** Snatch
// ***************************************

/datum/action/ability/activable/xeno/snatch
	cooldown_duration = 35 SECONDS

/datum/action/ability/activable/xeno/snatch/drop_item()
	if(!stolen_item)
		return

	stolen_item.drag_windup = 0 SECONDS
	owner.start_pulling(stolen_item, suppress_message = FALSE)
	stolen_item.drag_windup = 1.5 SECONDS

	return ..()

/datum/action/ability/activable/xeno/snatch/use_ability(atom/A)
	var/mob/living/carbon/xenomorph/X = owner
	if(!do_after(owner, 0.5 SECONDS, IGNORE_HELD_ITEM, A, BUSY_ICON_DANGER, extra_checks = CALLBACK(owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = X.health))))
		return FALSE
	var/mob/living/carbon/human/victim = A
	stolen_item = victim.get_active_held_item()
	if(!stolen_item)
		stolen_item = victim.get_inactive_held_item()
		for(var/slot in slots_to_steal_from)
			stolen_item = victim.get_item_by_slot(slot)
			if(stolen_item)
				break
	if(!stolen_item)
		victim.balloon_alert(owner, "Snatch failed, no item")
		return fail_activate()
	playsound(owner, 'sound/voice/alien_pounce2.ogg', 30)
	victim.dropItemToGround(stolen_item, TRUE)
	stolen_item.forceMove(owner)
	stolen_appearance = mutable_appearance(stolen_item.icon, stolen_item.icon_state)
	stolen_appearance.layer = ABOVE_OBJ_LAYER
	addtimer(CALLBACK(src, PROC_REF(drop_item), stolen_item), 3 SECONDS)
	RegisterSignal(owner, COMSIG_ATOM_DIR_CHANGE, PROC_REF(owner_turned))
	owner.add_movespeed_modifier(MOVESPEED_ID_SNATCH, TRUE, 0, NONE, TRUE, 2)
	owner_turned(null, null, owner.dir)
	succeed_activate()
	add_cooldown()
