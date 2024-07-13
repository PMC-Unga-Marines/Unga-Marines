/obj/item/reagent_containers/hypospray/unique_action(mob/living/carbon/user)
	. = ..()
	if(user.species.species_flags & ROBOTIC_LIMBS)
		return FALSE

	if(inject_mode == HYPOSPRAY_INJECT_MODE_DRAW)
		balloon_alert(user, "You don't think this is a good idea...")
		return FALSE

	if(!reagents.total_volume)
		balloon_alert(user, "Hypospray is empty!")
		return FALSE

	if(skilllock && user.skills.getRating(SKILL_MEDICAL) < SKILL_MEDICAL_NOVICE)
		user.visible_message(span_notice("[user] fumbles around figuring out how to use the [src]."),
		span_notice("You fumble around figuring out how to use the [src]."))
		if(!do_after(user, SKILL_TASK_EASY, NONE, user_display = BUSY_ICON_UNSKILLED))
			return FALSE

	if(!user.can_inject(user, TRUE, user.zone_selected, TRUE))
		return FALSE

	var/list/injected = list()
	for(var/datum/reagent/R in reagents.reagent_list)
		injected += R.name

	to_chat(user, span_notice("You inject yourself with [src]!"))
	record_reagent_consumption(min(amount_per_transfer_from_this, reagents.total_volume), injected, user)

	// /mob/living/carbon/human/attack_hand causes
	// changeNext_move(7) which creates a delay
	// This line overrides the delay, and will absolutely break everything
	user.changeNext_move(3) // please don't break the game

	playsound(loc, 'sound/items/hypospray.ogg', 50, 1)
	reagents.reaction(user, INJECT, min(amount_per_transfer_from_this, reagents.total_volume) / reagents.total_volume)
	var/trans = reagents.trans_to(user, amount_per_transfer_from_this)
	to_chat(user, span_notice("[trans] units injected. [reagents.total_volume] units remaining in [src]. ")) // better to not balloon
	return TRUE
