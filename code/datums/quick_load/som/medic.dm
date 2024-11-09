//Base SOM medic outfit
/datum/outfit/quick/som/medic
	name = "SOM Squad Medic"
	jobtype = "SOM Squad Medic"

	belt = /obj/item/storage/belt/lifesaver/som/quick
	ears = /obj/item/radio/headset/distress/som
	w_uniform = /obj/item/clothing/under/som/medic/vest
	shoes = /obj/item/clothing/shoes/marine/som/knife
	wear_suit = /obj/item/clothing/suit/modular/som/medic
	gloves = /obj/item/clothing/gloves/marine/som
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/som
	glasses = /obj/item/clothing/glasses/hud/health
	r_store = /obj/item/storage/pouch/magazine/large/som
	l_store = /obj/item/storage/pouch/grenade/som/combat_patrol
	back = /obj/item/storage/backpack/lightpack/som

/datum/outfit/quick/som/medic/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_HEAD)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_HEAD)

	H.equip_to_slot_or_del(new /obj/item/roller, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tweezers_advanced, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/pill_bottle/spaceacillin, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/nanoblood, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/bodybag/cryobag, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/combat_advanced, SLOT_IN_ACCESSORY)

	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/defibrillator, SLOT_IN_SUIT)

/datum/outfit/quick/som/medic/standard_assaultrifle
	name = "V-31 Medic"
	desc = "Keeping your buddies alive and in the fight. Equipped with a V-31 assault rifle with integrated 'micro grenade' rail launcher, medium armor and a good selection of grenades. Packs a large amount of medical supplies, the squad medic is vital to maintaining combat viability. The rail launcher fires grenades that must arm mid flight, so are ineffective at close ranges, but add significant tactical options at medium range."

	suit_store = /obj/item/weapon/gun/rifle/som/standard

/datum/outfit/quick/som/medic/standard_assaultrifle/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/smoke_burst, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/dragonbreath, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/oxycodone, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/som, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/som, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/som, SLOT_IN_R_POUCH)

/datum/outfit/quick/som/medic/mpi
	name = "MPI_KM Medic"
	desc = "Keeping your buddies alive and in the fight. Equipped with an MPI_KM assault rifle, medium armor and a good selection of grenades. Packs a large amount of medical supplies, the squad medic is vital to maintaining combat viability. An old weapon that was a common sight during the original Martian rebellion, the MPI's good stopping power, reliability and a healthy dose of nostalgia means it is still seen in use by some among the SOM despite its age."

	suit_store = /obj/item/weapon/gun/rifle/mpi_km/black/magharness

/datum/outfit/quick/som/medic/mpi/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/oxycodone, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_R_POUCH)

/datum/outfit/quick/som/medic/standard_carbine
	name = "V-34 Medic"
	desc = "Keeping your buddies alive and in the fight. Equipped with an V-34 carbine, medium armor for massive firepower and mobility, but poor ammo economy and range. Packs a large amount of medical supplies, the squad medic is vital to maintaining combat viability. The V-34 is a modern update of an old weapon that was a common sight during the original Martian rebellion. Very reliable and excellent stopping power in a small, lightweight package. Brought into service as a much cheaper alternative to the VX-32."

	suit_store = /obj/item/weapon/gun/rifle/som_carbine/black/standard

/datum/outfit/quick/som/medic/standard_carbine/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/carbine/black, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/carbine/black, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/carbine/black, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/carbine/black, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/oxycodone, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/carbine/black, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/carbine/black, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/carbine/black, SLOT_IN_R_POUCH)

/datum/outfit/quick/som/medic/standard_smg
	name = "V-21 Medic"
	desc = "Keeping your buddies alive and in the fight. Equipped with a V-21 submachine gun with variable firerate allowing for extreme rates of fire when properly wielded, medium armor and a good selection of grenades. Packs a large amount of medical supplies, the squad medic is vital to maintaining combat viability."

	suit_store = /obj/item/weapon/gun/smg/som/support

/datum/outfit/quick/som/medic/standard_smg/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/oxycodone, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_R_POUCH)

/datum/outfit/quick/som/medic/standard_shotgun
	name = "V-51 Medic"
	desc = "Keeping your buddies alive and in the fight. Equipped with a V-51 semi-automatic shotgun, medium armor and a good selection of grenades. Packs a large amount of medical supplies, the squad medic is vital to maintaining combat viability."

	r_store = /obj/item/storage/pouch/shotgun/som
	suit_store = /obj/item/weapon/gun/shotgun/som/support

/datum/outfit/quick/som/medic/standard_shotgun/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/oxycodone, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclotplus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/flechette, SLOT_IN_R_POUCH)
