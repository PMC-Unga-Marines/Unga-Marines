/datum/outfit/quick/beginner/robot
	jobtype = SQUAD_ROBOT

	w_uniform = /obj/item/clothing/under/marine/robotic/black_vest
	shoes = null
	wear_suit = /obj/item/clothing/suit/modular/robot
	gloves = null
	mask = null
	head = /obj/item/clothing/head/modular/robot
	r_store = /obj/item/storage/pouch/tools/full

/datum/outfit/quick/beginner/robot/post_equip(mob/living/carbon/human/robot, visualsOnly)
	robot.equip_to_slot_or_del(new /obj/item/tool/surgery/solderingtool, SLOT_IN_ACCESSORY)
	robot.equip_to_slot_or_del(new /obj/item/stack/cable_coil, SLOT_IN_ACCESSORY)
	robot.equip_to_slot_or_del(new /obj/item/tool/weldingtool, SLOT_IN_ACCESSORY)
	robot.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_ACCESSORY)
	robot.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_ACCESSORY)

	robot.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/inaprovaline, SLOT_IN_HEAD)
	robot.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/inaprovaline, SLOT_IN_HEAD)

/datum/outfit/quick/beginner/robot/laser_rifle
	name = "Laser Rifleman"
	desc = "A typycal robotic rifleman. Uses the Laser Rifle, often called as the TE-M by marines. Has multiple firemodes for tactical flexibility. Uses standard Terra Experimental (abbreviated as TE) power cells. \
	As with all TE Laser weapons, they use a lightweight alloy combined without the need for bullets any longer decreases their weight and aiming speed quite some vs their ballistic counterparts."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle/medic
	belt = /obj/item/storage/belt/marine
	head = /obj/item/clothing/head/modular/robot/motion_detector
	wear_suit = /obj/item/clothing/suit/modular/robot/svalinn
	l_hand = /obj/item/paper/tutorial/robot_laser_rifleman

/datum/outfit/quick/beginner/robot/laser_rifle/post_equip(mob/living/carbon/human/robot, visualsOnly)
	. = ..()
	for(var/i in 1 to 3)
		robot.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_BELT)
	for(var/i in 1 to 3)
		robot.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle/recharger, SLOT_IN_BELT)

	for(var/i in 1 to 6)
		robot.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/mini, SLOT_IN_BACKPACK)
	robot.equip_to_slot_or_del(new /obj/item/weapon/powerfist/full, SLOT_IN_BACKPACK)

	robot.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/powerpack/marine, SLOT_IN_SUIT)

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

/datum/outfit/quick/beginner/robot/laser_machinegunner/post_equip(mob/living/carbon/human/robot, visualsOnly)
	. = ..()
	robot.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_SUIT)
	robot.equip_to_slot_or_del(new /obj/item/weapon/powerfist/full, SLOT_IN_SUIT)

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

/datum/outfit/quick/beginner/robot/laser_sniper/post_equip(mob/living/carbon/human/robot, visualsOnly)
	. = ..()
	robot.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_SUIT)
	robot.equip_to_slot_or_del(new /obj/item/weapon/powerfist/full, SLOT_IN_SUIT)
