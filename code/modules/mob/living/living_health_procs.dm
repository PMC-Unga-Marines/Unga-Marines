//procs directly related to mob health
/mob/living/proc/get_brute_loss(organic_only = FALSE)
	return bruteloss

///We straight up set bruteloss/brute damage to a desired amount unless godmode is enabled
/mob/living/proc/set_brute_loss(amount)
	if(status_flags & GODMODE)
		return FALSE
	bruteloss = amount

/mob/living/proc/adjust_brute_loss(amount, updating_health = FALSE)
	if(status_flags & GODMODE)
		return FALSE	//godmode
	bruteloss = clamp(bruteloss + amount, 0, maxHealth * 2)
	if(updating_health)
		update_health()

/mob/living/proc/get_fire_loss(organic_only = FALSE)
	return fireloss

///We straight up set fireloss/burn damage to a desired amount unless godmode is enabled
/mob/living/proc/set_fire_loss(amount)
	if(status_flags & GODMODE)
		return FALSE
	fireloss = amount

/mob/living/proc/adjust_fire_loss(amount, updating_health = FALSE)
	if(status_flags & GODMODE)
		return FALSE	//godmode
	fireloss = clamp(fireloss + amount, 0, maxHealth * 2)

	if(updating_health)
		update_health()

/mob/living/proc/get_oxy_loss()
	return oxyloss

/mob/living/proc/adjust_oxy_loss(amount)
	if(status_flags & GODMODE)
		return FALSE	//godmode
	oxyloss = clamp(oxyloss + amount, 0, maxHealth * 2)
	return TRUE

/mob/living/proc/set_oxy_loss(amount)
	if(status_flags & GODMODE)
		return FALSE	//godmode
	oxyloss = amount

/mob/living/proc/get_tox_loss()
	return toxloss

/mob/living/proc/adjust_tox_loss(amount)
	if(status_flags & GODMODE)
		return FALSE	//godmode
	toxloss = clamp(toxloss + amount, 0, maxHealth * 2)

/mob/living/proc/set_tox_loss(amount)
	if(status_flags & GODMODE)
		return FALSE	//godmode
	toxloss = amount

/mob/living/proc/get_stamina_loss()
	return staminaloss

/mob/living/proc/adjust_stamina_loss(amount, update = TRUE, feedback = TRUE)
	if(status_flags & GODMODE)
		return FALSE	//godmode

	var/stamina_loss_adjustment = staminaloss + amount
	var/health_limit = maxHealth * 2
	if(stamina_loss_adjustment > health_limit) //If we exceed maxHealth * 2 stamina damage, half of any excess as oxyloss
		adjust_oxy_loss((stamina_loss_adjustment - health_limit) * 0.5)

	staminaloss = clamp(stamina_loss_adjustment, -max_stamina, health_limit)

	if(amount > 0)
		last_staminaloss_dmg = world.time
	if(update)
		update_stamina(feedback)

/mob/living/proc/set_stamina_loss(amount, update = TRUE, feedback = TRUE)
	if(status_flags & GODMODE)
		return FALSE	//godmode
	staminaloss = amount
	if(update)
		update_stamina(feedback)

/mob/living/proc/update_stamina(feedback = TRUE)
	hud_used?.staminas?.update_icon()
	if(staminaloss < max(health * 1.5,0) || !(COOLDOWN_CHECK(src, last_stamina_exhaustion))) //If we're on cooldown for stamina exhaustion, don't bother
		return

	if(feedback)
		visible_message(span_warning("\The [src] slumps to the ground, too weak to continue fighting."),
			span_warning("You slump to the ground, you're too exhausted to keep going..."))

	ParalyzeNoChain(1 SECONDS) //Short stun
	adjust_stagger(STAMINA_EXHAUSTION_STAGGER_DURATION)
	add_slowdown(STAMINA_EXHAUSTION_DEBUFF_STACKS)
	adjust_blurriness(STAMINA_EXHAUSTION_DEBUFF_STACKS)
	COOLDOWN_START(src, last_stamina_exhaustion, LIVING_STAMINA_EXHAUSTION_COOLDOWN - (skills.getRating(SKILL_STAMINA) * STAMINA_SKILL_COOLDOWN_MOD)) //set the cooldown.

/// Adds an entry to our stamina_regen_modifiers and updates stamina_regen_multiplier
/mob/living/proc/add_stamina_regen_modifier(mod_name, mod_value)
	if(stamina_regen_modifiers[mod_name] == mod_value)
		return
	stamina_regen_modifiers[mod_name] = mod_value
	recalc_stamina_regen_multiplier()

/// Removes an entry from our stamina_regen_modifiers and updates stamina_regen_multiplier. Returns TRUE if an entry was removed
/mob/living/proc/remove_stamina_regen_modifier(mod_name)
	if(!stamina_regen_modifiers.Remove(mod_name))
		return FALSE
	recalc_stamina_regen_multiplier()
	return TRUE

/// Regenerates stamina_regen_multiplier from initial based on the current modifier list, minimum 0.
/mob/living/proc/recalc_stamina_regen_multiplier()
	stamina_regen_multiplier = initial(stamina_regen_multiplier)
	for(var/mod_name in stamina_regen_modifiers)
		stamina_regen_multiplier += stamina_regen_modifiers[mod_name]
	stamina_regen_multiplier = max(stamina_regen_multiplier, 0)

///Updates the mob's stamina modifiers if their stam skill changes
/mob/living/proc/update_stam_skill_mod(datum/source)
	SIGNAL_HANDLER
	add_stamina_regen_modifier(SKILL_STAMINA, skills.getRating(SKILL_STAMINA) * STAMINA_SKILL_REGEN_MOD)

/mob/living/proc/get_clone_loss()
	return cloneloss

/mob/living/proc/adjust_clone_loss(amount)
	if(status_flags & GODMODE)
		return FALSE	//godmode
	cloneloss = clamp(cloneloss+amount,0,maxHealth*2)

/mob/living/proc/set_clone_loss(amount)
	if(status_flags & GODMODE)
		return FALSE	//godmode
	cloneloss = amount

/mob/living/proc/get_brain_loss()
	return brainloss

/mob/living/proc/adjust_brain_loss(amount)
	if(status_flags & GODMODE)
		return FALSE	//godmode
	brainloss = clamp(brainloss+amount,0,maxHealth*2)

/mob/living/proc/set_brain_loss(amount)
	if(status_flags & GODMODE)
		return FALSE	//godmode
	brainloss = amount

/mob/living/proc/get_max_health()
	return maxHealth

/mob/living/proc/set_max_health(new_max_health)
	maxHealth = new_max_health

/mob/living/proc/Losebreath(amount, forced = FALSE)
	return

/mob/living/proc/adjust_Losebreath(amount, forced = FALSE)
	return

/mob/living/proc/set_Losebreath(amount, forced = FALSE)
	return

/mob/living/proc/adjust_drowsyness(amount)
	if(status_flags & GODMODE)
		return FALSE
	set_drowsyness(max(drowsyness + amount, 0))

/mob/living/proc/set_drowsyness(amount)
	if(status_flags & GODMODE)
		return FALSE
	if(drowsyness == amount)
		return
	. = drowsyness //Old value
	drowsyness = amount
	if(drowsyness)
		if(!.)
			add_movespeed_modifier(MOVESPEED_ID_DROWSINESS, TRUE, 0, NONE, TRUE, 6)
		return
	remove_movespeed_modifier(MOVESPEED_ID_DROWSINESS)

///Adjusts the blood volume, with respect to the minimum and maximum values
/mob/living/proc/adjust_blood_volume(amount)
	if(!amount)
		return
	blood_volume = clamp(blood_volume + amount, 0, BLOOD_VOLUME_MAXIMUM)

///Sets the blood volume, with respect to the minimum and maximum values
/mob/living/proc/set_blood_volume(amount)
	if(!amount)
		return
	blood_volume = clamp(amount, 0, BLOOD_VOLUME_MAXIMUM)

// heal ONE limb, organ gets randomly selected from damaged ones.
/mob/living/proc/heal_limb_damage(brute, burn, robo_repair = FALSE, updating_health = FALSE)
	adjust_brute_loss(-brute)
	adjust_fire_loss(-burn)
	if(updating_health)
		update_health()

// damage ONE limb, organ gets randomly selected from damaged ones.
/mob/living/proc/take_limb_damage(brute, burn, sharp = FALSE, edge = FALSE, updating_health = FALSE)
	if(status_flags & GODMODE)
		return FALSE	//godmode
	adjust_brute_loss(brute)
	adjust_fire_loss(burn)
	if(updating_health)
		update_health()

// heal MANY limbs, in random order
/mob/living/proc/heal_overall_damage(brute, burn, robo_repair = FALSE, updating_health = FALSE)
	adjust_brute_loss(-brute)
	adjust_fire_loss(-burn)
	if(updating_health)
		update_health()

///Damages all limbs equally. Overridden by human, otherwise just does apply_damage
/mob/living/proc/take_overall_damage(damage, damagetype, armortype, sharp = FALSE, edge = FALSE, updating_health = FALSE, penetration, max_limbs)
	return apply_damage(damage, damagetype, null, armortype, sharp, edge, updating_health, penetration)

/mob/living/proc/restore_all_organs()
	return

///Heal limbs until the total mob health went up by health_to_heal
/mob/living/carbon/human/proc/heal_limbs(health_to_heal)
	var/proportion_to_heal = (health_to_heal < (maxHealth - health)) ? (health_to_heal / (maxHealth - health)) : 1
	for(var/datum/limb/limb AS in limbs)
		limb.heal_limb_damage(limb.brute_dam * proportion_to_heal, limb.burn_dam * proportion_to_heal, robo_repair = TRUE)
	update_health()

/mob/living/proc/on_revive()
	SEND_SIGNAL(src, COMSIG_MOB_REVIVE)
	timeofdeath = 0
	GLOB.alive_living_list += src
	GLOB.dead_mob_list -= src

/mob/living/carbon/human/on_revive()
	. = ..()
	GLOB.alive_human_list += src
	LAZYADD(GLOB.alive_human_list_faction[faction], src)
	GLOB.dead_human_list -= src
	LAZYADD(GLOB.humans_by_zlevel["[z]"], src)
	RegisterSignal(src, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(human_z_changed))

	hud_list[HEART_STATUS_HUD].icon_state = ""

/mob/living/carbon/xenomorph/on_revive()
	. = ..()
	GLOB.alive_xeno_list += src
	LAZYADD(GLOB.alive_xeno_list_hive[hivenumber], src)
	GLOB.dead_xeno_list -= src

/mob/living/proc/revive(admin_revive = FALSE)
	for(var/obj/item/embedded AS in embedded_objects)
		if(embedded.is_beneficial_implant())
			continue
		embedded.unembed_ourself()
	// shut down various types of badness
	set_stamina_loss(-50)
	set_tox_loss(0)
	set_oxy_loss(0)
	set_clone_loss(0)
	set_brain_loss(0)
	remove_all_status_effect()
	ExtinguishMob()
	fire_stacks = 0

	// shut down ongoing problems
	bodytemperature = get_standard_bodytemperature()
	disabilities = 0

	// fix blindness and deafness
	set_drugginess(0)
	set_blindness(0, TRUE)
	set_blurriness(0, TRUE)
	set_ear_damage(0, 0)
	heal_overall_damage(get_brute_loss(), get_fire_loss(), robo_repair = TRUE)
	set_slowdown(0)

	// fix all of our organs
	restore_all_organs()

	//remove larva
	var/obj/item/alien_embryo/A = locate() in src
	var/mob/living/carbon/xenomorph/larva/L = locate() in src //the larva was fully grown, ready to burst.
	if(A)
		qdel(A)
	if(L)
		qdel(L)
	DISABLE_BITFIELD(status_flags, XENO_HOST)

	// restore us to conciousness
	set_stat(CONSCIOUS)
	update_health()

	// make the icons look correct
	regenerate_icons()
	med_pain_set_perceived_health()
	med_hud_set_health()
	handle_regular_hud_updates()
	reload_fullscreens()
	hud_used?.show_hud(hud_used.hud_version)

	SSmobs.start_processing(src)
	SEND_SIGNAL(src, COMSIG_LIVING_POST_FULLY_HEAL, admin_revive)

/mob/living/carbon/revive(admin_revive = FALSE)
	set_nutrition(400)
	set_painloss(0)
	set_painloss(0)
	drunkenness = 0
	disabilities = 0

	if(handcuffed && !initial(handcuffed))
		dropItemToGround(handcuffed)
	update_handcuffed(initial(handcuffed))

	return ..()

/mob/living/carbon/human/revive(admin_revive = FALSE)
	restore_all_organs()

	if(species && !(species.species_flags & NO_BLOOD))
		restore_blood()

	//try to find the brain player in the decapitated head and put them back in control of the human
	if(!client && !mind) //if another player took control of the human, we don't want to kick them out.
		for(var/obj/item/limb/head/H AS in GLOB.head_list)
			if(!H.brainmob)
				continue

			if(H.brainmob.real_name != real_name)
				continue

			if(!H.brainmob.mind)
				continue

			H.brainmob.mind.transfer_to(src)
			qdel(H)

	for(var/datum/internal_organ/I in internal_organs)
		I.heal_organ_damage(I.damage)

	reagents.clear_reagents() //and clear all reagents in them
	if(!(species?.species_flags & (IS_SYNTHETIC|ROBOTIC_LIMBS))) // change this to check src for stomach if ever decide to remove organs from something other than robots
		var/datum/internal_organ/stomach/belly = get_organ_slot(ORGAN_SLOT_STOMACH)
		belly.reagents.clear_reagents()
	REMOVE_TRAIT(src, TRAIT_UNDEFIBBABLE, TRAIT_UNDEFIBBABLE)
	REMOVE_TRAIT(src, TRAIT_PSY_DRAINED, TRAIT_PSY_DRAINED)
	dead_ticks = 0
	chestburst = CARBON_NO_CHEST_BURST
	update_body()
	update_hair()
	return ..()

/mob/living/carbon/xenomorph/revive(admin_revive = FALSE)
	. = ..()
	set_plasma(xeno_caste.plasma_max)
	sunder = 0
	hud_update_primo()
	if(stat == DEAD)
		hive?.on_xeno_revive(src)

///Revive the huamn up to X health points
/mob/living/carbon/human/proc/revive_to_crit(should_offer_to_ghost = FALSE, should_zombify = FALSE)
	if(!has_working_organs())
		on_fire = TRUE
		fire_stacks = 15
		update_fire()
		QDEL_IN(src, 1 MINUTES)
		return
	if(health > 0)
		return
	var/mob/dead/observer/ghost = get_ghost()
	if(istype(ghost))
		notify_ghost(ghost, "<font size=3>Your body slowly regenerated. Return to it if you want to be resurrected!</font>", ghost_sound = 'sound/effects/adminhelp.ogg', enter_text = "Enter", enter_link = "reentercorpse=1", source = src, action = NOTIFY_JUMP)
	do_jitter_animation(1000)
	ADD_TRAIT(src, TRAIT_IS_RESURRECTING, REVIVE_TO_CRIT_TRAIT)
	if(should_zombify && (istype(wear_ear, /obj/item/radio/headset/mainship)))
		var/obj/item/radio/headset/mainship/radio = wear_ear
		if(istype(radio))
			radio.safety_protocol(src)
	addtimer(CALLBACK(src, PROC_REF(finish_revive_to_crit), should_offer_to_ghost, should_zombify), 10 SECONDS)

///Check if we have a mind, and finish the revive if we do
/mob/living/carbon/human/proc/finish_revive_to_crit(should_offer_to_ghost = FALSE, should_zombify = FALSE)
	if(!has_working_organs())
		on_fire = TRUE
		fire_stacks = 15
		update_icon()
		QDEL_IN(src, 1 MINUTES)
		return
	do_jitter_animation(1000)
	if(!client)
		if(should_offer_to_ghost)
			offer_mob()
			addtimer(CALLBACK(src, PROC_REF(finish_revive_to_crit), FALSE, should_zombify), 10 SECONDS)
			return
		REMOVE_TRAIT(src, TRAIT_IS_RESURRECTING, REVIVE_TO_CRIT_TRAIT)
		if(should_zombify || istype(species, /datum/species/zombie))
			AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno/zombie/patrolling, src) //Zombie patrol
			a_intent = INTENT_HARM
	if(should_zombify)
		set_species("Strong zombie")
		faction = FACTION_ZOMBIE
	heal_limbs(- health)
	set_stat(CONSCIOUS)
	overlay_fullscreen_timer(0.5 SECONDS, 10, "roundstart1", /atom/movable/screen/fullscreen/black)
	overlay_fullscreen_timer(2 SECONDS, 20, "roundstart2", /atom/movable/screen/fullscreen/spawning_in)
	REMOVE_TRAIT(src, TRAIT_IS_RESURRECTING, REVIVE_TO_CRIT_TRAIT)
	SSmobs.start_processing(src)
