//Base TGMC corpsman outfit
/datum/outfit/quick/tgmc/corpsman
	name = "TGMC Squad Corpsman"
	jobtype = SQUAD_CORPSMAN

	belt = /obj/item/storage/belt/lifesaver/quick
	ears = /obj/item/radio/headset/mainship/marine
	glasses = /obj/item/clothing/glasses/hud/health
	w_uniform = /obj/item/clothing/under/marine/corpsman/corpman_vest
	shoes = /obj/item/clothing/shoes/marine/full
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/mimir
	gloves = /obj/item/clothing/gloves/marine
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/m10x/mimir
	r_store = /obj/item/storage/pouch/magazine/large
	l_store = /obj/item/storage/pouch/grenade/combat_patrol
	back = /obj/item/storage/backpack/marine/corpsman

/datum/outfit/quick/tgmc/corpsman/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/bodybag/cryobag, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/roller, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tweezers_advanced, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/nanoblood, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/pill_bottle/spaceacillin, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/combat_advanced, SLOT_IN_ACCESSORY)

	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/defibrillator, SLOT_IN_SUIT)

	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/isotonic, SLOT_IN_HEAD)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/neuraline, SLOT_IN_HEAD)

/datum/outfit/quick/tgmc/corpsman/ar12
	name = "AR-12 Corpsman"
	desc = "Keeping everone else in the fight. Armed with an AR-12 assault rifle with underbarrel grenade launcher, an impressive array of tools for healing your team, and a 'Mimir' biological protection module to allow you to continue operating in hazardous environments. With medivacs out of the question, you are the only thing standing between your buddies and an early grave."

	suit_store = /obj/item/weapon/gun/rifle/ar12/medic

/datum/outfit/quick/tgmc/corpsman/ar12/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x24mm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar12, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar12, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar12, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar12, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar12, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar12, SLOT_IN_R_POUCH)

/datum/outfit/quick/tgmc/corpsman/smg90
	name = "SMG-90 Corpsman"
	desc = "Keeping everone else in the fight. Armed with an SMG-90 submachine gun to maintain good mobility, an impressive array of tools for healing your team, and a 'Mimir' biological protection module to allow you to continue operating in hazardous environments. With medivacs out of the question, you are the only thing standing between your buddies and an early grave."

	suit_store = /obj/item/weapon/gun/smg/smg90/tactical

/datum/outfit/quick/tgmc/corpsman/smg90/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/smg90, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/smg90, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x20mm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/smg90, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/smg90, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/smg90, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/smg90, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/smg90, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/smg90, SLOT_IN_R_POUCH)

/datum/outfit/quick/tgmc/corpsman/ar21
	name = "AR-21 Corpsman"
	desc = "Keeping everone else in the fight. Armed with an AR-21 skirmish rifle with underbarrel grenade launcher, an impressive array of tools for healing your team, and a 'Mimir' biological protection module to allow you to continue operating in hazardous environments. With medivacs out of the question, you are the only thing standing between your buddies and an early grave."

	suit_store = /obj/item/weapon/gun/rifle/ar21/standard

/datum/outfit/quick/tgmc/corpsman/ar21/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x25mm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar21, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar21, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar21, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar21, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar21, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar21, SLOT_IN_R_POUCH)

/datum/outfit/quick/tgmc/corpsman/auto_shotgun
	name = "SH-15 Corpsman"
	desc = "Keeping everone else in the fight. Armed with a SH-15 auto shotgun with underbarrel grenade launcher, an impressive array of tools for healing your team, and a 'Mimir' biological protection module to allow you to continue operating in hazardous environments. With medivacs out of the question, you are the only thing standing between your buddies and an early grave."

	suit_store = /obj/item/weapon/gun/rifle/sh15/engineer

/datum/outfit/quick/tgmc/corpsman/auto_shotgun/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sh15_slug, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sh15_slug, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sh15_flechette, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sh15_flechette, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sh15_flechette, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/sh15_slug, SLOT_IN_R_POUCH)

	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_R_POUCH)

/datum/outfit/quick/tgmc/corpsman/laser_medic
	name = "Laser Rifle Corpsman"
	desc = "Keeping everone else in the fight. Armed with an laser rifle with miniflamer, an impressive array of tools for healing your team, and a 'Mimir' biological protection module to allow you to continue operating in hazardous environments. With medivacs out of the question, you are the only thing standing between your buddies and an early grave."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle/medic

/datum/outfit/quick/tgmc/corpsman/laser_medic/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/mini, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/mini, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_R_POUCH)

/datum/outfit/quick/tgmc/corpsman/laser_carbine
	name = "Laser Carbine Corpsman"
	desc = "Keeping everone else in the fight. Armed with an laser carbine with underbarrel grenade launcher, an impressive array of tools for healing your team, and a 'Mimir' biological protection module to allow you to continue operating in hazardous environments. With medivacs out of the question, you are the only thing standing between your buddies and an early grave."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_carbine/scout

/datum/outfit/quick/tgmc/corpsman/laser_carbine/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_R_POUCH)
