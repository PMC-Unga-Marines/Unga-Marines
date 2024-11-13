/datum/supply_packs/operations
	group = "Operations"
	containertype = /obj/structure/closet/crate/operations

/datum/supply_packs/operations/standard_ammo
	name = "Surplus Standard Ammo Crate"
	notes = "Contains 22 ammo boxes of a wide variety which come prefilled. You lazy bum."
	contains = list(/obj/structure/largecrate/supply/ammo/standard_ammo)
	containertype = null
	cost = 200

/datum/supply_packs/operations/beacons_supply
	name = "Supply beacon"
	contains = list(/obj/item/beacon/supply_beacon)
	cost = 100

/datum/supply_packs/operations/beacons_orbital
	name = "orbital beacon"
	contains = list(/obj/item/beacon/orbital_bombardment_beacon)
	cost = 30

/datum/supply_packs/operations/fulton_extraction_pack
	name = "Fulton extraction pack"
	contains = list(/obj/item/fulton_extraction_pack)
	cost = 50

/datum/supply_packs/operations/autominer
	name = "Autominer upgrade"
	contains = list(/obj/item/minerupgrade/automatic)
	cost = 50

/datum/supply_packs/operations/miningwelloverclock
	name = "Mining well reinforcement upgrade"
	contains = list(/obj/item/minerupgrade/reinforcement)
	cost = 50

/datum/supply_packs/operations/miningwellresistance
	name = "Mining well overclock upgrade"
	contains = list(/obj/item/minerupgrade/overclock)
	cost = 50

/datum/supply_packs/operations/binoculars_tatical
	name = "Tactical binoculars crate"
	contains = list(
		/obj/item/binoculars/tactical,
		/obj/item/encryptionkey/cas,
	)
	cost = 300

/datum/supply_packs/operations/pinpointer
	name = "Xeno structure tracker crate"
	contains = list(/obj/item/pinpointer)
	cost = 200

/datum/supply_packs/operations/xeno_iff_tag
	name = "Xenomorph IFF tag crate" //Intended for corrupted or friendly rounies as rounds sometimes turn out. Avoid abuse or I'll have to admin-only it, which is no fun!
	notes = "Contains an IFF tag used to mark a xenomorph as friendly to IFF systems. Warning: Nanotrasen is not responsible for incidents related to attaching this to hostile entities."
	contains = list(/obj/item/xeno_iff_tag)
	access = ACCESS_MARINE_BRIDGE //Better be safe.
	cost = 130

/datum/supply_packs/operations/deployable_camera
	name = "3 Deployable Cameras"
	contains = list(
		/obj/item/deployable_camera,
		/obj/item/deployable_camera,
		/obj/item/deployable_camera,
	)
	cost = 20

/datum/supply_packs/operations/exportpad
	name = "ASRS Bluespace Export Point"
	contains = list(/obj/machinery/exportpad)
	cost = 300

/datum/supply_packs/operations/warhead_cluster
	name = "Cluster orbital warhead"
	contains = list(/obj/structure/ob_ammo/warhead/cluster)
	cost = 200
	access = ACCESS_MARINE_ENGINEERING
	containertype = /obj/structure/closet/crate/secure/explosives

/datum/supply_packs/operations/warhead_explosive
	name = "HE orbital warhead"
	contains = list(/obj/structure/ob_ammo/warhead/explosive)
	cost = 300
	access = ACCESS_MARINE_ENGINEERING
	containertype = /obj/structure/closet/crate/secure/explosives

/datum/supply_packs/operations/warhead_incendiary
	name = "Incendiary orbital warhead"
	contains = list(/obj/structure/ob_ammo/warhead/incendiary)
	cost = 200
	access = ACCESS_MARINE_ENGINEERING
	containertype = /obj/structure/closet/crate/secure/explosives

/datum/supply_packs/operations/warhead_plasmaloss
	name = "Plasma draining orbital warhead"
	contains = list(/obj/structure/ob_ammo/warhead/plasmaloss)
	cost = 150
	access = ACCESS_MARINE_ENGINEERING
	containertype = /obj/structure/closet/crate/secure/explosives

/datum/supply_packs/operations/ob_fuel
	name = "Solid fuel"
	contains = list(/obj/structure/ob_ammo/ob_fuel)
	cost = 50
	access = ACCESS_MARINE_ENGINEERING
	containertype = /obj/structure/closet/crate/secure/explosives

/datum/supply_packs/operations/droppod
	name = "drop pod"
	contains = list(/obj/structure/droppod)
	containertype = null
	cost = 50

/datum/supply_packs/operations/droppod_leader
	name = "leader drop pod"
	contains = list(/obj/structure/droppod/leader)
	containertype = null
	cost = 100

/datum/supply_packs/operations/researchcomp
	name = "Research console"
	contains = list(/obj/machinery/researchcomp)
	containertype = null
	cost = 200
