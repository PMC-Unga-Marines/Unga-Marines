//Base SOM leader outfit
/datum/outfit/quick/som/squad_leader
	name = "SOM Squad Leader"
	jobtype = "SOM Squad Leader"

	ears = /obj/item/radio/headset/distress/som
	w_uniform = /obj/item/clothing/under/som/leader/webbing
	shoes = /obj/item/clothing/shoes/marine/som/knife
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/leader/valk
	gloves = /obj/item/clothing/gloves/marine/som/veteran
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/som/leader
	glasses = /obj/item/clothing/glasses/hud/health
	r_store = /obj/item/storage/pouch/firstaid/som/combat_patrol_leader
	l_store = /obj/item/storage/pouch/grenade/som/combat_patrol
	back = /obj/item/storage/backpack/satchel/som

/datum/outfit/quick/som/squad_leader/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_HEAD)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/combat_advanced, SLOT_IN_HEAD)

	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/isotonic, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclot, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/dylovene, SLOT_IN_SUIT)

/datum/outfit/quick/som/squad_leader/standard_assaultrifle
	name = "V-31 Squad Leader"
	desc = "Tactical utility. Equipped with a V-31 assault rifle with integrated 'micro grenade' rail launcher, Gorgon heavy armor with 'Valkyrie' autodoctor module, a large variety of grenades as well as AP ammunition. Excellent performance against heavily armored targets, while the plentiful grenade provide greater tactical flexibility."

	back = /obj/item/storage/backpack/lightpack/som
	suit_store = /obj/item/weapon/gun/rifle/som/veteran
	belt = /obj/item/storage/belt/marine/som/som_rifle_ap

/datum/outfit/quick/som/squad_leader/standard_assaultrifle/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/som/ap, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/som/ap, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/dragonbreath, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/dragonbreath, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/cluster, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/cluster, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/smoke_burst, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/small, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/binoculars/fire_support/campaign/som, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/squad_leader/standard_smg
	name = "V-21 Squad Leader"
	desc = "Close range high damage, high speed. Equipped with a V-21 submachine gun with variable firerate allowing for extreme rates of fire when properly wielded, Gorgon heavy armor with 'Valkyrie' autodoctor module, a good variety of grenades and AP ammunition. Allows for excellent close to medium range firepower, especially against heavily armored targets, and is surprisingly mobile."

	suit_store = /obj/item/weapon/gun/smg/som/veteran
	belt = /obj/item/storage/belt/marine/som/som_smg_ap

/datum/outfit/quick/som/squad_leader/standard_smg/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/small, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som/ap, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som/incendiary, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som/incendiary, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang/stun, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/binoculars/fire_support/campaign/som, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/squad_leader/charger
	name = "Charger Squad Leader"
	desc = "For the leader that prefers to be up close and personal. Equipped with a volkite charger with motion sensor and gyrostabiliser for better one handed use, Gorgon heavy armor with 'Valkyrie' autodoctor module and a good variety of grenades. Allows for excellent close to medium range firepower, with first rate survivability. Very dangerous."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger/scout
	belt = /obj/item/storage/belt/marine/som/volkite

/datum/outfit/quick/som/squad_leader/charger/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/small, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/binoculars/fire_support/campaign/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang/stun, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/squad_leader/caliver
	name = "Caliver Squad Leader"
	desc = "Victory through superior firepower. Equipped with a volkite caliver and motion sensor, Gorgon heavy armor with 'Valkyrie' autodoctor module and a good variety of grenades. Allows for excellent damage at all ranges, with first rate survivability. Very dangerous."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/caliver/tacsensor
	belt = /obj/item/storage/belt/marine/som/volkite

/datum/outfit/quick/som/squad_leader/caliver/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/small, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/binoculars/fire_support/campaign/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang/stun, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/squad_leader/mpi
	name = "MPI_KM Squad Leader"
	desc = "For the leader with a taste for nostalgia. Equipped with an MPI_KM assault rifle, with under barrel grenade launcher, Gorgon heavy armor with 'Valkyrie' autodoctor module and a large supply of grenades. An old weapon that was a common sight during the original Martian rebellion, the MPI's good stopping power, reliability and a healthy dose of nostalgia means it is still seen in use by some among the SOM despite its age."

	suit_store = /obj/item/weapon/gun/rifle/mpi_km/grenadier
	belt = /obj/item/storage/belt/marine/som/mpi_plum

/datum/outfit/quick/som/squad_leader/mpi/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/small, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/small, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/extended, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/binoculars/fire_support/campaign/som, SLOT_IN_ACCESSORY)
