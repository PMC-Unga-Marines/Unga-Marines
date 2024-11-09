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

/datum/outfit/quick/beginner/robot/lasermachinegunner
	name = "Laser Machinegunner"
	desc = "The king of suppressive fire. Uses the MG-60, a fully automatic 200 round machine gun with a bipod attached. \
	Excels at denying large areas to the enemy and eliminating those who refuse to leave."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_mlaser/beginner
	back = /obj/item/cell/lasgun/volkite/powerpack/marine_back
	belt = /obj/item/belt_harness/marine
	head = /obj/item/clothing/head/modular/robot/heavy/tyr
	wear_suit = /obj/item/clothing/suit/modular/robot/heavy/tyr_onegeneral

/datum/outfit/quick/beginner/robot/lasermachinegunner/post_equip(mob/living/carbon/human/robot, visualsOnly)
	. = ..()
	robot.equip_to_slot_or_del(new /obj/item/weapon/powerfist/full, SLOT_IN_SUIT)
	robot.equip_to_slot_or_del(new /obj/item/cell/lasgun/lasrifle, SLOT_IN_SUIT)
