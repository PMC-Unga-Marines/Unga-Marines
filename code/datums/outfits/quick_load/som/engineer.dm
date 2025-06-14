//Base SOM engineer outfit
/datum/outfit/quick/som/engineer
	name = "SOM Squad Engineer"
	jobtype = "SOM Squad Engineer"

	ears = /obj/item/radio/headset/distress/som
	w_uniform = /obj/item/clothing/under/som/webbing
	shoes = /obj/item/clothing/shoes/marine/som/knife
	wear_suit = /obj/item/clothing/suit/modular/som/engineer
	gloves = /obj/item/clothing/gloves/marine/som/insulated
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/som/engineer
	glasses = /obj/item/clothing/glasses/meson
	r_pocket = /obj/item/storage/pouch/firstaid/som/combat_patrol
	l_pocket = /obj/item/storage/pouch/tools/som/full
	back = /obj/item/storage/backpack/lightpack/som

	head_contents = list(
		/obj/item/explosive/plastique = 1,
	)

	suit_contents = list(
		/obj/item/circuitboard/apc = 1,
		/obj/item/cell/high = 1,
		/obj/item/stack/sheet/plasteel/medium_stack = 1,
		/obj/item/stack/sheet/metal/large_stack = 1,
		/obj/item/stack/barbed_wire/half_stack = 1,
	)

/datum/outfit/quick/som/engineer/standard_assaultrifle
	name = "V-31 Engineer"
	desc = "Battlefield engineer; building up and tearing down. Equipped with a V-31 assault rifle with integrated 'micro grenade' rail launcher, medium armor, a deployable COPE sentry and a selection of explosives. Has a variety of supplies and equipment to build, repair or apply demolitions in the field. A valuable support asset to a well rounded combat force. The rail launcher fires grenades that must arm mid flight, so are ineffective at close ranges, but add significant tactical options at medium range."

	suit_store = /obj/item/weapon/gun/rifle/som/standard
	belt = /obj/item/storage/belt/marine/som/som_rifle

	backpack_contents = list(
		/obj/item/tool/extinguisher = 1,
		/obj/item/assembly/signaler = 1,
		/obj/item/detpack = 4,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/cope = 1,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/plastique = 2,
	)

	webbing_contents = list(
		/obj/item/ammo_magazine/handful/micro_grenade = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/dragonbreath = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/cluster = 2,
		/obj/item/explosive/grenade/smokebomb/satrapine = 1,
	)

/datum/outfit/quick/som/engineer/mpi
	name = "MPI-KM Engineer"
	desc = "Battlefield engineer; building up and tearing down. Equipped with an MPI_KM assault rifle, medium armor, a deployable COPE sentry and a selection of explosives. Has a variety of supplies and equipment to build, repair or apply demolitions in the field. A valuable support asset to a well rounded combat force. An old weapon that was a common sight during the original Martian rebellion, the MPI's good stopping power, reliability and a healthy dose of nostalgia means it is still seen in use by some among the SOM despite its age."

	suit_store = /obj/item/weapon/gun/rifle/mpi_km/black/magharness
	belt = /obj/item/storage/belt/marine/som/mpi_black

	backpack_contents = list(
		/obj/item/tool/extinguisher = 1,
		/obj/item/assembly/signaler = 1,
		/obj/item/detpack = 4,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/cope = 1,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/plastique = 2,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 3,
		/obj/item/explosive/grenade/smokebomb/som = 1,
		/obj/item/explosive/grenade/smokebomb/satrapine = 1,
	)

/datum/outfit/quick/som/engineer/standard_carbine
	name = "V-34 Engineer"
	desc = "Battlefield engineer; building up and tearing down. Equipped with a V-34 carbine, medium armor, a deployable COPE sentry and a selection of explosives. Has a variety of supplies and equipment to build, repair or apply demolitions in the field. A valuable support asset to a well rounded combat force. The V-34 is a modern update of an old weapon that was a common sight during the original Martian rebellion. Very reliable and excellent stopping power in a small, lightweight package. Brought into service as a much cheaper alternative to the VX-32."

	suit_store = /obj/item/weapon/gun/rifle/som_carbine/black/standard
	belt = /obj/item/storage/belt/marine/som/carbine_black

	backpack_contents = list(
		/obj/item/tool/extinguisher = 1,
		/obj/item/assembly/signaler = 1,
		/obj/item/detpack = 4,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/cope = 1,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/plastique = 2,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 3,
		/obj/item/explosive/grenade/smokebomb/som = 1,
		/obj/item/explosive/grenade/smokebomb/satrapine = 1,
	)

/datum/outfit/quick/som/engineer/standard_smg
	name = "V-21 Engineer"
	desc = "Battlefield engineer; building up and tearing down. Equipped with a V-21 submachine gun with variable firerate allowing for extreme rates of fire when properly wielded, medium armor, a deployable COPE sentry and a selection of explosives. Has a variety of supplies and equipment to build, repair or apply demolitions in the field. A valuable support asset to a well rounded combat force. "

	suit_store = /obj/item/weapon/gun/smg/som/support
	belt = /obj/item/storage/belt/marine/som/som_smg

	backpack_contents = list(
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/assembly/signaler = 1,
		/obj/item/detpack = 3,
		/obj/item/ammo_magazine/smg/som = 2,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/cope = 1,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/plastique = 2,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/smokebomb/som = 2,
		/obj/item/explosive/grenade/flashbang/stun = 1,
		/obj/item/explosive/grenade/som = 1,
		/obj/item/explosive/grenade/smokebomb/satrapine = 1,
	)

/datum/outfit/quick/som/engineer/standard_shotgun
	name = "V-51 Engineer"
	desc = "Battlefield engineer; building up and tearing down. Equipped with a V-51 semi-automatic shotgun, medium armor, a deployable COPE sentry and a selection of explosives. Has a variety of supplies and equipment to build, repair or apply demolitions in the field. A valuable support asset to a well rounded combat force. "

	belt = /obj/item/storage/belt/shotgun/som/flechette
	suit_store = /obj/item/weapon/gun/shotgun/som/support

	backpack_contents = list(
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/assembly/signaler = 1,
		/obj/item/detpack = 3,
		/obj/item/ammo_magazine/handful/buckshot = 2,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/cope = 1,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/plastique = 2,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/smokebomb/som = 2,
		/obj/item/explosive/grenade/flashbang/stun = 1,
		/obj/item/explosive/grenade/som = 1,
		/obj/item/explosive/grenade/smokebomb/satrapine = 1,
	)
