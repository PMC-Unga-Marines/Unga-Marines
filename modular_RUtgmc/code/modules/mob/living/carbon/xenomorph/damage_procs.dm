/mob/living/carbon/xenomorph/ex_act(severity, direction)
	if(severity <= 0)
		return

	if(status_flags & (INCORPOREAL|GODMODE))
		return

	if(lying_angle)
		severity *= EXPLOSION_PRONE_MULTIPLIER

	if(severity >= (health) && severity >= EXPLOSION_THRESHOLD_GIB + get_soft_armor(BOMB))
		var/oldloc = loc
		gib()
		create_shrapnel(oldloc, rand(16, 24), direction, shrapnel_type = /datum/ammo/bullet/shrapnel/light/xeno)
		return

	var/sunder_amount = severity * modify_by_armor(1, BOMB) / 8

	apply_damages(severity * 0.5, severity * 0.5, blocked = BOMB, updating_health = TRUE)
	adjust_sunder(sunder_amount)

	var/powerfactor_value = round(severity * 0.05, 1)
	powerfactor_value = min(powerfactor_value, 20)
	if(powerfactor_value > 10)
		powerfactor_value /= 5
	else if(powerfactor_value > 0)
		explosion_throw(severity, direction)

	if(mob_size < MOB_SIZE_BIG)
		adjust_slowdown(powerfactor_value / 3)
		adjust_stagger(powerfactor_value / 2)
	else
		adjust_slowdown(powerfactor_value / 3)
