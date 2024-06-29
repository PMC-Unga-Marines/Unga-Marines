/mob/living/simple_animal/ex_act(severity)
	flash_act()

	if(severity >= EXPLOSION_THRESHOLD_GIB)
		gib()
		return

	adjustBruteLoss(severity / 3)
	UPDATEHEALTH(src)
