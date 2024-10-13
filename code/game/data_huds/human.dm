#define PAIN_RATIO_PAIN_HUD 0.25
#define STAMINA_RATIO_PAIN_HUD 0.25

/mob/living/carbon/human/add_to_all_mob_huds()
	for(var/h in GLOB.huds)
		if(istype(h, /datum/atom_hud/xeno)) //this one is xeno only
			continue
		var/datum/atom_hud/hud = h
		hud.add_to_hud(src)

/mob/living/carbon/human/remove_from_all_mob_huds()
	for(var/h in GLOB.huds)
		if(istype(h, /datum/atom_hud/xeno))
			continue
		var/datum/atom_hud/hud = h
		hud.remove_from_hud(src)

/mob/living/carbon/human/proc/update_suit_sensors()
	var/datum/atom_hud/medical/basic/B = GLOB.huds[DATA_HUD_MEDICAL_BASIC]
	B.update_suit_sensors(src)

/mob/living/carbon/human/med_hud_set_health(hud_holder = HEALTH_HUD)
	var/image/holder = hud_list[HEALTH_HUD]
	holder.icon = 'icons/mob/hud/human_health.dmi'
	if(stat == DEAD)
		holder.icon_state = "health98"
		return
	var/percentage = round(health * 100 / maxHealth, 7) // rounding to 7 because there are 14 pixel lines in the health hud
	holder.icon_state = "health[percentage]"

/mob/living/carbon/human/med_hud_set_status()
	set_status_hud()
	set_infection_hud()
	set_simple_status_hud()
	set_reagent_hud()
	set_debuff_hud()

//Set status for med-hud.
/mob/living/carbon/human/proc/set_status_hud()
	var/image/status_hud = hud_list[STATUS_HUD]
	status_hud.icon_state = ""
	if(species.species_flags & IS_SYNTHETIC)
		if(stat != DEAD)
			status_hud.icon_state = "synth"
		else if(!client)
			var/mob/dead/observer/G = get_ghost(FALSE, TRUE)
			if(!G)
				status_hud.icon_state = "synth_dnr"
			else
				status_hud.icon_state = "synth_dead"
		return TRUE
	if(species.species_flags & HEALTH_HUD_ALWAYS_DEAD)
		if(species.species_flags & ROBOTIC_LIMBS) //Robot check
			status_hud.icon_state = "dead_robot"
		else
			status_hud.icon_state = "dead"
		return TRUE
	switch(stat)
		if(DEAD)
			if(HAS_TRAIT(src, TRAIT_UNDEFIBBABLE))
				hud_list[HEART_STATUS_HUD].icon_state = "still_heart"
				if(species.species_flags & ROBOTIC_LIMBS)
					status_hud.icon_state = "dead_robot"
				else
					status_hud.icon_state = "dead"
				return TRUE
			if(!client)
				var/mob/dead/observer/ghost = get_ghost()
				if(!ghost?.can_reenter_corpse)
					if(species.species_flags & ROBOTIC_LIMBS)
						status_hud.icon_state = "dead_robot"
					else
						status_hud.icon_state = "dead"
					return TRUE
			var/stage
			switch(dead_ticks)
				if(0 to 0.4 * TIME_BEFORE_DNR)
					stage = 1
				if(0.4 * TIME_BEFORE_DNR to 0.8 * TIME_BEFORE_DNR)
					stage = 2
				if(0.8 * TIME_BEFORE_DNR to INFINITY)
					stage = 3
			if(initial_stage != stage)
				initial_stage = stage
				SEND_SIGNAL(src, COMSIG_HUMAN_DEATH_STAGE_CHANGE) // this is used to slightly increase performance of minimap revivable icons
			if(species.species_flags & ROBOTIC_LIMBS)
				status_hud.icon_state = "dead_defibable_robot"
			else
				status_hud.icon_state = "dead_defibable[stage]"
			return TRUE
		if(UNCONSCIOUS)
			if(!client) //Nobody home.
				status_hud.icon_state = "afk"
				return TRUE
			if(IsUnconscious()) //Should hopefully get out of it soon.
				status_hud.icon_state = "knockout"
				return TRUE
			status_hud.icon_state = "sleep" //Regular sleep, else.
			return TRUE
		if(CONSCIOUS)
			if(!key) //Nobody home. Shouldn't affect aghosting.
				status_hud.icon_state = "afk"
				return TRUE
			if(IsParalyzed()) //I've fallen and I can't get up.
				status_hud.icon_state = "knockdown"
				return TRUE
			if(IsStun())
				status_hud.icon_state = "stun"
				return TRUE
			if(IsStaggered())
				return TRUE
			if(slowdown)
				status_hud.icon_state = "slowdown"
				return TRUE
			if(species.species_flags & ROBOTIC_LIMBS)
				status_hud.icon_state = "robot"
				return TRUE
			else
				status_hud.icon_state = "healthy"
				return TRUE
	return FALSE

//Set state of the xeno embryo and other strange stuff
/mob/living/carbon/human/proc/set_infection_hud()
	if(species.species_flags & HEALTH_HUD_ALWAYS_DEAD)
		return FALSE

	var/image/infection_hud = hud_list[XENO_EMBRYO_HUD]
	infection_hud.icon_state = ""
	if(species.species_flags & IS_SYNTHETIC)
		infection_hud.icon_state = "synth" //Xenos can feel synths are not human.
		return TRUE

	if(stat == DEAD)
		if(!HAS_TRAIT(src, TRAIT_PSY_DRAINED))
			infection_hud.icon_state = "psy_drain"
		else
			infection_hud.icon_state = "dead_xeno_animated"
		return TRUE

	if(species.species_flags & ROBOTIC_LIMBS)
		infection_hud.icon_state = "robot"
		return TRUE

	if(status_flags & XENO_HOST)
		infection_hud.icon = 'icons/mob/hud/infected.dmi'
		var/obj/item/alien_embryo/embryo = locate(/obj/item/alien_embryo) in src
		if(embryo)
			if(embryo.boost_timer)
				infection_hud.icon_state = "infectedmodifier[embryo.stage]"
			else
				infection_hud.icon_state = "infected[embryo.stage]"
		else if(locate(/mob/living/carbon/xenomorph/larva) in src)
			infection_hud.icon_state = "infected6"
		return TRUE
	return FALSE

//Set status for the naked eye.
/mob/living/carbon/human/proc/set_simple_status_hud()
	var/image/simple_status_hud = hud_list[STATUS_HUD_SIMPLE]
	simple_status_hud.icon_state = ""

	if(species.species_flags & (IS_SYNTHETIC || HEALTH_HUD_ALWAYS_DEAD))
		return FALSE

	switch(stat)
		if(DEAD)
			return FALSE
		if(UNCONSCIOUS)
			if(!client) //Nobody home.
				simple_status_hud.icon_state = "afk"
				return TRUE
			if(IsUnconscious()) //Should hopefully get out of it soon.
				simple_status_hud.icon_state = "knockout"
				return TRUE
			simple_status_hud.icon_state = "sleep"
			return TRUE
		if(CONSCIOUS)
			if(!key) //Nobody home. Shouldn't affect aghosting.
				simple_status_hud.icon_state = "afk"
				return TRUE
			if(IsParalyzed()) //I've fallen and I can't get up.
				simple_status_hud.icon_state = "knockdown"
				return TRUE
			if(IsStun())
				simple_status_hud.icon_state = "stun"
				return TRUE
			if(IsStaggered())
				simple_status_hud.icon_state = "stagger"
				return TRUE
			if(slowdown)
				simple_status_hud.icon_state = "slowdown"
				return TRUE
	return FALSE

///Displays active reagents for xenomorphs, so they know how to react to it
/mob/living/carbon/human/proc/set_reagent_hud()
	var/image/xeno_reagent = hud_list[XENO_REAGENT_HUD]
	xeno_reagent.overlays.Cut()
	xeno_reagent.icon_state = ""

	if(stat == DEAD)
		return FALSE

	var/static/image/neurotox_image = image('icons/mob/hud/reagent.dmi', icon_state = "neurotoxin")
	var/static/image/hemodile_image = image('icons/mob/hud/reagent.dmi', icon_state = "hemodile")
	var/static/image/transvitox_image = image('icons/mob/hud/reagent.dmi', icon_state = "transvitox")
	var/static/image/sanguinal_image = image('icons/mob/hud/reagent.dmi', icon_state = "sanguinal")
	var/static/image/ozelomelyn_image = image('icons/mob/hud/reagent.dmi', icon_state = "ozelomelyn")
	var/static/image/ozelomelyn_high_image = image('icons/mob/hud/reagent.dmi', icon_state = "ozelomelyn_high")
	var/static/image/neurotox_high_image = image('icons/mob/hud/reagent.dmi', icon_state = "neurotoxin_high")
	var/static/image/hemodile_high_image = image('icons/mob/hud/reagent.dmi', icon_state = "hemodile_high")
	var/static/image/transvitox_high_image = image('icons/mob/hud/reagent.dmi', icon_state = "transvitox_high")
	var/static/image/sanguinal_high_image = image('icons/mob/hud/reagent.dmi', icon_state = "sanguinal_high")
	var/static/image/medicalnanites_high_image = image('icons/mob/hud/reagent.dmi', icon_state = "nanites")
	var/static/image/medicalnanites_medium_image = image('icons/mob/hud/reagent.dmi', icon_state = "nanites_medium")
	var/static/image/medicalnanites_low_image = image('icons/mob/hud/reagent.dmi', icon_state = "nanites_low")
	var/static/image/ifosfamide_image = image('icons/mob/hud/reagent.dmi', icon_state = "ifosfamide")
	var/static/image/jellyjuice_image = image('icons/mob/hud/reagent.dmi', icon_state = "jellyjuice")
	var/static/image/russianred_image = image('icons/mob/hud/reagent.dmi', icon_state = "russian_red")

	var/neurotox_amount = reagents.get_reagent_amount(/datum/reagent/toxin/xeno_neurotoxin)
	var/hemodile_amount = reagents.get_reagent_amount(/datum/reagent/toxin/xeno_hemodile)
	var/transvitox_amount = reagents.get_reagent_amount(/datum/reagent/toxin/xeno_transvitox)
	var/sanguinal_amount = reagents.get_reagent_amount(/datum/reagent/toxin/xeno_sanguinal)
	var/ozelomelyn_amount = reagents.get_reagent_amount(/datum/reagent/toxin/xeno_ozelomelyn)
	var/jellyjuice_amount = reagents.get_reagent_amount(/datum/reagent/medicine/xenojelly)
	var/medicalnanites_amount = reagents.get_reagent_amount(/datum/reagent/medicalnanites)
	var/russianred_amount = reagents.get_reagent_amount(/datum/reagent/medicine/russian_red)
	var/ifosfamide_amount = reagents.get_reagent_amount(/datum/reagent/medicine/ifosfamide)

	if(neurotox_amount > 10) //Blinking image for particularly high concentrations
		xeno_reagent.overlays += neurotox_high_image
	else if(neurotox_amount > 0)
		xeno_reagent.overlays += neurotox_image

	if(ozelomelyn_amount > 10)
		xeno_reagent.overlays += ozelomelyn_high_image
	else if(ozelomelyn_amount > 0)
		xeno_reagent.overlays += ozelomelyn_image

	if(hemodile_amount > 10)
		xeno_reagent.overlays += hemodile_high_image
	else if(hemodile_amount > 0)
		xeno_reagent.overlays += hemodile_image

	if(transvitox_amount > 10)
		xeno_reagent.overlays += transvitox_high_image
	else if(transvitox_amount > 0)
		xeno_reagent.overlays += transvitox_image

	if(sanguinal_amount > 10)
		xeno_reagent.overlays += sanguinal_high_image
	else if(sanguinal_amount > 0)
		xeno_reagent.overlays += sanguinal_image

	if(ifosfamide_amount > 0)
		xeno_reagent.overlays += ifosfamide_image

	if(medicalnanites_amount > 25)
		xeno_reagent.overlays += medicalnanites_high_image
	else if(medicalnanites_amount > 15)
		xeno_reagent.overlays += medicalnanites_medium_image
	else if(medicalnanites_amount > 0)
		xeno_reagent.overlays += medicalnanites_low_image

	if(russianred_amount > 0)
		xeno_reagent.overlays += russianred_image

	if(jellyjuice_amount > 0)
		xeno_reagent.overlays += jellyjuice_image

	hud_list[XENO_REAGENT_HUD] = xeno_reagent

///Displays active xeno specific debuffs
/mob/living/carbon/human/proc/set_debuff_hud()
	var/image/xeno_debuff = hud_list[XENO_DEBUFF_HUD]
	var/static/image/intoxicated_image = image('icons/mob/hud/intoxicated.dmi', icon_state = "intoxicated")
	var/static/image/intoxicated_amount_image = image('icons/mob/hud/intoxicated.dmi', icon_state = "intoxicated_amount0")
	var/static/image/intoxicated_high_image = image('icons/mob/hud/intoxicated.dmi', icon_state = "intoxicated_high")
	var/static/image/hive_target_image = image('icons/mob/hud/human_misc.dmi', icon_state = "hive_target")
	var/static/image/hunter_silence_image = image('icons/mob/hud/human_misc.dmi', icon_state = "silence_debuff")

	//Xeno debuff section start
	xeno_debuff.overlays.Cut()
	xeno_debuff.icon_state = ""

	if(stat != DEAD && IsMute())
		xeno_debuff.overlays += hunter_silence_image

	if(HAS_TRAIT(src, TRAIT_HIVE_TARGET))
		xeno_debuff.overlays += hive_target_image

	if(has_status_effect(STATUS_EFFECT_INTOXICATED))
		var/datum/status_effect/stacking/intoxicated/debuff = has_status_effect(STATUS_EFFECT_INTOXICATED)
		var/intoxicated_amount = debuff.stacks
		xeno_debuff.overlays += intoxicated_amount_image
		intoxicated_amount_image.icon_state = "intoxicated_amount[intoxicated_amount]"
		if(intoxicated_amount > 15)
			xeno_debuff.overlays += intoxicated_high_image
		else if(intoxicated_amount > 0)
			xeno_debuff.overlays += intoxicated_image

	hud_list[XENO_DEBUFF_HUD] = xeno_debuff

/mob/proc/med_pain_set_perceived_health()
	return

/mob/living/carbon/human/med_pain_set_perceived_health()
	if(species?.species_flags & IS_SYNTHETIC)
		return FALSE
	if(HAS_TRAIT(src, TRAIT_FOREIGN_BIO))
		return FALSE
	var/image/holder = hud_list[PAIN_HUD]
	holder.icon = 'icons/mob/hud/human_health.dmi'
	if(stat == DEAD || SEND_SIGNAL(src, COMSIG_LIVING_HEALTH_STEALTH) & COMPONENT_HIDE_HEALTH)
		holder.icon_state = "health98"
		return TRUE

	var/perceived_health = round(health * 100 / maxHealth)
	if(!(species.species_flags & NO_PAIN))
		perceived_health -= PAIN_RATIO_PAIN_HUD * painloss
	if(!(species.species_flags & NO_STAMINA) && staminaloss > 0)
		perceived_health -= STAMINA_RATIO_PAIN_HUD * staminaloss

	holder.icon_state = "health[clamp(round(perceived_health, 7), -98, 98)]" // rounding to 7 because there are 14 pixel lines in the health hud
	return TRUE

/mob/living/carbon/human/proc/hud_set_job(faction = FACTION_TERRAGOV)
	var/hud_type
	switch(faction)
		if(FACTION_TERRAGOV)
			hud_type = SQUAD_HUD_TERRAGOV
		if(FACTION_SOM)
			hud_type = SQUAD_HUD_SOM
		else
			return
	var/image/holder = hud_list[hud_type]
	holder.icon_state = ""
	holder.overlays.Cut()

	if(assigned_squad)
		var/squad_color = assigned_squad.color
		var/rank = job.comm_title
		if(assigned_squad.squad_leader == src)
			rank = JOB_COMM_TITLE_SQUAD_LEADER
		if(job.job_flags & JOB_FLAG_PROVIDES_SQUAD_HUD)
			var/image/IMG = image('icons/mob/hud/job.dmi', src, "color")
			IMG.color = squad_color
			holder.overlays += IMG
			holder.overlays += image('icons/mob/hud/job.dmi', src, "[rank]")
		var/fireteam = wear_id?.assigned_fireteam
		if(fireteam)
			var/image/IMG2 = image('icons/mob/hud/job.dmi', src, "squadft[fireteam]")
			IMG2.color = squad_color
			holder.overlays += IMG2

	else if(job.job_flags & JOB_FLAG_PROVIDES_SQUAD_HUD)
		holder.overlays += image('icons/mob/hud/job.dmi', src, "[job.comm_title]")
	hud_list[hud_type] = holder

/mob/living/carbon/human/proc/hud_set_order()
	var/image/holder = hud_list[ORDER_HUD]
	holder.icon = 'icons/mob/hud/aura.dmi'
	holder.icon_state = ""
	if(stat != DEAD)
		var/tempname = ""
		if(mobility_aura)
			tempname += "move"
		if(protection_aura)
			tempname += "hold"
		if(marksman_aura)
			tempname += "focus"
		if(tempname)
			holder.icon_state = "[tempname]"

	hud_list[ORDER_HUD] = holder

//Only called when an aura is added or removed
/mob/living/carbon/human/update_aura_overlay()
	var/image/holder = hud_list[ORDER_HUD]
	holder.overlays.Cut()
	for(var/aura_type in command_aura_allowed)
		if(emitted_auras.Find(aura_type))
			holder.overlays += image('icons/mob/hud/aura.dmi', src, "[aura_type]_aura")

/mob/living/carbon/human/species/yautja/med_hud_set_health(hud_holder = HUNTER_HEALTH_HUD)
	var/image/holder = hud_list[HUNTER_HEALTH_HUD]
	holder.icon = 'icons/mob/hud/human_health.dmi'
	if(stat == DEAD)
		holder.icon_state = "health98"
		return
	var/percentage = round(health * 100 / maxHealth, 7) // rounding to 7 because there are 14 pixel lines in the health hud
	holder.icon_state = "health[percentage]"

#undef PAIN_RATIO_PAIN_HUD
#undef STAMINA_RATIO_PAIN_HUD
