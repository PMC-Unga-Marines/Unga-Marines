/datum/outfit/job/yautja
	name = "Yautja"
	id = null
	back = FALSE
	w_uniform = /obj/item/clothing/under/chainshirt/hunter
	ears = /obj/item/radio/headset/yautja
	r_pocket = /obj/item/flashlight/lantern
	l_pocket = /obj/item/yautja_teleporter
	belt = /obj/item/storage/belt/yautja
	belt_contents = list(
		/obj/item/storage/medicomp/full = 1,
	)
	var/default_cape_type = "None"
	var/clan_rank
	var/name_prefix = ""

/datum/outfit/job/yautja/pre_equip(mob/living/carbon/human/H, visualsOnly, client/override_client)
	H.set_species("Yautja")

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

	if(H.client)
		using_legacy = H.client.prefs.predator_use_legacy
		armor_number = H.client.prefs.predator_armor_type
		boot_number = H.client.prefs.predator_boot_type
		mask_number = H.client.prefs.predator_mask_type
		armor_material = H.client.prefs.predator_armor_material
		greave_material = H.client.prefs.predator_greave_material
		mask_material = H.client.prefs.predator_mask_material
		caster_material = H.client.prefs.predator_caster_material
		translator_type = H.client.prefs.predator_translator_type
		cape_type = H.client.prefs.predator_cape_type
		cape_color = H.client.prefs.predator_cape_color

	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/yautja/hunter(H, translator_type, caster_material, clan_rank), SLOT_GLOVES, TRUE, TRUE)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/yautja/hunter/knife(H, boot_number, greave_material), SLOT_SHOES)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/yautja/hunter(H, armor_number, armor_material, using_legacy), SLOT_WEAR_SUIT)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/yautja/hunter(H, mask_number, mask_material, using_legacy), SLOT_WEAR_MASK)

	var/cape_path = GLOB.all_yautja_capes[cape_type]
	if(ispath(cape_path))
		H.equip_to_slot_or_del(new cape_path(H, cape_color), SLOT_BACK)

/datum/outfit/job/yautja/handle_id(mob/living/carbon/human/H, client/override_client)
	var/datum/job/job = H.job ? H.job : SSjob.GetJobType(jobtype)
	H.faction = GLOB.faction_to_iff[job.faction]
	var/new_name = name_prefix ? "[name_prefix] [H.real_name]" : "[H.real_name]"
	H.real_name = new_name
	H.name = new_name

/datum/outfit/job/yautja/youngblood
	name = "Yautja Young"
	clan_rank = CLAN_RANK_UNBLOODED_INT
	name_prefix = "Young"

/datum/outfit/job/yautja/blooded
	name = "Yautja Blooded"
	default_cape_type = PRED_YAUTJA_QUARTER_CAPE
	clan_rank = CLAN_RANK_BLOODED_INT

/datum/outfit/job/yautja/elite
	name = "Yautja Elite"
	default_cape_type = PRED_YAUTJA_HALF_CAPE
	clan_rank = CLAN_RANK_ELITE_INT
	name_prefix = "Elite"

/datum/outfit/job/yautja/elder
	name = "Yautja Elder"
	default_cape_type = PRED_YAUTJA_THIRD_CAPE
	ears = /obj/item/radio/headset/yautja/elder
	clan_rank = CLAN_RANK_ELDER_INT
	name_prefix = "Elder"

/datum/outfit/job/yautja/leader
	name = "Yautja Leader"
	default_cape_type = PRED_YAUTJA_CAPE
	ears = /obj/item/radio/headset/yautja/elder
	clan_rank = CLAN_RANK_LEADER_INT
	name_prefix = "Clan Leader"

/datum/outfit/job/yautja/ancient
	name = "Yautja Ancient"
	default_cape_type = PRED_YAUTJA_PONCHO
	ears = /obj/item/radio/headset/yautja/elder
	clan_rank = CLAN_RANK_ADMIN_INT
	name_prefix = "Ancient"
