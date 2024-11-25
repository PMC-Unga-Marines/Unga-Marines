#define JOB_DISPLAY_ORDER_CLOWN 26
#define CLOWN "Ship Clown"

/datum/skills/civilian/clown
	name = CLOWN
	cqc = SKILL_CQC_MASTER
	medical = SKILL_MEDICAL_UNTRAINED
	firearms = SKILL_FIREARMS_UNTRAINED
	melee_weapons = SKILL_MELEE_TRAINED

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

/obj/item/radio/headset/mainship/service
	name = "service radio headset"
	icon_state = "headset_marine_xray"
	keyslot = /obj/item/encryptionkey/general

/datum/element/waddling

/datum/element/waddling/Attach(datum/target)
	. = ..()
	if(!ismovable(target))
		return ELEMENT_INCOMPATIBLE
	if(isliving(target))
		RegisterSignal(target, COMSIG_MOVABLE_MOVED, PROC_REF(LivingWaddle))
	else
		RegisterSignal(target, COMSIG_MOVABLE_MOVED, PROC_REF(Waddle))

/datum/element/waddling/Detach(datum/source, force)
	. = ..()
	UnregisterSignal(source, COMSIG_MOVABLE_MOVED)

/datum/element/waddling/proc/LivingWaddle(mob/living/target)
	if(target.incapacitated())
		return
	Waddle(target)

/datum/element/waddling/proc/Waddle(atom/movable/target)
	animate(target, pixel_z = 4, time = 0)
	var/prev_trans = matrix(target.transform)
	animate(pixel_z = 0, transform = turn(target.transform, pick(-12, 0, 12)), time = 2)
	animate(pixel_z = 0, transform = prev_trans, time = 0)

/obj/item/clothing/shoes/clown_shoes
	var/enabled_waddle = TRUE

/obj/item/clothing/shoes/clown_shoes/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_SHOES && enabled_waddle)
		user.AddElement(/datum/element/waddling)

/obj/item/clothing/shoes/clown_shoes/unequipped(mob/user)
	. = ..()
	if(enabled_waddle)
		user.RemoveElement(/datum/element/waddling)
