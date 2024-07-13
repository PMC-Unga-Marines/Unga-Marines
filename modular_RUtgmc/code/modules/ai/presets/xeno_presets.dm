/mob/living/carbon/xenomorph/facehugger/ai

/mob/living/carbon/xenomorph/facehugger/ai/Initialize(mapload)
	. = ..()
	GLOB.hive_datums[hivenumber].facehuggers -= src
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno)

/mob/living/carbon/xenomorph/chimera/ai

/mob/living/carbon/xenomorph/chimera/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno)
