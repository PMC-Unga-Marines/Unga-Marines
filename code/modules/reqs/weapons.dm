/datum/supply_packs/weapons
	group = "Weapons"
	containertype = /obj/structure/closet/crate/weapon

/datum/supply_packs/weapons/sentry
	name = "Турель TUR-B \"Базис\""
	contains = list(
		/obj/item/weapon/gun/sentry/basic,
	)
	cost = 200

/datum/supply_packs/weapons/sentry_upgrade
	name = "Набор для улучшения турели TUR-B"
	contains = list(
		/obj/item/sentry_upgrade_kit,
	)
	cost = 150

/datum/supply_packs/weapons/sentry/ammo
	name = "Магазин для турели TUR-B \"Базис\""
	contains = list(
		/obj/item/ammo_magazine/sentry,
	)
	cost = 50

/datum/supply_packs/weapons/sentry/ammo/mini
	name = "Магазин для турели TUR-M \"Гном\""
	contains = list(
		/obj/item/ammo_magazine/minisentry,
	)

/datum/supply_packs/weapons/sentry/ammo/sniper
	name = "Магазин для турели TUR-SN \"Оса\""
	contains = list(
		/obj/item/ammo_magazine/sentry/sniper,
	)

/datum/supply_packs/weapons/sentry/ammo/shotgun
	name = "Магазин для турели TUR-SH \"Бык\""
	contains = list(
		/obj/item/ammo_magazine/sentry/shotgun,
	)

/datum/supply_packs/weapons/sentry/ammo/flamer
	name = "Бак для турели TUR-F \"Феникс\""
	contains = list(
		/obj/item/ammo_magazine/flamer_tank/large/sentry,
	)

/datum/supply_packs/weapons/buildasentry
	name = "Build-A-Sentry Attachment System"
	contains = list(
		/obj/item/attachable/buildasentry,
	)
	cost = 250


/datum/supply_packs/weapons/m56d_emplacement
	name = "HSG-102 Mounted Heavy Smartgun"
	contains = list(/obj/item/storage/box/hsg102)
	cost = 600

/datum/supply_packs/weapons/m56d
	name = "HSG-102 mounted heavy smartgun ammo"
	contains = list(/obj/item/ammo_magazine/hsg102)
	cost = 30

/datum/supply_packs/weapons/minigun_emplacement
	name = "Mounted Automatic Minigun"
	contains = list(/obj/item/weapon/gun/standard_minigun)
	cost = 600

/datum/supply_packs/weapons/minigun_ammo
	name = "Mounted Minigun ammo"
	contains = list(/obj/item/ammo_magazine/heavy_minigun)
	cost = 30

/datum/supply_packs/weapons/autocannon_emplacement
	name = "ATR-22 Mounted Flak Cannon"
	contains = list(/obj/item/weapon/gun/atr22)
	cost = 700

/datum/supply_packs/weapons/ac_hv
	name = "ATR-22 High-Velocity ammo"
	contains = list(/obj/item/ammo_magazine/atr22)
	cost = 40

/datum/supply_packs/weapons/ac_flak
	name = "ATR-22 Smart-Detonating ammo"
	contains = list(/obj/item/ammo_magazine/atr22/flak)
	cost = 40

/datum/supply_packs/weapons/ags_emplacement
	name = "AGLS-37 Mounted Automated Grenade Launcher"
	contains = list(/obj/item/weapon/gun/agls37)
	cost = 700

/datum/supply_packs/weapons/ags_highexplo
	name = "AGLS-37 AGL High Explosive Grenades"
	contains = list(/obj/item/ammo_magazine/agls37)
	cost = 40

/datum/supply_packs/weapons/ags_frag
	name = "AGLS-37 AGL Fragmentation Grenades"
	contains = list(/obj/item/ammo_magazine/agls37/fragmentation)
	cost = 40

/datum/supply_packs/weapons/ags_incendiary
	name = "AGLS-37 AGL White Phosphorous Grenades"
	contains = list(/obj/item/ammo_magazine/agls37/incendiary)
	cost = 40

/datum/supply_packs/weapons/ags_flare
	name = "AGLS-37 AGL Flare Grenades"
	contains = list(/obj/item/ammo_magazine/agls37/flare)
	cost = 30

/datum/supply_packs/weapons/ags_cloak
	name = "AGLS-37 AGL Cloak Grenades"
	contains = list(/obj/item/ammo_magazine/agls37/cloak)
	cost = 30

/datum/supply_packs/weapons/ags_tanglefoot
	name = "AGLS-37 AGL Tanglefoot Grenades"
	contains = list(/obj/item/ammo_magazine/agls37/tanglefoot)
	cost = 55

/datum/supply_packs/weapons/antitankgun
	name = "AT-36 Anti Tank Gun"
	contains = list(/obj/item/weapon/gun/at36)
	cost = 800

/datum/supply_packs/weapons/antitankgunammo
	name = "AT-36 AP-HE Shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36,
		/obj/item/ammo_magazine/at36,
		/obj/item/ammo_magazine/at36,
	)
	cost = 20

/datum/supply_packs/weapons/antitankgunammo/apcr
	name = "AT-36 APCR Shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/apcr,
		/obj/item/ammo_magazine/at36/apcr,
		/obj/item/ammo_magazine/at36/apcr,
	)
	cost = 20

/datum/supply_packs/weapons/antitankgunammo/he
	name = "AT-36 HE Shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/he,
		/obj/item/ammo_magazine/at36/he,
		/obj/item/ammo_magazine/at36/he,
	)
	cost = 20

/datum/supply_packs/weapons/antitankgunammo/beehive
	name = "AT-36 Beehive Shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/beehive,
		/obj/item/ammo_magazine/at36/beehive,
		/obj/item/ammo_magazine/at36/beehive,
	)
	cost = 20

/datum/supply_packs/weapons/antitankgunammo/incendiary
	name = "AT-36 Napalm Shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/incend,
		/obj/item/ammo_magazine/at36/incend,
		/obj/item/ammo_magazine/at36/incend,
	)
	cost = 20

/datum/supply_packs/weapons/flak_gun
	name = "FK-88 Flak Gun"
	contains = list(/obj/item/weapon/gun/heavy_isg)
	cost = 1200

/datum/supply_packs/weapons/flak_he
	name = "FK-88 HE Shell"
	contains = list(/obj/item/ammo_magazine/heavy_isg/he)
	cost = 100

/datum/supply_packs/weapons/flak_sabot
	name = "FK-88 APFDS Shell"
	contains = list(/obj/item/ammo_magazine/heavy_isg/sabot)
	cost = 120

/datum/supply_packs/weapons/heayvlaser_emplacement
	name = "Mounted Heavy Laser"
	contains = list(/obj/item/weapon/gun/energy/lasgun/lasrifle/heavy_laser/deployable)
	cost = 800


/datum/supply_packs/weapons/heayvlaser_ammo
	name = "Mounted Heavy Laser Ammo (x1)"
	contains = list(/obj/item/cell/lasgun/heavy_laser)
	cost = 15

/datum/supply_packs/weapons/tesla
	name = "Tesla Shock Rifle"
	contains = list(/obj/item/weapon/gun/energy/lasgun/lasrifle/tesla)
	cost = 600

/datum/supply_packs/weapons/tx54
	name = "GL-54 airburst grenade launcher"
	contains = list(/obj/item/weapon/gun/rifle/tx54)
	cost = 300

/datum/supply_packs/weapons/tx54_airburst
	name = "GL-54 airburst grenade magazine"
	contains = list(/obj/item/ammo_magazine/rifle/tx54)
	cost = 20

/datum/supply_packs/weapons/tx54_incendiary
	name = "GL-54 incendiary grenade magazine"
	contains = list(/obj/item/ammo_magazine/rifle/tx54/incendiary)
	cost = 60

/datum/supply_packs/weapons/tx54_smoke
	name = "GL-54 tactical smoke grenade magazine"
	contains = list(/obj/item/ammo_magazine/rifle/tx54/smoke)
	cost = 12

/datum/supply_packs/weapons/tx54_smoke/dense
	name = "GL-54 dense smoke grenade magazine"
	contains = list(/obj/item/ammo_magazine/rifle/tx54/smoke/dense)
	cost = 8

/datum/supply_packs/weapons/tx54_smoke/tangle
	name = "GL-54 tanglefoot grenade magazine"
	contains = list(/obj/item/ammo_magazine/rifle/tx54/smoke/tangle)
	cost = 48

/datum/supply_packs/weapons/tx54_he
	name = "GL-54 HE grenade magazine"
	contains = list(/obj/item/ammo_magazine/rifle/tx54/he)
	cost = 50

/datum/supply_packs/weapons/tx55
	name = "AR-55 OICW Rifle"
	contains = list(/obj/item/weapon/gun/rifle/tx55)
	cost = 525

/datum/supply_packs/weapons/recoillesskit
	name = "RL-160 Recoilless rifle kit"
	contains = list(/obj/item/storage/holster/backholster/rpg/full)
	cost = 400

/datum/supply_packs/weapons/shell_regular
	name = "RL-160 RR HE shell"
	contains = list(/obj/item/ammo_magazine/rocket/recoilless)
	cost = 30

/datum/supply_packs/weapons/shell_le
	name = "RL-160 RR LE shell"
	contains = list(/obj/item/ammo_magazine/rocket/recoilless/light)
	cost = 30

/datum/supply_packs/weapons/shell_heat
	name = "RL-160 HEAT shell"
	contains = list(/obj/item/ammo_magazine/rocket/recoilless/heat)
	cost = 30

/datum/supply_packs/weapons/shell_smoke
	name = "RL-160 RR Smoke shell"
	contains = list(/obj/item/ammo_magazine/rocket/recoilless/smoke)
	cost = 30

/datum/supply_packs/weapons/shell_smoke
	name = "RL-160 RR Cloak shell"
	contains = list(/obj/item/ammo_magazine/rocket/recoilless/cloak)
	cost = 30

/datum/supply_packs/weapons/shell_smoke
	name = "RL-160 RR Tanglefoot shell"
	contains = list(/obj/item/ammo_magazine/rocket/recoilless/plasmaloss)
	cost = 30

/datum/supply_packs/weapons/pepperball
	name = "PB-12 pepperball gun"
	contains = list(/obj/item/weapon/gun/rifle/pepperball)
	cost = 100

/datum/supply_packs/weapons/bricks
	name = "Brick"
	contains = list(/obj/item/weapon/brick)
	cost = 10

/datum/supply_packs/weapons/railgun
	name = "SR-220 Railgun"
	contains = list(/obj/item/weapon/gun/rifle/railgun)
	cost = 400

/datum/supply_packs/weapons/railgun_ammo
	name = "SR-220 Railgun armor piercing discarding sabot round"
	contains = list(/obj/item/ammo_magazine/railgun)
	cost = 50

/datum/supply_packs/weapons/railgun_ammo/hvap
	name = "SR-220 Railgun high velocity armor piercing round"
	contains = list(/obj/item/ammo_magazine/railgun/hvap)
	cost = 50

/datum/supply_packs/weapons/railgun_ammo/smart
	name = "SR-220 Railgun smart armor piercing round"
	contains = list(/obj/item/ammo_magazine/railgun/smart)
	cost = 50

/datum/supply_packs/weapons/tx8
	name = "BR-8 Scout Rifle"
	contains = list(/obj/item/weapon/gun/rifle/tx8)
	cost = 400

/datum/supply_packs/weapons/scout_regular
	name = "BR-8 scout rifle magazine"
	contains = list(/obj/item/ammo_magazine/rifle/tx8)
	cost = 20

/datum/supply_packs/weapons/scout_regular_box
	name = "BR-8 scout rifle ammo box"
	contains = list(/obj/item/ammo_magazine/packet/scout_rifle)
	cost = 50

/datum/supply_packs/weapons/scout_impact
	name = "BR-8 scout rifle impact magazine"
	contains = list(/obj/item/ammo_magazine/rifle/tx8/impact)
	cost = 40

/datum/supply_packs/weapons/scout_incendiary
	name = "Br-8 scout rifle incendiary magazine"
	contains = list(/obj/item/ammo_magazine/rifle/tx8/incendiary)
	cost = 40

/datum/supply_packs/weapons/thermobaric
	name = "RL-57 Thermobaric Launcher"
	contains = list(/obj/item/weapon/gun/launcher/rocket/m57a4/t57)
	cost = 500

/datum/supply_packs/weapons/thermobaric_wp
	name = "RL-57 Thermobaric WP rocket array"
	contains = list(/obj/item/ammo_magazine/rocket/m57a4)
	cost = 50

/datum/supply_packs/weapons/specdemo
	name = "RL-152 SADAR Rocket Launcher"
	contains = list(/obj/item/weapon/gun/launcher/rocket/sadar)
	cost = SADAR_PRICE

/datum/supply_packs/weapons/rpg_regular
	name = "RL-152 SADAR HE rocket"
	contains = list(/obj/item/ammo_magazine/rocket/sadar)
	cost = 50

/datum/supply_packs/weapons/rpg_regular_unguided
	name = "RL-152 SADAR HE rocket (Unguided)"
	contains = list(/obj/item/ammo_magazine/rocket/sadar/unguided)
	cost = 50

/datum/supply_packs/weapons/rpg_ap
	name = "RL-152 SADAR AP rocket"
	contains = list(/obj/item/ammo_magazine/rocket/sadar/ap)
	cost = 60

/datum/supply_packs/weapons/rpg_wp
	name = "RL-152 SADAR WP rocket"
	contains = list(/obj/item/ammo_magazine/rocket/sadar/wp)
	cost = 40

/datum/supply_packs/weapons/rpg_wp_unguided
	name = "RL-152 SADAR WP rocket (Unguided)"
	contains = list(/obj/item/ammo_magazine/rocket/sadar/wp/unguided)
	cost = 40

/datum/supply_packs/weapons/zx76
	name = "ZX-76 Twin-Barrled Burst Shotgun"
	contains = list(/obj/item/weapon/gun/shotgun/zx76)
	cost = 1000

/datum/supply_packs/weapons/shotguntracker
	name = "12 Gauge Tracker Shells"
	contains = list(/obj/item/ammo_magazine/shotgun/tracker)
	cost = 50

/datum/supply_packs/weapons/incendiaryslugs
	name = "Box of Incendiary Slugs"
	contains = list(/obj/item/ammo_magazine/shotgun/incendiary)
	cost = 100

/datum/supply_packs/weapons/sr81
	name = "SR-81 IFF Auto Sniper kit"
	contains = list(/obj/item/weapon/gun/rifle/sr81)
	cost = 500

/datum/supply_packs/weapons/sr81_ammo
	name = "SR-81 IFF sniper magazine"
	contains = list(/obj/item/ammo_magazine/rifle/sr81)
	cost = 30

/datum/supply_packs/weapons/sr81_packet
	name = "SR-81 IFF sniper ammo box"
	contains = list(/obj/item/ammo_magazine/packet/sr81)
	cost = 50

/datum/supply_packs/weapons/antimaterial
	name = "SR-26 Antimaterial rifle (AMR) kit"
	contains = list(/obj/item/weapon/gun/rifle/sniper/antimaterial)
	cost = 775

/datum/supply_packs/weapons/antimaterial_ammo
	name = "SR-26 AMR magazine"
	contains = list(/obj/item/ammo_magazine/sniper)
	cost = 30

/datum/supply_packs/weapons/antimaterial_incend_ammo
	name = "SR-26 AMR incendiary magazine"
	contains = list(/obj/item/ammo_magazine/sniper/incendiary)
	cost = 50

/datum/supply_packs/weapons/antimaterial_flak_ammo
	name = "SR-26 AMR flak magazine"
	contains = list(/obj/item/ammo_magazine/sniper/flak)
	cost = 40

/datum/supply_packs/weapons/specminigun
	name = "MG-100 Vindicator Minigun"
	contains = list(/obj/item/weapon/gun/minigun)
	cost = MINIGUN_PRICE

/datum/supply_packs/weapons/minigun
	name = "MG-100 Vindicator Minigun Powerpack"
	contains = list(/obj/item/ammo_magazine/minigun_powerpack)
	cost = 50

/datum/supply_packs/weapons/mg27
	name = "MG-27 Medium Machinegun"
	contains = list(/obj/item/weapon/gun/mg27)
	cost = 100

/datum/supply_packs/weapons/hmg08
	name = "HMG-08 heavy machinegun"
	contains = list(/obj/item/weapon/gun/hmg08)
	cost = 400

/datum/supply_packs/weapons/hmg08_ammo
	name = "HMG-08 heavy machinegun ammo (500 rounds)"
	contains = list(/obj/item/ammo_magazine/hmg08)
	cost = 70

/datum/supply_packs/weapons/hmg08_ammo_small
	name = "HMG-08 heavy machinegun ammo (250 rounds)"
	contains = list(/obj/item/ammo_magazine/hmg08/small)
	cost = 40

/datum/supply_packs/weapons/sg29
	name = "SG-29 smart machine gun"
	contains = list(/obj/item/weapon/gun/rifle/sg29)
	cost = 400

/datum/supply_packs/weapons/sg29_ammo
	name = "SG-29 ammo drum"
	contains = list(/obj/item/ammo_magazine/sg29)
	cost = 50

/datum/supply_packs/weapons/smart_minigun
	name = "SG-85 smart gatling gun"
	contains = list(/obj/item/weapon/gun/minigun/smart_minigun)
	cost = 400

/datum/supply_packs/weapons/smart_minigun_ammo
	name = "SG-85 ammo bin"
	contains = list(/obj/item/ammo_magazine/packet/smart_minigun)
	cost = 50

/datum/supply_packs/weapons/sg62
	name = "SG-62 Smart Target Rifle"
	contains = list(/obj/item/weapon/gun/rifle/sg62)
	cost = 400

/datum/supply_packs/weapons/sg62_ammo
	name = "SG-62 smart target rifle ammo"
	contains = list(/obj/item/ammo_magazine/rifle/sg62)
	cost = 35

/datum/supply_packs/weapons/sg153_ammo
	name = "SG-153 spotting rifle ammo"
	contains = list(/obj/item/ammo_magazine/rifle/sg153)
	cost = 15

/datum/supply_packs/weapons/sg153_ammo/highimpact
	name = "SG-153 high impact spotting rifle ammo"
	contains = list(/obj/item/ammo_magazine/rifle/sg153/highimpact)

/datum/supply_packs/weapons/sg153_ammo/heavyrubber
	name = "SG-153 heavy rubber spotting rifle ammo"
	contains = list(/obj/item/ammo_magazine/rifle/sg153/heavyrubber)

/datum/supply_packs/weapons/sg153_ammo/plasmaloss
	name = "SG-153 tanglefoot spotting rifle ammo"
	contains = list(/obj/item/ammo_magazine/rifle/sg153/plasmaloss)

/datum/supply_packs/weapons/sg153_ammo/tungsten
	name = "SG-153 tungsten spotting rifle ammo"
	contains = list(/obj/item/ammo_magazine/rifle/sg153/tungsten)

/datum/supply_packs/weapons/sg153_ammo/flak
	name = "SG-153 flak spotting rifle ammo"
	contains = list(/obj/item/ammo_magazine/rifle/sg153/flak)

/datum/supply_packs/weapons/sg153_ammo/incendiary
	name = "SG-153 incendiary spotting rifle ammo"
	contains = list(/obj/item/ammo_magazine/rifle/sg153/incendiary)

/datum/supply_packs/weapons/flamethrower
	name = "FL-84 Flamethrower"
	contains = list(/obj/item/weapon/gun/flamer/big_flamer/marinestandard)
	cost = 150

/datum/supply_packs/weapons/napalm
	name = "FL-84 normal fuel tank"
	contains = list(/obj/item/ammo_magazine/flamer_tank/large)
	cost = 60

/datum/supply_packs/weapons/napalm_G
	name = "FL-84 G fuel tank"
	contains = list(/obj/item/ammo_magazine/flamer_tank/large/G)
	cost = 75

/datum/supply_packs/weapons/napalm_X
	name = "FL-84 X fuel tank"
	contains = list(/obj/item/ammo_magazine/flamer_tank/large/X)
	cost = 300

/datum/supply_packs/weapons/back_fuel_tank
	name = "Standard back fuel tank"
	contains = list(/obj/item/ammo_magazine/flamer_tank/backtank)
	cost = 200

/datum/supply_packs/weapons/back_fuel_tank_g
	name = "Type G fuel tank"
	contains = list(/obj/item/ammo_magazine/flamer_tank/backtank/G)
	cost = 150

/datum/supply_packs/weapons/back_fuel_tank_x
	name = "Type X back fuel tank"
	contains = list(/obj/item/ammo_magazine/flamer_tank/backtank/X)
	cost = 600

/datum/supply_packs/weapons/mini_fuel_tank_g
	name = "Type G  mini fuel tank"
	contains = list(/obj/item/ammo_magazine/flamer_tank/mini/G)
	cost = 5

/datum/supply_packs/weapons/mini_fuel_tank_x
	name = "Type X back mini fuel tank"
	contains = list(/obj/item/ammo_magazine/flamer_tank/mini/X)
	cost = 20

/datum/supply_packs/weapons/fueltank_g
	name = "G-fuel tank"
	contains = list(/obj/structure/reagent_dispensers/fueltank/gfuel)
	cost = 150
	containertype = null

/datum/supply_packs/weapons/fueltank
	name = "X-fuel tank"
	contains = list(/obj/structure/reagent_dispensers/fueltank/xfuel)
	cost = 600
	containertype = null

/datum/supply_packs/weapons/rpgoneuse
	name = "RL-72 Disposable RPG"
	contains = list(/obj/item/weapon/gun/launcher/rocket/oneuse)
	cost = 100

/datum/supply_packs/weapons/mateba
	name = "Mateba Autorevolver belt"
	contains = list(/obj/item/storage/holster/belt/revolver/mateba/full)
	notes = "Contains 6 speedloaders"
	cost = 150

/datum/supply_packs/weapons/mateba_ammo
	name = "Mateba magazine"
	contains = list(/obj/item/ammo_magazine/revolver/mateba)
	cost = 30

/datum/supply_packs/weapons/mateba_packet
	name = "Mateba packet"
	contains = list(/obj/item/ammo_magazine/packet/mateba)
	cost = 120

/datum/supply_packs/weapons/standard_ammo
	name = "Surplus Standard Ammo Crate"
	notes = "Contains 22 ammo boxes of a wide variety which come prefilled. You lazy bum."
	contains = list(/obj/structure/largecrate/supply/ammo/standard_ammo)
	containertype = null
	cost = 200

/datum/supply_packs/weapons/sr127_flak
	name = "SR-127 Flak Magazine"
	contains = list(/obj/item/ammo_magazine/rifle/sr127/flak)
	cost = 50

/datum/supply_packs/weapons/rechargemag
	name = "Terra Experimental recharger battery"
	contains = list(/obj/item/cell/lasgun/lasrifle/recharger)
	cost = 60

/datum/supply_packs/weapons/xray_gun
	name = "TE-X Laser Rifle"
	contains = list(/obj/item/weapon/gun/energy/lasgun/lasrifle/xray)
	cost = 400

/datum/supply_packs/weapons/rocketsledge
	name = "Rocket Sledge"
	contains = list(/obj/item/weapon/twohanded/rocketsledge)
	cost = 600

/datum/supply_packs/weapons/smart_pistol
	name = "TX13 smartpistol"
	contains = list(/obj/item/weapon/gun/pistol/smart_pistol)
	cost = 150

/datum/supply_packs/weapons/smart_pistol_ammo
	name = "TX13 smartpistol ammo"
	contains = list(/obj/item/ammo_magazine/pistol/p14/smart_pistol)
	cost = 10

/datum/supply_packs/weapons/vector_incendiary
	name = "vector incendiary magazine"
	contains = list(/obj/item/ammo_magazine/smg/vector/incendiary)
	cost = 20 //40 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/valihalberd
	name = "VAL-HAL-A"
	contains = list(/obj/item/weapon/twohanded/glaive/halberd/harvester)
	cost = 600

/datum/supply_packs/weapons/t500case
	name = "R-500 bundle"
	contains = list(/obj/item/storage/box/t500case)
	cost = 50

/datum/supply_packs/weapons/ar12_incendiary
	name = "AR-12 incendiary magazine"
	contains = list(/obj/item/ammo_magazine/rifle/ar12/incendiary)
	cost = 30 //50 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/zarya_extended_mag
	name = "Type-16 extended magazine"
	contains = list(/obj/item/ammo_magazine/rifle/zarya/extended)
	cost = 15
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/smg25_ap
	name = "SMG-25 armor piercing magazine"
	contains = list(/obj/item/ammo_magazine/smg/m25/ap)
	cost = 30 //60 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/box_10x24mm_incendiary
	name = "10x24mm incendiary ammo box"
	contains = list(/obj/item/ammo_magazine/packet/p10x24mm/incendiary)
	cost = 45 //150 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/rifle/t25
	name = "T25 smartrifle"
	contains = list(/obj/item/weapon/gun/rifle/t25)
	cost = 400

/datum/supply_packs/weapons/ammo_magazine/rifle/t25
	name = "T25 smartrifle magazine"
	contains = list(/obj/item/ammo_magazine/rifle/t25)
	cost = 20

/datum/supply_packs/weapons/t25_extended_mag
	name = "T25 extended magazine"
	contains = list(/obj/item/ammo_magazine/rifle/t25/extended)
	cost = 200
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/ammo_magazine/packet/t25
	name = "T25 smartrifle ammo box"
	contains = list(/obj/item/ammo_magazine/packet/t25)
	cost = 60

/datum/supply_packs/weapons/box_10x25mm_incendiary
	name = "10x25mm incendiary ammo box"
	contains = list(/obj/item/ammo_magazine/packet/p10x25mm/incendiary)
	cost = 50 //125 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/p9mm_incendiary
	name = "9mm incendiary packet"
	contains = list(/obj/item/ammo_magazine/packet/p9mm/incendiary)
	cost = 30 //70 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/box_10x265mm_ap
	name = "10x26.5mm armor piercing ammo box"
	contains = list(/obj/item/ammo_magazine/packet/p10x265mm/ap)
	cost = 60 //100 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/box_10x20mm_ap
	name = "10x20mm armor piercing ammo box"
	contains = list(/obj/item/ammo_magazine/packet/p10x20mm/ap)
	cost = 50 //150 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/thermobaric
	name = "RL-57 Thermobaric Launcher Kit"
	contains = list(/obj/item/storage/holster/backholster/rlquad/full)
	cost = 500 + 50 //ammo price

/datum/supply_packs/weapons/specdemo
	name = "RL-152 SADAR Rocket Launcher kit"
	contains = list(/obj/item/storage/holster/backholster/rlsadar/full)
	cost = SADAR_PRICE + 150 //ammo price

/datum/supply_packs/weapons/minigun_powerpack
	name = "SG-85 Minigun Powerpack"
	contains = list(/obj/item/ammo_magazine/minigun_powerpack/smartgun)
	cost = 150

/datum/supply_packs/weapons/box_10x27mm
	name = "SG-62 smart target rifle ammo box"
	contains = list(/obj/item/ammo_magazine/packet/sg62)
	cost = 50

/datum/supply_packs/weapons/xray_gun
	contains = list(/obj/item/weapon/gun/energy/lasgun/lasrifle/xray)
	cost = 500

/datum/supply_packs/weapons/singleshot_launcher
	name = "GL-81 grenade launcher"
	contains = list(/obj/item/weapon/gun/grenade_launcher/single_shot)
	cost = 150

/datum/supply_packs/weapons/multinade_launcher
	name = "GL-70 grenade launcher"
	contains = list(/obj/item/weapon/gun/grenade_launcher/multinade_launcher/unloaded)
	cost = 450

/datum/supply_packs/weapons/ltb_shells
	name = "LTB tank shell"
	contains = list(/obj/item/ammo_magazine/tank/ltb_cannon)
	cost = 10

/datum/supply_packs/weapons/ltb_shells_apfds
	name = "LTB tank APFDS shell"
	contains = list(/obj/item/ammo_magazine/tank/ltb_cannon/apfds)
	cost = 10

/datum/supply_packs/weapons/ltaap_rounds
	name = "LTAAP tank magazine"
	contains = list(/obj/item/ammo_magazine/tank/ltaap_chaingun)
	cost = 10

/datum/supply_packs/weapons/cupola_rounds
	name = "Cupola tank magazine"
	contains = list(/obj/item/ammo_magazine/tank/secondary_cupola)
	cost = 10

/datum/supply_packs/weapons/secondary_flamer_tank
	name = "Spray flamer tank"
	contains = list(/obj/item/ammo_magazine/tank/secondary_flamer_tank)
	cost = 10
