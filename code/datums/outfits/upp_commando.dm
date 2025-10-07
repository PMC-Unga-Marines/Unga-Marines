/datum/outfit/job/upp/commando
	wear_suit = /obj/item/clothing/suit/storage/faction/upp/commando
	head = /obj/item/clothing/head/uppcap
	mask = /obj/item/clothing/mask/gas/pmc/upp
	glasses = /obj/item/clothing/glasses/night/m42_night_goggles/upp
	r_pocket = /obj/item/storage/pouch/general/large
	l_pocket = /obj/item/storage/pouch/medical_injectors/firstaid
	implants = list(/obj/item/implant/suicide_dust)

/datum/outfit/job/upp/commando/standard
	name = "USL Elite Powder Monkey"
	jobtype = /datum/job/upp/commando/standard

	belt = /obj/item/storage/belt/marine/upp/full
	suit_store = /obj/item/weapon/gun/rifle/type71/commando

	backpack_contents = list(
		/obj/item/stack/sheet/metal/medium_stack = 1,
		/obj/item/reagent_containers/food/snacks/upp = 2,
		/obj/item/radio = 1,
		/obj/item/tool/crowbar/red = 1,
		/obj/item/explosive/grenade/smokebomb/cloak = 2,
		/obj/item/chameleon = 1,
		/obj/item/explosive/plastique = 2,
		/obj/item/binoculars = 1,
		/obj/item/restraints/handcuffs = 1,
	)

	r_pocket_contents = list(
		/obj/item/reagent_containers/hypospray/advanced = 1,
		/obj/item/reagent_containers/glass/bottle/chloralhydrate = 1,
		/obj/item/reagent_containers/glass/bottle/sleeptoxin = 1,
	)

/datum/outfit/job/upp/commando/medic
	name = "USL Elite Surgeon"
	jobtype = /datum/job/upp/commando/medic

	belt = /obj/item/storage/belt/lifesaver/full/upp
	w_uniform = /obj/item/clothing/under/marine/veteran/upp/medic
	suit_store = /obj/item/weapon/gun/smg/skorpion/commando
	r_pocket = /obj/item/storage/pouch/medkit/medic

	backpack_contents = list(
		/obj/item/defibrillator = 1,
		/obj/item/healthanalyzer = 1,
		/obj/item/binoculars = 1,
		/obj/item/radio = 1,
		/obj/item/tool/crowbar/red = 1,
		/obj/item/chameleon = 1,
		/obj/item/clothing/glasses/hud/health = 1,
		/obj/item/ammo_magazine/smg/skorpion = 6,
	)

/datum/outfit/job/upp/commando/leader
	name = "USL Elite Captain"
	jobtype = /datum/job/upp/commando/leader

	belt = /obj/item/storage/holster/belt/pistol/korovin/tranq
	head = /obj/item/clothing/head/uppcap/beret
	suit_store = /obj/item/weapon/gun/rifle/type71/commando

	backpack_contents = list(
		/obj/item/reagent_containers/food/snacks/upp = 1,
		/obj/item/radio = 1,
		/obj/item/tool/crowbar/red = 1,
		/obj/item/explosive/grenade/phosphorus/upp = 2,
		/obj/item/stack/sheet/metal/medium_stack = 1,
		/obj/item/stack/sheet/plasteel/small_stack = 1,
		/obj/item/chameleon = 1,
		/obj/item/ammo_magazine/rifle/type71 = 3,
	)

	r_pocket_contents = list(
		/obj/item/binoculars = 1,
		/obj/item/assembly/signaler = 1,
		/obj/item/detpack = 1,
	)
