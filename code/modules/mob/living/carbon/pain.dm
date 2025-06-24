/mob/living/carbon/proc/get_painloss()
	return painloss

/mob/living/carbon/proc/adjust_painloss(amount)
	if(amount > 0 && (status_flags & GODMODE))
		return FALSE
	painloss = clamp(painloss + (amount - painloss) * PAIN_REACTIVITY, -100, maxHealth * 2)

/mob/living/carbon/proc/set_painloss(amount)
	if(HAS_TRAIT(src, TRAIT_PAIN_IMMUNE))
		amount = 0
	if(painloss == amount)
		return FALSE
	painloss = amount
	SEND_SIGNAL(src, COMSIG_MOB_PAINLOSS_CHANGED, painloss)
	adjust_pain_speed_mod(painloss)

/mob/living/carbon/proc/adjust_pain_speed_mod(old_painloss)
	switch(painloss)
		if(0 to 100)
			if(old_painloss <= 100)
				return
			remove_movespeed_modifier(MOVESPEED_ID_PAIN)
		if(100 to 125)
			if(old_painloss > 100 || old_painloss <= 125)
				return
			add_movespeed_modifier(MOVESPEED_ID_PAIN, TRUE, 0, NONE, TRUE, 1)
		if(125 to 150)
			if(old_painloss > 125 || old_painloss <= 150)
				return
			add_movespeed_modifier(MOVESPEED_ID_PAIN, TRUE, 0, NONE, TRUE, 2)
		if(150 to INFINITY)
			if(old_painloss > 150)
				return
			add_movespeed_modifier(MOVESPEED_ID_PAIN, TRUE, 0, NONE, TRUE, 3)

// proc to find out in how much pain the mob is at the moment
/mob/living/carbon/proc/update_pain()
	if(species?.species_flags & NO_PAIN || stat == DEAD)
		painloss = 0
		return

	painloss = (0.75 * get_oxy_loss()) + (0.75 * get_tox_loss()) + (1.20 * get_fire_loss()) + get_brute_loss() + get_clone_loss()
	painloss += reagent_shock_modifier

	if(has_status_effect(/datum/status_effect/speech/slurring/drunk))
		painloss -= 10

	//Broken or ripped off organs and limbs will add quite a bit of pain
	if(ishuman(src))
		var/mob/living/carbon/human/M = src
		for(var/datum/limb/O in M.limbs)
			if(((O.limb_status & LIMB_DESTROYED) && !(O.limb_status & LIMB_AMPUTATED)) || O.limb_status & LIMB_NECROTIZED)
				painloss += 40
			else if(O.limb_status & LIMB_BROKEN || O.surgery_open_stage)
				if(O.limb_status & LIMB_SPLINTED)
					painloss += 15
				else
					painloss += 25
			if(O.germ_level >= INFECTION_LEVEL_ONE)
				painloss += O.germ_level * 0.05

		//Internal organs hurt too
		for(var/datum/internal_organ/O in M.internal_organs)
			if(O.damage)
				painloss += O.damage * 1.5

		if(M.protection_aura)
			painloss -= 20 * (1 + M.protection_aura) //-60 pain for SLs (2-1+1), -80 for Commanders (3-1+1)
		if(M.flag_aura)
			painloss -= M.flag_aura * 20

	painloss += reagent_pain_modifier

	return painloss

/mob/living/carbon/proc/handle_pain_levels()
	update_pain()
