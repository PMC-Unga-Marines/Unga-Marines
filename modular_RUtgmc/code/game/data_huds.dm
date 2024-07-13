/mob/living/carbon/human/med_hud_set_status()
	var/image/status_hud = hud_list[STATUS_HUD] //Status for med-hud.
	var/image/infection_hud = hud_list[XENO_EMBRYO_HUD] //State of the xeno embryo.
	var/image/simple_status_hud = hud_list[STATUS_HUD_SIMPLE] //Status for the naked eye.
	var/image/xeno_reagent = hud_list[XENO_REAGENT_HUD] // Displays active xeno reagents
	var/image/xeno_debuff = hud_list[XENO_DEBUFF_HUD] //Displays active xeno specific debuffs
	var/static/image/neurotox_image = image('icons/mob/hud.dmi', icon_state = "neurotoxin")
	var/static/image/hemodile_image = image('icons/mob/hud.dmi', icon_state = "hemodile")
	var/static/image/transvitox_image = image('icons/mob/hud.dmi', icon_state = "transvitox")
	var/static/image/sanguinal_image = image('icons/mob/hud.dmi', icon_state = "sanguinal")
	var/static/image/ozelomelyn_image = image('icons/mob/hud.dmi', icon_state = "ozelomelyn")
	var/static/image/intoxicated_image = image('modular_RUtgmc/icons/mob/hud.dmi', icon_state = "intoxicated")
	var/static/image/intoxicated_amount_image = image('modular_RUtgmc/icons/mob/hud.dmi', icon_state = "intoxicated_amount0")
	var/static/image/neurotox_high_image = image('modular_RUtgmc/icons/mob/hud.dmi', icon_state = "neurotoxin_high")
	var/static/image/hemodile_high_image = image('icons/mob/hud.dmi', icon_state = "hemodile_high")
	var/static/image/transvitox_high_image = image('icons/mob/hud.dmi', icon_state = "transvitox_high")
	var/static/image/hunter_silence_image = image('icons/mob/hud.dmi', icon_state = "silence_debuff")
	var/static/image/sanguinal_high_image = image('icons/mob/hud.dmi', icon_state = "sanguinal_high")
	var/static/image/intoxicated_high_image = image('modular_RUtgmc/icons/mob/hud.dmi', icon_state = "intoxicated_high")
	var/static/image/hive_target_image = image('modular_RUtgmc/icons/mob/hud.dmi', icon_state = "hive_target")
	var/static/image/medicalnanites_high_image = image('modular_RUtgmc/icons/mob/hud.dmi', icon_state = "nanites")
	var/static/image/medicalnanites_medium_image = image('modular_RUtgmc/icons/mob/hud.dmi', icon_state = "nanites_medium")
	var/static/image/medicalnanites_low_image = image('modular_RUtgmc/icons/mob/hud.dmi', icon_state = "nanites_low")
	var/static/image/jellyjuice_image = image('modular_RUtgmc/icons/mob/hud.dmi', icon_state = "jellyjuice")
	var/static/image/russianred_image = image('modular_RUtgmc/icons/mob/hud.dmi', icon_state = "russian_red")

	xeno_reagent.overlays.Cut()
	xeno_reagent.icon_state = ""
	if(stat != DEAD)
		var/neurotox_amount = reagents.get_reagent_amount(/datum/reagent/toxin/xeno_neurotoxin)
		var/hemodile_amount = reagents.get_reagent_amount(/datum/reagent/toxin/xeno_hemodile)
		var/transvitox_amount = reagents.get_reagent_amount(/datum/reagent/toxin/xeno_transvitox)
		var/sanguinal_amount = reagents.get_reagent_amount(/datum/reagent/toxin/xeno_sanguinal)
		var/ozelomelyn_amount = reagents.get_reagent_amount(/datum/reagent/toxin/xeno_ozelomelyn)
		var/jellyjuice_amount = reagents.get_reagent_amount(/datum/reagent/medicine/xenojelly)
		var/medicalnanites_amount = reagents.get_reagent_amount(/datum/reagent/medicine/research/medicalnanites)
		var/russianred_amount = reagents.get_reagent_amount(/datum/reagent/medicine/russian_red)

		if(neurotox_amount > 10) //Blinking image for particularly high concentrations
			xeno_reagent.overlays += neurotox_high_image
		else if(neurotox_amount > 0)
			xeno_reagent.overlays += neurotox_image

		if(ozelomelyn_amount > 0) // Has no effect beyond having it in them, don't need to have a high image.
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

	//Xeno debuff section start
	xeno_debuff.overlays.Cut()
	xeno_debuff.icon_state = ""
	if(stat != DEAD)
		if(IsMute())
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

	if(species.species_flags & IS_SYNTHETIC)
		simple_status_hud.icon_state = ""
		if(stat != DEAD)
			status_hud.icon_state = "hudsynth"
		else
			if(!client)
				var/mob/dead/observer/G = get_ghost(FALSE, TRUE)
				if(!G)
					status_hud.icon_state = "hudsynthdnr"
				else
					status_hud.icon_state = "hudsynthdead"
			return
		infection_hud.icon_state = "hudsynth" //Xenos can feel synths are not human.
		return TRUE

	if(species.species_flags & HEALTH_HUD_ALWAYS_DEAD)
		if(species.species_flags & ROBOTIC_LIMBS) //Robot check
			status_hud.icon_state = "huddead_robot"
		else
			status_hud.icon_state = "huddead"
		infection_hud.icon_state = ""
		simple_status_hud.icon_state = ""
		return TRUE

	if(status_flags & XENO_HOST)
		var/obj/item/alien_embryo/E = locate(/obj/item/alien_embryo) in src
		if(E)
			if(E.boost_timer)
				infection_hud.icon_state = "infectedmodifier[E.stage]"
			else
				infection_hud.icon_state = "infected[E.stage]"
		else if(locate(/mob/living/carbon/xenomorph/larva) in src)
			infection_hud.icon_state = "infected6"
		else
			infection_hud.icon_state = ""
	else
		infection_hud.icon_state = ""
	if(species.species_flags & ROBOTIC_LIMBS)
		simple_status_hud.icon_state = ""
		infection_hud.icon_state = "hudrobot"

	switch(stat)
		if(DEAD)
			simple_status_hud.icon_state = ""
			infection_hud.icon_state = "huddead_xeno_animated"
			if(!HAS_TRAIT(src, TRAIT_PSY_DRAINED))
				infection_hud.icon_state = "psy_drain"
			if(HAS_TRAIT(src, TRAIT_UNDEFIBBABLE ))
				hud_list[HEART_STATUS_HUD].icon_state = "still_heart"
				if(species.species_flags & ROBOTIC_LIMBS)
					status_hud.icon_state = "huddead_robot"
				else
					status_hud.icon_state = "huddead"
				return TRUE
			if(!client)
				var/mob/dead/observer/ghost = get_ghost()
				if(!ghost?.can_reenter_corpse)
					if(species.species_flags & ROBOTIC_LIMBS)
						status_hud.icon_state = "huddead_robot"
					else
						status_hud.icon_state = "huddead"
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
				SEND_SIGNAL(src, COMSIG_HUMAN_DEATH_STAGE_CHANGE) // i dunno where else to put it even
				if(species.species_flags & ROBOTIC_LIMBS)
					status_hud.icon_state = "huddeaddefib_robot"
				else
					status_hud.icon_state = "huddeaddefib[stage]"
			return TRUE
		if(UNCONSCIOUS)
			if(!client) //Nobody home.
				simple_status_hud.icon_state = "hud_uncon_afk"
				status_hud.icon_state = "hud_uncon_afk"
				return TRUE
			if(IsUnconscious()) //Should hopefully get out of it soon.
				simple_status_hud.icon_state = "hud_uncon_ko"
				status_hud.icon_state = "hud_uncon_ko"
				return TRUE
			status_hud.icon_state = "hud_uncon_sleep" //Regular sleep, else.
			simple_status_hud.icon_state = "hud_uncon_sleep"
			return TRUE
		if(CONSCIOUS)
			if(!key) //Nobody home. Shouldn't affect aghosting.
				simple_status_hud.icon_state = "hud_uncon_afk"
				status_hud.icon_state = "hud_uncon_afk"
				return TRUE
			if(IsParalyzed()) //I've fallen and I can't get up.
				simple_status_hud.icon_state = "hud_con_kd"
				status_hud.icon_state = "hud_con_kd"
				return TRUE
			if(IsStun())
				simple_status_hud.icon_state = "hud_con_stun"
				status_hud.icon_state = "hud_con_stun"
				return TRUE
			if(IsStaggered())
				simple_status_hud.icon_state = "hud_con_stagger"
				status_hud.icon_state = "hud_con_stagger"
				return TRUE
			if(slowdown)
				simple_status_hud.icon_state = "hud_con_slowdown"
				status_hud.icon_state = "hud_con_slowdown"
				return TRUE
			else
				if(species.species_flags & ROBOTIC_LIMBS)
					simple_status_hud.icon_state = ""
					status_hud.icon_state = "hudrobot"
					return TRUE
				else
					simple_status_hud.icon_state = ""
					status_hud.icon_state = "hudhealthy"
					return TRUE

//medical hud used by ghosts

/datum/atom_hud/medical/add_to_single_hud(mob/user, mob/target)
	return ..()

/datum/atom_hud/medical/observer
	hud_icons = list(HEALTH_HUD, XENO_EMBRYO_HUD, XENO_REAGENT_HUD, XENO_DEBUFF_HUD, STATUS_HUD, MACHINE_HEALTH_HUD, MACHINE_AMMO_HUD, XENO_BANISHED_HUD, HUNTER_CLAN, HUNTER_HUD, HUNTER_HEALTH_HUD)

//Xeno status hud, for xenos
/datum/atom_hud/xeno
	hud_icons = list(HEALTH_HUD_XENO, PLASMA_HUD, PHEROMONE_HUD, QUEEN_OVERWATCH_HUD, ARMOR_SUNDER_HUD, XENO_FIRE_HUD, XENO_RANK_HUD, XENO_PRIMO_HUD, XENO_BANISHED_HUD, XENO_BLESSING_HUD, XENO_EVASION_HUD, HUNTER_HUD)

/mob/living/carbon/xenomorph/proc/hud_set_banished()
	var/image/holder = hud_list[XENO_BANISHED_HUD]
	holder.overlays.Cut()
	holder.icon_state = "hudblank"
	if (stat != DEAD && HAS_TRAIT(src, TRAIT_BANISHED))
		holder.icon_state = "xeno_banished"
	holder.pixel_x = -4
	holder.pixel_y = -6

/mob/living/carbon/xenomorph/proc/hud_update_rank()
	var/image/holder = hud_list[XENO_RANK_HUD]
	if(!holder)
		return
	holder.icon_state = "hudblank"
	if(stat != DEAD && playtime_as_number() > 0)
		holder.icon_state = "hudxenoupgrade[playtime_as_number()]"

	hud_list[XENO_RANK_HUD] = holder

/datum/atom_hud/hunter_clan
	hud_icons = list(HUNTER_CLAN)


/datum/atom_hud/hunter_hud
	hud_icons = list(HUNTER_HUD, HUNTER_HEALTH_HUD)

/mob/living/carbon/xenomorph/proc/hud_update_primo()
	var/image/holder = hud_list[XENO_PRIMO_HUD]
	if(!holder)
		return
	holder.icon_state = "hudblank"
	if(stat == DEAD)
		return
	if(upgrade == XENO_UPGRADE_PRIMO)
		holder.icon_state = "hudxenoprimo[playtime_as_number()]"

	hud_list[XENO_PRIMO_HUD] = holder

/mob/living/carbon/human/med_hud_set_health(hud_holder = HEALTH_HUD)
	var/image/holder = hud_list[HEALTH_HUD]
	if(stat == DEAD)
		holder.icon_state = "hudhealth-100"
		return

	var/percentage = round(health * 100 / maxHealth)
	switch(percentage)
		if(100 to INFINITY)
			holder.icon_state = "hudhealth100"
		if(90 to 99)
			holder.icon_state = "hudhealth90"
		if(80 to 89)
			holder.icon_state = "hudhealth80"
		if(70 to 79)
			holder.icon_state = "hudhealth70"
		if(60 to 69)
			holder.icon_state = "hudhealth60"
		if(50 to 59)
			holder.icon_state = "hudhealth50"
		if(45 to 49)
			holder.icon_state = "hudhealth45"
		if(40 to 44)
			holder.icon_state = "hudhealth40"
		if(35 to 39)
			holder.icon_state = "hudhealth35"
		if(30 to 34)
			holder.icon_state = "hudhealth30"
		if(25 to 29)
			holder.icon_state = "hudhealth25"
		if(20 to 24)
			holder.icon_state = "hudhealth20"
		if(15 to 19)
			holder.icon_state = "hudhealth15"
		if(10 to 14)
			holder.icon_state = "hudhealth10"
		if(5 to 9)
			holder.icon_state = "hudhealth5"
		if(0 to 4)
			holder.icon_state = "hudhealth0"
		if(-4 to -1)
			holder.icon_state = "hudhealth-5"
		if(-9 to -5)
			holder.icon_state = "hudhealth-10"
		if(-19 to -10)
			holder.icon_state = "hudhealth-20"
		if(-29 to -20)
			holder.icon_state = "hudhealth-30"
		if(-39 to -30)
			holder.icon_state = "hudhealth-40"
		if(-49 to -40)
			holder.icon_state = "hudhealth-50"
		if(-59 to -50)
			holder.icon_state = "hudhealth-60"
		if(-69 to -60)
			holder.icon_state = "hudhealth-70"
		if(-79 to -70)
			holder.icon_state = "hudhealth-80"
		if(-89 to -80)
			holder.icon_state = "hudhealth-90"
		if(-94 to -90)
			holder.icon_state = "hudhealth-95"
		if(-99 to -95)
			holder.icon_state = "hudhealth-99"
		else
			holder.icon_state = "hudhealth-100"

/mob/living/carbon/human/species/yautja/med_hud_set_health(hud_holder = HUNTER_HEALTH_HUD)
	. = ..()

/mob/living/carbon/human/med_pain_set_perceived_health()
	if(species?.species_flags & IS_SYNTHETIC)
		return FALSE
	if(HAS_TRAIT(src, TRAIT_FOREIGN_BIO))
		return FALSE
	var/image/holder = hud_list[PAIN_HUD]
	if(stat == DEAD)
		holder.icon_state = "hudhealth-100"
		return TRUE

	var/perceived_health = round(health * 100 / maxHealth)
	if(!(species.species_flags & NO_PAIN))
		perceived_health -= PAIN_RATIO_PAIN_HUD * traumatic_shock
	if(!(species.species_flags & NO_STAMINA) && staminaloss > 0)
		perceived_health -= STAMINA_RATIO_PAIN_HUD * staminaloss

	switch(perceived_health)
		if(100 to INFINITY)
			holder.icon_state = "hudhealth100"
		if(90 to 99)
			holder.icon_state = "hudhealth90"
		if(80 to 89)
			holder.icon_state = "hudhealth80"
		if(70 to 79)
			holder.icon_state = "hudhealth70"
		if(60 to 69)
			holder.icon_state = "hudhealth60"
		if(50 to 59)
			holder.icon_state = "hudhealth50"
		if(45 to 49)
			holder.icon_state = "hudhealth45"
		if(40 to 44)
			holder.icon_state = "hudhealth40"
		if(35 to 39)
			holder.icon_state = "hudhealth35"
		if(30 to 34)
			holder.icon_state = "hudhealth30"
		if(25 to 29)
			holder.icon_state = "hudhealth25"
		if(20 to 24)
			holder.icon_state = "hudhealth20"
		if(15 to 19)
			holder.icon_state = "hudhealth15"
		if(10 to 14)
			holder.icon_state = "hudhealth10"
		if(5 to 9)
			holder.icon_state = "hudhealth5"
		if(0 to 4)
			holder.icon_state = "hudhealth0"
		if(-4 to -1)
			holder.icon_state = "hudhealth-5"
		if(-9 to -5)
			holder.icon_state = "hudhealth-10"
		if(-19 to -10)
			holder.icon_state = "hudhealth-20"
		if(-29 to -20)
			holder.icon_state = "hudhealth-30"
		if(-39 to -30)
			holder.icon_state = "hudhealth-40"
		if(-49 to -40)
			holder.icon_state = "hudhealth-50"
		if(-59 to -50)
			holder.icon_state = "hudhealth-60"
		if(-69 to -60)
			holder.icon_state = "hudhealth-70"
		if(-79 to -70)
			holder.icon_state = "hudhealth-80"
		if(-89 to -80)
			holder.icon_state = "hudhealth-90"
		if(-94 to -90)
			holder.icon_state = "hudhealth-95"
		if(-99 to -95)
			holder.icon_state = "hudhealth-99"

	return TRUE
