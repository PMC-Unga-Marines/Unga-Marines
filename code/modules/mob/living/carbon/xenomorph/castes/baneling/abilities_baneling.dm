/datum/action/ability/xeno_action/baneling_explode
	name = "Baneling Explode"
	desc = "Explode and spread dangerous toxins to hinder or kill your foes. You die."
	action_icon_state = "baneling_explode"
	action_icon = 'icons/Xeno/actions/general.dmi'
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_BANELING_EXPLODE,
	)

/datum/action/ability/xeno_action/baneling_explode/give_action(mob/living/L)
	. = ..()
	RegisterSignal(xeno_owner, COMSIG_MOB_PRE_DEATH, PROC_REF(handle_smoke))

/datum/action/ability/xeno_action/baneling_explode/remove_action(mob/living/L)
	UnregisterSignal(xeno_owner, COMSIG_MOB_PRE_DEATH)
	return ..()

/datum/action/ability/xeno_action/baneling_explode/action_activate()
	. = ..()
	handle_smoke(ability = TRUE)
	xeno_owner.record_tactical_unalive()
	xeno_owner.death(TRUE)

/// This proc defines, and sets up and then lastly starts the smoke, if ability is false we divide range by 4.
/datum/action/ability/xeno_action/baneling_explode/proc/handle_smoke(datum/source, ability = FALSE)
	SIGNAL_HANDLER
	if(xeno_owner.plasma_stored <= 60)
		return
	var/turf/owner_T = get_turf(xeno_owner)
	var/datum/effect_system/smoke_spread/smoke = new /datum/effect_system/smoke_spread/xeno/acid(owner_T)
	xeno_owner.use_plasma(xeno_owner.plasma_stored)
	var/smoke_range = BANELING_SMOKE_RANGE
	/// If this proc is triggered by signal(so death), we want to divide range by 2
	if(!ability)
		smoke_range = smoke_range * 0.5
	smoke.set_up(smoke_range, owner_T, BANELING_SMOKE_DURATION)
	playsound(owner_T, 'sound/effects/blobattack.ogg', 25)
	smoke.start()

	xeno_owner.record_war_crime()

/datum/action/ability/xeno_action/baneling_explode/ai_should_start_consider()
	return TRUE

/datum/action/ability/xeno_action/baneling_explode/ai_should_use(atom/target)
	if(!iscarbon(target))
		return FALSE
	if(get_dist(target, xeno_owner) > 1)
		return FALSE
	if(!line_of_sight(xeno_owner, target))
		return FALSE
	if(target.get_xeno_hivenumber() == xeno_owner.get_xeno_hivenumber())
		return FALSE
	return TRUE
