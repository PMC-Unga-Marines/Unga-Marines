
/mob/living/carbon/xenomorph/proc/upgrade_xeno(newlevel, silent = FALSE)
	if(!(newlevel in (GLOB.xenoupgradetiers - XENO_UPGRADE_INVALID)))
		return FALSE
	hive.upgrade_xeno(src, upgrade, newlevel)
	upgrade = newlevel
	if(!silent)
		visible_message(span_xenonotice("\The [src] begins to twist and contort."), \
		span_xenonotice("We begin to twist and contort."))
		do_jitter_animation(1000)
	set_datum(FALSE)
	var/selected_ability_type = selected_ability?.type

	var/list/datum/action/ability/xeno_action/actions_already_added = mob_abilities
	mob_abilities = list()

	for(var/allowed_action_path in xeno_caste.actions)
		var/found = FALSE
		for(var/datum/action/ability/xeno_action/action_already_added AS in actions_already_added)
			if(action_already_added.type == allowed_action_path)
				mob_abilities.Add(action_already_added)
				actions_already_added.Remove(action_already_added)
				found = TRUE
				break
		if(found)
			continue
		var/datum/action/ability/xeno_action/action = new allowed_action_path()
		if(!SSticker.mode || (SSticker.mode.xeno_abilities_flags & action.gamemode_flags))
			action.give_action(src)

	for(var/datum/action/ability/xeno_action/action_already_added AS in actions_already_added)
		action_already_added.remove_action(src)

	SEND_SIGNAL(src, COMSIG_XENOMORPH_ABILITY_ON_UPGRADE)
	if(selected_ability_type)
		for(var/datum/action/ability/activable/xeno/activable_ability in actions)
			if(selected_ability_type != activable_ability.type)
				continue
			activable_ability.select()
			break

	if(xeno_flags & XENO_LEADER)
		give_rally_abilities() //Give them back their rally hive ability

	if(current_aura) //Updates pheromone strength
		current_aura.range = 6 + xeno_caste.aura_strength * 2
		current_aura.strength = xeno_caste.aura_strength

	switch(upgrade)
		if(XENO_UPGRADE_NORMAL)
			switch(tier)
				if(XENO_TIER_TWO)
					SSmonitor.stats.normal_T2++
				if(XENO_TIER_THREE)
					SSmonitor.stats.normal_T3++
				if(XENO_TIER_FOUR)
					SSmonitor.stats.normal_T4++
		if(XENO_UPGRADE_PRIMO)
			switch(tier)
				if(XENO_TIER_TWO)
					SSmonitor.stats.primo_T2++
				if(XENO_TIER_THREE)
					SSmonitor.stats.primo_T3++
				if(XENO_TIER_FOUR)
					SSmonitor.stats.primo_T4++
			if(!silent)
				to_chat(src, span_xenoannounce(xeno_caste.primordial_message))

	generate_name() //Give them a new name now

	hud_set_plasma()
	med_hud_set_health()
	hud_update_primo()

	hud_set_queen_overwatch() //update the upgrade level insignia on our xeno hud.

	update_spits() //Update spits to new/better ones
	return TRUE

//Tiered spawns.

//-----RUNNER START-----//

/mob/living/carbon/xenomorph/runner/primordial
	upgrade = XENO_UPGRADE_PRIMO

//-----RUNNER END-----//
//================//
//-----BULL START-----//

/mob/living/carbon/xenomorph/bull/primordial
	upgrade = XENO_UPGRADE_PRIMO

//-----BULL END-----//
//================//
//-----DRONE START-----//

/mob/living/carbon/xenomorph/drone/primordial
	upgrade = XENO_UPGRADE_PRIMO

//-----DRONE END-----//
//================//

//----------------------------------------------//
// ERT DRONE START

/mob/living/carbon/xenomorph/drone/Corrupted //Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/drone/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/drone/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/drone/Zeta
	hivenumber = XENO_HIVE_ZETA

// ERT DRONE START END
//---------------------------------------------//
//-----CARRIER START-----//

/mob/living/carbon/xenomorph/carrier
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/carrier/primordial
	upgrade = XENO_UPGRADE_PRIMO

//-----CARRIER END-----//
//================//
//----HIVELORD START----//

/mob/living/carbon/xenomorph/hivelord
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/hivelord/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----HIVELORD END----//
//================//

//================//
//----PRAETORIAN START----//

/mob/living/carbon/xenomorph/praetorian
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/praetorian/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/praetorian/dancer/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----PRAETORIAN END----//
//================//
//----RAVAGER START----//

/mob/living/carbon/xenomorph/ravager
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/ravager/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----RAVAGER END----//
//================//
//RAVAGER ERT START

/mob/living/carbon/xenomorph/ravager/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/ravager/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/ravager/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/ravager/Zeta
	hivenumber = XENO_HIVE_ZETA

//RAVAGER ERT END
//================//
//----SENTINEL START----//

/mob/living/carbon/xenomorph/sentinel
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/sentinel/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/sentinel/retrograde/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----SENTINEL END----//
//================//
//-----SPITTER START-----//

/mob/living/carbon/xenomorph/spitter
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/spitter/primordial
	upgrade = XENO_UPGRADE_PRIMO

//-----SPITTER END-----//
//================//
//SENTINEL ERT START

/mob/living/carbon/xenomorph/spitter/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/spitter/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/spitter/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/spitter/Zeta
	hivenumber = XENO_HIVE_ZETA

//SENTINEL ERT END
//================//
//----HUNTER START----//

/mob/living/carbon/xenomorph/hunter
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/hunter/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----HUNTER END----//
//================//
//HUNTER ERT START

/mob/living/carbon/xenomorph/hunter/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/hunter/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/hunter/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/hunter/Zeta
	hivenumber = XENO_HIVE_ZETA

//HUNTER ERT END
//================//
//----QUEEN START----//

/mob/living/carbon/xenomorph/queen
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/queen/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----QUEEN END----//
//============//
//---KING START---//

/mob/living/carbon/xenomorph/king
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/king/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----KING END----//
//============//
//---CRUSHER START---//

/mob/living/carbon/xenomorph/crusher
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/crusher/primordial
	upgrade = XENO_UPGRADE_PRIMO

//---CRUSHER END---//
//============//
//---GORGER START---//

/mob/living/carbon/xenomorph/gorger
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/gorger/primordial
	upgrade = XENO_UPGRADE_PRIMO

//---GORGER END---//
//============//
//---BOILER START---//

/mob/living/carbon/xenomorph/boiler
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/boiler/primordial
	upgrade = XENO_UPGRADE_PRIMO

//---BOILER END---//
//============//
//---DEFENDER START---//

/mob/living/carbon/xenomorph/defender
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/defender/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/defender/steel_crest/primordial
	upgrade = XENO_UPGRADE_PRIMO

//---DEFENDER END---//
//============//
//----WARRIOR START----//

/mob/living/carbon/xenomorph/warrior
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/warrior/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----WARRIOR END----//
//============//
//----DEFILER START----//

/mob/living/carbon/xenomorph/defiler
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/defiler/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----DEFILER END----//
//============//
//----SHRIKE START----//

/mob/living/carbon/xenomorph/shrike
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/shrike/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----SHRIKE END----//

//----WARLOCK START----//

/mob/living/carbon/xenomorph/warlock
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/warlock/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----WARLOCK END----//
//============//

//============//
//----BEHEMOTH START----//

/mob/living/carbon/xenomorph/behemoth
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/behemoth/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----BEHEMOTH END----//
//============//

//----WIDOW START----//
/mob/living/carbon/xenomorph/widow
	upgrade = XENO_UPGRADE_NORMAL

/mob/living/carbon/xenomorph/widow/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----WIDOW END----//

//----PANTHER START----//
/mob/living/carbon/xenomorph/panther/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----PANTHER END----//
//================//
//----CHIMERA START----//

/mob/living/carbon/xenomorph/chimera/primordial
	upgrade = XENO_UPGRADE_PRIMO

//----CHIMERA END----//
