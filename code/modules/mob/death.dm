///This is the proc for gibbing a mob. Cannot gib ghosts.
/mob/proc/gib()
	playsound(src, 'sound/effects/gib.ogg', 90, TRUE, 8)
	gib_animation()
	spawn_gibs()
	death(TRUE)

///Proc for playing the gib animation on the gib proc.
/mob/proc/gib_animation()
	return

///Proc for spawning gore, blood and gibs on the gib proc
/mob/proc/spawn_gibs()
	hgibs(loc)

//This is the proc for turning a mob into ash. Mostly a copy of gib code (above).
//Originally created for wizard disintegrate. I've removed the virus code since it's irrelevant here.
//Dusting robots does not eject the MMI, so it's a bit more powerful than gib() /N
/mob/proc/dust()
	dust_animation()
	spawn_dust_remains()
	death(TRUE)

/mob/proc/spawn_dust_remains()
	new /obj/effect/decal/cleanable/ash(loc)

/mob/proc/dust_animation()
	return

/mob/proc/death(gibbing = FALSE, deathmessage = "seizes up and falls limp...", silent = FALSE)
	SHOULD_CALL_PARENT(TRUE)
	if(SEND_SIGNAL(src, COMSIG_MOB_PRE_DEATH, FALSE) & COMPONENT_CANCEL_DEATH)
		return FALSE
	if(stat == DEAD)
		if(!gibbing)
			return
		qdel(src)
		return
	set_stat(DEAD)
	if(SSticker.current_state != GAME_STATE_FINISHED && !is_centcom_level(z))
		var/mob/living/living = last_damage_source
		if(istype(living))
			hunter_data.death(living)
			if(isyautja(living) && living != src)
				INVOKE_ASYNC(living.client, TYPE_PROC_REF(/client, add_honor), life_kills_total + life_value)
			living.life_kills_total += life_kills_total + life_value
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_MOB_DEATH, src)
	SEND_SIGNAL(src, COMSIG_MOB_DEATH, gibbing)
	if(client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[ckey]
		personal_statistics.deaths++

	if(deathmessage && !silent && !gibbing)
		log_combat(src, src, "[deathmessage]")
		visible_message("<b>\The [name]</b> [deathmessage]")

	if(!QDELETED(src) && gibbing)
		qdel(src)


/mob/proc/on_death()
	SHOULD_CALL_PARENT(TRUE) // no exceptions
	client?.view_size.reset_to_default()//just so we never get stuck with a large view somehow

	hide_fullscreens()

	update_sight()

	drop_r_hand()
	drop_l_hand()

	if(hud_used?.healths)
		hud_used.healths.icon_state = "health7"

	timeofdeath = world.time
	if(mind)
		mind.store_memory("Time of death: [worldtime2text()]", 0)
		if(mind.active && is_gameplay_level(loc.z))
			var/turf/T = get_turf(src)
			deadchat_broadcast("has died at <b>[get_area_name(T)]</b>.", "<b>[mind.name]</b>", follow_target = src, turf_target = T, message_type = DEADCHAT_DEATHRATTLE)

	GLOB.dead_mob_list |= src
	GLOB.offered_mob_list -= src

	med_pain_set_perceived_health()
	med_hud_set_health()
	med_hud_set_status()

	update_icons()

	if(SSticker.HasRoundStarted())
		SSblackbox.ReportDeath(src)
