// ***************************************
// *********** Hive message
// ***************************************
/datum/action/ability/xeno_action/hive_message
	name = "Hive Message" // Also known as Word of Queen.
	desc = "Announces a message to the hive."
	action_icon_state = "queen_order"
	action_icon = 'icons/Xeno/actions/general.dmi'
	ability_cost = 50
	cooldown_duration = 10 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_QUEEN_HIVE_MESSAGE,
	)
	use_state_flags = ABILITY_USE_LYING

/datum/action/ability/xeno_action/hive_message/action_activate()
	//Preferring the use of multiline input as the message box is larger and easier to quickly proofread before sending to hive.
	var/input = stripped_multiline_input(xeno_owner, "Максимальная длина: [MAX_BROADCAST_LEN]", "Приказ Улью", "", MAX_BROADCAST_LEN, TRUE)
	//Newlines are of course stripped and replaced with a space.
	input = capitalize(trim(replacetext(input, "\n", " ")))
	if(!input)
		return
	var/filter_result = is_ic_filtered(input)
	if(filter_result)
		to_chat(xeno_owner, span_warning("That announcement contained a word prohibited in IC chat! Consider reviewing the server rules.\n<span replaceRegex='show_filtered_ic_chat'>\"[input]\"</span>"))
		SSblackbox.record_feedback(FEEDBACK_TALLY, "ic_blocked_words", 1, lowertext(config.ic_filter_regex.match))
		REPORT_CHAT_FILTER_TO_USER(src, filter_result)
		log_filter("IC", input, filter_result)
		return FALSE
	if(NON_ASCII_CHECK(input))
		to_chat(xeno_owner, span_warning("That announcement contained characters prohibited in IC chat! Consider reviewing the server rules."))
		return FALSE

	log_game("[key_name(xeno_owner)] has messaged the hive with: \"[input]\"")
	deadchat_broadcast("has messaged the hive: \"[input]\"", xeno_owner, xeno_owner)
	var/queens_word = HUD_ANNOUNCEMENT_FORMATTING("СООБЩЕНИЕ УЛЬЮ", input, CENTER_ALIGN_TEXT)

	var/sound/queen_sound = sound(SFX_QUEEN, channel = CHANNEL_ANNOUNCEMENTS)
	var/sound/king_sound = sound('sound/voice/alien/xenos_roaring.ogg', channel = CHANNEL_ANNOUNCEMENTS)
	for(var/mob/living/carbon/xenomorph/xeno AS in xeno_owner.hive.get_all_xenos())
		to_chat(xeno, assemble_alert(
			title = "Приказ Улью",
			subtitle = "Приказ [xeno_owner.name]",
			message = input,
			color_override = "purple"
		))
		switch(xeno_owner.caste_base_type)
			if(/datum/xeno_caste/queen, /datum/xeno_caste/shrike)
				SEND_SOUND(xeno, queen_sound)
			if(/datum/xeno_caste/king, /datum/xeno_caste/predalien)
				SEND_SOUND(xeno, king_sound)
		//Display the ruler's hive message at the top of the game screen.
		xeno.play_screen_text(queens_word, /atom/movable/screen/text/screen_text/queen_order)

	succeed_activate()
	add_cooldown()

// ***************************************
// *********** Screech
// ***************************************
/datum/action/ability/activable/xeno/screech
	name = "Screech"
	desc = "A large area knockdown that causes pain and screen-shake."
	action_icon_state = "screech"
	action_icon = 'icons/Xeno/actions/queen.dmi'
	ability_cost = 250
	cooldown_duration = 90 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_SCREECH,
	)

/datum/action/ability/activable/xeno/screech/on_cooldown_finish()
	to_chat(owner, span_warning("We feel our throat muscles vibrate. We are ready to screech again."))
	return ..()

/datum/action/ability/activable/xeno/screech/use_ability(atom/A)
	//screech is so powerful it kills huggers in our hands
	if(istype(xeno_owner.r_hand, /obj/item/clothing/mask/facehugger))
		var/obj/item/clothing/mask/facehugger/hugger = xeno_owner.r_hand
		if(hugger.stat != DEAD)
			hugger.kill_hugger()

	if(istype(xeno_owner.l_hand, /obj/item/clothing/mask/facehugger))
		var/obj/item/clothing/mask/facehugger/hugger = xeno_owner.l_hand
		if(hugger.stat != DEAD)
			hugger.kill_hugger()

	succeed_activate()
	add_cooldown()

	playsound(xeno_owner.loc, 'sound/voice/alien/queen/screech.ogg', 75, 0)
	xeno_owner.visible_message(span_xenouserdanger("\The [xeno_owner] emits an ear-splitting guttural roar!"))
	GLOB.round_statistics.queen_screech++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "queen_screech")
	xeno_owner.create_shriekwave() //Adds the visual effect. Wom wom wom

	var/list/nearby_living = list()
	for(var/mob/living/L in hearers(WORLD_VIEW, xeno_owner))
		nearby_living.Add(L)
	for(var/obj/vehicle/sealed/armored/tank AS in GLOB.tank_list)
		if(get_dist(tank, xeno_owner) > WORLD_VIEW_NUM)
			continue
		nearby_living += tank.occupants

	for(var/mob/living/L AS in GLOB.mob_living_list)
		if(get_dist(L, xeno_owner) > WORLD_VIEW_NUM)
			continue
		L.screech_act(xeno_owner, WORLD_VIEW_NUM, L in nearby_living)

	var/datum/action/ability/xeno_action/plasma_screech = xeno_owner.actions_by_path[/datum/action/ability/activable/xeno/plasma_screech]
	if(plasma_screech)
		plasma_screech.add_cooldown(15 SECONDS)
	var/datum/action/ability/xeno_action/frenzy_screech = xeno_owner.actions_by_path[/datum/action/ability/activable/xeno/frenzy_screech]
	if(frenzy_screech)
		frenzy_screech.add_cooldown(15 SECONDS)

/datum/action/ability/activable/xeno/screech/ai_should_start_consider()
	return TRUE

/datum/action/ability/activable/xeno/screech/ai_should_use(atom/target)
	if(!iscarbon(target))
		return FALSE
	if(get_dist(target, owner) > 4)
		return FALSE
	if(!can_use_ability(target, override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(target.get_xeno_hivenumber() == owner.get_xeno_hivenumber())
		return FALSE
	return TRUE

/datum/action/ability/activable/xeno/plasma_screech
	name = "Plasma Screech"
	desc = "Screech that increases plasma regeneration for nearby xenos."
	action_icon_state = "plasma_screech"
	action_icon = 'icons/Xeno/actions/queen.dmi'
	ability_cost = 300
	cooldown_duration = 45 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PLASMA_SCREECH,
	)
	var/screech_range = 5
	var/bonus_regen = 0.5
	var/duration = 20 SECONDS

/datum/action/ability/activable/xeno/plasma_screech/use_ability(atom/A)
	for(var/mob/living/carbon/xenomorph/affected_xeno in cheap_get_xenos_near(xeno_owner, screech_range))
		if(affected_xeno == xeno_owner)
			continue
		if(!(affected_xeno.xeno_caste.can_flags & CASTE_CAN_BE_GIVEN_PLASMA))
			continue
		affected_xeno.apply_status_effect(/datum/status_effect/plasma_surge, affected_xeno.xeno_caste.plasma_max / 3, bonus_regen, duration)

	playsound(xeno_owner.loc, 'sound/voice/alien/queen/screech_plasma.ogg', 75, 0)
	xeno_owner.visible_message(span_xenouserdanger("\The [xeno_owner] emits an ear-splitting guttural roar!"))

	succeed_activate()
	add_cooldown()

	var/datum/action/ability/xeno_action/screech = xeno_owner.actions_by_path[/datum/action/ability/activable/xeno/screech]
	if(screech)
		screech.add_cooldown(10 SECONDS)
	var/datum/action/ability/xeno_action/frenzy_screech = xeno_owner.actions_by_path[/datum/action/ability/activable/xeno/frenzy_screech]
	if(frenzy_screech)
		frenzy_screech.add_cooldown(5 SECONDS)

/datum/action/ability/activable/xeno/frenzy_screech
	name = "Frenzy Screech"
	desc = "Screech that increases damage for nearby xenos."
	action_icon_state = "frenzy_screech"
	action_icon = 'icons/Xeno/actions/queen.dmi'
	ability_cost = 300
	cooldown_duration = 45 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_FRENZY_SCREECH,
	)
	var/screech_range = 5
	var/buff_duration = 20 SECONDS
	var/buff_damage_modifier = 0.1

/datum/action/ability/activable/xeno/frenzy_screech/use_ability(atom/A)
	for(var/mob/living/carbon/xenomorph/affected_xeno in cheap_get_xenos_near(xeno_owner, screech_range))
		if(affected_xeno == xeno_owner)
			continue
		affected_xeno.apply_status_effect(/datum/status_effect/frenzy_screech, buff_duration, buff_damage_modifier)

	playsound(xeno_owner.loc, 'sound/voice/alien/queen/screech_frenzy.ogg', 75, 0)
	xeno_owner.visible_message(span_xenouserdanger("\The [xeno_owner] emits an ear-splitting guttural roar!"))

	succeed_activate()
	add_cooldown()

	var/datum/action/ability/xeno_action/screech = xeno_owner.actions_by_path[/datum/action/ability/activable/xeno/screech]
	if(screech)
		screech.add_cooldown(10 SECONDS)
	var/datum/action/ability/xeno_action/plasma_screech = xeno_owner.actions_by_path[/datum/action/ability/activable/xeno/plasma_screech]
	if(plasma_screech)
		plasma_screech.add_cooldown(5 SECONDS)

/// Promote the passed xeno to a hive leader, should not be called direct
/datum/action/ability/xeno_action/set_xeno_lead/proc/set_xeno_leader(mob/living/carbon/xenomorph/selected_xeno)
	xeno_owner.balloon_alert(xeno_owner, "Xeno promoted")
	selected_xeno.balloon_alert(selected_xeno, "Promoted to leader")
	to_chat(selected_xeno, span_xenoannounce("[xeno_owner] has selected us as a Hive Leader. The other Xenomorphs must listen to us. We will also act as a beacon for the Queen's pheromones."))

	xeno_owner.hive.add_leader(selected_xeno)
	selected_xeno.hud_set_queen_overwatch()
	selected_xeno.handle_xeno_leader_pheromones(xeno_owner)
	notify_ghosts("\ [xeno_owner] has designated [selected_xeno] as a Hive Leader", source = selected_xeno, action = NOTIFY_ORBIT)

	selected_xeno.update_leader_icon(TRUE)

// ***************************************
// *********** Overwatch
// ***************************************
/datum/action/ability/xeno_action/watch_xeno
	name = "Watch Xenomorph"
	desc = "See from the target Xenomorphs vision. Click again the ability to stop observing"
	action_icon_state = "watch_xeno"
	action_icon = 'icons/Xeno/actions/queen.dmi'
	ability_cost = 0
	use_state_flags = ABILITY_USE_LYING
	hidden = TRUE
	var/overwatch_active = FALSE

/datum/action/ability/xeno_action/watch_xeno/give_action(mob/living/L)
	. = ..()
	RegisterSignal(L, COMSIG_MOB_DEATH, PROC_REF(on_owner_death))
	RegisterSignal(L, COMSIG_XENOMORPH_WATCHXENO, PROC_REF(on_list_xeno_selection))

/datum/action/ability/xeno_action/watch_xeno/remove_action(mob/living/L)
	if(overwatch_active)
		stop_overwatch()
	UnregisterSignal(L, list(COMSIG_MOB_DEATH, COMSIG_XENOMORPH_WATCHXENO))
	return ..()

/datum/action/ability/xeno_action/watch_xeno/proc/start_overwatch(mob/living/carbon/xenomorph/target)
	if(!can_use_action()) // Check for action now done here as action_activate pipeline has been bypassed with signal activation.
		return

	var/mob/living/carbon/xenomorph/old_xeno = xeno_owner.observed_xeno
	if(old_xeno == target)
		stop_overwatch(TRUE)
		return
	if(old_xeno)
		stop_overwatch(FALSE)
	xeno_owner.observed_xeno = target
	if(isxenoqueen(xeno_owner)) // Only queen needs the eye shown.
		target.hud_set_queen_overwatch()
	xeno_owner.reset_perspective()
	RegisterSignal(target, COMSIG_HIVE_XENO_DEATH, PROC_REF(on_xeno_death))
	RegisterSignals(target, list(COMSIG_XENOMORPH_EVOLVED, COMSIG_XENOMORPH_DEEVOLVED), PROC_REF(on_xeno_evolution))
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_movement))
	RegisterSignal(xeno_owner, COMSIG_XENOMORPH_TAKING_DAMAGE, PROC_REF(on_damage_taken))
	overwatch_active = TRUE
	set_toggle(TRUE)

/datum/action/ability/xeno_action/watch_xeno/proc/stop_overwatch(do_reset_perspective = TRUE)
	var/mob/living/carbon/xenomorph/observed = xeno_owner.observed_xeno
	xeno_owner.observed_xeno = null
	if(!QDELETED(observed))
		UnregisterSignal(observed, list(COMSIG_HIVE_XENO_DEATH, COMSIG_XENOMORPH_EVOLVED, COMSIG_XENOMORPH_DEEVOLVED))
		if(isxenoqueen(xeno_owner)) // Only queen has to reset the eye overlay.
			observed.hud_set_queen_overwatch()
	if(do_reset_perspective)
		xeno_owner.reset_perspective()
	UnregisterSignal(xeno_owner, list(COMSIG_MOVABLE_MOVED, COMSIG_XENOMORPH_TAKING_DAMAGE))
	overwatch_active = FALSE
	set_toggle(FALSE)

/datum/action/ability/xeno_action/watch_xeno/proc/on_list_xeno_selection(datum/source, mob/living/carbon/xenomorph/selected_xeno)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(start_overwatch), selected_xeno)

/datum/action/ability/xeno_action/watch_xeno/proc/on_xeno_evolution(datum/source, mob/living/carbon/xenomorph/new_xeno)
	SIGNAL_HANDLER
	start_overwatch(new_xeno)

/datum/action/ability/xeno_action/watch_xeno/proc/on_xeno_death(datum/source, mob/living/carbon/xenomorph/dead_xeno)
	SIGNAL_HANDLER
	if(overwatch_active)
		stop_overwatch()

/datum/action/ability/xeno_action/watch_xeno/proc/on_owner_death(mob/source, gibbing)
	SIGNAL_HANDLER
	if(overwatch_active)
		stop_overwatch()

/datum/action/ability/xeno_action/watch_xeno/proc/on_movement(datum/source, atom/oldloc, direction, Forced)
	SIGNAL_HANDLER
	if(overwatch_active)
		stop_overwatch()

/datum/action/ability/xeno_action/watch_xeno/proc/on_damage_taken(datum/source, damage)
	SIGNAL_HANDLER
	if(overwatch_active)
		stop_overwatch()


// ***************************************
// *********** Queen zoom
// ***************************************
/datum/action/ability/xeno_action/toggle_queen_zoom
	name = "Toggle Queen Zoom"
	desc = "Zoom out for a larger view around wherever you are looking."
	action_icon_state = "toggle_queen_zoom"
	action_icon = 'icons/Xeno/actions/queen.dmi'
	ability_cost = 0
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TOGGLE_QUEEN_ZOOM,
	)

/datum/action/ability/xeno_action/toggle_queen_zoom/action_activate()
	if(xeno_owner.do_actions)
		return
	if(xeno_owner.xeno_flags & XENO_ZOOMED)
		zoom_xeno_out(xeno_owner.observed_xeno ? FALSE : TRUE)
		return
	if(!do_after(xeno_owner, 1 SECONDS, IGNORE_HELD_ITEM, null, BUSY_ICON_GENERIC) || xeno_owner.xeno_flags & XENO_ZOOMED)
		return
	zoom_xeno_in(xeno_owner.observed_xeno ? FALSE : TRUE) //No need for feedback message if our eye is elsewhere.

/datum/action/ability/xeno_action/toggle_queen_zoom/proc/zoom_xeno_in(message = TRUE)
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_movement))
	if(message)
		xeno_owner.visible_message(span_notice("[xeno_owner] emits a broad and weak psychic aura."),
		span_notice("We start focusing our psychic energy to expand the reach of our senses."), null, 5)
	xeno_owner.zoom_in(0, 12)

/datum/action/ability/xeno_action/toggle_queen_zoom/proc/zoom_xeno_out(message = TRUE)
	UnregisterSignal(xeno_owner, COMSIG_MOVABLE_MOVED)
	if(message)
		xeno_owner.visible_message(span_notice("[xeno_owner] stops emitting its broad and weak psychic aura."),
		span_notice("We stop the effort of expanding our senses."), null, 5)
	xeno_owner.zoom_out()

/datum/action/ability/xeno_action/toggle_queen_zoom/proc/on_movement(datum/source, atom/oldloc, direction, Forced)
	zoom_xeno_out()

// ***************************************
// *********** Set leader
// ***************************************
/datum/action/ability/xeno_action/set_xeno_lead
	name = "Choose/Follow Xenomorph Leaders"
	desc = "Make a target Xenomorph a leader."
	action_icon_state = "xeno_lead"
	action_icon = 'icons/Xeno/actions/queen.dmi'
	ability_cost = 200
	use_state_flags = ABILITY_USE_LYING
	hidden = TRUE

/datum/action/ability/xeno_action/set_xeno_lead/give_action(mob/living/L)
	. = ..()
	RegisterSignal(L, COMSIG_XENOMORPH_LEADERSHIP, PROC_REF(try_use_action))

/datum/action/ability/xeno_action/set_xeno_lead/remove_action(mob/living/L)
	. = ..()
	UnregisterSignal(L, COMSIG_XENOMORPH_LEADERSHIP)

/// Signal handler for the set_xeno_lead action that checks can_use
/datum/action/ability/xeno_action/set_xeno_lead/proc/try_use_action(datum/source, mob/living/carbon/xenomorph/target)
	SIGNAL_HANDLER
	if(!can_use_action())
		return
	INVOKE_ASYNC(src, PROC_REF(select_xeno_leader), target)

/// Check if there is an empty slot and promote the passed xeno to a hive leader
/datum/action/ability/xeno_action/set_xeno_lead/proc/select_xeno_leader(mob/living/carbon/xenomorph/selected_xeno)
	if(selected_xeno.xeno_flags & XENO_LEADER)
		unset_xeno_leader(selected_xeno)
		return

	if(xeno_owner.xeno_caste.queen_leader_limit <= length(xeno_owner.hive.xeno_leader_list))
		xeno_owner.balloon_alert(xeno_owner, "No more leadership slots")
		return

	set_xeno_leader(selected_xeno)

/// Remove the passed xeno's leadership
/datum/action/ability/xeno_action/set_xeno_lead/proc/unset_xeno_leader(mob/living/carbon/xenomorph/selected_xeno)
	xeno_owner.balloon_alert(xeno_owner, "Xeno demoted")
	selected_xeno.balloon_alert(selected_xeno, "Leadership removed")
	selected_xeno.hive.remove_leader(selected_xeno)
	selected_xeno.hud_set_queen_overwatch()
	selected_xeno.handle_xeno_leader_pheromones(xeno_owner)

	selected_xeno.update_leader_icon(FALSE)

// ***************************************
// *********** Queen Acidic Salve
// ***************************************
/datum/action/ability/activable/xeno/psychic_cure/queen_give_heal
	name = "Heal"
	desc = "Apply a minor heal to the target."
	cooldown_duration = 5 SECONDS
	ability_cost = 150
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_QUEEN_HEAL,
	)
	heal_range = HIVELORD_HEAL_RANGE
	target_flags = ABILITY_MOB_TARGET

/datum/action/ability/activable/xeno/psychic_cure/queen_give_heal/use_ability(atom/target)
	if(owner.do_actions)
		return FALSE
	owner.face_atom(target) //Face the target so we don't look stupid
	if(!do_after(owner, 1 SECONDS, NONE, target, BUSY_ICON_FRIENDLY, BUSY_ICON_MEDICAL))
		return FALSE
	target.visible_message(span_xenowarning("\the [owner] vomits acid over [target], mending their wounds!"))
	playsound(target, SFX_ALIEN_DROOL, 25)
	new /obj/effect/temp_visual/telekinesis(get_turf(target))
	var/mob/living/carbon/xenomorph/patient = target
	patient.salve_healing()
	owner.changeNext_move(CLICK_CD_RANGE)
	succeed_activate()
	add_cooldown()
	if(owner.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[owner.ckey]
		personal_statistics.heals++

/// Heals the target.
/mob/living/carbon/xenomorph/proc/salve_healing()
	var/amount = 50
	if(recovery_aura)
		amount += recovery_aura * maxHealth * 0.01
	var/remainder = max(0, amount - get_brute_loss())
	adjust_brute_loss(-amount)
	adjust_fire_loss(-remainder, updating_health = TRUE)
	adjust_sunder(-amount * 0.1)

// ***************************************
// *********** Queen plasma
// ***************************************
/datum/action/ability/activable/xeno/queen_give_plasma
	name = "Give Plasma"
	desc = "Give plasma to a target Xenomorph (you must be overwatching them.)"
	action_icon_state = "queen_give_plasma"
	action_icon = 'icons/Xeno/actions/queen.dmi'
	ability_cost = 150
	cooldown_duration = 8 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_QUEEN_GIVE_PLASMA,
	)
	use_state_flags = ABILITY_USE_LYING
	target_flags = ABILITY_MOB_TARGET

/datum/action/ability/activable/xeno/queen_give_plasma/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(!isxeno(target))
		return FALSE
	var/mob/living/carbon/xenomorph/receiver = target
	if(!CHECK_BITFIELD(use_state_flags|override_flags, ABILITY_IGNORE_DEAD_TARGET) && receiver.stat == DEAD)
		if(!silent)
			receiver.balloon_alert(owner, "Cannot give plasma, dead")
		return FALSE
	if(!CHECK_BITFIELD(receiver.xeno_caste.can_flags, CASTE_CAN_BE_GIVEN_PLASMA))
		if(!silent)
			receiver.balloon_alert(owner, "Cannot give plasma")
			return FALSE
	if(xeno_owner.z != receiver.z)
		if(!silent)
			receiver.balloon_alert(owner, "Cannot give plasma, too far")
		return FALSE
	if(receiver.plasma_stored >= receiver.xeno_caste.plasma_max)
		if(!silent)
			receiver.balloon_alert(owner, "Cannot give plasma, full")
		return FALSE

/datum/action/ability/activable/xeno/queen_give_plasma/give_action(mob/living/L)
	. = ..()
	RegisterSignal(L, COMSIG_XENOMORPH_QUEEN_PLASMA, PROC_REF(try_use_ability))

/datum/action/ability/activable/xeno/queen_give_plasma/remove_action(mob/living/L)
	. = ..()
	UnregisterSignal(L, COMSIG_XENOMORPH_QUEEN_PLASMA)

/// Signal handler for the queen_give_plasma action that checks can_use
/datum/action/ability/activable/xeno/queen_give_plasma/proc/try_use_ability(datum/source, mob/living/carbon/xenomorph/target)
	SIGNAL_HANDLER
	if(!can_use_ability(target, FALSE, ABILITY_IGNORE_SELECTED_ABILITY))
		return
	use_ability(target)

/datum/action/ability/activable/xeno/queen_give_plasma/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/receiver = target
	add_cooldown()
	receiver.gain_plasma(300)
	succeed_activate()
	receiver.balloon_alert_to_viewers("Queen plasma", ignored_mobs = GLOB.alive_human_list)
	if (get_dist(owner, receiver) > 7)
		// Out of screen transfer.
		owner.balloon_alert(owner, "Transferred plasma")
