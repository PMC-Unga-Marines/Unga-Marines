/mob/living/carbon/xenomorph/generic_evolution_checks()
	if(HAS_TRAIT(src, TRAIT_BANISHED))
		balloon_alert(src, span_warning("You are banished and cannot reach the hivemind."))
		return FALSE
	return ..()

/mob/living/carbon/xenomorph/caste_evolution_checks(new_mob_type, castepick, regression)
	for(var/forbid_info in hive.hive_forbiden_castes)
		if(forbid_info["type_path"] == new_mob_type && forbid_info["is_forbid"])
			var/confirm = tgui_alert(src, "Queen Mother doesnt want this caste in the Hive. Are you sure you want to evolve? Forbidden caste is limited to 1 per Hive.", "Confirm.", list("Yes", "No"), timeout = 15 SECONDS)
			if(confirm != "Yes")
				return FALSE
			if(length(hive.xenos_by_typepath[new_mob_type]) >= 1)
				to_chat(src, span_xenodanger("Forbidden caste is limited to 1 per Hive!"))
				return FALSE
	return ..()

///Actually changes the xenomorph to another caste
/mob/living/carbon/xenomorph/proc/finish_evolve(new_mob_type)
	var/mob/living/carbon/xenomorph/new_xeno = new new_mob_type(get_turf(src))

	if(!istype(new_xeno))
		//Something went horribly wrong!
		stack_trace("[src] tried to evolve but their new_xeno wasn't a xeno at all.")
		if(new_xeno)
			qdel(new_xeno)
		return

	while(new_xeno.upgrade_possible())
		new_xeno.upgrade_xeno(new_xeno.upgrade_next(), TRUE)


	SEND_SIGNAL(src, COMSIG_XENOMORPH_EVOLVED, new_xeno)

	for(var/obj/item/W in contents) //Drop stuff
		dropItemToGround(W)

	if(mind)
		mind.transfer_to(new_xeno)
	else
		new_xeno.key = key

	//Pass on the unique nicknumber, then regenerate the new mob's name on Login()
	new_xeno.nicknumber = nicknumber
	new_xeno.hivenumber = hivenumber
	new_xeno.transfer_to_hive(hivenumber)
	new_xeno.life_kills_total = life_kills_total
	if(new_xeno.hunter_data)
		new_xeno.hunter_data.clean_data()
		qdel(new_xeno.hunter_data)
		new_xeno.hunter_data = hunter_data
		hunter_data = null
	transfer_observers_to(new_xeno)

	if(new_xeno.health - getBruteLoss(src) - getFireLoss(src) > 0) //Cmon, don't kill the new one! Shouldnt be possible though
		new_xeno.bruteloss = bruteloss //Transfers the damage over.
		new_xeno.fireloss = fireloss //Transfers the damage over.
		new_xeno.updatehealth()

	if(xeno_mobhud)
		var/datum/atom_hud/H = GLOB.huds[DATA_HUD_XENO_STATUS]
		H.add_hud_to(new_xeno) //keep our mobhud choice
		new_xeno.xeno_mobhud = TRUE

	if(lighting_alpha != new_xeno.lighting_alpha)
		new_xeno.toggle_nightvision(lighting_alpha)

	new_xeno.update_spits() //Update spits to new/better ones

	new_xeno.visible_message(span_xenodanger("A [new_xeno.xeno_caste.caste_name] emerges from the husk of \the [src]."), \
	span_xenodanger("We emerge in a greater form from the husk of our old body. For the hive!"))

	SEND_SIGNAL(hive, COMSIG_XENOMORPH_POSTEVOLVING, new_xeno)
	// Update the turf just in case they moved, somehow.
	var/turf/T = get_turf(src)
	deadchat_broadcast(" has evolved into a <b>[new_xeno.xeno_caste.caste_name]</b> at <b>[get_area_name(T)]</b>.", "<b>[src]</b>", follow_target = new_xeno, turf_target = T)

	GLOB.round_statistics.total_xenos_created-- //so an evolved xeno doesn't count as two.
	SSblackbox.record_feedback("tally", "round_statistics", -1, "total_xenos_created")

	if(queen_chosen_lead && (new_xeno.xeno_caste.can_flags & CASTE_CAN_BE_LEADER)) // xeno leader is removed by Destroy()
		hive.add_leader(new_xeno)
		new_xeno.hud_set_queen_overwatch()
		if(hive.living_xeno_queen)
			new_xeno.handle_xeno_leader_pheromones(hive.living_xeno_queen)

		new_xeno.update_leader_icon(TRUE)

	if(upgrade == XENO_UPGRADE_PRIMO)
		switch(tier)
			if(XENO_TIER_TWO)
				SSmonitor.stats.primo_T2--
			if(XENO_TIER_THREE)
				SSmonitor.stats.primo_T3--
			if(XENO_TIER_FOUR)
				SSmonitor.stats.primo_T4--

	while(new_xeno.upgrade_possible())
		new_xeno.upgrade_xeno(new_xeno.upgrade_next(), TRUE)

	var/atom/movable/screen/zone_sel/selector = new_xeno.hud_used?.zone_sel
	selector?.set_selected_zone(zone_selected, new_xeno)
	qdel(src)
	INVOKE_ASYNC(new_xeno, TYPE_PROC_REF(/atom, do_jitter_animation), 1000)

	new_xeno.overlay_fullscreen_timer(2 SECONDS, 20, "roundstart2", /atom/movable/screen/fullscreen/spawning_in)
