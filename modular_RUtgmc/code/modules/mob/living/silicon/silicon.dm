/mob/living/silicon/ex_act(severity)
	flash_act()
	if(stat == DEAD)
		return

	if(severity >= EXPLODE_HEAVY && !anchored)
		gib()
		return

	adjustBruteLoss(severity)
	UPDATEHEALTH(src)
