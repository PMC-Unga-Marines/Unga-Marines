/datum/job/predator
	title = JOB_PREDATOR
	job_category = JOB_PREDATOR
	job_flags = JOB_FLAG_OVERRIDELATEJOINSPAWN|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_SHOW_OPEN_POSITIONS
	supervisors = "Ancients"
	outfit = /datum/outfit/job/yautja/blooded
	skills_type = /datum/skills/yautja/warrior
	faction = FACTION_YAUTJA
	minimap_icon = "predator"

	total_positions = 0
	max_positions = 0

/datum/job/predator/New()
	. = ..()
	gear_preset_whitelist = list(
		"[JOB_PREDATOR][CLAN_RANK_YOUNG]" = new /datum/outfit/job/yautja/youngblood,
		"[JOB_PREDATOR][CLAN_RANK_BLOODED]" = new /datum/outfit/job/yautja/blooded,
		"[JOB_PREDATOR][CLAN_RANK_ELITE]" = new /datum/outfit/job/yautja/elite,
		"[JOB_PREDATOR][CLAN_RANK_ELDER]" = new /datum/outfit/job/yautja/elder,
		"[JOB_PREDATOR][CLAN_RANK_LEADER]" = new /datum/outfit/job/yautja/leader,
		"[JOB_PREDATOR][CLAN_RANK_ADMIN]" = new /datum/outfit/job/yautja/ancient
	)

/datum/job/predator/return_spawn_type(datum/preferences/prefs)
	return /mob/living/carbon/human/species/yautja

/datum/job/predator/return_spawn_turf(mob/living/carbon/human/new_predator, client/player)
	var/clan_id = CLAN_SHIP_PUBLIC
	var/clan_rank = CLAN_RANK_BLOODED
	if(player.clan_info)
		clan_id = player.clan_info.item[4]
		clan_rank = player.clan_info.item[2] > 0 && player.clan_info.item[2] <= GLOB.clan_ranks_ordered.len ? GLOB.clan_ranks_ordered[player.clan_info.item[2]] : GLOB.clan_ranks_ordered[1]

	SSpredships.load_new(clan_id)
	var/turf/spawn_point = SAFEPICK(SSpredships.get_clan_spawnpoints(clan_id))
	if(!isturf(spawn_point))
		//log_debug("Failed to find spawn point for new_predator ship in transform_predator - clan_id=[clan_id]")
		to_chat(player, span_warning("Unable to setup spawn location - you might want to tell someone about this."))
		return

	if(SSticker.mode)
		SSticker.mode.initialize_predator(new_predator, player, clan_rank == CLAN_RANK_ADMIN)

	return spawn_point

/datum/job/predator/get_whitelist_status(list/roles_whitelist, client/player) // Might be a problem waiting here, but we've got no choice
	. = ..()
	if(!.)
		return

	if(!player || !player.clan_info)
		return CLAN_RANK_BLOODED

	var/title = player.clan_info.item[2] > 0 && player.clan_info.item[2] <= GLOB.clan_ranks_ordered.len ? GLOB.clan_ranks_ordered[player.clan_info.item[2]] : GLOB.clan_ranks_ordered[1]

	if(!title)
		return CLAN_RANK_BLOODED

	if(!("[JOB_PREDATOR][title]" in gear_preset_whitelist))
		return CLAN_RANK_BLOODED

	if(\
		(roles_whitelist[player.ckey] & (WHITELIST_YAUTJA_LEADER|WHITELIST_YAUTJA_COUNCIL|WHITELIST_YAUTJA_COUNCIL_LEGACY)) &&\
		get_desired_status(player.prefs.yautja_status, WHITELIST_COUNCIL) == WHITELIST_NORMAL\
	)
		return CLAN_RANK_BLOODED

	return title

/datum/job/predator/announce(mob/new_predator)
	to_chat(new_predator, span_notice("You are <B>Yautja</b>, a great and noble predator!"))
	to_chat(new_predator, span_notice("Your job is to first study your opponents. A hunt cannot commence unless intelligence is gathered."))
	to_chat(new_predator, span_notice("Hunt at your discretion, yet be observant rather than violent."))
	log_admin("([new_predator.key]) joined as Yautja, [new_predator.real_name].")

/datum/outfit/job/yautja
	name = "Yautja"

	id = null //No IDs for Yautja!
	back = FALSE //Null hecks, no null here

	var/default_cape_type = "None"
	var/clan_rank

/datum/outfit/job/yautja/pre_equip(mob/living/carbon/human/H, visualsOnly, client/override_client)
	var/client/mob_client = H.client
	if(override_client)
		mob_client = override_client

	H.ethnicity = "Tan"
	if(mob_client)
		H.ethnicity = mob_client.prefs.predator_skin_color

	H.set_species("Yautja")
	if(mob_client)
		H.h_style = mob_client.prefs.predator_h_style
		H.update_hair()

	var/using_legacy = "No"
	var/armor_number = 1
	var/boot_number = 1
	var/mask_number = 1
	var/armor_material = "ebony"
	var/greave_material = "ebony"
	var/caster_material = "ebony"
	var/mask_material = "ebony"
	var/translator_type = "Modern"
	var/cape_type = default_cape_type
	var/cape_color = "#654321"

	if(mob_client)
		using_legacy = mob_client.prefs.predator_use_legacy
		armor_number = mob_client.prefs.predator_armor_type
		boot_number = mob_client.prefs.predator_boot_type
		mask_number = mob_client.prefs.predator_mask_type
		armor_material = mob_client.prefs.predator_armor_material
		greave_material = mob_client.prefs.predator_greave_material
		mask_material = mob_client.prefs.predator_mask_material
		caster_material = mob_client.prefs.predator_caster_material
		translator_type = mob_client.prefs.predator_translator_type
		if(mob_client.prefs.predator_cape_type != "Default")
			cape_type = mob_client.prefs.predator_cape_type

		cape_color = mob_client.prefs.predator_cape_color

	H.equip_to_slot_or_del(new /obj/item/clothing/under/chainshirt/hunter(H), SLOT_W_UNIFORM)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/yautja/hunter(H, translator_type, caster_material, clan_rank), SLOT_GLOVES, TRUE, TRUE)
	H.equip_to_slot_or_del(new /obj/item/radio/headset/yautja(H), SLOT_EARS)
	H.equip_to_slot_or_del(new /obj/item/flashlight/lantern(H), SLOT_R_STORE)
	H.equip_to_slot_or_del(new /obj/item/yautja_teleporter(H), SLOT_L_STORE)
	H.equip_to_slot_or_del(new /obj/item/storage/belt/yautja(H), SLOT_BELT)
	H.equip_to_slot_or_del(new /obj/item/storage/medicomp/full(H), SLOT_IN_BELT)

	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/yautja/hunter/knife(H, boot_number, greave_material), SLOT_SHOES)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/yautja/hunter(H, armor_number, armor_material, using_legacy), SLOT_WEAR_SUIT)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/yautja/hunter(H, mask_number, mask_material, using_legacy), SLOT_WEAR_MASK)

	var/cape_path = GLOB.all_yautja_capes[cape_type]
	if(ispath(cape_path))
		H.equip_to_slot_or_del(new cape_path(H, cape_color), SLOT_BACK)

/datum/outfit/job/yautja/handle_id(mob/living/carbon/human/H, client/override_client)
	var/client/mob_client = H.client
	if(override_client)
		mob_client = override_client

	var/datum/job/job = SSjob.GetJobType(jobtype)
	if(!job)
		job = H.job

	H.faction = GLOB.faction_to_iff[job.faction]

	var/final_name = "Le'pro"
	H.gender = MALE
	H.age = 100
	H.flavor_text = ""

	if(mob_client)
		H.h_style = mob_client.prefs.predator_h_style
		H.update_hair()
		H.gender = mob_client.prefs.predator_gender
		H.age = mob_client.prefs.predator_age
		final_name = mob_client.prefs.predator_name
		H.flavor_text = mob_client.prefs.predator_flavor_text
		H.r_eyes = mob_client.prefs.pred_r_eyes
		H.g_eyes = mob_client.prefs.pred_g_eyes
		H.b_eyes = mob_client.prefs.pred_b_eyes
		if(!final_name || final_name == "Undefined") //In case they don't have a name set or no prefs, there's a name.
			final_name = "Le'pro"

		H.update_body()
		H.update_hair()
		H.regenerate_icons()

	H.real_name = final_name
	H.name = final_name
	H.hud_set_hunter()

// YOUNG BLOOD
/datum/outfit/job/yautja/youngblood
	name = "Yautja Young"
	clan_rank = CLAN_RANK_UNBLOODED_INT

/datum/outfit/job/yautja/youngblood/handle_id(mob/living/carbon/human/H, client/override_client)
	. = ..()
	var/new_name = "Young [H.real_name]"
	H.real_name = new_name
	H.name = new_name

//BLOODED
/datum/outfit/job/yautja/blooded
	name = "Yautja Blooded"
	default_cape_type = PRED_YAUTJA_QUARTER_CAPE
	clan_rank = CLAN_RANK_BLOODED_INT

// ELITE
/datum/outfit/job/yautja/elite
	name = "Yautja Elite"
	default_cape_type = PRED_YAUTJA_HALF_CAPE
	clan_rank = CLAN_RANK_ELITE_INT

/datum/outfit/job/yautja/elite/handle_id(mob/living/carbon/human/H, client/override_client)
	. = ..()
	var/new_name = "Elite [H.real_name]"
	H.real_name = new_name
	H.name = new_name

// ELDER
/datum/outfit/job/yautja/elder
	name = "Yautja Elder"
	default_cape_type = PRED_YAUTJA_THIRD_CAPE
	ears = /obj/item/radio/headset/yautja/elder
	clan_rank = CLAN_RANK_ELDER_INT

/datum/outfit/job/yautja/elder/handle_id(mob/living/carbon/human/H, client/override_client)
	. = ..()
	var/new_name = "Elder [H.real_name]"
	H.real_name = new_name
	H.name = new_name

// CLAN LEADER
/datum/outfit/job/yautja/leader
	name = "Yautja Leader"
	default_cape_type = PRED_YAUTJA_CAPE
	ears = /obj/item/radio/headset/yautja/elder
	clan_rank = CLAN_RANK_LEADER_INT

/datum/outfit/job/yautja/leader/handle_id(mob/living/carbon/human/H, client/override_client)
	. = ..()
	var/new_name = "Clan Leader [H.real_name]"
	H.real_name = new_name
	H.name = new_name

// ANCIENT
/datum/outfit/job/yautja/ancient
	name = "Yautja Ancient"
	default_cape_type = PRED_YAUTJA_PONCHO
	ears = /obj/item/radio/headset/yautja/elder
	clan_rank = CLAN_RANK_ADMIN_INT

/datum/outfit/job/yautja/ancient/handle_id(mob/living/carbon/human/H, client/override_client)
	. = ..()
	var/new_name = "Ancient [H.real_name]"
	H.real_name = new_name
	H.name = new_name
