/obj/item/weapon/gun
	var/wield_sound
	var/silenced_sound

/obj/item/weapon/gun/wield(mob/user)
	if(CHECK_BITFIELD(flags_gun_features, GUN_DEPLOYED_FIRE_ONLY))
		to_chat(user, span_notice("[src] cannot be fired by hand and must be deployed."))
		return

	. = ..()

	if(!.)
		return

	user.add_movespeed_modifier(MOVESPEED_ID_AIM_SLOWDOWN, TRUE, 0, NONE, TRUE, aim_slowdown)

	var/wdelay = wield_delay
	//slower or faster wield delay depending on skill.
	if(user.skills.getRating(SKILL_FIREARMS) < SKILL_FIREARMS_DEFAULT)
		wdelay += 0.3 SECONDS //no training in any firearms
	else
		var/skill_value = user.skills.getRating(gun_skill_category)
		if(skill_value > 0)
			wdelay -= skill_value * 2
		else
			wdelay += wield_penalty
	wield_time = world.time + wdelay
	playsound(loc, wield_sound, 20, 1)
	do_wield(user, wdelay)
	if(HAS_TRAIT(src, TRAIT_GUN_AUTO_AIM_MODE))
		toggle_aim_mode(user)
