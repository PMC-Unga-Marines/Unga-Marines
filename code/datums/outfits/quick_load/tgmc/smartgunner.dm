//Base TGMC smartgunner outfit
/datum/outfit/quick/tgmc/smartgunner
	name = "TGMC Squad Smartgunner"
	jobtype = SQUAD_SMARTGUNNER

	belt = /obj/item/belt_harness/marine
	ears = /obj/item/radio/headset/mainship/marine
	glasses = /obj/item/clothing/glasses/night/m56_goggles
	w_uniform = /obj/item/clothing/under/marine/black_vest
	shoes = /obj/item/clothing/shoes/marine/full
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/heavy/tyr_two
	gloves = /obj/item/clothing/gloves/marine
	mask = /obj/item/clothing/mask/gas/tactical
	head = /obj/item/clothing/head/modular/m10x/tyr
	r_pocket = /obj/item/storage/pouch/firstaid/combat_patrol
	l_pocket = /obj/item/storage/pouch/grenade/combat_patrol
	back = /obj/item/storage/backpack/marine/satchel

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

/datum/outfit/quick/tgmc/smartgunner/sg29
	name = "SG29 Smart Machinegunner"
	desc = "A gun smarter than the average bear, or marine. Equipped with an SG-29 smart machine gun and heavy armor upgraded with a 'Tyr' extra armor mdule, the SG is responsible for providing mobile, accurate firesupport thanks to your IFF ammunition."

	suit_store = /obj/item/weapon/gun/rifle/sg29/patrol

	backpack_contents = list(
		/obj/item/ammo_magazine/sg29 = 4,
		/obj/item/weapon/gun/pistol/vp70/tactical = 1,
	)
	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/pistol/vp70 = 4,
	)

/datum/outfit/quick/tgmc/smartgunner/minigun_sg
	name = "SG85 Smart Machinegunner"
	desc = "More bullets than sense. Equipped with an SG-85 smart gatling gun, an MP-19 sidearm, heavy armor upgraded with a 'Tyr' extra armor mdule and a whole lot of bullets. For when you want to unleash a firehose of firepower. Try not to run out of ammo."

	belt = /obj/item/storage/belt/sparepouch
	suit_store = /obj/item/weapon/gun/minigun/smart_minigun/motion_detector
	back = /obj/item/ammo_magazine/minigun_powerpack/smartgun

	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/smg/mp19 = 4,
	)
	belt_contents = list(
		/obj/item/ammo_magazine/packet/smart_minigun = 2,
		/obj/item/weapon/gun/smg/mp19/compact = 1,
	)

/datum/outfit/quick/tgmc/smartgunner/sg62
	name = "SG62 Smart Machinegunner"
	desc = "Flexibility and precision. Equipped with an SG-62 smart target rifle and heavy armor upgraded with a 'Tyr' extra armor mdule. The integrated spotting rifle comes with a variety of flexible ammo types, which combined with high damage, penetration and IFF, makes for a dangerous support loadout."

	belt = /obj/item/storage/belt/marine/sg62
	suit_store = /obj/item/weapon/gun/rifle/sg62/motion

	backpack_contents = list(
		/obj/item/ammo_magazine/rifle/sg153/incendiary = 2,
		/obj/item/ammo_magazine/rifle/sg153/tungsten = 2,
		/obj/item/ammo_magazine/pistol/vp70 = 3,
		/obj/item/weapon/gun/pistol/vp70/tactical = 1,
	)
	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/rifle/sg153/highimpact = 4,
	)
