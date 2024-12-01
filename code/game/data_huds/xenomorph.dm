/mob/living/carbon/xenomorph/add_to_all_mob_huds()
	for(var/h in GLOB.huds)
		if(!istype(h, /datum/atom_hud/xeno))
			continue
		var/datum/atom_hud/hud = h
		hud.add_to_hud(src)

/mob/living/carbon/xenomorph/remove_from_all_mob_huds()
	for(var/h in GLOB.huds)
		if(!istype(h, /datum/atom_hud/xeno))
			continue
		var/datum/atom_hud/hud = h
		hud.remove_from_hud(src)

/mob/living/carbon/xenomorph/med_hud_set_health()
	var/image/holder = hud_list[HEALTH_HUD_XENO]
	if(!holder)
		return
	holder.icon = 'icons/mob/hud/xeno_health.dmi'
	if(stat == DEAD)
		holder.icon_state = "xenohealth0"
		return

	var/amount = health > 0 ? round(health * 100 / maxHealth, 10) : CEILING(health, 10)
	if(!amount && health < 0)
		amount = -1 //don't want the 'zero health' icon when we are crit
	holder.icon_state = "xenohealth[amount]"

/mob/living/carbon/xenomorph/hivemind/med_hud_set_health()
	var/image/holder = hud_list[HEALTH_HUD_XENO]
	if(!holder)
		return

	holder.icon = 'icons/mob/hud/xeno_health.dmi'
	if(status_flags & INCORPOREAL)
		holder.icon_state = "xenohealth0"
		return

	var/amount = round(health * 100 / maxHealth, 10)
	if(!amount)
		amount = 1 //don't want the 'zero health' icon when we still have 4% of our health
	holder.icon_state = "xenohealth0"
	holder.icon_state = "xenohealth[amount]"

/mob/living/carbon/xenomorph/med_hud_set_status()
	hud_set_pheromone()

/// Hiveminds specifically have no status hud element
/mob/living/carbon/xenomorph/hivemind/med_hud_set_status()
	return

///Set sunder on the hud
/mob/living/carbon/xenomorph/proc/hud_set_sunder()
	var/image/holder = hud_list[ARMOR_SUNDER_HUD]
	if(!holder)
		return

	holder.icon = 'icons/mob/hud/xeno_health.dmi'
	if(stat == DEAD)
		holder.icon_state = "sundering0"
		return

	var/amount = min(round(sunder * 100 / xeno_caste.sunder_max, 10), 100)
	holder.icon_state = "sundering[amount]"

///Set fire stacks on the hud
/mob/living/carbon/xenomorph/proc/hud_set_firestacks()
	var/image/holder = hud_list[XENO_FIRE_HUD]
	if(!holder)
		return

	holder.icon = 'icons/mob/hud/xeno_misc.dmi'
	if(stat == DEAD)
		holder.icon_state = "firestack0"
		return
	switch(fire_stacks)
		if(-INFINITY to 0)
			holder.icon_state = "firestack0"
		if(1 to 5)
			holder.icon_state = "firestack1"
		if(6 to 10)
			holder.icon_state = "firestack2"
		if(11 to 15)
			holder.icon_state = "firestack3"
		if(16 to INFINITY)
			holder.icon_state = "firestack4"

/mob/living/carbon/xenomorph/proc/hud_set_plasma()
	if(!xeno_caste) // usually happens because hud ticks before New() finishes.
		return
	var/image/holder = hud_list[PLASMA_HUD]
	if(!holder)
		return
	holder.overlays.Cut()
	if(stat == DEAD)
		return
	holder.icon = 'icons/mob/hud/xeno_health.dmi'
	var/plasma_amount = xeno_caste.plasma_max? round(plasma_stored * 100 / xeno_caste.plasma_max, 10) : 0
	holder.overlays += xeno_caste.plasma_icon_state? "[xeno_caste.plasma_icon_state][plasma_amount]" : null
	var/wrath_amount = xeno_caste.wrath_max? round(wrath_stored * 100 / xeno_caste.wrath_max, 10) : 0
	holder.overlays += "wrath[wrath_amount]"

/mob/living/carbon/xenomorph/proc/hud_set_pheromone()
	var/image/holder = hud_list[PHEROMONE_HUD]
	if(!holder)
		return
	holder.icon_state = ""
	if(stat != DEAD)
		var/tempname = ""
		if(frenzy_aura)
			tempname += AURA_XENO_FRENZY
		if(warding_aura)
			tempname += AURA_XENO_WARDING
		if(recovery_aura)
			tempname += AURA_XENO_RECOVERY
		if(tempname)
			holder.icon_state = "[tempname]"
			holder.icon = 'icons/mob/hud/aura.dmi'

	hud_list[PHEROMONE_HUD] = holder

//Only called when an aura is added or removed
/mob/living/carbon/xenomorph/update_aura_overlay()
	var/image/holder = hud_list[PHEROMONE_HUD]
	if(!holder)
		return
	holder.overlays.Cut()
	if(stat == DEAD)
		return
	for(var/aura_type in GLOB.pheromone_images_list)
		if(emitted_auras.Find(aura_type))
			holder.overlays += image('icons/mob/hud/aura.dmi', src, "[aura_type]_aura")

/mob/living/carbon/xenomorph/proc/hud_set_queen_overwatch()
	var/image/holder = hud_list[QUEEN_OVERWATCH_HUD]
	holder.overlays.Cut()
	holder.icon_state = ""
	if(stat == DEAD)
		return
	if(!hive?.living_xeno_queen)
		return
	if(hive.living_xeno_queen.observed_xeno == src)
		holder.icon = 'icons/mob/hud/xeno_misc.dmi'
		holder.icon_state = "queen_overwatch"
	if(queen_chosen_lead)
		var/image/I = image('icons/mob/hud/xeno_misc.dmi',src, "leader")
		holder.overlays += I
	hud_list[QUEEN_OVERWATCH_HUD] = holder

/mob/living/carbon/xenomorph/proc/hud_set_banished()
	var/image/holder = hud_list[XENO_BANISHED_HUD]
	holder.icon_state = ""
	if(stat != DEAD && HAS_TRAIT(src, TRAIT_BANISHED))
		holder.icon = 'icons/mob/hud/xeno_misc.dmi'
		holder.icon_state = "banished"
	holder.pixel_x = -4
	holder.pixel_y = -6

/mob/living/carbon/xenomorph/proc/hud_update_rank()
	var/image/holder = hud_list[XENO_RANK_HUD]
	if(!holder)
		return
	holder.icon_state = ""
	if(stat == DEAD)
		return
	if(playtime_as_number() > 0)
		holder.icon = 'icons/mob/hud/xeno_misc.dmi'
		holder.icon_state = "upgrade[playtime_as_number()]"

	hud_list[XENO_RANK_HUD] = holder

/mob/living/carbon/xenomorph/proc/hud_update_primo()
	var/image/holder = hud_list[XENO_PRIMO_HUD]
	if(!holder)
		return
	holder.icon_state = ""
	if(stat == DEAD)
		return
	if(upgrade == XENO_UPGRADE_PRIMO)
		holder.icon = 'icons/mob/hud/xeno_misc.dmi'
		holder.icon_state = "primo[playtime_as_number()]"

	hud_list[XENO_PRIMO_HUD] = holder
