//Base SOM marine outfit
/datum/outfit/quick/som/marine
	name = "SOM Squad Marine"
	jobtype = "SOM Squad Standard"

	ears = /obj/item/radio/headset/distress/som
	w_uniform = /obj/item/clothing/under/som/webbing
	shoes = /obj/item/clothing/shoes/marine/som/knife
	wear_suit = /obj/item/clothing/suit/modular/som/shield
	gloves = /obj/item/clothing/gloves/marine/som
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/som
	r_store = /obj/item/storage/pouch/firstaid/som/combat_patrol
	l_store = /obj/item/storage/pouch/grenade/som/combat_patrol
	back = /obj/item/storage/backpack/satchel/som

/datum/outfit/quick/som/marine/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/combat, SLOT_IN_HEAD)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/combat_advanced, SLOT_IN_HEAD)

	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/isotonic, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/quickclot, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/dylovene, SLOT_IN_SUIT)

/datum/outfit/quick/som/marine/standard_assaultrifle
	name = "V-31 Infantryman"
	desc = "The typical SOM infantryman. Equipped with a V-31 assault rifle with integrated 'micro grenade' rail launcher, medium armor and a good selection of grenades. The rail launcher fires grenades that must arm mid flight, so are ineffective at close ranges, but add significant tactical options at medium range."

	suit_store = /obj/item/weapon/gun/rifle/som/standard
	belt = /obj/item/storage/belt/marine/som/som_rifle

/datum/outfit/quick/som/marine/standard_assaultrifle/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/standard(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/som, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/dragonbreath, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/cluster, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/micro_grenade/smoke_burst, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/marine/mpi
	name = "MPI_KM Infantryman"
	desc = "A call back to an earlier time. Equipped with an MPI_KM assault rifle, with under barrel grenade launcher and a large supply of grenades. An old weapon that was a common sight during the original Martian rebellion, the MPI's good stopping power, reliability and a healthy dose of nostalgia means it is still seen in use by some among the SOM despite its age."

	suit_store = /obj/item/weapon/gun/rifle/mpi_km/black/grenadier
	belt = /obj/item/storage/belt/marine/som/mpi_black

/datum/outfit/quick/som/marine/mpi/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/standard(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/marine/light_carbine
	name = "V-34 Light Infantryman"
	desc = "Mobile and dangerous. Equipped with a V-34 carbine, light armor with an 'Aegis' shield module and a large supply of grenades. The V-34 is a modern update of an old weapon that was a common sight during the original Martian rebellion. Very reliable and excellent stopping power in a small, lightweight package. Brought into service as a much cheaper alternative to the VX-32."

	wear_suit = /obj/item/clothing/suit/modular/som/light/shield
	suit_store = /obj/item/weapon/gun/rifle/som_carbine/black/standard
	belt = /obj/item/storage/belt/marine/som/carbine_black

/datum/outfit/quick/som/marine/light_carbine/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/standard(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/carbine/black, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/carbine/black, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/marine/scout
	name = "V-21 Light Infantryman"
	desc = "Highly mobile scouting configuration. Equipped with a V-21 submachine gun with variable firerate allowing for extreme rates of fire when properly wielded, light armor with an 'Aegis' shield module and a good selection of grenades. Allows for exceptional mobility and blistering firepower, it will falter in extended engagements where low armor and the V-21's high rate of fire can become liabilities."

	wear_suit = /obj/item/clothing/suit/modular/som/light/shield
	suit_store = /obj/item/weapon/gun/smg/som/scout
	belt = /obj/item/storage/belt/marine/som/som_smg

/datum/outfit/quick/som/marine/scout/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/standard(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/marine/shotgunner
	name = "V-51 Pointman"
	desc = "For close encounters. Equipped with a V-51 semi-automatic shotgun, light armor with an 'Aegis' shield module and a large selection of grenades. Allows for good mobility and dangerous CQC firepower."

	belt = /obj/item/storage/belt/shotgun/som/mixed
	wear_suit = /obj/item/clothing/suit/modular/som/light/shield
	suit_store = /obj/item/weapon/gun/shotgun/som/standard

/datum/outfit/quick/som/marine/shotgunner/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/standard(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang/stun, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang/stun, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/marine/pyro
	name = "V-62 Flamethrower Operator"
	desc = "Smells like victory. Equipped with an V-62 incinerator and wide nozzle, V-11 equipped for rapid burst fire, heavy armor upgraded with a 'Hades' fireproof module, and a backtank of fuel. Has better than average range and can quickly burn down large areas. It suffers from significant slowdown, lacks an integrated extinguisher, and undisciplined use can result in rapidly consuming all available fuel."

	head = /obj/item/clothing/head/modular/som/hades
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/pyro
	belt = /obj/item/storage/holster/belt/pistol/m4a3/som
	back = /obj/item/ammo_magazine/flamer_tank/backtank
	suit_store = /obj/item/weapon/gun/flamer/som/mag_harness

/datum/outfit/quick/som/marine/pyro/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/burst(H), SLOT_IN_HOLSTER)

	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/marine/breacher
	name = "V-21 Breacher"
	desc = "Heavy armored breaching configuration. Equipped with a V-21 submachine gun with variable firerate allowing for extreme rates of fire when properly wielded, heavy armor, a boarding shield and a good selection of grenades. Offers outstanding protection although damage may be lacking, particular at longer range."

	glasses = /obj/item/clothing/glasses/welding
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/shield
	suit_store = /obj/item/weapon/gun/smg/som/one_handed
	belt = /obj/item/storage/belt/marine/som/som_smg
	r_hand = /obj/item/weapon/shield/riot/marine/som

/datum/outfit/quick/som/marine/breacher/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/weldingtool/largetank, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/som, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang/stun, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/marine/breacher_melee
	name = "CQC Breacher"
	desc = "For when a complete lack of subtlety is required. Equipped with 'Lorica' enhanced heavy armor and armed with a monsterous two handed breaching axe, designed to cut through heavy armor. When properly wielded, it also provides a degree of protection."

	head = /obj/item/clothing/head/modular/som/lorica
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/lorica
	suit_store = /obj/item/weapon/twohanded/fireaxe/som
	belt = /obj/item/storage/holster/belt/pistol/m4a3/som

/datum/outfit/quick/som/marine/breacher_melee/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/synaptizine, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/combat_advanced, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/burst(H), SLOT_IN_HOLSTER)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)

/datum/outfit/quick/som/marine/machine_gunner
	name = "V-41 Machinegunner"
	desc = "Heavy static firesupport. Equipped with a V-41 machine gun, burst fire V-11 sidearm and some basic building supplies. While often ill suited to the SOM's standard doctrine of mobility and aggression, the V-41 is typically seen in defensive positions or second line units where its poor mobility is a minor drawback compared to its sustained firepower."

	suit_store = /obj/item/weapon/gun/rifle/som_mg/standard
	belt = /obj/item/storage/holster/belt/pistol/m4a3/som
	l_store = /obj/item/storage/pouch/construction/som

/datum/outfit/quick/som/marine/machine_gunner/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som/extended, SLOT_IN_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/burst(H), SLOT_IN_HOLSTER)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/som_mg, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/som_mg, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/som_mg, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/som_mg, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb/satrapine, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_ACCESSORY)

	H.equip_to_slot_or_del(new /obj/item/tool/shovel/etool, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/stack/sandbags_empty/half, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/stack/sandbags/large_stack, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/stack/barbed_wire/half_stack, SLOT_IN_L_POUCH)

/datum/outfit/quick/som/marine/charger
	name = "Charger Infantryman"
	desc = "The future infantryman of the SOM. Equipped with a volkite charger, medium armor and a good variety of grenades. Volkite weapons are exceptionally dangerous, especially against poorly armored or tightly grouped opponents. The charger is the SOM's premier close/medium range weapon, with good mobility, and can be used (with some difficulty) one handed when required."
	quantity = 4

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger/magharness
	belt = /obj/item/storage/belt/marine/som/volkite

/datum/outfit/quick/som/marine/charger/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/som/standard(H), SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)
