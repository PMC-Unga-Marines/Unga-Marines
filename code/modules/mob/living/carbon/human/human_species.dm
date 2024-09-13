// These may have some say.dm bugs regarding understanding common,
// might be worth adapting the bugs into a feature and using these
// subtypes as a basis for non-common-speaking alien foreigners. ~ Z

/mob/living/carbon/human/species/monkey
	race = "Monkey"

/mob/living/carbon/human/species/monkey/farwa
	race = "Farwa"

/mob/living/carbon/human/species/monkey/naera
	race = "Naera"

/mob/living/carbon/human/species/monkey/stok
	race = "Stok"

/mob/living/carbon/human/species/monkey/yiren
	race = "Yiren"

/mob/living/carbon/human/species/synthetic
	race = "Synthetic"

/mob/living/carbon/human/species/synthetic/set_jump_component(duration = 0.5 SECONDS, cooldown = 2 SECONDS, cost = 0, height = 16, sound = null, flags = JUMP_SHADOW, flags_pass = PASS_LOW_STRUCTURE|PASS_FIRE|PASS_TANK)
	var/gravity = get_gravity()
	if(gravity < 1) //low grav
		duration *= 2.5 - gravity
		cooldown *= 2 - gravity
		height *= 2 - gravity
		if(gravity <= 0.75)
			flags_pass |= PASS_DEFENSIVE_STRUCTURE
	else if(gravity > 1) //high grav
		duration *= gravity * 0.5
		cooldown *= gravity
		height *= gravity * 0.5

	AddComponent(/datum/component/jump, _jump_duration = duration, _jump_cooldown = cooldown, _stamina_cost = 0, _jump_height = height, _jump_sound = sound, _jump_flags = flags, _jumper_allow_pass_flags = flags_pass)

/mob/living/carbon/human/species/early_synthetic
	race = "Early Synthetic"

/mob/living/carbon/human/species/early_synthetic/set_jump_component(duration = 0.5 SECONDS, cooldown = 2 SECONDS, cost = 0, height = 16, sound = null, flags = JUMP_SHADOW, flags_pass = PASS_LOW_STRUCTURE|PASS_FIRE|PASS_TANK)
	var/gravity = get_gravity()
	if(gravity < 1) //low grav
		duration *= 2.5 - gravity
		cooldown *= 2 - gravity
		height *= 2 - gravity
		if(gravity <= 0.75)
			flags_pass |= PASS_DEFENSIVE_STRUCTURE
	else if(gravity > 1) //high grav
		duration *= gravity * 0.5
		cooldown *= gravity
		height *= gravity * 0.5

	AddComponent(/datum/component/jump, _jump_duration = duration, _jump_cooldown = cooldown, _stamina_cost = 0, _jump_height = height, _jump_sound = sound, _jump_flags = flags, _jumper_allow_pass_flags = flags_pass)

/mob/living/carbon/human/species/moth
	race = "Moth"

/datum/species/moth/handle_post_spawn(mob/living/carbon/human/H)
	. = ..()
	H.moth_wings = pick(GLOB.moth_wings_list - "Burnt Off")

/mob/living/carbon/human/species/vatgrown
	race = "Vat-Grown Human"

/mob/living/carbon/human/species/sectoid
	race = "Sectoid"

/mob/living/carbon/human/species/vatborn
	race = "Vatborn"

/mob/living/carbon/human/species/skeleton
	race = "Skeleton"

/mob/living/carbon/human/species/zombie
	race = "Strong zombie"

/mob/living/carbon/human/species/zombie/Initialize(mapload)
	. = ..()
	var/datum/outfit/outfit = pick(GLOB.survivor_outfits)
	outfit = new outfit()
	INVOKE_ASYNC(outfit, TYPE_PROC_REF(/datum/outfit, equip), src)
	a_intent = INTENT_HARM

/mob/living/carbon/human/species/robot
	race = "Combat Robot"
	bubble_icon = "robot"

/mob/living/carbon/human/species/robot/set_jump_component(duration = 0.5 SECONDS, cooldown = 2 SECONDS, cost = 0, height = 16, sound = null, flags = JUMP_SHADOW, flags_pass = PASS_LOW_STRUCTURE|PASS_FIRE|PASS_TANK)
	var/gravity = get_gravity()
	if(gravity < 1) //low grav
		duration *= 2.5 - gravity
		cooldown *= 2 - gravity
		height *= 2 - gravity
		if(gravity <= 0.75)
			flags_pass |= PASS_DEFENSIVE_STRUCTURE
	else if(gravity > 1) //high grav
		duration *= gravity * 0.5
		cooldown *= gravity
		height *= gravity * 0.5

	AddComponent(/datum/component/jump, _jump_duration = duration, _jump_cooldown = cooldown, _stamina_cost = 0, _jump_height = height, _jump_sound = sound, _jump_flags = flags, _jumper_allow_pass_flags = flags_pass)

/mob/living/carbon/human/species/robot/alpharii
	race = "Hammerhead Combat Robot"

/mob/living/carbon/human/species/robot/charlit
	race = "Chilvaris Combat Robot"

/mob/living/carbon/human/species/robot/deltad
	race = "Ratcher Combat Robot"

/mob/living/carbon/human/species/robot/bravada
	race = "Sterling Combat Robot"

/mob/living/carbon/human/species/necoarc
	race = "Neco Arc"
