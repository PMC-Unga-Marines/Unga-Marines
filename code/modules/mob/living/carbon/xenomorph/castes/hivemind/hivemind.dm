#define TIME_TO_TRANSFORM 1 SECONDS

/mob/living/carbon/xenomorph/hivemind
	caste_base_type =/datum/xeno_caste/hivemind
	name = "Hivemind"
	real_name = "Hivemind"
	desc = "A glorious singular entity."

	icon_state = "hivemind_marker"
	bubble_icon = "alienroyal"
	icon = 'icons/Xeno/castes/hivemind/basic.dmi'
	effects_icon = 'icons/Xeno/castes/hivemind/effects.dmi'
	status_flags = GODMODE | INCORPOREAL
	resistance_flags = RESIST_ALL
	density = FALSE
	a_intent = INTENT_HELP
	health = 1000
	maxHealth = 1000
	plasma_stored = 5
	tier = XENO_TIER_ZERO
	upgrade = XENO_UPGRADE_BASETYPE

	see_invisible = SEE_INVISIBLE_LIVING
	invisibility = INVISIBILITY_MAXIMUM
	sight = SEE_MOBS|SEE_TURFS|SEE_OBJS
	move_on_shuttle = TRUE
	initial_language_holder = /datum/language_holder/hivemind

	hud_type = /datum/hud/hivemind
	hud_possible = list(PLASMA_HUD, HEALTH_HUD_XENO, PHEROMONE_HUD, XENO_RANK_HUD, QUEEN_OVERWATCH_HUD, XENO_BLESSING_HUD, XENO_EVASION_HUD)
	///The core of our hivemind
	var/datum/weakref/core
	///The minimum health we can have
	var/minimum_health = -300
	///pass_flags given when going incorporeal
	var/incorporeal_pass_flags = PASS_LOW_STRUCTURE|PASS_THROW|PASS_PROJECTILE|PASS_AIR|PASS_FIRE
	///pass_flags given when manifested
	var/manifest_pass_flags = PASS_LOW_STRUCTURE|PASS_MOB|PASS_XENO

/mob/living/carbon/xenomorph/hivemind/Initialize(mapload)
	var/obj/structure/xeno/hivemindcore/new_core = new /obj/structure/xeno/hivemindcore(loc, hivenumber)
	core = WEAKREF(new_core)
	. = ..()
	new_core.parent = WEAKREF(src)
	RegisterSignal(src, COMSIG_XENOMORPH_CORE_RETURN, PROC_REF(return_to_core))
	RegisterSignal(src, COMSIG_XENOMORPH_HIVEMIND_CHANGE_FORM, PROC_REF(change_form))
	add_pass_flags(incorporeal_pass_flags, INNATE_TRAIT)
	update_action_buttons()

/mob/living/carbon/xenomorph/hivemind/get_evolution_options()
	return

/mob/living/carbon/xenomorph/hivemind/upgrade_possible()
	return FALSE

/mob/living/carbon/xenomorph/hivemind/upgrade_xeno(newlevel, silent = FALSE)
	newlevel = XENO_UPGRADE_BASETYPE
	return ..()

/mob/living/carbon/xenomorph/hivemind/update_health()
	if(on_fire)
		ExtinguishMob()
	health = maxHealth - get_fire_loss() - get_brute_loss() //Xenos can only take brute and fire damage.
	if(health <= 0 && !(status_flags & INCORPOREAL))
		set_brute_loss(0)
		set_fire_loss(-minimum_health)
		change_form()
		remove_status_effect(/datum/status_effect/spacefreeze)
	health = maxHealth - get_fire_loss() - get_brute_loss()
	med_hud_set_health()
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	update_wounds()
	handle_regular_hud_updates()

/mob/living/carbon/xenomorph/hivemind/handle_living_health_updates()
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	var/turf/T = loc
	if(!istype(T))
		return
	// If manifested and off weeds, lets deal some damage.
	if(!(status_flags & INCORPOREAL) && !loc_weeds_type)
		adjust_brute_loss(20 * XENO_RESTING_HEAL, TRUE)
		return
	// If not manifested
	if(health < minimum_health + maxHealth)
		set_brute_loss(0)
		set_fire_loss(-minimum_health)
	if(health >= maxHealth) //can't regenerate.
		update_health() //Update health-related stats, like health itself (using brute and fireloss), health HUD and status.
		return
	heal_wounds(XENO_RESTING_HEAL)
	update_health()

/mob/living/carbon/xenomorph/hivemind/Destroy()
	var/obj/structure/xeno/hivemindcore/hive_core = get_core()
	if(hive_core)
		qdel(hive_core)
	return ..()

/mob/living/carbon/xenomorph/hivemind/on_death()
	var/obj/structure/xeno/hivemindcore/hive_core = get_core()
	if(!QDELETED(hive_core))
		qdel(hive_core)
	return ..()

/mob/living/carbon/xenomorph/hivemind/gib()
	return_to_core()

/mob/living/carbon/xenomorph/hivemind/set_resting()
	return

/mob/living/carbon/xenomorph/hivemind/change_form()
	if(status_flags & INCORPOREAL && health != maxHealth)
		to_chat(src, span_xenowarning("You do not have the strength to manifest yet!"))
		return
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	wound_overlay.icon_state = "none"
	TIMER_COOLDOWN_START(src, COOLDOWN_HIVEMIND_MANIFESTATION, TIME_TO_TRANSFORM)
	invisibility = 0
	flick(status_flags & INCORPOREAL ? "Hivemind_[initial(loc_weeds_type.color_variant)]_materialisation" : "Hivemind_[initial(loc_weeds_type.color_variant)]_materialisation_reverse", src)
	setDir(SOUTH)
	addtimer(CALLBACK(src, PROC_REF(do_change_form)), TIME_TO_TRANSFORM)

/mob/living/carbon/xenomorph/hivemind/set_jump_component(duration = 0.5 SECONDS, cooldown = 2 SECONDS, cost = 0, height = 16, sound = null, flags = JUMP_SHADOW, jump_pass_flags = PASS_LOW_STRUCTURE|PASS_FIRE|PASS_TANK)
	return //no jumping, bad hivemind

///Finish the form changing of the hivemind and give the needed stats
/mob/living/carbon/xenomorph/hivemind/proc/do_change_form()
	LAZYCLEARLIST(movespeed_modification)
	update_movespeed()
	if(status_flags & INCORPOREAL)
		status_flags = NONE
		resistance_flags = NONE
		remove_pass_flags(incorporeal_pass_flags, INNATE_TRAIT)
		add_pass_flags(manifest_pass_flags, MANIFESTED_TRAIT)
		density = TRUE
		hive.xenos_by_upgrade[upgrade] -= src
		upgrade = XENO_UPGRADE_MANIFESTATION
		set_datum(FALSE)
		hive.xenos_by_upgrade[upgrade] += src
		update_wounds()
		update_icon()
		update_action_buttons()
		return
	status_flags = initial(status_flags)
	resistance_flags = initial(resistance_flags)
	remove_pass_flags(manifest_pass_flags, MANIFESTED_TRAIT)
	add_pass_flags(incorporeal_pass_flags, INNATE_TRAIT)
	density = FALSE
	hive.xenos_by_upgrade[upgrade] -= src
	upgrade = XENO_UPGRADE_BASETYPE
	set_datum(FALSE)
	hive.xenos_by_upgrade[upgrade] += src
	setDir(SOUTH)
	update_wounds()
	update_icon()
	update_action_buttons()
	handle_weeds_adjacent_removed()

/mob/living/carbon/xenomorph/hivemind/fire_act(burn_level, flame_color)
	return_to_core()
	to_chat(src, span_xenonotice("We were on top of fire, we got moved to our core."))

/mob/living/carbon/xenomorph/hivemind/handle_weeds_adjacent_removed()
	if(loc_weeds_type || check_weeds(get_turf(src)))
		return
	return_to_core()
	to_chat(src, span_xenonotice("We had no weeds nearby, we got moved to our core."))
	return

/mob/living/carbon/xenomorph/hivemind/proc/return_to_core()
	if(!(status_flags & INCORPOREAL) && !TIMER_COOLDOWN_CHECK(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		do_change_form()
	for(var/obj/item/explosive/grenade/sticky/sticky_bomb in contents)
		sticky_bomb.clean_refs()
		sticky_bomb.forceMove(loc)
	forceMove(get_turf(get_core()))

///Start the teleportation process to send the hivemind manifestation to the selected turf
/mob/living/carbon/xenomorph/hivemind/proc/start_teleport(turf/T)
	if(!isopenturf(T))
		balloon_alert(src, "Can't teleport into a wall")
		return
	TIMER_COOLDOWN_START(src, COOLDOWN_HIVEMIND_MANIFESTATION, TIME_TO_TRANSFORM * 2)
	flick("Hivemind_[initial(loc_weeds_type.color_variant)]_materialisation_reverse", src)
	setDir(SOUTH)
	addtimer(CALLBACK(src, PROC_REF(end_teleport), T), TIME_TO_TRANSFORM)

///Finish the teleportation process to send the hivemind manifestation to the selected turf
/mob/living/carbon/xenomorph/hivemind/proc/end_teleport(turf/T)
	if(!check_weeds(T, TRUE))
		balloon_alert(src, "No weeds in destination")
		return
	forceMove(T)
	flick("Hivemind_[initial(loc_weeds_type.color_variant)]_materialisation", src)
	setDir(SOUTH)

/mob/living/carbon/xenomorph/hivemind/Move(atom/newloc, direction, glide_size_override)
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	if(!(status_flags & INCORPOREAL))
		return ..()
	if(!check_weeds(newloc))
		return FALSE

	// FIXME: Port canpass refactor from tg
	// Don't allow them over the timed_late doors
	var/obj/machinery/door/poddoor/timed_late/door = locate() in newloc
	if(door && !door.CanPass(src, newloc))
		return FALSE

	abstract_move(newloc)

/mob/living/carbon/xenomorph/hivemind/receive_hivemind_message(mob/living/carbon/xenomorph/speaker, message)
	var/track = "<a href='byond://?src=[REF(src)];hivemind_jump=[REF(speaker)]'>(F)</a>"
	return show_message("[track] [speaker.hivemind_start()] [span_message("hisses, '[message]'")][speaker.hivemind_end()]", 2)

/mob/living/carbon/xenomorph/hivemind/Topic(href, href_list)
	. = ..()
	if(.)
		return
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	if(href_list["hivemind_jump"])
		var/mob/living/carbon/xenomorph/xeno = locate(href_list["hivemind_jump"])
		if(!istype(xeno))
			return
		jump(xeno)

/// Jump hivemind's camera to the passed xeno, if they are on/near weeds
/mob/living/carbon/xenomorph/hivemind/proc/jump(mob/living/carbon/xenomorph/xeno)
	if(!check_weeds(get_turf(xeno), TRUE))
		balloon_alert(src, "No nearby weeds")
		return
	if(!(status_flags & INCORPOREAL))
		start_teleport(get_turf(xeno))
		return
	abstract_move(get_turf(xeno))

/// handles hivemind updating with their respective weedtype
/mob/living/carbon/xenomorph/hivemind/update_icon_state()
	. = ..()
	if(status_flags & INCORPOREAL)
		icon_state = "hivemind_marker"
		return
	icon_state = "Hivemind_[initial(loc_weeds_type.color_variant)]"

/mob/living/carbon/xenomorph/hivemind/update_icons()
	return

/mob/living/carbon/xenomorph/hivemind/DblClickOn(atom/A, params)
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	var/list/modifiers = params2list(params)
	if(modifiers["right"])
		return
	var/turf/target_turf = get_turf(A)
	if(!check_weeds(target_turf, TRUE))
		return
	if(!(status_flags & INCORPOREAL))
		start_teleport(target_turf)
		return
	setDir(SOUTH)
	abstract_move(target_turf)

/mob/living/carbon/xenomorph/hivemind/CtrlClick(mob/user)
	if(!(status_flags & INCORPOREAL))
		return ..()
	return FALSE

/mob/living/carbon/xenomorph/hivemind/CtrlShiftClickOn(atom/A)
	if(!(status_flags & INCORPOREAL))
		return ..()
	return FALSE

/mob/living/carbon/xenomorph/hivemind/a_intent_change()
	return //Unable to change intent, forced help intent

/mob/living/carbon/xenomorph/hivemind/update_progression()
	return

/obj/fire/flamer/CanAllowThrough(atom/movable/mover, turf/target)
	if(isxenohivemind(mover))
		return FALSE
	return ..()

/// Getter proc for the weakref'd core
/mob/living/carbon/xenomorph/hivemind/proc/get_core()
	return core?.resolve()

// =================
// hivemind core
/obj/structure/xeno/hivemindcore
	name = "hivemind core"
	desc = "A very weird, pulsating node. This looks almost alive."
	max_integrity = 600
	icon = 'icons/Xeno/1x1building.dmi'
	icon_state = "hivemind_core"
	xeno_structure_flags = IGNORE_WEED_REMOVAL|CRITICAL_STRUCTURE|DEPART_DESTRUCTION_IMMUNE|XENO_STRUCT_WARNING_RADIUS|XENO_STRUCT_DAMAGE_ALERT
	///The weakref to the parent hivemind mob that we're attached to
	var/datum/weakref/parent

/obj/structure/xeno/hivemindcore/Initialize(mapload)
	. = ..()
	GLOB.hive_datums[hivenumber].hivemindcores += src
	new /obj/alien/weeds/node(loc)
	set_light(7, 5, LIGHT_COLOR_PURPLE)
	update_minimap_icon()

/obj/structure/xeno/hivemindcore/Destroy()
	GLOB.hive_datums[hivenumber].hivemindcores -= src
	var/mob/living/carbon/xenomorph/hivemind/our_parent = get_parent()
	if(isnull(our_parent))
		return ..()
	our_parent.playsound_local(our_parent, SFX_ALIEN_HELP, 30, TRUE)
	to_chat(our_parent, span_xenouserdanger("Your core has been destroyed!"))
	xeno_message("A sudden tremor ripples through the hive... \the [our_parent] has been slain!", "xenoannounce", 5, our_parent.hivenumber)
	GLOB.key_to_time_of_role_death[our_parent.key] = world.time
	GLOB.key_to_time_of_death[our_parent.key] = world.time
	our_parent.ghostize()
	if(!QDELETED(our_parent))
		qdel(our_parent)
	return ..()

//hivemind cores

/obj/structure/xeno/hivemindcore/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(isxenoqueen(xeno_attacker))
		var/choice = tgui_alert(xeno_attacker, "Are you sure you want to destroy the hivemind?", "Destroy hivemind", list("Yes", "Cancel"))
		if(choice == "Yes")
			deconstruct(FALSE)
			return

	xeno_attacker.visible_message(span_danger("[xeno_attacker] nudges its head against [src]."), \
	span_danger("You nudge your head against [src]."))

/obj/structure/xeno/hivemindcore/take_damage(damage_amount, damage_type, damage_flag = null, effects = TRUE, attack_dir, armour_penetration, mob/living/blame_mob)
	. = ..()
	var/mob/living/carbon/xenomorph/hivemind/our_parent = get_parent()
	if(isnull(our_parent))
		return
	var/health_percent = round((max_integrity / obj_integrity) * 100)
	switch(health_percent)
		if(-INFINITY to 25)
			to_chat(our_parent, span_xenouserdanger("Your core is under attack, and dangerous low on health!"))
		if(26 to 75)
			to_chat(our_parent, span_xenodanger("Your core is under attack, and low on health!"))
		if(76 to INFINITY)
			to_chat(our_parent, span_xenodanger("Your core is under attack!"))

/obj/structure/xeno/hivemindcore/update_minimap_icon()
	SSminimaps.remove_marker(src)
	SSminimaps.add_marker(src, MINIMAP_FLAG_XENO, image('icons/UI_icons/map_blips.dmi', null, "hivemindcore[threat_warning ? "_warn" : "_passive"]", MINIMAP_LABELS_LAYER))

/// Getter for the parent of this hive core
/obj/structure/xeno/hivemindcore/proc/get_parent()
	return parent?.resolve()

/mob/living/carbon/xenomorph/hivemind/add_inherent_verbs()
	return

/mob/living/carbon/xenomorph/hivemind/remove_inherent_verbs()
	return

/mob/living/carbon/xenomorph/hivemind/add_to_hive(datum/hive_status/HS, force = FALSE, prevent_ruler=FALSE)
	. = ..()
	if(!GLOB.xeno_structures_by_hive[HS.hivenumber])
		GLOB.xeno_structures_by_hive[HS.hivenumber] = list()

	var/obj/structure/xeno/hivemindcore/hive_core = get_core()

	if(!hive_core) //how are you even alive then?
		qdel(src)
		return

	GLOB.xeno_structures_by_hive[HS.hivenumber] |= hive_core

	if(!GLOB.xeno_critical_structures_by_hive[HS.hivenumber])
		GLOB.xeno_critical_structures_by_hive[HS.hivenumber] = list()

	GLOB.xeno_critical_structures_by_hive[HS.hivenumber] |= hive_core
	hive_core.hivenumber = HS.hivenumber
	hive_core.name = "[HS.hivenumber == XENO_HIVE_NORMAL ? "" : "[HS.name] "]hivemind core"
	hive_core.color = HS.color

/mob/living/carbon/xenomorph/hivemind/remove_from_hive()
	var/obj/structure/xeno/hivemindcore/hive_core = get_core()
	GLOB.xeno_structures_by_hive[hivenumber] -= hive_core
	GLOB.xeno_critical_structures_by_hive[hivenumber] -= hive_core
	. = ..()
	if(!QDELETED(src)) //if we aren't dead, somehow?
		hive_core.name = "banished hivemind core"
		hive_core.color = null

/mob/living/carbon/xenomorph/hivemind/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/hivemind/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/hivemind/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/hivemind/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/hivemind/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/hivemind/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN

#undef TIME_TO_TRANSFORM
