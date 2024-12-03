#define JOB_DISPLAY_ORDER_BASIA 25
#define BASIA "Basia Test"

/obj/item/card/id/basia
	icon = 'icons/obj/items/card.dmi'
	name = "identification card"
	desc = "Basia's card. No more."
	icon_state = "gold"
	item_state = "gold_id"

/datum/skills/basia
	name = BASIA
	cqc = SKILL_CQC_MASTER
	police = SKILL_POLICE_MP
	medical = SKILL_MEDICAL_MASTER
	pistols = SKILL_PISTOLS_TRAINED
	firearms = SKILL_FIREARMS_TRAINED
	shotguns = SKILL_SHOTGUNS_TRAINED
	stamina = SKILL_STAMINA_SUPER
	large_vehicle = SKILL_LARGE_VEHICLE_VETERAN
	pilot = SKILL_PILOT_TRAINED
	melee_weapons = SKILL_MELEE_SUPER
	powerloader = SKILL_POWERLOADER_MASTER
	surgery = SKILL_SURGERY_MASTER
	engineer = SKILL_ENGINEER_INHUMAN
	construction = SKILL_CONSTRUCTION_INHUMAN
	firearms = SKILL_FIREARMS_TRAINED
	swordplay = SKILL_SWORDPLAY_TRAINED

/datum/job/terragov/command/basia
	title = BASIA
	paygrade = "Yellow"
	comm_title = "Yellow"
	total_positions = 0
	access = ALL_ACCESS
	minimal_access = ALL_ACCESS
	skills_type = /datum/skills/basia
	display_order = JOB_DISPLAY_ORDER_BASIA
	outfit = /datum/outfit/job/command/basia
	exp_requirements = XP_REQ_INTERMEDIATE
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Death<br /><br />
		<b>You answer to the</b> Captain<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Distress<br /><br /><br />
		<b>Duty</b>: Your primary job is to uphold the law, order, peace and stability aboard the ship. Marines can get rowdy after a few weeks of cryosleep!
In addition, you are tasked with the security of high-ranking personnel, including the command staff. Keep them safe!
	"}

	minimap_icon = "military_police"

/datum/job/terragov/command/basia/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your primary job is to uphold the law, order, peace and stability aboard the ship. Marines can get rowdy after a few weeks of cryosleep!
In addition, you are tasked with the security of high-ranking personnel, including the command staff. Keep them safe!"})

/datum/outfit/job/command/basia
	name = BASIA
	jobtype = /datum/job/terragov/command/basia

	id = /obj/item/card/id/basia
	ears = /obj/item/radio/headset/mainship/mp
	belt = NONE
	w_uniform = /obj/item/clothing/under/marine/jaeger
	shoes = /obj/item/clothing/shoes/marine/headskin
	head = /obj/item/clothing/head/tgmcberet/squad/bravo/black
	glasses = /obj/item/clothing/glasses/sunglasses/sa
	r_store = NONE
	l_store = NONE
	gloves = /obj/item/clothing/gloves/marine/fingerless
	back = NONE
	wear_suit = /obj/item/clothing/suit/storage/labcoat/researcher/basia
	suit_store = NONE
