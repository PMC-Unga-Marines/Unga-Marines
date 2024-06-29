/datum/species
	icobase = 'modular_RUtgmc/icons/mob/human_races/r_human.dmi'

/datum/species/early_synthetic
	icobase = 'modular_RUtgmc/icons/mob/human_races/r_synthetic.dmi'

/datum/species/human/vatborn
	icobase = 'modular_RUtgmc/icons/mob/human_races/r_vatborn.dmi'

/datum/species/human/vatgrown
	icobase = 'modular_RUtgmc/icons/mob/human_races/r_vatgrown.dmi'

/datum/species/necoarc
	name = "Neco Arc"
	name_plural = "Neco Arc"
	icobase = 'modular_RUtgmc/icons/mob/human_races/r_NecoArc.dmi'
	default_language_holder = /datum/language_holder/sectoid
	eyes = "blank_eyes"
	speech_verb_override = "transmits"
	count_human = TRUE

	species_flags = HAS_NO_HAIR|NO_BREATHE|NO_POISON|NO_PAIN|USES_ALIEN_WEAPONS|NO_DAMAGE_OVERLAY

	paincries = list("neuter" = 'modular_RUtgmc/sound/voice/necoarc/NecoVIBIVII!!.ogg')
	death_sound = 'modular_RUtgmc/sound/voice/necoarc/Necojooooonoooooooo.ogg'

	blood_color = "#00FF00"
	flesh_color = "#C0C0C0"

	reagent_tag = IS_SECTOID

	namepool = /datum/namepool/necoarc
	special_death_message = "You have perished."
