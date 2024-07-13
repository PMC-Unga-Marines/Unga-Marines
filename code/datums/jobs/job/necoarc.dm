/datum/job/necoarc
	job_category = JOB_CAT_MARINE
	access = ALL_ANTAGONIST_ACCESS
	minimal_access = ALL_ANTAGONIST_ACCESS
	skills_type = /datum/skills/sectoid
	faction = FACTION_SECTOIDS

/datum/outfit/job/necoarc/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.set_species("Neco Arc")

	H.name = GLOB.namepool[/datum/namepool/necoarc].random_name(H)
	H.real_name = H.name

/datum/job/necoarc/standard
	title = "Neco Arc"
	outfit = /datum/outfit/job/necoarc/standard

/datum/outfit/job/necoarc/standard
	name = "Neco Arc standard"
	jobtype = /datum/job/necoarc/standard

	id = /obj/item/card/id
	belt = /obj/item/storage/belt/marine/sectoid
	head = /obj/item/clothing/head/helmet/sectoid
	ears = /obj/item/radio/headset/distress/sectoid
	w_uniform = /obj/item/clothing/under/sectoid
	glasses = /obj/item/clothing/glasses/night/sectoid
	shoes = /obj/item/clothing/shoes/sectoid
	wear_suit = /obj/item/clothing/suit/armor/sectoid
	gloves = /obj/item/clothing/gloves/sectoid
	r_store = /obj/item/stack/medical/heal_pack/gauze/sectoid
	l_store = /obj/item/explosive/grenade/sectoid
	back = /obj/item/weapon/gun/rifle/sectoid_rifle

/datum/outfit/job/necoarc/standard/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sectoid_rifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sectoid_rifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sectoid_rifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sectoid_rifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sectoid_rifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BELT)

/datum/job/necoarc/leader
	job_category = JOB_CAT_COMMAND
	title = "Neco Arc Leader"
	outfit = /datum/outfit/job/necoarc/leader

/datum/outfit/job/necoarc/leader
	name = "Neco Arc leader"
	jobtype = /datum/job/necoarc/leader

	id = /obj/item/card/id
	belt = /obj/item/storage/belt/marine/sectoid
	head = /obj/item/clothing/head/helmet/sectoid
	ears = /obj/item/radio/headset/distress/sectoid
	w_uniform = /obj/item/clothing/under/sectoid
	glasses = /obj/item/clothing/glasses/night/sectoid
	shoes = /obj/item/clothing/shoes/sectoid
	wear_suit = /obj/item/clothing/suit/armor/sectoid/shield
	gloves = /obj/item/clothing/gloves/sectoid
	r_store = /obj/item/stack/medical/heal_pack/gauze/sectoid
	l_store = /obj/item/explosive/grenade/sectoid
	back = /obj/item/weapon/gun/rifle/sectoid_rifle

/datum/outfit/job/necoarc/leader/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sectoid_rifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sectoid_rifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sectoid_rifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sectoid_rifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sectoid_rifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BELT)
