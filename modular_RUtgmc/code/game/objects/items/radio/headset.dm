/obj/item/radio/headset/mainship/dropped(mob/living/carbon/human/user)
	if(istype(user) && headset_hud_on)
		disable_squadhud()
		squadhud.remove_hud_from(user)
		user.hud_used?.SL_locator.alpha = 0
		wearer = null
		squadhud = null
	if(camera)
		camera.c_tag = "Unknown"
		if(user.assigned_squad)
			camera.network -= lowertext(user.assigned_squad.name)
	UnregisterSignal(user, list(COMSIG_MOB_DEATH, COMSIG_HUMAN_SET_UNDEFIBBABLE, COMSIG_MOB_REVIVE, COMSIG_HUMAN_DEATH_STAGE_CHANGE))
	return ..()

/obj/item/radio/headset/mainship/proc/update_minimap_icon()
	SIGNAL_HANDLER
	SSminimaps.remove_marker(wearer)
	if(!wearer.job || !wearer.job.minimap_icon)
		return
	var/marker_flags = initial(minimap_type.marker_flags)
	if(wearer.stat == DEAD)
		if(HAS_TRAIT(wearer, TRAIT_UNDEFIBBABLE))
			if(issynth(wearer))
				SSminimaps.add_marker(wearer, marker_flags, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, "undefibbable_synt"))
			else if(isrobot(wearer))
				SSminimaps.add_marker(wearer, marker_flags, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, "undefibbable_robo"))
			else if(ishuman(wearer))
				SSminimaps.add_marker(wearer, marker_flags, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, "undefibbable"))
			return
		if(!wearer.client)
			var/mob/dead/observer/ghost = wearer.get_ghost()
			if(!ghost?.can_reenter_corpse)
				if(issynth(wearer))
					SSminimaps.add_marker(wearer, marker_flags, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, "undefibbable_synt"))
				else if(isrobot(wearer))
					SSminimaps.add_marker(wearer, marker_flags, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, "undefibbable_robo"))
				else if(ishuman(wearer))
					SSminimaps.add_marker(wearer, marker_flags, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, "undefibbable"))
				return
		if(issynth(wearer))
			SSminimaps.add_marker(wearer, marker_flags, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, "defibbable_synt"))
		else if(isrobot(wearer))
			SSminimaps.add_marker(wearer, marker_flags, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, "defibbable_robo"))
		else if(ishuman(wearer))
			var/stage
			switch(wearer.dead_ticks)
				if(0 to 0.4 * TIME_BEFORE_DNR)
					stage = 1
				if(0.4 * TIME_BEFORE_DNR to 0.8 * TIME_BEFORE_DNR)
					stage = 2
				if(0.8 * TIME_BEFORE_DNR to INFINITY)
					stage = 3
			SSminimaps.add_marker(wearer, marker_flags, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, "defibbable[stage]"))
		return
	if(wearer.assigned_squad)
		SSminimaps.add_marker(wearer, marker_flags, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, lowertext(wearer.assigned_squad.name)+"_"+wearer.job.minimap_icon))
		/* //Выключил ибо у нас свой набор иконок который и так не грейскейл
		var/image/underlay = image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, "squad_underlay")
		var/image/overlay = image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, wearer.job.minimap_icon)
		overlay.color = wearer.assigned_squad.color
		underlay.overlays += overlay
		SSminimaps.add_marker(wearer, marker_flags, underlay)
		*/
		return
	SSminimaps.add_marker(wearer, marker_flags, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, wearer.job.minimap_icon))

/obj/item/radio/headset/mainship/mcom
	var/loud = FALSE

/obj/item/radio/headset/mainship/mcom/examine(mob/user)
	. = ..()
	. += span_info("Ctrl-click to toggle the voice high-volume mode.")

/obj/item/radio/headset/mainship/mcom/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if (slot == SLOT_EARS)
		RegisterSignal(user, COMSIG_MOB_SAY, PROC_REF(handle_speech))
		loud = TRUE
	else
		UnregisterSignal(user, COMSIG_MOB_SAY)
		loud = FALSE

/obj/item/radio/headset/mainship/mcom/dropped(mob/living/carbon/human/user)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_SAY)
	loud = FALSE

/obj/item/radio/headset/mainship/mcom/proc/handle_speech(mob/living/carbon/user, list/speech_args)
	SIGNAL_HANDLER
	speech_args[SPEECH_SPANS] |= list(SPAN_COMMAND)

/obj/item/radio/headset/mainship/mcom/CtrlClick(mob/user)
	. = ..()
	if(loud == TRUE)
		UnregisterSignal(user, COMSIG_MOB_SAY)
		loud = FALSE
		balloon_alert(user, "Loud mode disabled")
	else
		RegisterSignal(user, COMSIG_MOB_SAY, PROC_REF(handle_speech))
		loud = TRUE
		balloon_alert(user, "Loud mode enabled")
