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
	r_pocket = /obj/item/storage/pouch/firstaid/som/combat_patrol
	l_pocket = /obj/item/storage/pouch/grenade/som/combat_patrol
	back = /obj/item/storage/backpack/satchel/som

	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/combat = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
	)

	suit_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/isotonic = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
	)

/datum/outfit/quick/som/marine/standard_assaultrifle
	name = "V-31 Infantryman"
	desc = "The typical SOM infantryman. Equipped with a V-31 assault rifle with integrated 'micro grenade' rail launcher, medium armor and a good selection of grenades. The rail launcher fires grenades that must arm mid flight, so are ineffective at close ranges, but add significant tactical options at medium range."

	suit_store = /obj/item/weapon/gun/rifle/som/standard
	belt = /obj/item/storage/belt/marine/som/som_rifle

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/ammo_magazine/rifle/som = 2,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 1,
		/obj/item/ammo_magazine/handful/micro_grenade = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/dragonbreath = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/cluster = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/smoke_burst = 1,
	)

/datum/outfit/quick/som/marine/mpi
	name = "MPI_KM Infantryman"
	desc = "A call back to an earlier time. Equipped with an MPI_KM assault rifle, with under barrel grenade launcher and a large supply of grenades. An old weapon that was a common sight during the original Martian rebellion, the MPI's good stopping power, reliability and a healthy dose of nostalgia means it is still seen in use by some among the SOM despite its age."

	suit_store = /obj/item/weapon/gun/rifle/mpi_km/black/grenadier
	belt = /obj/item/storage/belt/marine/som/mpi_black

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/ammo_magazine/rifle/mpi_km/black = 2,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 4,
		/obj/item/explosive/grenade/incendiary/som = 1,
	)

/datum/outfit/quick/som/marine/light_carbine
	name = "V-34 Light Infantryman"
	desc = "Mobile and dangerous. Equipped with a V-34 carbine, light armor with an 'Aegis' shield module and a large supply of grenades. The V-34 is a modern update of an old weapon that was a common sight during the original Martian rebellion. Very reliable and excellent stopping power in a small, lightweight package. Brought into service as a much cheaper alternative to the VX-32."

	wear_suit = /obj/item/clothing/suit/modular/som/light/shield
	suit_store = /obj/item/weapon/gun/rifle/som_carbine/black/standard
	belt = /obj/item/storage/belt/marine/som/carbine_black

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/ammo_magazine/rifle/mpi_km/carbine/black = 2,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 4,
		/obj/item/explosive/grenade/incendiary/som = 1,
	)

/datum/outfit/quick/som/marine/scout
	name = "V-21 Light Infantryman"
	desc = "Highly mobile scouting configuration. Equipped with a V-21 submachine gun with variable firerate allowing for extreme rates of fire when properly wielded, light armor with an 'Aegis' shield module and a good selection of grenades. Allows for exceptional mobility and blistering firepower, it will falter in extended engagements where low armor and the V-21's high rate of fire can become liabilities."

	wear_suit = /obj/item/clothing/suit/modular/som/light/shield
	suit_store = /obj/item/weapon/gun/smg/som/scout
	belt = /obj/item/storage/belt/marine/som/som_smg

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/ammo_magazine/smg/som = 3,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/explosive/grenade/incendiary/som = 2,
		/obj/item/binoculars = 1,
	)

/datum/outfit/quick/som/marine/shotgunner
	name = "V-51 Pointman"
	desc = "For close encounters. Equipped with a V-51 semi-automatic shotgun, light armor with an 'Aegis' shield module and a large selection of grenades. Allows for good mobility and dangerous CQC firepower."

	belt = /obj/item/storage/belt/shotgun/som/mixed
	wear_suit = /obj/item/clothing/suit/modular/som/light/shield
	suit_store = /obj/item/weapon/gun/shotgun/som/standard

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 3,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/explosive/grenade/flashbang/stun = 2,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/explosive/grenade/incendiary/som = 2,
		/obj/item/binoculars = 1,
	)

/datum/outfit/quick/som/marine/pyro
	name = "V-62 Flamethrower Operator"
	desc = "Smells like victory. Equipped with an V-62 incinerator and wide nozzle, V-11 equipped for rapid burst fire, heavy armor upgraded with a 'Hades' fireproof module, and a backtank of fuel. Has better than average range and can quickly burn down large areas. It suffers from significant slowdown, lacks an integrated extinguisher, and undisciplined use can result in rapidly consuming all available fuel."

	head = /obj/item/clothing/head/modular/som/hades
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/pyro
	belt = /obj/item/storage/holster/belt/pistol/m4a3/som
	back = /obj/item/ammo_magazine/flamer_tank/backtank
	suit_store = /obj/item/weapon/gun/flamer/som/mag_harness

	belt_contents = list(
		/obj/item/ammo_magazine/pistol/som/extended = 6,
		/obj/item/weapon/gun/pistol/som/burst = 1,
	)

	webbing_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/explosive/grenade/som = 1,
		/obj/item/ammo_magazine/pistol/som/extended = 2,
	)

/datum/outfit/quick/som/marine/breacher
	name = "V-21 Breacher"
	desc = "Heavy armored breaching configuration. Equipped with a V-21 submachine gun with variable firerate allowing for extreme rates of fire when properly wielded, heavy armor, a boarding shield and a good selection of grenades. Offers outstanding protection although damage may be lacking, particular at longer range."

	glasses = /obj/item/clothing/glasses/welding
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/shield
	suit_store = /obj/item/weapon/gun/smg/som/one_handed
	belt = /obj/item/storage/belt/marine/som/som_smg
	r_hand = /obj/item/weapon/shield/riot/marine/som

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/tool/weldingtool/largetank = 1,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/ammo_magazine/smg/som = 4,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/explosive/grenade/incendiary/som = 2,
		/obj/item/explosive/grenade/flashbang/stun = 1,
	)

/datum/outfit/quick/som/marine/breacher_melee
	name = "CQC Breacher"
	desc = "For when a complete lack of subtlety is required. Equipped with 'Lorica' enhanced heavy armor and armed with a monsterous two handed breaching axe, designed to cut through heavy armor. When properly wielded, it also provides a degree of protection."

	head = /obj/item/clothing/head/modular/som/lorica
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/lorica
	suit_store = /obj/item/weapon/twohanded/fireaxe/som
	belt = /obj/item/storage/holster/belt/pistol/m4a3/som

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/explosive/plastique = 3,
		/obj/item/tool/extinguisher = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/synaptizine = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
	)
	belt_contents = list(
		/obj/item/ammo_magazine/pistol/som/extended = 6,
		/obj/item/weapon/gun/pistol/som/burst = 1,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 4,
		/obj/item/explosive/grenade/incendiary/som = 1,
	)

/datum/outfit/quick/som/marine/machine_gunner
	name = "V-41 Machinegunner"
	desc = "Heavy static firesupport. Equipped with a V-41 machine gun, burst fire V-11 sidearm and some basic building supplies. While often ill suited to the SOM's standard doctrine of mobility and aggression, the V-41 is typically seen in defensive positions or second line units where its poor mobility is a minor drawback compared to its sustained firepower."

	suit_store = /obj/item/weapon/gun/rifle/som_mg/standard
	belt = /obj/item/storage/holster/belt/pistol/m4a3/som
	l_pocket = /obj/item/storage/pouch/construction/som

	belt_contents = list(
		/obj/item/ammo_magazine/pistol/som/extended = 6,
		/obj/item/weapon/gun/pistol/som/burst = 1,
	)

	backpack_contents = list(
		/obj/item/ammo_magazine/som_mg = 4,
		/obj/item/tool/extinguisher = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/explosive/grenade/smokebomb/som = 1,
		/obj/item/explosive/grenade/smokebomb/satrapine = 1,
		/obj/item/storage/box/mre/som = 1,
	)
	l_pocket_contents = list(
		/obj/item/tool/shovel/etool = 1,
		/obj/item/stack/sandbags_empty/half = 1,
		/obj/item/stack/sandbags/large_stack = 1,
		/obj/item/stack/barbed_wire/half_stack = 1,
	)

/datum/outfit/quick/som/marine/charger
	name = "Charger Infantryman"
	desc = "The future infantryman of the SOM. Equipped with a volkite charger, medium armor and a good variety of grenades. Volkite weapons are exceptionally dangerous, especially against poorly armored or tightly grouped opponents. The charger is the SOM's premier close/medium range weapon, with good mobility, and can be used (with some difficulty) one handed when required."
	quantity = 4

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger/magharness
	belt = /obj/item/storage/belt/marine/som/volkite

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/cell/lasgun/volkite = 2,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/explosive/grenade/incendiary/som = 2,
		/obj/item/tool/extinguisher/mini = 1,
	)
