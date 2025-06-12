/datum/outfit/quick/beginner/robot
	jobtype = SQUAD_ROBOT

	w_uniform = /obj/item/clothing/under/marine/robotic/black_vest
	shoes = null
	wear_suit = /obj/item/clothing/suit/modular/robot
	gloves = null
	mask = null
	head = /obj/item/clothing/head/modular/robot
	r_pocket = /obj/item/storage/pouch/tools/full

	webbing_contents = list(
		/obj/item/tool/surgery/solderingtool = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/tool/weldingtool = 1,
		/obj/item/storage/box/m94 = 2,
	)
	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/inaprovaline = 2,
	)

/datum/outfit/quick/beginner/robot/laser_rifle
	name = "Laser Rifleman"
	desc = "A typycal robotic rifleman. Uses the Laser Rifle, often called as the TE-M by marines. Has multiple firemodes for tactical flexibility. Uses standard Terra Experimental (abbreviated as TE) power cells. \
	As with all TE Laser weapons, they use a lightweight alloy combined without the need for bullets any longer decreases their weight and aiming speed quite some vs their ballistic counterparts."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle/medic
	belt = /obj/item/storage/belt/marine
	head = /obj/item/clothing/head/modular/robot/motion_detector
	wear_suit = /obj/item/clothing/suit/modular/robot/svalinn
	l_hand = /obj/item/paper/tutorial/robot_laser_rifleman

	belt_contents = list(
		/obj/item/cell/lasgun/lasrifle = 6,
	)

	backpack_contents = list(
		/obj/item/ammo_magazine/flamer_tank/mini = 6,
		/obj/item/weapon/powerfist/full = 1,
	)

	suit_contents = list(
		/obj/item/cell/lasgun/volkite/powerpack/marine = 1,
	)

/datum/outfit/quick/beginner/robot/laser_machinegunner
	name = "Laser Machinegunner"
	desc = "The king of suppressive fire. Uses the Laser Machinegun, often called as the TE-M by marines. High efficiency modulators ensure the TE-M has an extremely high fire count, and multiple firemodes makes it a flexible infantry support gun. Uses standard Terra Experimental (abbreviated as TE) power cells. \
	As with all TE Laser weapons, they use a lightweight alloy combined without the need for bullets any longer decreases their weight and aiming speed quite some vs their ballistic counterparts."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_mlaser/beginner
	back = /obj/item/cell/lasgun/volkite/powerpack/marine_back
	belt = /obj/item/belt_harness/marine
	head = /obj/item/clothing/head/modular/robot/heavy/tyr
	wear_suit = /obj/item/clothing/suit/modular/robot/heavy/tyr_onegeneral
	l_hand = /obj/item/paper/tutorial/robot_laser_machinegunner

	suit_contents = list(
		/obj/item/cell/lasgun/lasrifle = 1,
		/obj/item/weapon/powerfist/full = 1,
	)

/datum/outfit/quick/beginner/robot/laser_sniper
	name = "Laser Sniper"
	desc = "The king of suppressive fire. Uses the Laser Sniper Rifle, it has an integrated charge selector for normal, heat, and overcharge settings. Uses standard Terra Experimental (abbreviated as TE) power cells. \
	As with all TE Laser weapons, they use a lightweight alloy combined without the need for bullets any longer decreases their weight and aiming speed quite some vs their ballistic counterparts."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_sniper/beginner
	back = /obj/item/cell/lasgun/volkite/powerpack/marine_back
	belt = /obj/item/storage/holster/belt/pistol/laser
	head = /obj/item/clothing/head/modular/robot/light/motion_detector
	wear_suit = /obj/item/clothing/suit/modular/robot/light/baldur_general
	l_hand = /obj/item/paper/tutorial/robot_laser_sniper

	suit_contents = list(
		/obj/item/cell/lasgun/lasrifle = 1,
		/obj/item/weapon/powerfist/full = 1,
	)
