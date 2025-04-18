/datum/species/necoarc
	name = "Neco Arc"
	icobase = 'icons/mob/human_races/r_NecoArc.dmi'
	default_language_holder = /datum/language_holder/sectoid
	eyes = "blank_eyes"
	count_human = TRUE
	total_health = 80

	species_flags = HAS_NO_HAIR|NO_BREATHE|NO_POISON|NO_PAIN|USES_ALIEN_WEAPONS|NO_DAMAGE_OVERLAY

	paincries = list("neuter" = 'sound/voice/necoarc/NecoVIBIVII!!.ogg')
	death_sound = 'sound/voice/necoarc/Necojooooonoooooooo.ogg'

	blood_color = "#00FF00"
	flesh_color = "#C0C0C0"

	reagent_tag = IS_SECTOID

	namepool = /datum/namepool/necoarc
	special_death_message = "You have perished."
