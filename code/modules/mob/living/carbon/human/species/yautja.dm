/datum/species/yautja
	name = "Yautja"
	brute_mod = 0.28 //Beefy!
	burn_mod = 0.45
	reagent_tag = IS_YAUTJA
	species_flags = HAS_SKIN_COLOR|NO_POISON|NO_PAIN|USES_ALIEN_WEAPONS|PARALYSE_RESISTANT
	inherent_traits = list(
		TRAIT_YAUTJA_TECH,
		TRAIT_SUPER_STRONG,
		TRAIT_FOREIGN_BIO,
	)
	inherent_actions = list(
		/datum/action/predator_action/mark_for_hunt,
		/datum/action/predator_action/mark_panel,
	)

	screams = list(MALE = SFX_PRED_SCREAM, FEMALE = SFX_PRED_SCREAM)
	paincries = list(MALE = SFX_PRED_PAIN, FEMALE = SFX_PRED_PAIN)
	goredcries = list(MALE = SFX_PRED_PAIN, FEMALE = SFX_PRED_PAIN)
	burstscreams = list(MALE = SFX_PRED_PREBURST, FEMALE = SFX_PRED_PREBURST)
	warcries = list(MALE = SFX_PRED_WARCRY, FEMALE = SFX_PRED_WARCRY)
	laughs = list(MALE = SFX_PRED_LAUGH, FEMALE = SFX_PRED_LAUGH)

	unarmed_type = /datum/unarmed_attack/punch/strong
	secondary_unarmed_type = /datum/unarmed_attack/bite/strong
	max_stamina = 250
	blood_color = "#20d450"
	flesh_color = "#907E4A"
	death_message = "clicks in agony and falls still, motionless and completely lifeless..."

	brute_damage_icon_state = "pred_brute"
	burn_damage_icon_state = "pred_burn"

	slowdown = -0.5
	total_health = 175 //more health than regular humans

	default_language_holder = /datum/language_holder/yautja

	heat_level_1 = 500
	heat_level_2 = 700
	heat_level_3 = 1000

	inherent_verbs = list(
		/mob/living/carbon/human/proc/butcher,
	)

	icobase = 'icons/mob/hunter/r_predator.dmi'

/datum/species/yautja/handle_death(mob/living/carbon/human/H, gibbed)
	if(gibbed)
		GLOB.yautja_mob_list -= H

	for(var/mob/living/carbon/M in H.hunter_data.dishonored_targets)
		M.hunter_data.dishonored_set = null
		H.hunter_data.dishonored_targets -= M
	for(var/mob/living/carbon/M in H.hunter_data.honored_targets)
		M.hunter_data.honored_set = null
		H.hunter_data.honored_targets -= M
	for(var/mob/living/carbon/M in H.hunter_data.gear_targets)
		M.hunter_data.gear_set = null
		H.hunter_data.gear_targets -= M

	if(H.hunter_data.prey)
		var/mob/living/carbon/M = H.hunter_data.prey
		H.hunter_data.prey = null
		M.hunter_data.hunter = null
		M.hud_set_hunter()

	set_predator_status(H, gibbed ? "Gibbed" : "Dead")

	// Notify all yautja so they start the gear recovery
	message_all_yautja("[H.real_name] has died at \the [get_area_name(H)].")

	if(H.hunter_data.thrall)
		var/mob/living/carbon/T = H.hunter_data.thrall
		message_all_yautja("[H.real_name]'s Thrall, [T.real_name] is now masterless.")
		H.message_thrall("Your master has fallen!")
		H.hunter_data.thrall = null

/datum/species/yautja/proc/set_predator_status(mob/living/carbon/human/H, status = "Alive")
	if(!H.key)
		return
	var/datum/game_mode/GM
	if(SSticker?.mode)
		GM = SSticker.mode
		if(H.key in GM.predators)
			GM.predators[lowertext(H.key)]["Status"] = status
		else
			GM.predators[lowertext(H.key)] = list("Name" = H.real_name, "Status" = status)

/datum/species/yautja/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	H.ethnicity = pick(GLOB.yautja_ethnicities_list) // snowflakes, yey
	var/datum/atom_hud/A = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	A.add_to_hud(H)

	for(var/datum/limb/limb in H.limbs)
		switch(limb.name)
			if("groin","chest")
				limb.min_broken_damage = 120
				limb.max_damage = 350
			if("head")
				limb.min_broken_damage = 100
				limb.max_damage = 350
			if("l_hand","r_hand","r_foot","l_foot")
				limb.min_broken_damage = 85
				limb.max_damage = 180
			if("r_leg","r_arm","l_leg","l_arm")
				limb.min_broken_damage = 100
				limb.max_damage = 225

	set_predator_status(H, "Alive")

/datum/species/yautja/post_species_loss(mob/living/carbon/human/H)
	. = ..()
	H.ethnicity = random_ethnicity()
	var/datum/atom_hud/A = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	A.remove_hud_from(H)
	remove_inherent_abilities(H)
	H.blood_type = pick("A+","A-","B+","B-","O-","O+","AB+","AB-")
	H.h_style = "Bald"
	GLOB.yautja_mob_list -= H

	for(var/datum/limb/limb in H.limbs)
		switch(limb.name)
			if("groin","chest")
				limb.min_broken_damage = 60
				limb.max_damage = 200
			if("head")
				limb.min_broken_damage = 40
				limb.max_damage = 125
			if("l_hand","r_hand","r_foot","l_foot")
				limb.min_broken_damage = 37
				limb.max_damage = 100
			if("r_arm","l_arm")
				limb.min_broken_damage = 50
				limb.max_damage = 150
			if("r_leg","l_leg")
				limb.min_broken_damage = 50
				limb.max_damage = 125

	set_predator_status(H, "Demoted")

	if(H.actions_by_path[/datum/action/minimap/yautja])
		var/datum/action/minimap/yautja/mini = H.actions_by_path[/datum/action/minimap/yautja]
		mini.remove_action(src)

/datum/species/yautja/handle_post_spawn(mob/living/carbon/human/H)
	GLOB.alive_human_list -= H

	H.blood_type = "Y*"
	H.h_style = H.client ? H.client.prefs.predator_h_style : "Standard"
	#ifndef UNIT_TESTS // Since this is a hard ref, we shouldn't confuse create_and_destroy
	GLOB.yautja_mob_list += H
	#endif

	if(!H.actions_by_path[/datum/action/minimap/yautja])
		var/datum/action/minimap/yautja/mini = new
		mini.give_action(H)
	return ..()

/datum/species/yautja/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(CHECK_BITFIELD(species_flags, NO_CHEM_METABOLIZATION)) //explicit
		H.reagents.del_reagent(chem.type) //for the time being
		return TRUE
	if(CHECK_BITFIELD(species_flags, NO_POISON) && istype(chem, /datum/reagent/toxin))
		H.reagents.remove_reagent(chem.type, chem.custom_metabolism * H.metabolism_efficiency)
		return TRUE
	if(istype(chem, /datum/reagent/medicine))
		H.reagents.remove_reagent(chem.type, chem.custom_metabolism * H.metabolism_efficiency)
		return TRUE
	if(CHECK_BITFIELD(species_flags, NO_OVERDOSE)) //no stacking
		if(chem.overdose_threshold && chem.volume > chem.overdose_threshold)
			H.reagents.remove_reagent(chem.type, chem.volume - chem.overdose_threshold)
	return FALSE

/mob/living/carbon/human/species/yautja
	race = "Yautja"
	h_style = "Standard"
	ethnicity = "Tan"
	gender = MALE
	age = 100
	chat_color = "#aa0000"

/mob/living/carbon/human/species/yautja/get_paygrade()
	if(client.clan_info)
		return client.clan_info.item[2] <= GLOB.clan_ranks_ordered.len ? GLOB.clan_ranks_ordered[client.clan_info.item[2]] : GLOB.clan_ranks_ordered[1]

/mob/living/carbon/human/species/yautja/hud_set_hunter()
	. = ..()

	var/image/holder = hud_list[HUNTER_CLAN]
	if(!holder)
		return

	holder.icon_state = "predhud"

	if(client?.clan_info?.item?[4])
		var/datum/db_query/player_clan = SSdbcore.NewQuery("SELECT id, name, description, honor, color FROM [format_table_name("clan")] WHERE id = :clan_id", list("clan_id" = client.clan_info.item[4]))
		player_clan.Execute()
		if(player_clan.NextRow())
			holder.color = player_clan.item[5]

	hud_list[HUNTER_CLAN] = holder

/mob/living/carbon/human/species/yautja/send_speech(message_raw, message_range = 6, obj/source = src, bubble_type = bubble_icon, list/spans, datum/language/message_language=null, message_mode)
	. = ..()
	playsound(loc, pick('sound/voice/predator/click1.ogg', 'sound/voice/predator/click2.ogg'), 25, 1)

/mob/living/carbon/human/species/yautja/get_idcard(hand_first = TRUE)
	. = ..()
	if(!.)
		var/obj/item/clothing/gloves/yautja/hunter/bracer = gloves
		if(istype(bracer))
			return bracer.embedded_id
	return .

/mob/living/carbon/human/species/yautja/get_reagent_tags()
	return species?.reagent_tag

/mob/living/carbon/human/species/yautja/can_be_operated_on(mob/user)
	return TRUE

/mob/living/carbon/human/species/yautja/randomize_appearance()
	name = "Le'pro"
	real_name = name
	switch(pick(15;"black", 15;"grey", 15;"brown", 15;"lightbrown", 10;"white", 15;"blonde", 15;"red"))
		if("black")
			r_hair = 10
			g_hair = 10
			b_hair = 10
		if("grey")
			r_hair = 50
			g_hair = 50
			b_hair = 50
		if("brown")
			r_hair = 70
			g_hair = 35
			b_hair = 0
		if("lightbrown")
			r_hair = 100
			g_hair = 50
			b_hair = 0
		if("white")
			r_hair = 235
			g_hair = 235
			b_hair = 235
		if("blonde")
			r_hair = 240
			g_hair = 240
			b_hair = 0
		if("red")
			r_hair = 128
			g_hair = 0
			b_hair = 0

	h_style = pick(GLOB.yautja_hair_styles_list)

	switch(pick(15;"black", 15;"green", 15;"brown", 15;"blue", 15;"lightblue", 5;"red"))
		if("black")
			r_eyes = 10
			g_eyes = 10
			b_eyes = 10
		if("green")
			r_eyes = 200
			g_eyes = 0
			b_eyes = 0
		if("brown")
			r_eyes = 100
			g_eyes = 50
			b_eyes = 0
		if("blue")
			r_eyes = 0
			g_eyes = 0
			b_eyes = 200
		if("lightblue")
			r_eyes = 0
			g_eyes = 150
			b_eyes = 255
		if("red")
			r_eyes = 220
			g_eyes = 0
			b_eyes = 0

	ethnicity = pick(GLOB.yautja_ethnicities_list)

	age = rand(100, 999)

	update_hair()
	update_body()
	regenerate_icons()
