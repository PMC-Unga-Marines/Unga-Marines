/mob/living/carbon/xenomorph/baneling
	caste_base_type = /datum/xeno_caste/baneling
	name = "Baneling"
	desc = "An oozy, squishy alien that can roll in agile speeds, storing dangerous chemicals in its sac..."
	icon = 'icons/Xeno/castes/baneling/basic.dmi'
	icon_state = "Baneling Walking"
	effects_icon = 'icons/Xeno/castes/baneling/effects.dmi'
	bubble_icon = "alienleft"
	health = 100
	maxHealth = 100
	plasma_stored = 50
	tier = XENO_TIER_MINION
	upgrade = XENO_UPGRADE_BASETYPE
	pixel_x = -16
	gib_chance = 100

/mob/living/carbon/xenomorph/baneling/UnarmedAttack(atom/A, has_proximity, modifiers)
	/// We dont wanna be able to slash while balling
	if((m_intent == MOVE_INTENT_RUN) && !isxenostructure(A))
		return
	return ..()

// ***************************************
// *********** Icon
// ***************************************
/mob/living/carbon/xenomorph/baneling/handle_special_state()
	. = ..()
	if(m_intent == MOVE_INTENT_RUN)
		icon_state = "[xeno_caste.caste_name] Running"
		return TRUE
	return FALSE

/mob/living/carbon/xenomorph/baneling/handle_special_wound_states(severity)
	. = ..()
	if(m_intent == MOVE_INTENT_RUN)
		return "wounded_running_[severity]"
