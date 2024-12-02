//It really should be just a subtype of synthetic
/datum/species/early_synthetic // Worse at medical, better at engineering. Tougher in general than later synthetics.
	name = "Early Synthetic"
	name_plural = "Early Synthetics"
	icobase = 'icons/mob/human_races/r_synthetic.dmi'
	hud_type = /datum/hud_data/robotic
	default_language_holder = /datum/language_holder/synthetic
	unarmed_type = /datum/unarmed_attack/punch
	slowdown = 1.15 //Slower than Late Synths.
	total_health = 200 //Tough boys, very tough boys.
	brute_mod = 0.6
	burn_mod = 0.6

	cold_level_1 = -1
	cold_level_2 = -1
	cold_level_3 = -1

	heat_level_1 = 500
	heat_level_2 = 1000
	heat_level_3 = 2000

	body_temperature = 350

	species_flags = NO_BREATHE|NO_SCAN|NO_BLOOD|NO_POISON|NO_PAIN|IS_SYNTHETIC|NO_CHEM_METABOLIZATION|NO_STAMINA|DETACHABLE_HEAD|HAS_UNDERWEAR|ROBOTIC_LIMBS|GREYSCALE_BLOOD

	blood_color = "#EEEEEE"
	hair_color = "#000000"
	has_organ = list()

	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	see_in_dark = 8

	screams = list(MALE = "male_scream", FEMALE = "female_scream")
	paincries = list(MALE = "male_pain", FEMALE = "female_pain")
	goredcries = list(MALE = "male_gored", FEMALE = "female_gored")
	warcries = list(MALE = "male_warcry", FEMALE = "female_warcry")
	laughs = list(MALE = "male_laugh", FEMALE = "female_laugh")
	special_death_message = "You have been shut down.<br><small>But it is not the end of you yet... if you still have your body, wait until somebody can resurrect you...</small>"

/datum/species/early_synthetic/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	var/datum/atom_hud/AH = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED_SYNTH]
	AH.add_hud_to(H)

/datum/species/early_synthetic/post_species_loss(mob/living/carbon/human/H)
	. = ..()
	var/datum/atom_hud/AH = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED_SYNTH]
	AH.remove_hud_from(H)

/mob/living/carbon/human/species/early_synthetic/binarycheck(mob/H)
	return TRUE

/datum/species/early_synthetic/prefs_name(datum/preferences/prefs)
	. = prefs.synthetic_name
	if(!. || . == "Undefined") //In case they don't have a name set.
		switch(prefs.gender)
			if(MALE)
				. = "David"
			if(FEMALE)
				. = "Anna"
			else
				. = "Jeri"
		to_chat(prefs.parent, span_warning("You forgot to set your synthetic name in your preferences. Please do so next time."))
