//Base SOM veteran outfit
/datum/outfit/quick/som/veteran
	name = "SOM Squad Veteran"
	jobtype = "SOM Squad Veteran"

	ears = /obj/item/radio/headset/distress/som
	w_uniform = /obj/item/clothing/under/som/veteran/webbing
	shoes = /obj/item/clothing/shoes/marine/som/knife
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/shield
	gloves = /obj/item/clothing/gloves/marine/som/veteran
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/som/veteran
	glasses = /obj/item/clothing/glasses/meson
	r_store = /obj/item/storage/pouch/firstaid/som/combat_patrol
	l_store = /obj/item/storage/pouch/grenade/som/combat_patrol
	back = /obj/item/storage/backpack/satchel/som

/datum/outfit/quick/som/veteran/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_HEAD)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/combat_advanced, SLOT_IN_HEAD)

	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/isotonic, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclot, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/dylovene, SLOT_IN_SUIT)

/datum/outfit/quick/som/veteran/standard_assaultrifle
	name = "V-31 Veteran Infantryman"
	desc = "Heavily armed and armored SOM elite. Equipped with a V-31 assault rifle with integrated 'micro grenade' rail launcher, heavy armor, a large variety of grenades as well as AP ammunition. Excellent performance against heavily armored targets, while the plentiful grenade provide greater tactical flexibility."

	back = /obj/item/storage/backpack/lightpack/som
	suit_store = /obj/item/weapon/gun/rifle/som/veteran
	belt = /obj/item/storage/belt/marine/som/som_rifle_ap

/datum/outfit/quick/som/veteran/standard_assaultrifle/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/standard(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/som/ap, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/som/ap, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/smoke_burst, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/dragonbreath, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/dragonbreath, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/cluster, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/cluster, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/veteran/standard_smg
	name = "V-21 Veteran Infantryman"
	desc = "Close range high damage, high speed. Equipped with a V-21 submachine gun with variable firerate allowing for extreme rates of fire when properly wielded, heavy armor, a good variety of grenades and AP ammunition. Allows for excellent close to medium range firepower, especially against heavily armored targets, and is surprisingly mobile."

	suit_store = /obj/item/weapon/gun/smg/som/veteran
	belt = /obj/item/storage/belt/marine/som/som_smg_ap

/datum/outfit/quick/som/veteran/standard_smg/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/standard(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som/ap, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som/ap, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som/ap, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang/stun, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/veteran/breacher
	name = "Charger Veteran Breacher"
	desc = "Heavy armored breaching configuration. Equipped with a volkite charger configured for better one handed use, heavy armor upgraded with 'Lorica' armor reinforcements, a boarding shield and a good selection of grenades. Premier protection and deadly close range firepower."

	head = /obj/item/clothing/head/modular/som/lorica
	glasses = /obj/item/clothing/glasses/welding
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/lorica
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger/somvet
	belt = /obj/item/storage/belt/marine/som/volkite
	r_hand = /obj/item/weapon/shield/riot/marine/som

/datum/outfit/quick/som/veteran/breacher/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/tool/weldingtool/largetank, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/veteran/charger
	name = "Charger Veteran Infantryman"
	desc = "Heavily armed and armored SOM elite. Equipped with a volkite charger with motion sensor and gyrostabiliser for better one handed use, heavy armor and a good variety of grenades. Volkite weapons are exceptionally dangerous, especially against poorly armored or tightly grouped opponents. The charger is the SOM's premier close/medium range weapon, with good mobility, and can be used (with some difficulty) one handed."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger/scout
	belt = /obj/item/storage/belt/marine/som/volkite

/datum/outfit/quick/som/veteran/charger/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/standard(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/veteran/caliver
	name = "Caliver Veteran Infantryman"
	desc = "Heavily armed and armored SOM elite. Equipped with a volkite caliver, heavy armor and a good variety of grenades. Volkite weapons are exceptionally dangerous, especially against poorly armored or tightly grouped opponents. The caliver provides deadly firepower at all ranges. Approach with caution."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/caliver/standard
	belt = /obj/item/storage/belt/marine/som/volkite

/datum/outfit/quick/som/veteran/caliver/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/standard(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/veteran/caliver_pack
	name = "Caliver Veteran Rifleman"
	desc = "Heavily armed and armored SOM elite. Equipped with a volkite caliver with motion sensor, heavy armor, plenty of grenades and a back mounted self charging power supply. Volkite weapons are exceptionally dangerous, especially against poorly armored or tightly grouped opponents. The caliver provides deadly firepower at all ranges, and the power pack allows for sustained period of fire, although over extended periods of time the recharge may struggle to keep up with the demands of the weapon."
	quantity = 2

	belt = /obj/item/storage/belt/grenade/som
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/caliver/tacsensor
	l_store = /obj/item/storage/pouch/pistol/som
	back = /obj/item/cell/lasgun/volkite/powerpack

/datum/outfit/quick/som/veteran/caliver_pack/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_ACCESSORY)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/som, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/som, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/satrapine, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/satrapine, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang/stun, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang/stun, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_BELT)

	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/standard(H), SLOT_IN_L_POUCH)

/datum/outfit/quick/som/veteran/mpi
	name = "MPI_KM Veteran Infantryman"
	desc = "Heavily armed and armored SOM elite, with a taste for nostalgia. Equipped with an MPI_KM assault rifle, with under barrel grenade launcher and a large supply of grenades. An old weapon that was a common sight during the original Martian rebellion, the MPI's good stopping power, reliability and a healthy dose of nostalgia means it is still seen in use by some among the SOM despite its age."

	suit_store = /obj/item/weapon/gun/rifle/mpi_km/grenadier
	belt = /obj/item/storage/belt/marine/som/mpi_plum

/datum/outfit/quick/som/veteran/mpi/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/standard(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/extended, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/veteran/carbine
	name = "V-34 Veteran Infantryman"
	desc = "Heavily armed and armored SOM elite, with a taste for nostalgia. Equipped with an heirloom V-34 carbine, and a large supply of grenades. An old weapon that saw extensive use during the original Martian rebellion, this one has been preserved and passed down the generations. The V-34 is largely surpassed by the VX-32, however with its high calibre rounds and good rate of fire, it cannot be underestimated."

	suit_store = /obj/item/weapon/gun/rifle/som_carbine/mag_harness
	belt = /obj/item/storage/belt/marine/som/carbine

/datum/outfit/quick/som/veteran/carbine/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/standard(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/carbine, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/veteran/culverin
	name = "Culverin Veteran Machinegunner"
	desc = "Heavily armored heavy firesupport. Equipped with a volkite culverin and self charging backpack power unit, and a shotgun sidearm. The culverin is the most powerful man portable weapon the SOM have been seen to field. Capabable of laying down a tremendous barrage of firepower for extended periods of time. Although the back-mounted powerpack is self charging, it cannot keep up with the immense power requirements of the gun, so sustained, prolonged use can degrade the weapon's effectiveness greatly."
	quantity = 2

	belt = /obj/item/weapon/gun/shotgun/double/sawn
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/culverin/magharness
	back = /obj/item/cell/lasgun/volkite/powerpack

/datum/outfit/quick/som/veteran/culverin/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/buckshot, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/buckshot, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/buckshot, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/veteran/rocket_man
	name = "V-71 Rocket Veteran"
	desc = "War crimes have never been so easy. Equipped with a V-71 RPG and both incendiary and rad warheads, as well as a V-21 submachine gun with radioactive ammunition, heavy armor with a 'Mithridatius' environmental protection system, and rad grenades. Designed to inspire fear in the enemy and cripple them with deadly incendiary and radiological effects, providing excellent anti infantry support."
	quantity = 2

	head = /obj/item/clothing/head/modular/som/bio
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/mithridatius
	suit_store = /obj/item/weapon/gun/smg/som/support
	belt = /obj/item/storage/belt/marine/som
	back = /obj/item/storage/holster/backholster/rpg/som/war_crimes
	l_store = /obj/item/storage/pouch/grenade/som

/datum/outfit/quick/som/veteran/rocket_man/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som/rad, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som/rad, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som/rad, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som/rad, SLOT_IN_BELT)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/satrapine, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/satrapine, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/satrapine, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/rad, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/rad, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/rad, SLOT_IN_L_POUCH)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/packet/p10x20mm, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som/incendiary, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/veteran/blinker
	name = "Blink Assault Veteran"
	desc = "Shock melee assault class. Equipped with a blink drive and energy sword, light armor and a backup burstfire V-11. The blink drive allows for short range teleports at some risk to the user, but allows them to effortless close the distance to cut down enemies when used correctly."
	quantity = 2

	wear_suit = /obj/item/clothing/suit/modular/som/light/shield
	belt = /obj/item/storage/holster/belt/pistol/m4a3/som
	suit_store = /obj/item/weapon/energy/sword/som
	back = /obj/item/blink_drive

/datum/outfit/quick/som/veteran/blinker/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_ACCESSORY)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/burst(H), SLOT_IN_HOLSTER)
