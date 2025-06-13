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
	r_pocket = /obj/item/storage/pouch/magazine/large/som
	l_pocket = /obj/item/storage/pouch/grenade/som/combat_patrol
	back = /obj/item/storage/backpack/lightpack/som

	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 1,
	)
	webbing_contents = list(
		/obj/item/roller = 1,
		/obj/item/tweezers_advanced = 1,
		/obj/item/storage/pill_bottle/spaceacillin = 1,
		/obj/item/reagent_containers/hypospray/advanced/nanoblood = 1,
		/obj/item/bodybag/cryobag = 1,
		/obj/item/reagent_containers/hypospray/advanced/combat_advanced = 1,
	)
	suit_contents = list(
		/obj/item/tool/extinguisher = 1,
		/obj/item/defibrillator = 1,
	)

/datum/outfit/quick/som/medic/standard_assaultrifle
	name = "V-31 Medic"
	desc = "Keeping your buddies alive and in the fight. Equipped with a V-31 assault rifle with integrated 'micro grenade' rail launcher, medium armor and a good selection of grenades. Packs a large amount of medical supplies, the squad medic is vital to maintaining combat viability. The rail launcher fires grenades that must arm mid flight, so are ineffective at close ranges, but add significant tactical options at medium range."

	suit_store = /obj/item/weapon/gun/rifle/som/standard

	backpack_contents = list(
		/obj/item/ammo_magazine/rifle/som = 3,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/smoke_burst = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/dragonbreath = 1,
		/obj/item/ammo_magazine/handful/micro_grenade = 2,
		/obj/item/reagent_containers/hypospray/autoinjector/oxycodone = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 1,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/rifle/som = 3,
	)

/datum/outfit/quick/som/medic/mpi
	name = "MPI_KM Medic"
	desc = "Keeping your buddies alive and in the fight. Equipped with an MPI_KM assault rifle, medium armor and a good selection of grenades. Packs a large amount of medical supplies, the squad medic is vital to maintaining combat viability. An old weapon that was a common sight during the original Martian rebellion, the MPI's good stopping power, reliability and a healthy dose of nostalgia means it is still seen in use by some among the SOM despite its age."

	suit_store = /obj/item/weapon/gun/rifle/mpi_km/black/magharness

	backpack_contents = list(
		/obj/item/ammo_magazine/rifle/mpi_km/black = 4,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/explosive/grenade/som = 3,
		/obj/item/reagent_containers/hypospray/autoinjector/oxycodone = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 1,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/rifle/mpi_km/black = 3,
	)

/datum/outfit/quick/som/medic/standard_carbine
	name = "V-34 Medic"
	desc = "Keeping your buddies alive and in the fight. Equipped with an V-34 carbine, medium armor for massive firepower and mobility, but poor ammo economy and range. Packs a large amount of medical supplies, the squad medic is vital to maintaining combat viability. The V-34 is a modern update of an old weapon that was a common sight during the original Martian rebellion. Very reliable and excellent stopping power in a small, lightweight package. Brought into service as a much cheaper alternative to the VX-32."

	suit_store = /obj/item/weapon/gun/rifle/som_carbine/black/standard

	backpack_contents = list(
		/obj/item/ammo_magazine/rifle/mpi_km/carbine/black = 4,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/explosive/grenade/som = 3,
		/obj/item/reagent_containers/hypospray/autoinjector/oxycodone = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 1,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/rifle/mpi_km/carbine/black = 3,
	)

/datum/outfit/quick/som/medic/standard_smg
	name = "V-21 Medic"
	desc = "Keeping your buddies alive and in the fight. Equipped with a V-21 submachine gun with variable firerate allowing for extreme rates of fire when properly wielded, medium armor and a good selection of grenades. Packs a large amount of medical supplies, the squad medic is vital to maintaining combat viability."

	suit_store = /obj/item/weapon/gun/smg/som/support

	backpack_contents = list(
		/obj/item/ammo_magazine/smg/som = 6,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/explosive/grenade/som = 3,
		/obj/item/reagent_containers/hypospray/autoinjector/oxycodone = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 1,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/smg/som = 3,
	)

/datum/outfit/quick/som/medic/standard_shotgun
	name = "V-51 Medic"
	desc = "Keeping your buddies alive and in the fight. Equipped with a V-51 semi-automatic shotgun, medium armor and a good selection of grenades. Packs a large amount of medical supplies, the squad medic is vital to maintaining combat viability."

	r_pocket = /obj/item/storage/pouch/shotgun/som
	suit_store = /obj/item/weapon/gun/shotgun/som/support

	backpack_contents = list(
		/obj/item/ammo_magazine/handful/flechette = 7,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/explosive/grenade/som = 2,
		/obj/item/reagent_containers/hypospray/autoinjector/oxycodone = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 1,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/handful/flechette = 4,
	)
