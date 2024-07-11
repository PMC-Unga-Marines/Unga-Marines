/mob/living/carbon/xenomorph/hivemind
	icon = 'icons/Xeno/castes/hivemind.dmi'

/obj/structure/xeno/hivemindcore
	plane = FLOOR_PLANE

/mob/living/carbon/xenomorph/hivemind/updatehealth()
	. = ..()
	handle_regular_hud_updates()
