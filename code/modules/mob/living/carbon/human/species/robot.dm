/datum/species/robot
	name = "Combat Robot"
	name_plural = "Combat Robots"
	species_type = SPECIES_COMBAT_ROBOT
	icobase = 'icons/mob/human_races/r_robot.dmi'
	damage_mask_icon = 'icons/mob/dam_mask_robot.dmi'
	brute_damage_icon_state = "robot_brute"
	burn_damage_icon_state = "robot_burn"
	eyes = "blank_eyes"
	hud_type = /datum/hud_data/robotic
	default_language_holder = /datum/language_holder/robot
	namepool = /datum/namepool/robotic

	unarmed_type = /datum/unarmed_attack/punch/strong
	total_health = 100
	slowdown = SHOES_SLOWDOWN //because they don't wear boots.

	cold_level_1 = -1
	cold_level_2 = -1
	cold_level_3 = -1

	heat_level_1 = 500
	heat_level_2 = 1000
	heat_level_3 = 2000

	body_temperature = 350

	inherent_traits = list(TRAIT_NON_FLAMMABLE, TRAIT_IMMEDIATE_DEFIB)
	species_flags = NO_BREATHE|NO_BLOOD|NO_POISON|NO_PAIN|NO_CHEM_METABOLIZATION|NO_STAMINA|DETACHABLE_HEAD|HAS_NO_HAIR|ROBOTIC_LIMBS|IS_INSULATED

	no_equip = list(
		SLOT_W_UNIFORM,
		SLOT_HEAD,
		SLOT_WEAR_MASK,
		SLOT_WEAR_SUIT,
		SLOT_SHOES,
		SLOT_GLOVES,
		SLOT_GLASSES,
	)
	blood_color = "#2d2055" //"oil" color
	hair_color = "#00000000"
	has_organ = list()


	screams = list(MALE = "robot_scream", FEMALE = "robot_scream", PLURAL = "robot_scream", NEUTER = "robot_scream")
	paincries = list(MALE = "robot_pain", FEMALE = "robot_pain", PLURAL = "robot_pain", NEUTER = "robot_pain")
	goredcries = list(MALE = "robot_scream", FEMALE = "robot_scream", PLURAL = "robot_scream", NEUTER = "robot_scream")
	warcries = list(MALE = "robot_warcry", FEMALE = "robot_warcry", PLURAL = "robot_warcry", NEUTER = "robot_warcry")
	laughs = list(MALE = "robot_male_laugh", FEMALE = "robot_female_laugh", PLURAL = "robot_male_laugh", NEUTER = "robot_female_laugh")
	death_message = "shudders violently whilst spitting out error text before collapsing, their visual sensor darkening..."
	special_death_message = "You have been shut down.<br><small>But it is not the end of you yet... if you still have your body, wait until somebody can resurrect you...</small>"
	joinable_roundstart = FALSE

	inherent_actions = list(/datum/action/repair_self)

/datum/species/robot/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	H.speech_span = SPAN_ROBOT
	H.health_threshold_crit = -100

/datum/species/robot/post_species_loss(mob/living/carbon/human/H)
	. = ..()
	H.speech_span = initial(H.speech_span)
	H.health_threshold_crit = -50

/datum/species/robot/handle_unique_behavior(mob/living/carbon/human/H)
	if(H.health <= 0 && H.health > -50)
		H.clear_fullscreen("robotlow")
		H.overlay_fullscreen("robothalf", /atom/movable/screen/fullscreen/machine/robothalf)
	else if(H.health <= -50)
		H.clear_fullscreen("robothalf")
		H.overlay_fullscreen("robotlow", /atom/movable/screen/fullscreen/machine/robotlow)
	else
		H.clear_fullscreen("robothalf")
		H.clear_fullscreen("robotlow")
	if(H.health > -25) //Staggerslowed if below crit threshold.
		return
	H.Stagger(2 SECONDS)
	H.adjust_slowdown(1)

/mob/living/carbon/human/species/robot/binarycheck(mob/H)
	return TRUE

/datum/species/robot/prefs_name(datum/preferences/prefs)
	. = prefs.squad_robot_name
	if(!. || . == "Undefined") //In case they don't have a name set.
		. = GLOB.namepool[namepool].get_random_name()
		to_chat(prefs.parent, span_warning("You forgot to set your robot in your preferences. Please do so next time."))

/datum/species/robot/alpharii
	name = "Hammerhead Combat Robot"
	name_plural = "Hammerhead Combat Robots"
	icobase = 'icons/mob/human_races/r_robot_alpharii.dmi'
	joinable_roundstart = FALSE

/datum/species/robot/charlit
	name = "Chilvaris Combat Robot"
	name_plural = "Chilvaris Combat Robots"
	icobase = 'icons/mob/human_races/r_robot_charlit.dmi'
	joinable_roundstart = FALSE

/datum/species/robot/deltad
	name = "Ratcher Combat Robot"
	name_plural = "Ratcher Combat Robots"
	icobase = 'icons/mob/human_races/r_robot_deltad.dmi'
	joinable_roundstart = FALSE

/datum/species/robot/bravada
	name = "Sterling Combat Robot"
	name_plural = "Sterling Combat Robots"
	icobase = 'icons/mob/human_races/r_robot_bravada.dmi'
	joinable_roundstart = FALSE
