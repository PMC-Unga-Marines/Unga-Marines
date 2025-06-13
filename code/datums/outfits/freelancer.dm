/datum/outfit/job/freelancer
	name = "Freelancer"
	jobtype = /datum/job/freelancer

	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/distress/dutch
	mask = /obj/item/clothing/mask/rebreather/scarf/freelancer
	w_uniform = /obj/item/clothing/under/marine/veteran/freelancer
	belt = /obj/item/storage/belt/marine
	wear_suit = /obj/item/clothing/suit/storage/faction/freelancer
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/marine/veteran/pmc
	head = /obj/item/clothing/head/frelancer
	back = /obj/item/storage/backpack/lightpack
	l_pocket = /obj/item/storage/pouch/medkit/firstaid

	suit_contents = list(
		/obj/item/explosive/grenade/m15 = 2,
	)
	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/synaptizine = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
	)
	backpack_contents = list(
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/reagent_containers/food/snacks/burger/tofu = 1,
		/obj/item/reagent_containers/food/drinks/flask/marine = 1,
	)

/datum/outfit/job/freelancer/standard
	name = "Freelancer Standard"
	jobtype = /datum/job/freelancer/standard

	backpack_contents = list(
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/reagent_containers/food/snacks/burger/tofu = 1,
		/obj/item/reagent_containers/food/drinks/flask/marine = 1,
		/obj/item/stack/sheet/metal/medium_stack = 1,
		/obj/item/stack/sheet/metal/small_stack = 1,
		/obj/item/stack/sheet/plasteel/medium_stack = 1,
	)

/datum/outfit/job/freelancer/standard/one
	suit_store = /obj/item/weapon/gun/rifle/m16/freelancer
	r_pocket = /obj/item/storage/pouch/shotgun

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/m16 = 6,
	)

	backpack_contents = list(
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/reagent_containers/food/snacks/burger/tofu = 1,
		/obj/item/reagent_containers/food/drinks/flask/marine = 1,
		/obj/item/ammo_magazine/pistol/g22 = 3,
		/obj/item/ammo_magazine/rifle/m16 = 2,
	)

	r_pocket_contents = list(
		/obj/item/ammo_magazine/handful/buckshot = 7,
	)

/datum/outfit/job/freelancer/standard/two
	suit_store = /obj/item/weapon/gun/rifle/m16/ugl
	r_pocket = /obj/item/storage/pouch/grenade

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/m16 = 6,
	)

	backpack_contents = list(
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/reagent_containers/food/snacks/burger/tofu = 1,
		/obj/item/reagent_containers/food/drinks/flask/marine = 1,
		/obj/item/ammo_magazine/pistol/g22 = 3,
		/obj/item/ammo_magazine/rifle/m16 = 2,
	)

	r_pocket_contents = list(
		/obj/item/explosive/grenade = 4,
		/obj/item/explosive/grenade/incendiary = 2,
	)

/datum/outfit/job/freelancer/standard/three
	suit_store = /obj/item/weapon/gun/rifle/ar11/freelancerone
	r_pocket = /obj/item/storage/pouch/grenade

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/ar11 = 6,
	)

	backpack_contents = list(
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/reagent_containers/food/snacks/burger/tofu = 1,
		/obj/item/reagent_containers/food/drinks/flask/marine = 1,
		/obj/item/ammo_magazine/pistol/g22 = 3,
		/obj/item/ammo_magazine/rifle/ar11 = 2,
	)

	r_pocket_contents = list(
		/obj/item/explosive/grenade = 4,
		/obj/item/explosive/grenade/incendiary = 2,
	)

/datum/outfit/job/freelancer/medic
	name = "Freelancer Medic"
	jobtype = /datum/job/freelancer/medic

	belt = /obj/item/storage/belt/lifesaver/full
	wear_suit = /obj/item/clothing/suit/storage/faction/freelancer/medic
	glasses = /obj/item/clothing/glasses/hud/health
	suit_store = /obj/item/weapon/gun/rifle/famas/freelancermedic
	r_pocket = /obj/item/storage/pouch/medical_injectors/medic
	l_pocket = /obj/item/storage/pouch/magazine/large

	backpack_contents = list(
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/reagent_containers/food/snacks/burger/tofu = 1,
		/obj/item/reagent_containers/food/drinks/flask/marine = 1,
		/obj/item/defibrillator = 1,
		/obj/item/healthanalyzer = 1,
		/obj/item/roller = 1,
		/obj/item/tweezers = 1,
		/obj/item/ammo_magazine/rifle/famas = 2,
		/obj/item/ammo_magazine/pistol/g22 = 1,
	)
	l_pocket_contents = list(
		/obj/item/ammo_magazine/rifle/famas = 3,
	)

/datum/outfit/job/freelancer/veteran
	name = "Freelancer Veteran"
	jobtype = /datum/job/freelancer/veteran

/datum/outfit/job/freelancer/veteran/one
	w_uniform = /obj/item/clothing/under/marine/veteran/freelancer/veteran
	suit_store = /obj/item/weapon/gun/rifle/alf_machinecarbine/freelancer
	r_pocket = /obj/item/storage/pouch/grenade

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/alf_machinecarbine = 6,
	)

	backpack_contents = list(
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/reagent_containers/food/snacks/burger/tofu = 1,
		/obj/item/reagent_containers/food/drinks/flask/marine = 1,
		/obj/item/stack/sheet/metal/medium_stack = 1,
		/obj/item/stack/sheet/plasteel/medium_stack = 1,
		/obj/item/ammo_magazine/pistol/g22 = 3,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/ammo_magazine/rifle/alf_machinecarbine = 2,
	)

	r_pocket_contents = list(
		/obj/item/explosive/grenade = 2,
		/obj/item/explosive/grenade/smokebomb/cloak = 2,
		/obj/item/explosive/grenade/incendiary = 2,
	)

/datum/outfit/job/freelancer/veteran/two
	belt = /obj/item/storage/belt/sparepouch
	suit_store = /obj/item/weapon/gun/rifle/m412l1_hpr/freelancer

	belt_contents = list(
		/obj/item/ammo_magazine/m412l1_hpr = 3,
	)

	backpack_contents = list(
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/reagent_containers/food/snacks/burger/tofu = 1,
		/obj/item/reagent_containers/food/drinks/flask/marine = 1,
		/obj/item/ammo_magazine/pistol/g22 = 3,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/ammo_magazine/m412l1_hpr = 4,
	)

	r_pocket_contents = list(
		/obj/item/explosive/grenade = 2,
		/obj/item/explosive/grenade/smokebomb/cloak = 2,
		/obj/item/explosive/grenade/incendiary = 2,
	)

/datum/outfit/job/freelancer/veteran/three
	suit_store = /obj/item/weapon/gun/rifle/tx55/freelancer
	r_pocket = /obj/item/storage/pouch/magazine/large

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/ar12 = 2,
		/obj/item/ammo_magazine/rifle/tx54 = 2,
		/obj/item/ammo_magazine/rifle/tx54/incendiary = 2,
	)

	backpack_contents = list(
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/reagent_containers/food/snacks/burger/tofu = 1,
		/obj/item/reagent_containers/food/drinks/flask/marine = 1,
		/obj/item/ammo_magazine/pistol/g22 = 2,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/ammo_magazine/rifle/tx54 = 2,
		/obj/item/ammo_magazine/rifle/tx54/incendiary = 2,
	)

	r_pocket_contents = list(
		/obj/item/ammo_magazine/rifle/ar12 = 3,
	)

/datum/outfit/job/freelancer/leader
	name = "Freelancer Leader"
	jobtype = /datum/job/freelancer/leader

/datum/outfit/job/freelancer/leader
	w_uniform = /obj/item/clothing/under/marine/veteran/freelancer/veteran
	head = /obj/item/clothing/head/frelancer/beret
	glasses = /obj/item/clothing/glasses/hud/health

	backpack_contents = list(
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/reagent_containers/food/snacks/burger/tofu = 1,
		/obj/item/reagent_containers/food/drinks/flask/marine = 1,
		/obj/item/stack/sheet/metal/large_stack = 1,
	)

/datum/outfit/job/freelancer/leader/one
	belt = /obj/item/storage/belt/grenade/b17
	wear_suit = /obj/item/clothing/suit/storage/faction/freelancer/leader
	suit_store = /obj/item/weapon/gun/rifle/m16/freelancer
	r_pocket = /obj/item/storage/pouch/shotgun

	backpack_contents = list(
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/reagent_containers/food/snacks/burger/tofu = 1,
		/obj/item/reagent_containers/food/drinks/flask/marine = 1,
		/obj/item/stack/sheet/metal/large_stack = 1,
		/obj/item/ammo_magazine/rifle/m16 = 3,
		/obj/item/ammo_magazine/pistol/g22 = 2,
	)

	r_pocket_contents = list(
		/obj/item/ammo_magazine/handful/buckshot = 7,
	)

///ar11
/datum/outfit/job/freelancer/leader/two
	belt = /obj/item/belt_harness/marine
	wear_suit = /obj/item/clothing/suit/storage/faction/freelancer/leader/two
	suit_store = /obj/item/weapon/gun/rifle/ar11/freelancertwo
	r_pocket = /obj/item/storage/pouch/grenade

	backpack_contents = list(
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/reagent_containers/food/snacks/burger/tofu = 1,
		/obj/item/reagent_containers/food/drinks/flask/marine = 1,
		/obj/item/stack/sheet/metal/large_stack = 1,
		/obj/item/ammo_magazine/rifle/ar11 = 3,
		/obj/item/ammo_magazine/pistol/g22 = 2,
	)

	r_pocket_contents = list(
		/obj/item/explosive/grenade = 4,
		/obj/item/explosive/grenade/incendiary = 2,
	)

/datum/outfit/job/freelancer/leader/three
	wear_suit = /obj/item/clothing/suit/storage/faction/freelancer/leader/three
	suit_store = /obj/item/weapon/gun/rifle/tx55/freelancer
	r_pocket = /obj/item/storage/pouch/magazine/large

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/ar12 = 2,
		/obj/item/ammo_magazine/rifle/tx54 = 2,
		/obj/item/ammo_magazine/rifle/tx54/incendiary = 2,
	)

	backpack_contents = list(
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/reagent_containers/food/snacks/burger/tofu = 1,
		/obj/item/reagent_containers/food/drinks/flask/marine = 1,
		/obj/item/stack/sheet/metal/large_stack = 1,
		/obj/item/ammo_magazine/rifle/ar12 = 3,
		/obj/item/ammo_magazine/pistol/g22 = 2
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/rifle/ar12 = 3,
	)
