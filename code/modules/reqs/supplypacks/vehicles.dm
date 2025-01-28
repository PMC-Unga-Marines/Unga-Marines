/datum/supply_packs/vehicles
	group = "Vehicles"

/datum/supply_packs/vehicles/ltb_shells
	name = "LTB tank shell"
	contains = list(/obj/item/ammo_magazine/tank/ltb_cannon)
	cost = 10
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/ltb_shells_apfds
	name = "LTB tank APFDS shell"
	contains = list(/obj/item/ammo_magazine/tank/ltb_cannon/apfds)
	cost = 10
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/ltaap_rounds
	name = "LTAAP tank magazine"
	contains = list(/obj/item/ammo_magazine/tank/ltaap_chaingun)
	cost = 10
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/cupola_rounds
	name = "Cupola tank magazine"
	contains = list(/obj/item/ammo_magazine/tank/secondary_cupola)
	cost = 10
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/secondary_flamer_tank
	name = "Spray flamer tank"
	contains = list(/obj/item/ammo_magazine/tank/secondary_flamer_tank)
	cost = 10
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/tank_glauncher
	name = "Tank grenade laucnher magazine"
	contains = list(/obj/item/ammo_magazine/tank/tank_glauncher)
	cost = 10
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/motorbike
	name = "All-Terrain Motorbike"
	cost = 400
	contains = list(/obj/vehicle/ridden/motorbike)

/datum/supply_packs/vehicles/sidecar
	name = "Sidecar motorbike upgrade"
	cost = 200
	contains = list(/obj/item/sidecar)

/datum/supply_packs/vehicles/jerrycan
	name = "Jerry Can"
	cost = 100
	contains = list(/obj/item/reagent_containers/jerrycan)

/datum/supply_packs/vehicles/droid_combat
	name = "Combat droid with weapon equipped"
	contains = list(/obj/vehicle/unmanned/droid)
	cost = 400

/datum/supply_packs/vehicles/droid_scout
	name = "Scout droid"
	contains = list(/obj/vehicle/unmanned/droid/scout)
	cost = 300

/datum/supply_packs/vehicles/droid_powerloader
	name = "Powerloader droid"
	contains = list(/obj/vehicle/unmanned/droid/ripley)
	cost = 300

/datum/supply_packs/vehicles/droid_weapon
	name = "Droid weapon"
	contains = list(/obj/item/uav_turret/droid)
	cost = 200
	containertype = /obj/structure/closet/crate/weapon

/datum/supply_packs/vehicles/light_uv
	name = "Light unmanned vehicle - Iguana"
	contains = list(/obj/vehicle/unmanned)
	cost = 300

/datum/supply_packs/vehicles/medium_uv
	name = "Medium unmanned vehicle - Gecko"
	contains = list(/obj/vehicle/unmanned/medium)
	cost = 500

/datum/supply_packs/vehicles/heavy_uv
	name = "Heavy unmanned vehicle - Komodo"
	contains = list(/obj/vehicle/unmanned/heavy)
	cost = 700

/datum/supply_packs/vehicles/uv_light_weapon
	name = "Light UV weapon"
	contains = list(/obj/item/uav_turret)
	cost = 200
	containertype = /obj/structure/closet/crate/weapon

/datum/supply_packs/vehicles/uv_heavy_weapon
	name = "Heavy UV weapon"
	contains = list(/obj/item/uav_turret/heavy)
	cost = 200
	containertype = /obj/structure/closet/crate/weapon

/datum/supply_packs/vehicles/uv_light_ammo
	name = "Light UV ammo - 11x35mm"
	contains = list(/obj/item/ammo_magazine/box11x35mm)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/uv_heavy_ammo
	name = "Heavy UV ammo - 12x40mm"
	contains = list(/obj/item/ammo_magazine/box12x40mm)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/vehicle_remote
	name = "Vehicle remote"
	contains = list(/obj/item/unmanned_vehicle_remote)
	cost = 10
	containertype = /obj/structure/closet/crate

/datum/supply_packs/vehicles/mounted_hsg
	name = "Mounted HSG"
	contains = list(/obj/structure/dropship_equipment/shuttle/weapon_holder/machinegun)
	cost = 500

/datum/supply_packs/vehicles/minigun_nest
	name = "Mounted Minigun"
	contains = list(/obj/structure/dropship_equipment/shuttle/weapon_holder/minigun)
	cost = 750

/datum/supply_packs/vehicles/mounted_heavy_laser
	name = "Mounted Heavy Laser"
	contains = list(/obj/structure/dropship_equipment/shuttle/weapon_holder/heavylaser)
	cost = 900

/datum/supply_packs/vehicles/hsg_ammo
	name = "Mounted HSG ammo"
	contains = list(/obj/item/ammo_magazine/hsg102/hsg_nest)
	cost = 100
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/minigun_ammo
	name = "Mounted Minigun ammo"
	contains = list(/obj/item/ammo_magazine/heavy_minigun)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/hl_ammo
	name = "Mounted Heavy Laser ammo (x3)"
	contains = list(/obj/item/cell/lasgun/heavy_laser, /obj/item/cell/lasgun/heavy_laser, /obj/item/cell/lasgun/heavy_laser)
	cost = 50
	containertype = /obj/structure/closet/crate/ammo
