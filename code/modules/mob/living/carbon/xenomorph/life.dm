#define DEBUG_XENO_LIFE 0
#define XENO_RESTING_HEAL 1
#define XENO_STANDING_HEAL 0.2
#define XENO_CRIT_DAMAGE 5

#define XENO_HUD_ICON_BUCKETS 16  // should equal the number of icons you use to represent health / plasma (from 0 -> X)

/mob/living/carbon/xenomorph/Life()

	if(!loc)
		return

	..()

	if(notransform) //If we're in true stasis don't bother processing life
		return

	if(stat == DEAD)
		SSmobs.stop_processing(src)
		return
	if(stat == UNCONSCIOUS)
		if(is_zoomed)
			zoom_out()
	else
		if(is_zoomed)
			if(!can_walk_zoomed)
				if(loc != zoom_turf)
					zoom_out()
			if(lying_angle)
				zoom_out()
		update_progression()
		update_evolving()

	handle_living_sunder_updates()
	handle_living_health_updates()
	handle_living_plasma_updates()
//RUTGMC EDIT ADDITION BEGIN - Preds
	handle_interference()
//RUTGMC EDIT ADDITION END
	update_action_button_icons()
	update_icons(FALSE)

/mob/living/carbon/xenomorph/handle_fire()
	. = ..()
	if(.)
		if(resting && fire_stacks > 0)
			adjust_fire_stacks(-1)	//Passively lose firestacks when not on fire while resting and having firestacks built up.
		return
	if(!(xeno_caste.caste_flags & CASTE_FIRE_IMMUNE) && on_fire) //Sanity check; have to be on fire to actually take the damage.
		apply_damage((fire_stacks + 3), BURN, blocked = FIRE)

/mob/living/carbon/xenomorph/proc/handle_living_health_updates()
	if(health < 0)
		handle_critical_health_updates()
		return
	if((health >= maxHealth) || on_fire) //can't regenerate.
		updatehealth() //Update health-related stats, like health itself (using brute and fireloss), health HUD and status.
		return
	var/turf/T = loc
	if(!istype(T))
		return

	var/ruler_healing_penalty = 0.5
	if(hive?.living_xeno_ruler?.loc?.z == T.z || xeno_caste.can_flags & CASTE_CAN_HEAL_WITHOUT_QUEEN || (SSticker?.mode.flags_round_type & MODE_XENO_RULER)) //if the living queen's z-level is the same as ours.
		ruler_healing_penalty = 1
	if(loc_weeds_type || xeno_caste.caste_flags & CASTE_INNATE_HEALING) //We regenerate on weeds or can on our own.
		if(lying_angle || resting || xeno_caste.caste_flags & CASTE_QUICK_HEAL_STANDING)
			heal_wounds(XENO_RESTING_HEAL * ruler_healing_penalty * loc_weeds_type ? initial(loc_weeds_type.resting_buff) : 1, TRUE)
		else
			heal_wounds(XENO_STANDING_HEAL * ruler_healing_penalty, TRUE) //Major healing nerf if standing.
	updatehealth()

///Handles sunder modification/recovery during life.dm for xenos
/mob/living/carbon/xenomorph/proc/handle_living_sunder_updates()

	if(!sunder || on_fire) //No sunder, no problem; or we're on fire and can't regenerate.
		return

	var/sunder_recov = xeno_caste.sunder_recover * -0.5 //Baseline

	if(resting) //Resting doubles sunder recovery
		sunder_recov *= 2

	if(ispath(loc_weeds_type, /obj/alien/weeds/resting)) //Resting weeds double sunder recovery
		sunder_recov *= 2

	if(recovery_aura)
		sunder_recov *= 1 + recovery_aura * 0.1 //10% bonus per rank of recovery aura

	SEND_SIGNAL(src, COMSIG_XENOMORPH_SUNDER_REGEN, src)

	adjust_sunder(sunder_recov)

/mob/living/carbon/xenomorph/proc/handle_critical_health_updates()
	if(loc_weeds_type)
		heal_wounds(XENO_RESTING_HEAL)
	else if(!endure) //If we're not Enduring we bleed out
		adjustBruteLoss(XENO_CRIT_DAMAGE)

/mob/living/carbon/xenomorph/proc/heal_wounds(multiplier = XENO_RESTING_HEAL, scaling = FALSE)
	var/amount = 1 + (maxHealth * 0.0375) // 1 damage + 3.75% max health, with scaling power.
	if(recovery_aura)
		amount += recovery_aura * maxHealth * 0.01 // +1% max health per recovery level, up to +5%
	if(scaling)
		if(recovery_aura)
			regen_power = clamp(regen_power + xeno_caste.regen_ramp_amount*30,0,1) //Ignores the cooldown, and gives a 50% boost.
		else if(regen_power < 0) // We're not supposed to regenerate yet. Start a countdown for regeneration.
			regen_power += 2 SECONDS //Life ticks are 2 seconds.
			return
		else
			regen_power = min(regen_power + xeno_caste.regen_ramp_amount*20,1)
		amount *= regen_power
	amount *= multiplier * GLOB.xeno_stat_multiplicator_buff

	var/list/heal_data = list(amount)
	SEND_SIGNAL(src, COMSIG_XENOMORPH_HEALTH_REGEN, heal_data)
	HEAL_XENO_DAMAGE(src, heal_data[1], TRUE)
	return heal_data[1]

/mob/living/carbon/xenomorph/proc/handle_living_plasma_updates()
	var/turf/T = loc
	if(!istype(T)) //This means plasma doesn't update while you're in things like a vent, but since you don't have weeds in a vent or can actually take advantage of pheros, this is fine
		return

	if(!current_aura && (plasma_stored >= xeno_caste.plasma_max * xeno_caste.plasma_regen_limit)) //no loss or gain
		return

	if(current_aura)
		if(plasma_stored < pheromone_cost)
			use_plasma(plasma_stored, FALSE)
			QDEL_NULL(current_aura)
			src.balloon_alert(src, "Stop emitting, no plasma")
		else
			use_plasma(pheromone_cost, FALSE)

	if(HAS_TRAIT(src, TRAIT_NOPLASMAREGEN) || !loc_weeds_type && !(xeno_caste.caste_flags & CASTE_INNATE_PLASMA_REGEN))
		if(current_aura) //we only need to update if we actually used plasma from pheros
			hud_set_plasma()
		return

	var/plasma_gain = xeno_caste.plasma_gain

	if(lying_angle || resting)
		plasma_gain *= 2  // Doubled for resting

	plasma_gain *= loc_weeds_type ? initial(loc_weeds_type.resting_buff) : 1

	var/list/plasma_mod = list(plasma_gain)

	SEND_SIGNAL(src, COMSIG_XENOMORPH_PLASMA_REGEN, plasma_mod)

	gain_plasma(plasma_mod[1])

/mob/living/carbon/xenomorph/can_receive_aura(aura_type, atom/source, datum/aura_bearer/bearer)
	. = ..()
	if(!(xeno_caste.caste_flags & CASTE_FIRE_IMMUNE) && on_fire) //Xenos on fire cannot receive pheros.
		return FALSE

/mob/living/carbon/xenomorph/finish_aura_cycle()
	if(!(xeno_caste.caste_flags & CASTE_FIRE_IMMUNE) && on_fire) //Has to be here to prevent desyncing between phero and life, despite making more sense in handle_fire()
		if(current_aura)
			current_aura.suppressed = TRUE
		if(leader_current_aura)
			leader_current_aura.suppressed = TRUE

	if(frenzy_aura != (received_auras[AURA_XENO_FRENZY] || 0))
		set_frenzy_aura(received_auras[AURA_XENO_FRENZY] || 0)

	if(warding_aura != (received_auras[AURA_XENO_WARDING] || 0))
		if(warding_aura) //If either the new or old warding is 0, we can skip adjusting armor for it.
			soft_armor = soft_armor.modifyAllRatings(-warding_aura * 2.5)
		warding_aura = received_auras[AURA_XENO_WARDING] || 0
		if(warding_aura)
			soft_armor = soft_armor.modifyAllRatings(warding_aura * 2.5)

	recovery_aura = received_auras[AURA_XENO_RECOVERY] || 0

	hud_set_pheromone()
	..()

/mob/living/carbon/xenomorph/proc/handle_interference()
	if(interference)
		interference = max(interference-2, 0)
		SEND_SIGNAL(src, COMSIG_XENOMORPH_INTERFERENCE)

	return interference

//Possibly causes xenolags
/mob/living/carbon/xenomorph/handle_regular_hud_updates()
	if(!client)
		return FALSE

	handle_regular_health_hud_updates()

	// Evolve Hud
	if(hud_used && hud_used.alien_evolve_display)
		hud_used.alien_evolve_display.overlays.Cut()
		if(stat != DEAD)
			var/amount = 0
			if(xeno_caste.evolution_threshold)
				amount = round(evolution_stored * 100 / xeno_caste.evolution_threshold, 5)
				hud_used.alien_evolve_display.icon_state = "evolve[amount]"
				if(!hive.check_ruler() && !isxenolarva(src))
					hud_used.alien_evolve_display.overlays += image('icons/mob/screen/alien_better.dmi', icon_state = "evolve_cant")
				else
					hud_used.alien_evolve_display.overlays -= image('icons/mob/screen/alien_better.dmi', icon_state = "evolve_cant")
			else
				hud_used.alien_evolve_display.icon_state = "evolve_empty"
		else
			hud_used.alien_evolve_display.icon_state = "evolve_empty"

	//Sunder Hud
	if(hud_used && hud_used.alien_sunder_display)
		hud_used.alien_sunder_display.overlays.Cut()
		if(stat != DEAD)
			var/amount = round( 100 - sunder , 5)
			hud_used.alien_sunder_display.icon_state = "sunder[amount]"
			switch(amount)
				if(80 to 100)
					hud_used.alien_sunder_display.overlays += image('icons/mob/screen/alien_better.dmi', icon_state = "sunder_warn0")
				if(60 to 80)
					hud_used.alien_sunder_display.overlays += image('icons/mob/screen/alien_better.dmi', icon_state = "sunder_warn1")
				if(40 to 60)
					hud_used.alien_sunder_display.overlays += image('icons/mob/screen/alien_better.dmi', icon_state = "sunder_warn2")
				if(20 to 40)
					hud_used.alien_sunder_display.overlays += image('icons/mob/screen/alien_better.dmi', icon_state = "sunder_warn3")
				if(0 to 20)
					hud_used.alien_sunder_display.overlays += image('icons/mob/screen/alien_better.dmi', icon_state = "sunder_warn4")
		else
			hud_used.alien_sunder_display.icon_state = "sunder0"

	interactee?.check_eye(src)

	return TRUE

/mob/living/carbon/xenomorph/proc/handle_regular_health_hud_updates()
	if(!client)
		return FALSE

	// Sanity checks
	if(!maxHealth)
		stack_trace("[src] called handle_regular_health_hud_updates() while having [maxHealth] maxHealth.")
		return
	if(!xeno_caste.plasma_max)
		stack_trace("[src] called handle_regular_health_hud_updates() while having [xeno_caste.plasma_max] xeno_caste.plasma_max.")
		return

	// Health Hud
	if(hud_used && hud_used.healths)
		if(stat != DEAD)
			var/amount = round(health * 100 / maxHealth, 5)
			if(health < 0)
				amount = 0 //We dont want crit sprite only at 0 health
			hud_used.healths.icon_state = "health[amount]"
		else
			hud_used.healths.icon_state = "health_dead"

	// Plasma Hud
	if(hud_used && hud_used.alien_plasma_display)
		if(stat != DEAD)
			var/amount = round(plasma_stored * 100 / xeno_caste.plasma_max, 5)
			hud_used.alien_plasma_display.icon_state = "power_display_[amount]"
		else
			hud_used.alien_plasma_display.icon_state = "power_display_0"

/mob/living/carbon/xenomorph/updatehealth()
	if(status_flags & GODMODE)
		health = maxHealth
		stat = CONSCIOUS
		return
	health = maxHealth - getFireLoss() - getBruteLoss() //Xenos can only take brute and fire damage.
	med_hud_set_health()
	update_stat()
	update_wounds()
	handle_regular_health_hud_updates()

/mob/living/carbon/xenomorph/handle_slowdown()
	if(slowdown)
		#if DEBUG_XENO_LIFE
		world << span_debuginfo("Regen: Initial slowdown is: <b>[slowdown]</b>")
		#endif
		adjust_slowdown(-XENO_SLOWDOWN_REGEN)
		#if DEBUG_XENO_LIFE
		world << span_debuginfo("Regen: Final slowdown is: <b>[slowdown]</b>")
		#endif
	return slowdown

/mob/living/carbon/xenomorph/proc/set_frenzy_aura(new_aura)
	if(frenzy_aura == new_aura)
		return
	frenzy_aura = new_aura
	if(frenzy_aura)
		add_movespeed_modifier(MOVESPEED_ID_FRENZY_AURA, TRUE, 0, NONE, TRUE, -frenzy_aura * 0.06)
		return
	remove_movespeed_modifier(MOVESPEED_ID_FRENZY_AURA)
