/mob/living/carbon/human
	hud_possible = list(HEALTH_HUD, STATUS_HUD_SIMPLE, STATUS_HUD, XENO_EMBRYO_HUD, XENO_REAGENT_HUD, WANTED_HUD, SQUAD_HUD_TERRAGOV, SQUAD_HUD_SOM, ORDER_HUD, PAIN_HUD, XENO_DEBUFF_HUD, HEART_STATUS_HUD, HUNTER_CLAN, HUNTER_HUD, HUNTER_HEALTH_HUD)
	appearance_flags = KEEP_TOGETHER|TILE_BOUND|PIXEL_SCALE
	/// Used for preventing possible lags in the med_hud_set_status(), yes it's ugly
	var/initial_stage

	var/initial_transform
