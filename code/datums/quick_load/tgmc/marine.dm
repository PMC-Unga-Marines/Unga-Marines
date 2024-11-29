/datum/outfit/quick/tgmc/marine/ar12
	name = "AR-12 rifleman"
	desc = "The classic line rifleman. Equipped with an AR-12 assault rifle with UGL, heavy armor, and plenty of grenades and ammunition. A solid all-rounder."

	suit_store = /obj/item/weapon/gun/rifle/ar12/rifleman
	belt = /obj/item/storage/belt/marine/ar12

/datum/outfit/quick/tgmc/marine/ar12/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/weapon/shield/riot/marine/deployable, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x24mm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/p23/tactical(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/marine/standard_laserrifle
	name = "Laser Rifleman"
	desc = "For when bullets don't cut the mustard. Laser rifle with miniflamer and heavy armor. Lasers are more effective against SOM armor, but cannot break bones and damage organs."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle/rifleman
	belt = /obj/item/storage/belt/marine/te_cells

/datum/outfit/quick/tgmc/marine/standard_laserrifle/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol/tactical(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/mini, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/mini, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/marine/ar18
	name = "AR-18 Rifleman"
	desc = "The modern line rifleman. Equipped with an AR-18 carbine with UGL, heavy armor, and plenty of grenades and ammunition. Boasts better mobility and damage output than the AR-12, but suffers with a smaller magazine and worse performance at longer ranges."

	suit_store = /obj/item/weapon/gun/rifle/ar18/standard
	belt = /obj/item/storage/belt/marine/ar18

/datum/outfit/quick/tgmc/marine/ar18/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x24mm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar18, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/p23/tactical(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/marine/combat_rifle
	name = "AR-11 Rifleman"
	desc = "The old rifleman. Equipped with an AR-11 combat rifle with heavy armor, and plenty of grenades and ammunition. Has a large capacity with deadly damage output at all ranges, but lacks many attachment options of more modern weapons and somewhat more cumbersome to handle."

	suit_store = /obj/item/weapon/gun/rifle/ar11/standard
	belt = /obj/item/storage/belt/marine/combat_rifle

/datum/outfit/quick/tgmc/marine/combat_rifle/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p492x34mm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p492x34mm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/p23/tactical(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/marine/br64
	name = "BR-64 Rifleman"
	desc = "Heavier firepower for the discerning rifleman. Equipped with an BR-64 battle rifle with UGL, heavy armor, and plenty of grenades and ammunition. Higher damage and penetration, at the cost of a more bulky weapon."

	suit_store = /obj/item/weapon/gun/rifle/br64/standard
	belt = /obj/item/storage/belt/marine/br64

/datum/outfit/quick/tgmc/marine/br64/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/weapon/shield/riot/marine/deployable, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x265mm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/p23/tactical(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/marine/ar21
	name = "AR-21 Rifleman"
	desc = "Better stopping power at the cost of lower rate of fire. Equipped with an AR-21 skirmish rifle with UGL, heavy armor, and plenty of grenades and ammunition. Rewards good aim with its heavy rounds."

	suit_store = /obj/item/weapon/gun/rifle/ar21/standard
	belt = /obj/item/storage/belt/marine/ar21

/datum/outfit/quick/tgmc/marine/ar21/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/weapon/shield/riot/marine/deployable, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x25mm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/p23/tactical(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/marine/alf_shocktrooper
	name = "ALF-51B Shocktrooper"
	desc = "Shock assault loadout. Equipped with an ALF-51B machinecarbine, heavy armor reinforced with a Mk.II 'Tyr' module, and plenty of grenades and ammunition. Offers excellent damage output and superior protection, however the ALF-51B's cutdown size means it suffers from severe damage falloff. Best used up close."

	head = /obj/item/clothing/head/modular/m10x/tyr
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/heavy/tyr_two
	suit_store = /obj/item/weapon/gun/rifle/alf_machinecarbine/assault
	belt = /obj/item/storage/belt/marine/alf_machinecarbine

/datum/outfit/quick/tgmc/marine/alf_shocktrooper/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/alf_machinecarbine, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/alf_machinecarbine, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/p23/tactical(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/combat_advanced, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang/stun, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/marine/mg60
	name = "MG-60 Machinegunner"
	desc = "The old reliable workhorse of the TGMC. Equipped with an MG-60 machinegun with bipod, heavy armor and some basic construction supplies. Good for holding ground and providing firesupport, and the cost of some mobility."

	belt = /obj/item/storage/belt/sparepouch
	suit_store = /obj/item/weapon/gun/rifle/mg60/machinegunner
	l_store = /obj/item/storage/pouch/construction

/datum/outfit/quick/tgmc/marine/mg60/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/weapon/shield/riot/marine/deployable, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/mg60, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/p23/tactical(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/mg60, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/mg60, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/mg60, SLOT_IN_BELT)

	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang/stun, SLOT_IN_ACCESSORY)

	H.equip_to_slot_or_del(new /obj/item/tool/shovel/etool, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/stack/sandbags_empty/half, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/stack/sandbags/large_stack, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/stack/barbed_wire/half_stack, SLOT_IN_L_POUCH)

/datum/outfit/quick/tgmc/marine/mg27
	name = "MG-27 Machinegunner"
	desc = "For when you need the biggest gun you can carry. Equipped with an MG-27 machinegun and miniscope and a MR-25 SMG as a side arm, as well as medium armor and a small amount of construction supplies. Allows for devestating, albeit static firepower."

	belt = /obj/item/storage/holster/m25
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/shield
	suit_store = /obj/item/weapon/gun/mg27/machinegunner
	l_store = /obj/item/storage/pouch/construction
	glasses = /obj/item/clothing/glasses/mgoggles

/datum/outfit/quick/tgmc/marine/mg27/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/mg27, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/mg27, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/mg27, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang/stun, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m25/holstered(H), SLOT_IN_HOLSTER)

	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25, SLOT_IN_ACCESSORY)

	H.equip_to_slot_or_del(new /obj/item/tool/shovel/etool, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/stack/sandbags_empty/half, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/stack/sandbags/large_stack, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/stack/barbed_wire/half_stack, SLOT_IN_L_POUCH)

/datum/outfit/quick/tgmc/marine/standard_lasermg
	name = "Laser Machinegunner"
	desc = "Mess free fire superiority. Laser machinegun with underbarrel grenade launcher and heavy armor. Comparatively light for a machinegun, with variable firemodes makes this weapon a flexible and dangerous weapon. Lasers are more effective against SOM armor, but cannot break bones and damage organs."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_mlaser/patrol
	belt = /obj/item/storage/belt/marine/te_cells

/datum/outfit/quick/tgmc/marine/standard_lasermg/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol/tactical(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/marine/pyro
	name = "FL-84 Flamethrower Operator"
	desc = "For burning enemies, and sometimes friends. Equipped with an FL-84 flamethrower and wide nozzle, SMG-25 secondary weapon, heavy armor upgraded with a 'Surt' fireproof module, and a backtank of fuel. Can burn down large areas extremely quickly both to flush out the enemy and to cover flanks. Is very slow however, ineffective at long range, and can expend all available fuel quickly if used excessively."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/heavy/surt
	mask = /obj/item/clothing/mask/gas/tactical
	head = /obj/item/clothing/head/modular/m10x/surt
	belt = /obj/item/storage/holster/m25
	back = /obj/item/ammo_magazine/flamer_tank/backtank
	suit_store = /obj/item/weapon/gun/flamer/big_flamer/marinestandard/wide

/datum/outfit/quick/tgmc/marine/pyro/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m25/holstered(H), SLOT_IN_HOLSTER)

	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25/extended, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25/extended, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25/extended, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x20mm, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/marine/standard_shotgun
	name = "SH-35 Scout"
	desc = "For getting too close for comfort. Equipped with a SH-35 shotgun with buckshot and flechette rounds, a MP-19 sidearm, a good amount of grenades and light armor with a cutting edge 'svallin' shield module. Provides for excellent mobility and devestating close range firepower, but will falter against sustained firepower."

	belt = /obj/item/storage/belt/shotgun
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/light/shield
	suit_store = /obj/item/weapon/gun/shotgun/pump/t35/standard
	belt = /obj/item/storage/belt/shotgun/mixed

/datum/outfit/quick/tgmc/marine/standard_shotgun/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp19, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp19, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp19, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x20mm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/synaptizine, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/mp19/compact(H), SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/marine/standard_lasercarbine
	name = "Laser Carbine Scout"
	desc = "Highly mobile light infantry. Equipped with a laser carbine with UGL and a laser pistol sidearm, plenty of grenades and light armor with a cutting edge 'svallin' shield module. Excellent mobility, but not suited for sustained combat."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/light/shield
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_carbine/scout
	belt = /obj/item/storage/belt/marine/te_cells

/datum/outfit/quick/tgmc/marine/standard_lasercarbine/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol/tactical(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/synaptizine, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/combat_advanced, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/marine/light_carbine
	name = "AR-18 Scout"
	desc = "High damage and high speed. Equipped with an AR-18 carbine with UGL, light armor with a cutting edge 'svallin' shield module, and plenty of grenades and ammunition. Great mobility and damage output, but low magazine capacity and weak armor without the shield active means this loadout is best suited to hit and run tactics."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/light/shield
	suit_store = /obj/item/weapon/gun/rifle/ar18/scout
	belt = /obj/item/storage/belt/marine/ar18

/datum/outfit/quick/tgmc/marine/light_carbine/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x24mm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x24mm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar18, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/p23/tactical(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/p23, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/marine/shield_tank
	name = "SMG-25 Guardian"
	desc = "Professional bullet catcher. Equipped with an SMG-25 submachine gun, a TL-172 defensive shield and heavy armor reinforced with a 'Tyr' module. Designed to absorb as much incoming damage as possible to protect your squishier comrades, however your mobility and damage output are notably diminished. Also of note: the excellent thermal mass of the TL-172 means it is unusually effective against the SOM's volkite weaponry."

	head = /obj/item/clothing/head/modular/m10x/tyr
	glasses = /obj/item/clothing/glasses/welding
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/heavy/tyr_two
	suit_store = /obj/item/weapon/gun/smg/m25/magharness
	belt = /obj/item/storage/belt/marine/secondary
	r_hand = /obj/item/weapon/shield/riot/marine

/datum/outfit/quick/tgmc/marine/shield_tank/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/weldingtool/largetank, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25/extended, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x20mm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x20mm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/cloak, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/sticky, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/marine/machete
	name = "Assault Marine"
	desc = "This doesn't look standard issue... Equipped with a SMG-25 submachine gun, machete and heavy lift jetpack, along with light armor upgraded with a 'svallin' shield module. It's not clear why this is here, nevertheless it has excellent mobility, and would likely be devastating against anyone you manage to actually reach."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/light/shield
	back = /obj/item/jetpack_marine/heavy
	belt = /obj/item/storage/holster/blade/machete/full
	suit_store = /obj/item/weapon/gun/smg/m25/magharness

/datum/outfit/quick/tgmc/marine/machete/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25/extended, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25/extended, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25, SLOT_IN_ACCESSORY)

/datum/outfit/quick/tgmc/marine/scout
	name = "BR-8 Scout"
	desc = "IFF scout. Equipped with a BR-8 with a good amount of grenades and light armor with a cutting edge 'svallin' shield module. Provides for good mobility and powerful IFF damage, but the BR-8 is difficult to bring to bear at close range, and light armor wilts under sustained fire."
	quantity = 2

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/light/shield
	suit_store = /obj/item/weapon/gun/rifle/tx8/scout
	belt = /obj/item/storage/belt/marine/tx8

/datum/outfit/quick/tgmc/marine/scout/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp19, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp19, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp19, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/mp19/scanner(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/tx8, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/tx8, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_ACCESSORY)
