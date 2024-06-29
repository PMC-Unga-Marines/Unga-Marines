//Captain

/datum/job/terragov/command/captain/after_spawn(mob/living/new_mob, mob/user, latejoin)
	..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	new_human.dropItemToGround(new_human.head)
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "O6"
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/marine/captain/black, SLOT_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/captain_cloak_red, SLOT_BACK)
		if(1501 to 3000) // 25hrs
			new_human.wear_id.paygrade = "O7"
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/highcap/captain/black, SLOT_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/captain_cloak_red, SLOT_BACK)
		if(3001 to 4500) //50 hrs
			new_human.wear_id.paygrade = "O8"
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/marine/captain, SLOT_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/captain_cloak_red/white, SLOT_BACK)
		if(4501 to INFINITY) //75 hrs
			new_human.wear_id.paygrade = "O9"
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/highcap/captain, SLOT_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/captain_cloak_red/white, SLOT_BACK)


/datum/outfit/job/command/captain
	belt = /obj/item/storage/holster/blade/officer/sabre/full
	glasses = /obj/item/clothing/glasses/sunglasses/aviator/yellow
	head = null
	back = FALSE

//Staff officer
/datum/job/terragov/command/staffofficer/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	new_human.dropItemToGround(new_human.head)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "O3"
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/marine/staff, SLOT_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/officer_cloak_red, SLOT_BACK)
		if(1501 to 3000) // 25 hrs
			new_human.wear_id.paygrade = "O4"
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/highcap/staff, SLOT_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/officer_cloak_red, SLOT_BACK)
		if(3001 to INFINITY) // 50 hrs
			new_human.wear_id.paygrade = "O5"
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/highcap/staff, SLOT_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/officer_cloak_red/alt, SLOT_BACK)

/datum/outfit/job/command/staffofficer
	back = FALSE
	head = null
	w_uniform = /obj/item/clothing/under/marine/whites/blacks
	shoes = /obj/item/clothing/shoes/laceup

/datum/job/terragov/engineering/tech
	exp_type = EXP_TYPE_REGULAR_ALL
	exp_requirements = XP_REQ_INTERMEDIATE

/datum/job/terragov/medical/medicalofficer
	exp_type = EXP_TYPE_REGULAR_ALL
	exp_requirements = XP_REQ_INTERMEDIATE

/datum/job/terragov/medical/researcher
	exp_type = EXP_TYPE_MEDICAL
	exp_requirements = XP_REQ_INTERMEDIATE

/datum/job/terragov/command/pilot
	exp_type = EXP_TYPE_REGULAR_ALL
	exp_requirements = XP_REQ_EXPERIENCED

/datum/job/terragov/command/pilot/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to support marines with either close air support via the Condor, or mobile dropship support with the Tadpole.
While you are in charge of all aerial crafts the Normandy does not require supervision outside of turning automatic mode on or off at crucial times, and you are expected to choose between the Condor and Tadpole.
Though you are a warrant officer, your authority is limited to the dropship and your chosen aerial craft, where you have authority over the enlisted personnel.
"})

/datum/job/terragov/engineering/chief
	exp_type = EXP_TYPE_ENGINEERING
	exp_requirements = XP_REQ_INTERMEDIATE

/datum/job/terragov/requisitions/officer
	exp_type = EXP_TYPE_REGULAR_ALL
	exp_requirements = XP_REQ_EXPERIENCED

/datum/job/terragov/medical/professor
	exp_type = EXP_TYPE_MEDICAL
	exp_requirements = XP_REQ_INTERMEDIATE

/datum/job/terragov/civilian/liaison
	exp_type = EXP_TYPE_REGULAR_ALL
	exp_requirements = XP_REQ_INTERMEDIATE

/datum/job/terragov/silicon/ai
	exp_type = EXP_TYPE_REGULAR_ALL
	exp_requirements = XP_REQ_EXPERIENCED

/datum/job/terragov/command/fieldcommander
	exp_type = EXP_TYPE_MARINES
	exp_requirements = XP_REQ_EXPERT

/datum/job/terragov/command/mech_pilot
	exp_type = EXP_TYPE_MARINES
	exp_requirements = XP_REQ_EXPERIENCED

/datum/job/terragov/silicon/synthetic
	exp_type = EXP_TYPE_REGULAR_ALL
	exp_requirements = XP_REQ_EXPERT

/datum/job/terragov/silicon/synthetic/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) //up to 10 hours
			new_human.wear_id.paygrade = "Mk.I"
		if(601 to 3000) // 10 to 50 hrs
			new_human.wear_id.paygrade = "Mk.II"
		if(3001 to 6000) // 50 to 100 hrs
			new_human.wear_id.paygrade = "Mk.III"
		if(6001 to 9000) // 100 to 150 hrs
			new_human.wear_id.paygrade = "Mk.IV"
		if(9001 to 12000) // 150 to 200 hrs
			new_human.wear_id.paygrade = "Mk.V"
		if(12001 to 15000) // 200 to 250 hrs
			new_human.wear_id.paygrade = "Mk.VI"
		if(15001 to 18000) // 250 to 300 hrs
			new_human.wear_id.paygrade = "Mk.VII"
		if(18001 to 21000) // 300 to 350 hrs
			new_human.wear_id.paygrade = "Mk.VIII"
		if(21001 to 60000) // 350 to 1000 hrs
			new_human.wear_id.paygrade = "Mk.IX"
		if(60001 to INFINITY) // 1000 hrs and more
			new_human.wear_id.paygrade = "Mk.X"

/datum/job/terragov/command/captain
	exp_type = EXP_TYPE_REGULAR_ALL
	exp_requirements = XP_REQ_EXPERT

/datum/job/terragov/command/staffofficer
	exp_type = EXP_TYPE_REGULAR_ALL
	exp_requirements = XP_REQ_EXPERIENCED
