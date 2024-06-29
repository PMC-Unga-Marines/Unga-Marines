/mob/living/carbon/human/species/yautja
	chat_color = "#aa0000"

/mob/living/carbon/human/species/yautja/get_paygrade()
	if(client.clan_info)
		return client.clan_info.item[2] <= GLOB.clan_ranks_ordered.len ? GLOB.clan_ranks_ordered[client.clan_info.item[2]] : GLOB.clan_ranks_ordered[1]

/datum/species/yautja
	name = "Yautja"
	name_plural = "Yautja"
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

	screams = list(MALE = "pred_scream", FEMALE = "pred_scream")
	paincries = list(MALE = "pred_pain", FEMALE = "pred_pain")
	goredcries = list(MALE = "pred_pain", FEMALE = "pred_pain")
	burstscreams = list(MALE = "pred_preburst", FEMALE = "pred_preburst")
	warcries = list(MALE = "pred_warcry", FEMALE = "pred_warcry")

	unarmed_type = /datum/unarmed_attack/punch/strong
	secondary_unarmed_type = /datum/unarmed_attack/bite/strong
	max_stamina = 250
	blood_color = "#20d450"
	flesh_color = "#907E4A"
	speech_sounds = list('sound/voice/pred_click1.ogg', 'sound/voice/pred_click2.ogg')
	speech_chance = 100
	death_message = "clicks in agony and falls still, motionless and completely lifeless..."

	brute_damage_icon_state = "pred_brute"
	burn_damage_icon_state = "pred_burn"

	darksight = 5
	slowdown = -0.5
	total_health = 175 //more health than regular humans

	default_language_holder = /datum/language_holder/yautja

	heat_level_1 = 500
	heat_level_2 = 700
	heat_level_3 = 1000

	inherent_verbs = list(
		/mob/living/carbon/human/proc/butcher,
	)

	knock_down_reduction = 4
	stun_reduction = 4

	icobase = 'modular_RUtgmc/icons/mob/hunter/r_predator.dmi'

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
	..()
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

/mob/proc/hud_set_hunter()
	return

var/global/image/hud_icon_hunter_gear
var/global/image/hud_icon_hunter_hunted
var/global/image/hud_icon_hunter_dishonored
var/global/image/hud_icon_hunter_honored
var/global/image/hud_icon_hunter_thralled

/mob/living/carbon/hud_set_hunter()
	var/image/holder = hud_list[HUNTER_HUD]
	if(!holder)
		return
	holder.icon_state = "hudblank"
	holder.overlays.Cut()
	if(hunter_data.hunted)
		if(!hud_icon_hunter_hunted)
			hud_icon_hunter_hunted = image('modular_RUtgmc/icons/mob/screen/yautja.dmi', src, "hunter_hunted")
		holder.overlays += hud_icon_hunter_hunted

	if(hunter_data.dishonored)
		if(!hud_icon_hunter_dishonored)
			hud_icon_hunter_dishonored = image('modular_RUtgmc/icons/mob/screen/yautja.dmi', src, "hunter_dishonored")
		holder.overlays += hud_icon_hunter_dishonored
	else if(hunter_data.honored)
		if(!hud_icon_hunter_honored)
			hud_icon_hunter_honored = image('modular_RUtgmc/icons/mob/screen/yautja.dmi', src, "hunter_honored")
		holder.overlays += hud_icon_hunter_honored

	if(hunter_data.thralled)
		if(!hud_icon_hunter_thralled)
			hud_icon_hunter_thralled = image('modular_RUtgmc/icons/mob/screen/yautja.dmi', src, "hunter_thralled")
		holder.overlays += hud_icon_hunter_thralled
	else if(hunter_data.gear)
		if(!hud_icon_hunter_gear)
			hud_icon_hunter_gear = image('modular_RUtgmc/icons/mob/screen/yautja.dmi', src, "hunter_gear")
		holder.overlays += hud_icon_hunter_gear

	hud_list[HUNTER_HUD] = holder

/mob/living/carbon/xenomorph/hud_set_hunter()
	var/image/holder = hud_list[HUNTER_HUD]
	if(!holder)
		return
	holder.icon_state = "hudblank"
	holder.overlays.Cut()
	holder.pixel_x = -17
	holder.pixel_y = 20
	if(hunter_data.hunted)
		if(!hud_icon_hunter_hunted)
			hud_icon_hunter_hunted = image('modular_RUtgmc/icons/mob/screen/yautja.dmi', src, "hunter_hunted")
		holder.overlays += hud_icon_hunter_hunted

	if(hunter_data.dishonored)
		if(!hud_icon_hunter_dishonored)
			hud_icon_hunter_dishonored = image('modular_RUtgmc/icons/mob/screen/yautja.dmi', src, "hunter_dishonored")
		holder.overlays += hud_icon_hunter_dishonored
	else if(hunter_data.honored)
		if(!hud_icon_hunter_honored)
			hud_icon_hunter_honored = image('modular_RUtgmc/icons/mob/screen/yautja.dmi', src, "hunter_honored")
		holder.overlays += hud_icon_hunter_honored

	hud_list[HUNTER_HUD] = holder

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

/mob/living/carbon/human/species/yautja/send_speech(message_raw, message_range = 6, obj/source = src, bubble_type = bubble_icon, list/spans, datum/language/message_language=null, message_mode, tts_message, list/tts_filter)
	. = ..()
	playsound(loc, pick('sound/voice/pred_click1.ogg', 'sound/voice/pred_click2.ogg'), 25, 1)

/mob/living/carbon/human/species/yautja/get_idcard(hand_first = TRUE)
	. = ..()
	if(!.)
		var/obj/item/clothing/gloves/yautja/hunter/bracer = gloves
		if(istype(bracer))
			. = bracer.embedded_id
	return .

/mob/living/carbon/human/proc/disable_special_items()
	set waitfor = FALSE // Scout decloak animation uses sleep(), which is problematic for taser gun

	if(istype(back, /obj/item/storage/backpack/marine/satchel/scout_cloak))
		var/obj/item/storage/backpack/marine/satchel/scout_cloak/SC = back
		if(SC.camo_active)
			SC.camo_off(src)
			return
	var/list/cont = list()
	for(var/atom/A in contents)
		cont += A
		if(A.contents.len)
			cont += A.contents

	for(var/i in cont)
		if(istype(i, /obj/item/assembly/prox_sensor))
			var/obj/item/assembly/prox_sensor/prox = i
			if(prox.scanning)
				prox.toggle_scan()
		if(istype(i, /obj/item/attachable/motiondetector))
			var/obj/item/attachable/motiondetector/md = i
			md.clean_operator()

/mob/living/carbon/human/species/yautja/get_reagent_tags()
	return species?.reagent_tag

/mob/living/carbon/human/species/yautja/can_be_operated_on(mob/user)
	return TRUE
