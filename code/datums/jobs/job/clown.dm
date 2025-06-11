/datum/job/terragov/civilian/clown
	title = CLOWN
	paygrade = "CLW"
	comm_title = "CLW"
	total_positions = 0
	access = list(
		ACCESS_MARINE_ALPHA,
		ACCESS_MARINE_BRAVO,
		ACCESS_MARINE_CHARLIE,
		ACCESS_MARINE_DELTA,
		ACCESS_MARINE_PREP,
		ACCESS_MARINE_ROBOT,
		ACCESS_MARINE_ENGPREP,
		ACCESS_MARINE_SMARTPREP,
		ACCESS_MARINE_MEDPREP,
		ACCESS_MARINE_MEDBAY,
		ACCESS_MARINE_CHEMISTRY,
		ACCESS_CIVILIAN_MEDICAL,
		ACCESS_CIVILIAN_RESEARCH,
		ACCESS_CIVILIAN_ENGINEERING,
		ACCESS_MARINE_ENGINEERING,
		ACCESS_MARINE_LEADER,
	)
	minimal_access = list(
		ACCESS_MARINE_ALPHA,
		ACCESS_MARINE_BRAVO,
		ACCESS_MARINE_CHARLIE,
		ACCESS_MARINE_DELTA,
		ACCESS_MARINE_PREP,
		ACCESS_MARINE_DROPSHIP,
		ACCESS_MARINE_ROBOT,
		ACCESS_MARINE_ENGPREP,
		ACCESS_MARINE_SMARTPREP,
		ACCESS_MARINE_MEDPREP,
		ACCESS_MARINE_MEDBAY,
		ACCESS_MARINE_CHEMISTRY,
		ACCESS_CIVILIAN_MEDICAL,
		ACCESS_CIVILIAN_RESEARCH,
		ACCESS_CIVILIAN_ENGINEERING,
		ACCESS_MARINE_ENGINEERING,
		ACCESS_MARINE_LEADER,
	)
	skills_type = /datum/skills/civilian/clown
	display_order = JOB_DISPLAY_ORDER_CLOWN
	outfit = /datum/outfit/job/civilian/clown
	boosty_job = TRUE
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: HONK!<br /><br />
		<b>You answer to the</b> Honkmother<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Distress<br /><br /><br />
		<b>Duty</b>: Your primary job is to HONK! Do pranks and funny jokes, tell anecdotes, annoy marines, try not to die, try to resist pepperball, survive, for the glore of the Honkmother! HONK!
	"}

	minimap_icon = "clown"

/datum/job/terragov/civilian/clown/after_spawn(mob/living/carbon/C, mob/M, latejoin = FALSE)
	. = ..()

	C.equip_to_slot_or_del(new /obj/item/tool/soap/clown, SLOT_IN_BACKPACK)
	C.equip_to_slot_or_del(new /obj/item/tool/soap/clown, SLOT_IN_BACKPACK)
	C.equip_to_slot_or_del(new /obj/item/tool/soap/clown, SLOT_IN_BACKPACK)

/datum/job/terragov/civilian/clown/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your primary job is to uphold the law, order, peace and stability aboard the ship. Marines can get rowdy after a few weeks of cryosleep!
In addition, you are tasked with the security of high-ranking personnel, including the command staff. Keep them safe!"})

/datum/outfit/job/civilian/clown
	name = CLOWN
	jobtype = /datum/job/terragov/civilian/clown

	id = /obj/item/card/id
	ears = /obj/item/radio/headset/mainship/service
	belt = null
	mask = /obj/item/clothing/mask/gas/clown_hat
	w_uniform = /obj/item/clothing/under/rank/clown
	shoes = /obj/item/clothing/shoes/clown_shoes
	r_store = /obj/item/toy/bikehorn
	l_store = /obj/item/instrument/bikehorn
	gloves = /obj/item/clothing/gloves/white
	back = /obj/item/storage/backpack/clown
