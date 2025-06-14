/datum/supply_packs/explosives
	containertype = /obj/structure/closet/crate/ammo
	group = "Explosives"

/datum/supply_packs/explosives/explosives_mines
	name = "Claymore mines"
	notes = "Contains 5 mines"
	contains = list(/obj/item/storage/box/explosive_mines)
	cost = 150

/datum/supply_packs/explosives/explosives_minelayer
	name = "M21 APRDS \"Minelayer\""
	contains = list(/obj/item/minelayer)
	cost = 50

/datum/supply_packs/explosives/explosives_razor
	name = "Razorburn grenade box"
	notes = "Contains 15 razor burns"
	contains = list(/obj/item/storage/box/visual/grenade/razorburn)
	cost = 500

/datum/supply_packs/explosives/stickytanglenades
	name = "M45-T adhesive tanglefoot grenade"
	notes = "Contains 25 M45-T sticky grenade"
	contains = list(/obj/item/storage/box/visual/grenade/drain/sticky)
	cost = 300

/datum/supply_packs/explosives/explosives_antigas
	name = "M40-AG anti-gas grenade box"
	notes = "Cotains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/antigas)
	cost = 700

/datum/supply_packs/explosives/explosives_sticky
	name = "M40 adhesive charge grenade box"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/sticky)
	cost = 310

/datum/supply_packs/explosives/explosives_smokebomb
	name = "M40 HSDP smokebomb grenade box"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/smokebomb)
	cost = 310

/datum/supply_packs/explosives/explosives_hedp
	name = "M40 HEDP high explosive grenade box"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/frag)
	cost = 310

/datum/supply_packs/explosives/explosives_cloaker
	name = "M45 cloaker grenade box"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/cloaker)
	cost = 310

/datum/supply_packs/explosives/explosives_cloak
	name = "M40-2 SCDP grenade box"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/cloak)
	cost = 310

/datum/supply_packs/explosives/explosives_lasburster
	name = "M80 lasburster grenade box"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/lasburster)
	cost = 310

/datum/supply_packs/explosives/explosives_hidp
	name = "M40 HIDP incendiary explosive grenade box"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/incendiary)
	cost = 350

/datum/supply_packs/explosives/explosives_m15
	name = "M15 fragmentation grenade box"
	notes = "Contains 15 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/m15)
	cost = 350

/datum/supply_packs/explosives/explosives_trailblazer
	name = "M45 trailblazer grenade box"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/trailblazer)
	cost = 350

/datum/supply_packs/explosives/explosives_hsdp
	name = "M40 HSDP white phosphorous grenade box"
	notes = "Contains 15 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/phosphorus)
	cost = 700

/datum/supply_packs/explosives/explosives_hefa
	name = "M25 HEFA grenade box"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/hefa)
	cost = 550

/datum/supply_packs/explosives/explosives_plasmadrain
	name = "M40-T gas grenade box"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/drain)
	cost = 700

/datum/supply_packs/explosives/plastique
	name = "C4 plastic explosive"
	contains = list(/obj/item/explosive/plastique)
	cost = 30

/datum/supply_packs/explosives/plastique_incendiary
	name = "EX-62 Genghis incendiary charge"
	contains = list(/obj/item/explosive/plastique/genghis_charge)
	cost = 150

/datum/supply_packs/explosives/detpack
	name = "Detpack explosive"
	contains = list(/obj/item/detpack)
	cost = 50

/datum/supply_packs/explosives/mortar
	name = "T-50S mortar crate"
	contains = list(/obj/item/mortar_kit)
	cost = 250

/datum/supply_packs/explosives/mortar_ammo_he
	name = "T-50S mortar HE shell (x2)"
	contains = list(/obj/item/mortal_shell/he, /obj/item/mortal_shell/he)
	cost = 10

/datum/supply_packs/explosives/mortar_ammo_incend
	name = "T-50S mortar incendiary shell (x2)"
	contains = list(/obj/item/mortal_shell/incendiary, /obj/item/mortal_shell/incendiary)
	cost = 10

/datum/supply_packs/explosives/mortar_ammo_flare
	name = "T-50S mortar flare shell (x2)"
	notes = "Can be fired out of the MG-100Y howitzer, as well."
	contains = list(/obj/item/mortal_shell/flare, /obj/item/mortal_shell/flare)
	cost = 5

/datum/supply_packs/explosives/mortar_ammo_smoke
	name = "T-50S mortar smoke shell (x2)"
	contains = list(/obj/item/mortal_shell/smoke, /obj/item/mortal_shell/smoke)
	cost = 5

/datum/supply_packs/explosives/mortar_ammo_plasmaloss
	name = "T-50S mortar tanglefoot shell"
	contains = list(/obj/item/mortal_shell/plasmaloss)
	cost = 10

/datum/supply_packs/explosives/mlrs
	name = "TA-40L multiple rocket system"
	contains = list(/obj/item/mortar_kit/mlrs)
	cost = 450

/datum/supply_packs/explosives/mlrs_rockets
	name = "TA-40L MLRS rocket pack (x16)"
	contains = list(/obj/item/storage/box/mlrs_rockets)
	cost = 40

/datum/supply_packs/explosives/mlrs_rockets_gas
	name = "TA-40L X-50 MLRS rocket pack (x16)"
	contains = list(/obj/item/storage/box/mlrs_rockets_gas)
	cost = 50

/datum/supply_packs/explosives/mlrs_rockets_tangle
	name = "TA-40L T-33 MLRS rocket pack (x16)"
	contains = list(/obj/item/storage/box/mlrs_rockets_tangle)
	cost = 50

/datum/supply_packs/explosives/ai_target_module
	name = "AI artillery targeting module"
	contains = list(/obj/item/ai_target_beacon)
	cost = 50
	crash_restricted = TRUE

/datum/supply_packs/explosives/knee_mortar
	name = "T-10K knee mortar"
	contains = list(/obj/item/mortar_kit/knee)
	cost = 50

/datum/supply_packs/explosives/knee_mortar_ammo
	name = "TA-10K knee mortar HE shell"
	contains = list(/obj/item/mortal_shell/knee, /obj/item/mortal_shell/knee)
	cost = 5

/datum/supply_packs/explosives/explosives_trailblazer_phosphorus
	name = "M45 phosphorous trailblazer grenade box"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/trailblazer/phosphorus)
	cost = 600

/datum/supply_packs/explosives/howitzer
	name = "TA-100Y howitzer"
	contains = list(/obj/item/mortar_kit/howitzer)
	cost = 500

/datum/supply_packs/explosives/howitzer_ammo_he
	name = "TA-100Y howitzer HE shell"
	contains = list(/obj/item/mortal_shell/howitzer/he)
	cost = 30

/datum/supply_packs/explosives/howitzer_ammo_incend
	name = "TA-100Y howitzer incendiary shell"
	contains = list(/obj/item/mortal_shell/howitzer/incendiary)
	cost = 30

/datum/supply_packs/explosives/howitzer_ammo_wp
	name = "TA-100Y howitzer white phosporous smoke shell"
	contains = list(/obj/item/mortal_shell/howitzer/white_phos)
	cost = 45

/datum/supply_packs/explosives/howitzer_ammo_plasmaloss
	name = "TA-100Y howitzer tanglefoot shell"
	contains = list(/obj/item/mortal_shell/howitzer/plasmaloss)
	cost = 45
