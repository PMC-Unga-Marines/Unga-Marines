/datum/outfit/job/necoarc
	name = "Neco Arc"
	jobtype = /datum/job/necoarc

	id = /obj/item/card/id
	belt = /obj/item/storage/belt/marine/sectoid/full
	head = /obj/item/clothing/head/helmet/sectoid
	ears = /obj/item/radio/headset/distress/sectoid
	w_uniform = /obj/item/clothing/under/sectoid
	glasses = /obj/item/clothing/glasses/night/sectoid
	shoes = /obj/item/clothing/shoes/sectoid
	wear_suit = /obj/item/clothing/suit/armor/sectoid
	gloves = /obj/item/clothing/gloves/sectoid
	r_pocket = /obj/item/stack/medical/heal_pack/gauze/sectoid
	l_pocket = /obj/item/explosive/grenade/sectoid
	back = /obj/item/weapon/gun/rifle/sectoid_rifle

	var/list/abilities = list(
		/datum/action/ability/activable/sectoid/mindmeld,
		/datum/action/ability/activable/sectoid/mindfray,
	)

/datum/outfit/job/necoarc/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.set_species("Neco Arc")

	H.name = GLOB.namepool[/datum/namepool/necoarc].random_name(H)
	H.real_name = H.name

	for(var/ability in abilities)
		H.add_ability(ability)

/datum/outfit/job/necoarc/psionic
	name = "Neco Arc Psionic"
	jobtype = /datum/job/necoarc/psionic
	abilities = list(
		/datum/action/ability/activable/sectoid/mindmeld,
		/datum/action/ability/activable/sectoid/mindfray,
		/datum/action/ability/activable/sectoid/reknit_form,
		/datum/action/ability/activable/sectoid/stasis,
	)

/datum/outfit/job/necoarc/leader
	name = "Neco Arc Leader"
	jobtype = /datum/job/necoarc/leader
	wear_suit = /obj/item/clothing/suit/armor/sectoid/shield
	abilities = list(
		/datum/action/ability/activable/sectoid/mindmeld/greater,
		/datum/action/ability/activable/sectoid/mindfray,
		/datum/action/ability/activable/sectoid/reknit_form/greater,
		/datum/action/ability/activable/sectoid/stasis,
		/datum/action/ability/activable/sectoid/fuse,
		/datum/action/ability/activable/psionic_interact,
		/datum/action/ability/activable/sectoid/reanimate,
	)
