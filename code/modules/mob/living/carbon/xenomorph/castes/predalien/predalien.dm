/mob/living/carbon/xenomorph/predalien
	caste_base_type = /datum/xeno_caste/predalien
	name = "Abomination" //snowflake name
	desc = "A strange looking creature with fleshy strands on its head. It appears like a mixture of armor and flesh, smooth, but well carapaced."
	icon = 'icons/Xeno/castes/predalien/praetorian.dmi'
	icon_state = "Predalien Walking"
	effects_icon = 'icons/Xeno/castes/predalien/praetorian_effects.dmi'
	wall_smash = TRUE
	pixel_x = -16
	bubble_icon = "alienroyal"
	talk_sound = SFX_PREDALIEN_TALK
	mob_size = MOB_SIZE_BIG

	tier = XENO_TIER_FOUR
	upgrade = XENO_UPGRADE_NORMAL

	footstep_type = FOOTSTEP_PREDALIEN_STOMPY

	skins = list(
		/datum/xenomorph_skin/predalien,
		/datum/xenomorph_skin/predalien/warrior,
	)

	max_bonus_life_kills = 10

/mob/living/carbon/xenomorph/predalien/Initialize(mapload, mob/living/carbon/xenomorph/oldxeno, h_number)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(announce_spawn)), 3 SECONDS)
	hunter_data.dishonored = TRUE
	hunter_data.dishonored_reason = "An abomination upon the honor of us all!"
	hunter_data.dishonored_set = src
	hud_set_hunter()

/mob/living/carbon/xenomorph/predalien/Stat()
	. = ..()
	if(statpanel("Game"))
		stat("Life Kills Bonus:", "[min(life_kills_total, max_bonus_life_kills)] / [max_bonus_life_kills]")

/mob/living/carbon/xenomorph/predalien/proc/announce_spawn()
	if(!loc)
		return FALSE

	to_chat(src, {"
		<span class='role_body'>|______________________|</span>
		<span class='role_header'>You are a predator-alien hybrid!</span>
		<span class='role_body'>You are a very powerful xenomorph creature that was born of a Yautja warrior body.
		You are stronger, faster, and smarter than a regular xenomorph, but you must still listen to the hive ruler.
		You have a degree of freedom to where you can hunt and claim the heads of the hive's enemies, so check your verbs.
		Your health meter will not regenerate normally, so kill and die for the hive!</span>
		<span class='role_body'>|______________________|</span>
	"})
	emote("roar")

/mob/living/carbon/xenomorph/predalien/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/predalien/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/predalien/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/predalien/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/predalien/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/predalien/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
