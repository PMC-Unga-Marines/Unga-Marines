/datum/supply_packs/stationary
	group = "Stationary"
	containertype = /obj/structure/closet/crate/mounted

/datum/supply_packs/stationary/sentry
	name = "Турель TUR-B \"Базис\""
	contains = list(
		/obj/item/weapon/gun/sentry/basic,
	)
	cost = 200

/datum/supply_packs/stationary/sentry_upgrade
	name = "Набор для улучшения турели TUR-B"
	contains = list(
		/obj/item/sentry_upgrade_kit,
	)
	cost = 150

/datum/supply_packs/stationary/sentry/ammo
	name = "Магазин для турели TUR-B \"Базис\""
	contains = list(
		/obj/item/ammo_magazine/sentry,
	)
	cost = 50

/datum/supply_packs/stationary/sentry/ammo/mini
	name = "Магазин для турели TUR-M \"Гном\""
	contains = list(
		/obj/item/ammo_magazine/minisentry,
	)

/datum/supply_packs/stationary/sentry/ammo/sniper
	name = "Магазин для турели TUR-SN \"Оса\""
	contains = list(
		/obj/item/ammo_magazine/sentry/sniper,
	)

/datum/supply_packs/stationary/sentry/ammo/shotgun
	name = "Магазин для турели TUR-SH \"Бык\""
	contains = list(
		/obj/item/ammo_magazine/sentry/shotgun,
	)

/datum/supply_packs/stationary/sentry/ammo/flamer
	name = "Бак для турели TUR-F \"Феникс\""
	contains = list(
		/obj/item/ammo_magazine/flamer_tank/large/sentry,
	)

/datum/supply_packs/stationary/buildasentry
	name = "Build-A-Sentry Attachment System"
	contains = list(
		/obj/item/attachable/buildasentry,
	)
	cost = 250

/datum/supply_packs/stationary/m56d_emplacement
	name = "HSG-102 Mounted Heavy Smartgun"
	contains = list(/obj/item/storage/box/hsg102)
	cost = 600

/datum/supply_packs/stationary/m56d
	name = "HSG-102 mounted heavy smartgun ammo"
	contains = list(/obj/item/ammo_magazine/hsg102)
	cost = 30

/datum/supply_packs/stationary/minigun_emplacement
	name = "Mounted Automatic Minigun"
	contains = list(/obj/item/weapon/gun/standard_minigun)
	cost = 600

/datum/supply_packs/stationary/minigun_ammo
	name = "Mounted Minigun ammo"
	contains = list(/obj/item/ammo_magazine/heavy_minigun)
	cost = 30

/datum/supply_packs/stationary/autocannon_emplacement
	name = "ATR-22 Mounted Flak Cannon"
	contains = list(/obj/item/weapon/gun/atr22)
	cost = 700

/datum/supply_packs/stationary/ac_hv
	name = "ATR-22 High-Velocity ammo"
	contains = list(/obj/item/ammo_magazine/atr22)
	cost = 40

/datum/supply_packs/stationary/ac_flak
	name = "ATR-22 Smart-Detonating ammo"
	contains = list(/obj/item/ammo_magazine/atr22/flak)
	cost = 40

/datum/supply_packs/stationary/ags_emplacement
	name = "AGLS-37 Mounted Automated Grenade Launcher"
	contains = list(/obj/item/weapon/gun/agls37)
	cost = 300

/datum/supply_packs/stationary/ags_highexplo
	name = "AGLS-37 AGL High Explosive Grenades"
	contains = list(/obj/item/ammo_magazine/agls37)
	cost = 65

/datum/supply_packs/stationary/ags_frag
	name = "AGLS-37 AGL Fragmentation Grenades"
	contains = list(/obj/item/ammo_magazine/agls37/fragmentation)
	cost = 55

/datum/supply_packs/stationary/ags_incendiary
	name = "AGLS-37 AGL White Phosphorous Grenades"
	contains = list(/obj/item/ammo_magazine/agls37/incendiary)
	cost = 55

/datum/supply_packs/stationary/ags_flare
	name = "AGLS-37 AGL Flare Grenades"
	contains = list(/obj/item/ammo_magazine/agls37/flare)
	cost = 35

/datum/supply_packs/stationary/ags_cloak
	name = "AGLS-37 AGL Cloak Grenades"
	contains = list(/obj/item/ammo_magazine/agls37/cloak)
	cost = 45

/datum/supply_packs/stationary/ags_tanglefoot
	name = "AGLS-37 AGL Tanglefoot Grenades"
	contains = list(/obj/item/ammo_magazine/agls37/tanglefoot)
	cost = 85

/datum/supply_packs/stationary/antitankgun
	name = "AT-36 Anti Tank Gun"
	contains = list(/obj/item/weapon/gun/at36)
	cost = 800

/datum/supply_packs/stationary/antitankgunammo
	name = "AT-36 AP-HE Shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36,
		/obj/item/ammo_magazine/at36,
		/obj/item/ammo_magazine/at36,
	)
	cost = 20

/datum/supply_packs/stationary/antitankgunammo/apcr
	name = "AT-36 APCR Shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/apcr,
		/obj/item/ammo_magazine/at36/apcr,
		/obj/item/ammo_magazine/at36/apcr,
	)
	cost = 20

/datum/supply_packs/stationary/antitankgunammo/he
	name = "AT-36 HE Shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/he,
		/obj/item/ammo_magazine/at36/he,
		/obj/item/ammo_magazine/at36/he,
	)
	cost = 20

/datum/supply_packs/stationary/antitankgunammo/beehive
	name = "AT-36 Beehive Shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/beehive,
		/obj/item/ammo_magazine/at36/beehive,
		/obj/item/ammo_magazine/at36/beehive,
	)
	cost = 20

/datum/supply_packs/stationary/antitankgunammo/incendiary
	name = "AT-36 Napalm Shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/incend,
		/obj/item/ammo_magazine/at36/incend,
		/obj/item/ammo_magazine/at36/incend,
	)
	cost = 20

/datum/supply_packs/stationary/flak_gun
	name = "FK-88 Flak Gun"
	contains = list(/obj/item/weapon/gun/heavy_isg)
	cost = 1200

/datum/supply_packs/stationary/flak_he
	name = "FK-88 HE Shell"
	contains = list(/obj/item/ammo_magazine/heavy_isg/he)
	cost = 100

/datum/supply_packs/stationary/flak_sabot
	name = "FK-88 APFDS Shell"
	contains = list(/obj/item/ammo_magazine/heavy_isg/sabot)
	cost = 120

/datum/supply_packs/stationary/heayvlaser_emplacement
	name = "Mounted Heavy Laser"
	contains = list(/obj/item/weapon/gun/energy/lasgun/lasrifle/heavy_laser/deployable)
	cost = 800

/datum/supply_packs/stationary/heayvlaser_ammo
	name = "Mounted Heavy Laser Ammo (x1)"
	contains = list(/obj/item/cell/lasgun/heavy_laser)
	cost = 15

/datum/supply_packs/stationary/mg27
	name = "MG-27 Medium Machinegun"
	contains = list(/obj/item/weapon/gun/mg27)
	cost = 100

/datum/supply_packs/stationary/hmg08
	name = "HMG-08 heavy machinegun"
	contains = list(/obj/item/weapon/gun/hmg08)
	cost = 400

/datum/supply_packs/stationary/hmg08_ammo
	name = "HMG-08 heavy machinegun ammo (500 rounds)"
	contains = list(/obj/item/ammo_magazine/hmg08)
	cost = 70

/datum/supply_packs/stationary/hmg08_ammo_small
	name = "HMG-08 heavy machinegun ammo (250 rounds)"
	contains = list(/obj/item/ammo_magazine/hmg08/small)
	cost = 40
