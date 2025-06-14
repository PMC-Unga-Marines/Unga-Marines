/datum/supply_packs/stationary
	group = "Stationary"
	containertype = /obj/structure/closet/crate/mounted

/datum/supply_packs/stationary/sentry
	name = "Турель TUR-B \"Базис\""
	contains = list(/obj/item/weapon/gun/sentry/basic)
	cost = 200

/datum/supply_packs/stationary/sentry_upgrade
	name = "Набор для улучшения турели TUR-B"
	contains = list(/obj/item/sentry_upgrade_kit,)
	cost = 150

/datum/supply_packs/stationary/sentry/ammo
	name = "Магазин для турели TUR-B \"Базис\""
	contains = list(/obj/item/ammo_magazine/sentry)
	cost = 50

/datum/supply_packs/stationary/sentry/ammo/mini
	name = "Магазин для турели TUR-M \"Гном\""
	contains = list(/obj/item/ammo_magazine/minisentry)

/datum/supply_packs/stationary/sentry/ammo/sniper
	name = "Магазин для турели TUR-SN \"Оса\""
	contains = list(/obj/item/ammo_magazine/sentry/sniper)

/datum/supply_packs/stationary/sentry/ammo/shotgun
	name = "Магазин для турели TUR-SH \"Бык\""
	contains = list(/obj/item/ammo_magazine/sentry/shotgun)

/datum/supply_packs/stationary/sentry/ammo/flamer
	name = "Бак для турели TUR-F \"Феникс\""
	contains = list(/obj/item/ammo_magazine/flamer_tank/large/sentry)

/datum/supply_packs/stationary/buildasentry
	name = "Build-A-Sentry attachment system"
	contains = list(/obj/item/attachable/buildasentry)
	cost = 250

/datum/supply_packs/stationary/m56d_emplacement
	name = "HSG-102 mounted heavy smartgun"
	contains = list(/obj/item/storage/box/hsg102)
	cost = 600

/datum/supply_packs/stationary/m56d
	name = "HSG-102 mounted heavy smartgun ammo"
	contains = list(/obj/item/ammo_magazine/hsg102)
	cost = 30

/datum/supply_packs/stationary/minigun_emplacement
	name = "MG-2005 automatic minigun"
	contains = list(/obj/item/weapon/gun/standard_minigun)
	cost = 600

/datum/supply_packs/stationary/minigun_ammo
	name = "MG-2005 mounted minigun ammo"
	contains = list(/obj/item/ammo_magazine/heavy_minigun)
	cost = 30

/datum/supply_packs/stationary/autocannon_emplacement
	name = "ATR-22 mounted flak cannon"
	contains = list(/obj/item/weapon/gun/atr22)
	cost = 700

/datum/supply_packs/stationary/ac_hv
	name = "ATR-22 high-velocity ammo"
	contains = list(/obj/item/ammo_magazine/atr22)
	cost = 40

/datum/supply_packs/stationary/ac_flak
	name = "ATR-22 smart-detonating ammo"
	contains = list(/obj/item/ammo_magazine/atr22/flak)
	cost = 40

/datum/supply_packs/stationary/ags_emplacement
	name = "AGLS-37 mounted automated grenade launcher"
	contains = list(/obj/item/weapon/gun/agls37)
	cost = 300

/datum/supply_packs/stationary/ags_highexplo
	name = "AGLS-37 AGL high explosive grenades"
	contains = list(/obj/item/ammo_magazine/agls37)
	cost = 65

/datum/supply_packs/stationary/ags_frag
	name = "AGLS-37 AGL fragmentation grenades"
	contains = list(/obj/item/ammo_magazine/agls37/fragmentation)
	cost = 55

/datum/supply_packs/stationary/ags_incendiary
	name = "AGLS-37 AGL white phosphorous grenades"
	contains = list(/obj/item/ammo_magazine/agls37/incendiary)
	cost = 55

/datum/supply_packs/stationary/ags_flare
	name = "AGLS-37 AGL flare grenades"
	contains = list(/obj/item/ammo_magazine/agls37/flare)
	cost = 35

/datum/supply_packs/stationary/ags_cloak
	name = "AGLS-37 AGL cloak grenades"
	contains = list(/obj/item/ammo_magazine/agls37/cloak)
	cost = 45

/datum/supply_packs/stationary/ags_tanglefoot
	name = "AGLS-37 AGL tanglefoot grenades"
	contains = list(/obj/item/ammo_magazine/agls37/tanglefoot)
	cost = 85

/datum/supply_packs/stationary/antitankgun
	name = "AT-36 anti tank gun"
	contains = list(/obj/item/weapon/gun/at36)
	cost = 800

/datum/supply_packs/stationary/antitankgunammo
	name = "AT-36 ATG AP-HE shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36,
		/obj/item/ammo_magazine/at36,
		/obj/item/ammo_magazine/at36,
	)
	cost = 20

/datum/supply_packs/stationary/antitankgunammo/apcr
	name = "AT-36 ATG APCR shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/apcr,
		/obj/item/ammo_magazine/at36/apcr,
		/obj/item/ammo_magazine/at36/apcr,
	)
	cost = 20

/datum/supply_packs/stationary/antitankgunammo/he
	name = "AT-36 ATG HE shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/he,
		/obj/item/ammo_magazine/at36/he,
		/obj/item/ammo_magazine/at36/he,
	)
	cost = 20

/datum/supply_packs/stationary/antitankgunammo/beehive
	name = "AT-36 ATG beehive shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/beehive,
		/obj/item/ammo_magazine/at36/beehive,
		/obj/item/ammo_magazine/at36/beehive,
	)
	cost = 20

/datum/supply_packs/stationary/antitankgunammo/incendiary
	name = "AT-36 ATG napalm shell (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/incend,
		/obj/item/ammo_magazine/at36/incend,
		/obj/item/ammo_magazine/at36/incend,
	)
	cost = 20

/datum/supply_packs/stationary/fk88
	name = "FK-88 flak gun"
	contains = list(/obj/item/weapon/gun/fk88)
	cost = 1000

/datum/supply_packs/stationary/fk88_he
	name = "FK-88 flak HE shell"
	contains = list(/obj/item/ammo_magazine/fk88/he)
	cost = 50

/datum/supply_packs/stationary/fk88_he_unguided
	name = "FK-88 unguided flak HE shell"
	contains = list(/obj/item/ammo_magazine/fk88/he/unguided)
	cost = 50

/datum/supply_packs/stationary/fk88_sabot
	name = "FK-88 flak APFDS shell"
	contains = list(/obj/item/ammo_magazine/fk88/sabot)
	cost = 60

/datum/supply_packs/stationary/heayvlaser_emplacement
	name = "TE-9001 mounted heavy laser"
	contains = list(/obj/item/weapon/gun/energy/lasgun/lasrifle/heavy_laser/deployable)
	cost = 800

/datum/supply_packs/stationary/heayvlaser_ammo
	name = "TE-9001 mounted heavy laser ammo (x1)"
	contains = list(/obj/item/cell/lasgun/heavy_laser)
	cost = 15

/datum/supply_packs/stationary/mg27
	name = "MG-27 medium machinegun"
	contains = list(/obj/item/weapon/gun/mg27)
	cost = 100

/datum/supply_packs/stationary/hmg08
	name = "HMG-08 heavy machinegun"
	contains = list(/obj/item/weapon/gun/hmg08)
	cost = 400

/datum/supply_packs/stationary/hmg08_ammo
	name = "HMG-08 heavy machinegun drum magazine"
	contains = list(/obj/item/ammo_magazine/hmg08)
	cost = 70

/datum/supply_packs/stationary/hmg08_ammo_small
	name = "HMG-08 heavy machinegun box magazine"
	contains = list(/obj/item/ammo_magazine/hmg08/small)
	cost = 40
