/datum/supply_packs/personal/engineer
	job_type = /datum/job/terragov/squad/engineer
	containertype = /obj/structure/closet/crate/supply

/datum/supply_packs/personal/engineer/sandbags
	name = "50 empty sandbags"
	contains = list(/obj/item/stack/sandbags_empty/full)
	cost = 3

/datum/supply_packs/personal/engineer/metal50
	name = "50 metal sheets"
	contains = list(/obj/item/stack/sheet/metal/large_stack)
	cost = 5

/datum/supply_packs/personal/engineer/plas50
	name = "50 plasteel sheets"
	contains = list(/obj/item/stack/sheet/plasteel/large_stack)
	cost = 10

/datum/supply_packs/personal/engineer/handheld_charger
	name = "Handheld charger"
	contains = list(/obj/item/tool/handheld_charger)
	cost = 2

/datum/supply_packs/personal/engineer/plasmacutter
	name = "Plasma cutter"
	contains = list(/obj/item/tool/pickaxe/plasmacutter/)
	cost = 8

/datum/supply_packs/personal/engineer/quikdeploycade
	name = "Quikdeploy barricade"
	contains = list(/obj/item/quikdeploy/cade)
	cost = 1

/datum/supply_packs/personal/engineer/foam_grenade
	name = "Foam grenade"
	contains = list(/obj/item/explosive/grenade/chem_grenade/metalfoam)
	cost = 1

/datum/supply_packs/personal/engineer/floodlight
	name = "Deployable floodlight"
	contains = list(/obj/item/deployable_floodlight)
	cost = 1

/datum/supply_packs/personal/engineer/advanced_generator
	name = "Wireless power generator"
	contains = list(/obj/machinery/power/port_gen/pacman/mobile_power)
	cost = 5

/datum/supply_packs/personal/engineer/teleporter
	name = "Teleporter pads"
	contains = list(/obj/effect/teleporter_linker)
	cost = 13

/datum/supply_packs/personal/engineer/tesla_turret
	name = "Tesla turret"
	contains = list(/obj/item/tesla_turret)
	cost = 8

/datum/supply_packs/personal/engineer/explosives_mines
	name = "Claymore mines"
	notes = "Contains 5 mines"
	contains = list(/obj/item/storage/box/explosive_mines)
	cost = 4

/datum/supply_packs/personal/engineer/explosives_minelayer
	name = "M21 APRDS \"Minelayer\""
	contains = list(/obj/item/minelayer)
	cost = 1

/datum/supply_packs/personal/engineer/explosives_razor
	name = "Razorburn grenade box"
	notes = "Contains 15 razor burns"
	contains = list(/obj/item/storage/box/visual/grenade/razorburn)
	cost = 13

/datum/supply_packs/personal/engineer/plastique_incendiary
	name = "EX-62 Genghis incendiary charge"
	contains = list(/obj/item/explosive/plastique/genghis_charge)
	cost = 4

/datum/supply_packs/personal/engineer/detpack
	name = "Detpack explosive"
	contains = list(/obj/item/detpack)
	cost = 2

/datum/supply_packs/personal/engineer/autominer
	name = "Autominer upgrade"
	contains = list(/obj/item/minerupgrade/automatic)
	cost = 2

/datum/supply_packs/personal/engineer/miningwelloverclock
	name = "Mining well reinforcement upgrade"
	contains = list(/obj/item/minerupgrade/reinforcement)
	cost = 2

/datum/supply_packs/personal/engineer/miningwellresistance
	name = "Mining well overclock upgrade"
	contains = list(/obj/item/minerupgrade/overclock)
	cost = 2

/datum/supply_packs/personal/engineer/sentry
	name = "Турель TUR-B \"Базис\""
	contains = list(/obj/item/weapon/gun/sentry/basic)
	cost = 10

/datum/supply_packs/personal/engineer/sentry_upgrade
	name = "Набор для улучшения турели TUR-B"
	contains = list(/obj/item/sentry_upgrade_kit,)
	cost = 5

/datum/supply_packs/personal/engineer/sentry_ammo
	name = "Магазин для турели TUR-B \"Базис\""
	contains = list(/obj/item/ammo_magazine/sentry)
	cost = 2

/datum/supply_packs/personal/engineer/ammo_mini
	name = "Магазин для турели TUR-M \"Гном\""
	contains = list(/obj/item/ammo_magazine/minisentry)

/datum/supply_packs/personal/engineer/ammo_sniper
	name = "Магазин для турели TUR-SN \"Оса\""
	contains = list(/obj/item/ammo_magazine/sentry/sniper)

/datum/supply_packs/personal/engineer/ammo_shotgun
	name = "Магазин для турели TUR-SH \"Бык\""
	contains = list(/obj/item/ammo_magazine/sentry/shotgun)

/datum/supply_packs/personal/engineer/ammo_flamer
	name = "Бак для турели TUR-F \"Феникс\""
	contains = list(/obj/item/ammo_magazine/flamer_tank/large/sentry)

/datum/supply_packs/personal/engineer/buildasentry
	name = "Build-A-Sentry attachment system"
	contains = list(/obj/item/attachable/buildasentry)
	cost = 250