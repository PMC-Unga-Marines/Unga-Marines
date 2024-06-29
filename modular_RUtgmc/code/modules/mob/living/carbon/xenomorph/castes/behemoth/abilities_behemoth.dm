// ***************************************
// *********** Seismic Fracture
// ***************************************
#define SEISMIC_FRACTURE_WIND_UP 1.3 SECONDS
#define SEISMIC_FRACTURE_RANGE 4
#define SEISMIC_FRACTURE_ATTACK_RADIUS 2
#define SEISMIC_FRACTURE_ATTACK_RADIUS_ENHANCED 5
#define SEISMIC_FRACTURE_ATTACK_RADIUS_EARTH_PILLAR 2
#define SEISMIC_FRACTURE_ENHANCED_DELAY 1 SECONDS
#define SEISMIC_FRACTURE_PARALYZE_DURATION 1 SECONDS
#define SEISMIC_FRACTURE_DAMAGE_MULTIPLIER 1.2
#define SEISMIC_FRACTURE_DAMAGE_MECHA_MODIFIER 10

/datum/action/ability/activable/xeno/seismic_fracture
	name = "Seismic Fracture"
	action_icon_state = "seismic_fracture"
	desc = "Blast the earth around the selected location, inflicting heavy damage in a large radius."
	ability_cost = 50
	cooldown_duration = 20 SECONDS
	target_flags = ABILITY_TURF_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_SEISMIC_FRACTURE,
	)

/datum/action/ability/activable/xeno/seismic_fracture/on_cooldown_finish()
	owner.balloon_alert(owner, "[name] ready")
	return ..()

/datum/action/ability/activable/xeno/seismic_fracture/use_ability(atom/target)
	. = ..()
	if(!line_of_sight(owner, target, SEISMIC_FRACTURE_RANGE))
		owner.balloon_alert(owner, "Out of range")
		return
	var/mob/living/carbon/xenomorph/xeno_owner = owner
	var/datum/action/ability/xeno_action/ready_charge/behemoth_roll/behemoth_roll_action = xeno_owner.actions_by_path[/datum/action/ability/xeno_action/ready_charge/behemoth_roll]
	if(behemoth_roll_action?.charge_ability_on)
		behemoth_roll_action.charge_off()
	var/target_turf = get_turf(target)
	var/owner_turf = get_turf(xeno_owner)
	new /obj/effect/temp_visual/behemoth/stomp/east(owner_turf, owner.dir)
	new /obj/effect/temp_visual/behemoth/crack(owner_turf, owner.dir)
	playsound(target_turf, 'sound/effects/behemoth/behemoth_stomp.ogg', 30, TRUE)
	var/datum/action/ability/xeno_action/primal_wrath/primal_wrath_action = xeno_owner.actions_by_path[/datum/action/ability/xeno_action/primal_wrath]
	do_ability(target_turf, SEISMIC_FRACTURE_WIND_UP, primal_wrath_action?.ability_active? TRUE : FALSE)

/**
 * Handles the warnings, calling the following procs, as well as any alterations caused by Primal Wrath.
 * This has to be cut off from use_ability() to optimize code, due to an interaction with Earth Pillars.
 * Earth Pillars caught in the range of Seismic Fracture reflect the attack by calling this proc again.
 * * target_turf: The targeted turf.
 * * wind_up: The wind-up duration before the ability happens.
 * * enhanced: Whether this is enhanced by Primal Wrath or not.
 * * earth_riser: If this proc was called by an Earth Pillar, its attack radius is reduced.
*/
/datum/action/ability/activable/xeno/seismic_fracture/proc/do_ability(turf/target_turf, wind_up, enhanced, earth_pillar)
	if(!target_turf)
		return
	var/list/turf/turfs_to_attack = filled_turfs(target_turf, earth_pillar? SEISMIC_FRACTURE_ATTACK_RADIUS_EARTH_PILLAR : SEISMIC_FRACTURE_ATTACK_RADIUS, include_edge = FALSE, bypass_window = TRUE, projectile = TRUE)
	if(!length(turfs_to_attack))
		owner.balloon_alert(owner, "Unable to use here")
		return
	if(wind_up <= 0)
		do_attack(turfs_to_attack, enhanced, TRUE)
		return
	add_cooldown()
	succeed_activate()
	do_warning(owner, turfs_to_attack, wind_up)
	addtimer(CALLBACK(src, PROC_REF(do_attack), turfs_to_attack, enhanced), wind_up)
	if(!enhanced)
		return
	new /obj/effect/temp_visual/shockwave/enhanced(get_turf(owner), SEISMIC_FRACTURE_ATTACK_RADIUS, owner.dir)
	playsound(owner, 'sound/effects/behemoth/landslide_roar.ogg', 40, TRUE)
	var/list/turf/extra_turfs_to_warn = filled_turfs(target_turf, SEISMIC_FRACTURE_ATTACK_RADIUS_ENHANCED, bypass_window = TRUE, projectile = TRUE)
	for(var/turf/extra_turf_to_warn AS in extra_turfs_to_warn)
		if(isclosedturf(extra_turf_to_warn))
			extra_turfs_to_warn -= extra_turf_to_warn
	if(length(extra_turfs_to_warn) && length(turfs_to_attack))
		extra_turfs_to_warn -= turfs_to_attack
	do_warning(owner, extra_turfs_to_warn, wind_up + SEISMIC_FRACTURE_ENHANCED_DELAY)
	var/list/turf/extra_turfs = filled_turfs(target_turf, SEISMIC_FRACTURE_ATTACK_RADIUS + 1, bypass_window = TRUE, projectile = TRUE)
	if(length(extra_turfs) && length(turfs_to_attack))
		extra_turfs -= turfs_to_attack
	addtimer(CALLBACK(src, PROC_REF(do_attack_extra), target_turf, extra_turfs, turfs_to_attack, enhanced, SEISMIC_FRACTURE_ATTACK_RADIUS_ENHANCED, SEISMIC_FRACTURE_ATTACK_RADIUS_ENHANCED - SEISMIC_FRACTURE_ATTACK_RADIUS), wind_up + SEISMIC_FRACTURE_ENHANCED_DELAY)

/**
 * Checks for any atoms caught in the attack's range, and applies several effects based on the atom's type.
 * * turfs_to_attack: The turfs affected by this proc.
 * * enhanced: Whether this is enhanced or not.
 * * instant: Whether this is done instantly or not.
*/
/datum/action/ability/activable/xeno/seismic_fracture/proc/do_attack(list/turf/turfs_to_attack, enhanced, instant)
	if(!length(turfs_to_attack))
		return
	var/mob/living/carbon/xenomorph/xeno_owner = owner
	var/damage = (xeno_owner.xeno_caste.melee_damage * xeno_owner.xeno_melee_damage_modifier) * SEISMIC_FRACTURE_DAMAGE_MULTIPLIER
	for(var/turf/target_turf AS in turfs_to_attack)
		if(isclosedturf(target_turf))
			continue
		new /obj/effect/temp_visual/behemoth/crack(target_turf)
		playsound(target_turf, 'sound/effects/behemoth/seismic_fracture_explosion.ogg', 15)
		var/attack_vfx = enhanced? /obj/effect/temp_visual/behemoth/seismic_fracture/enhanced : /obj/effect/temp_visual/behemoth/seismic_fracture
		new attack_vfx(target_turf, enhanced? FALSE : null)
		for(var/atom/movable/affected_atom AS in target_turf)
			if(isliving(affected_atom))
				var/mob/living/affected_living = affected_atom
				if(xeno_owner.issamexenohive(affected_living) || affected_living.stat == DEAD || CHECK_BITFIELD(affected_living.status_flags, INCORPOREAL|GODMODE))
					continue
				affected_living.emote("scream")
				shake_camera(affected_living, 1, 0.8)
				affected_living.Paralyze(SEISMIC_FRACTURE_PARALYZE_DURATION)
				affected_living.apply_damage(damage, BRUTE, blocked = MELEE)
				if(instant)
					continue
				affected_living.layer = ABOVE_MOB_LAYER
				animate(affected_living, pixel_y = affected_living.pixel_y + 40, time = SEISMIC_FRACTURE_PARALYZE_DURATION / 2, easing = CIRCULAR_EASING|EASE_OUT, flags = ANIMATION_END_NOW)
				animate(pixel_y = initial(affected_living.pixel_y), time = SEISMIC_FRACTURE_PARALYZE_DURATION / 2, easing = CIRCULAR_EASING|EASE_IN)
				addtimer(CALLBACK(src, PROC_REF(living_landing), affected_living), SEISMIC_FRACTURE_PARALYZE_DURATION)
			else if(isearthpillar(affected_atom) || ismecha(affected_atom) || istype(affected_atom, /obj/structure/reagent_dispensers/fueltank))
				affected_atom.do_jitter_animation()
				new /obj/effect/temp_visual/behemoth/landslide/hit(affected_atom.loc)
				playsound(affected_atom.loc, get_sfx("behemoth_earth_pillar_hit"), 40)
				if(isearthpillar(affected_atom))
					var/obj/structure/earth_pillar/affected_pillar = affected_atom
					if(affected_pillar.warning_flashes < initial(affected_pillar.warning_flashes))
						continue
					affected_pillar.call_area_attack()
					do_ability(target_turf, initial(affected_pillar.warning_flashes) * 10, FALSE)
					continue
				if(ismecha(affected_atom))
					var/obj/vehicle/sealed/mecha/affected_mecha = affected_atom
					affected_mecha.take_damage(damage * SEISMIC_FRACTURE_DAMAGE_MECHA_MODIFIER, MELEE)
					continue
				if(istype(affected_atom, /obj/structure/reagent_dispensers/fueltank))
					var/obj/structure/reagent_dispensers/fueltank/affected_tank = affected_atom
					affected_tank.explode()
					continue

/// Living mobs that were previously caught in the attack's radius are subject to a landing effect. Their invincibility is removed, and they receive a reduced amount of damage.
/datum/action/ability/activable/xeno/seismic_fracture/proc/living_landing(mob/living/affected_living)
	var/mob/living/carbon/xenomorph/xeno_owner = owner
	affected_living.layer = initial(affected_living.layer)
	var/landing_damage = (xeno_owner.xeno_caste.melee_damage * xeno_owner.xeno_melee_damage_modifier) / 2
	affected_living.apply_damage(landing_damage, BRUTE, blocked = MELEE)
	//playsound(affected_living.loc, 'sound/effects/behemoth/seismic_fracture_landing.ogg', 10, TRUE)
	new /obj/effect/temp_visual/behemoth/stomp(affected_living.loc)

/**
 * Handles the additional attacks caused by Primal Wrath. These are done iteratively rather than instantly, with a delay inbetween.
 * * origin_turf: The starting turf.
 * * extra_turfs: Any additional turfs that should be handled.
 * * excepted_turfs: Turfs that should be excepted from this proc.
 * * enhanced: Whether this is enhanced by Primal Wrath or not.
 * * range: The range to cover.
 * * iteration: The current iteration.
*/
/datum/action/ability/activable/xeno/seismic_fracture/proc/do_attack_extra(turf/origin_turf, list/turf/extra_turfs, list/turf/excepted_turfs, enhanced, range, iteration)
	if(!origin_turf || !range || !iteration || iteration > range)
		return
	var/list/turfs_to_attack = list()
	for(var/turf/extra_turf AS in extra_turfs)
		turfs_to_attack += extra_turf
		var/list/turfs_to_check = get_adjacent_open_turfs(extra_turf)
		for(var/turf/turf_to_check AS in turfs_to_check)
			if((turf_to_check in extra_turfs) || (turf_to_check in excepted_turfs) || (turf_to_check in turfs_to_attack))
				continue
			if(!line_of_sight(origin_turf, turf_to_check) || LinkBlocked(origin_turf, turf_to_check, TRUE, TRUE))
				continue
			extra_turfs += turf_to_check
	do_attack(turfs_to_attack, enhanced)
	extra_turfs -= turfs_to_attack
	excepted_turfs += turfs_to_attack
	iteration++
	addtimer(CALLBACK(src, PROC_REF(do_attack_extra), origin_turf, extra_turfs, excepted_turfs, enhanced, range, iteration), SEISMIC_FRACTURE_ENHANCED_DELAY)

/obj/structure/earth_pillar/Initialize(mapload, mob/living/carbon/xenomorph/new_owner, enhanced)
	. = ..()
	xeno_owner = new_owner
	RegisterSignal(xeno_owner, COMSIG_QDELETING, PROC_REF(owner_deleted))
	if(enhanced)
		icon_state = "[icon_state]e"
		var/random_x = generator("num", -100, 100, NORMAL_RAND)
		animate(src, pixel_x = random_x, pixel_y = 500, time = 0)
		animate(pixel_x = 0, pixel_y = 0, time = 0.5 SECONDS)
		return
	playsound(src, 'sound/effects/behemoth/earth_pillar_rising.ogg', 40, TRUE)
	particle_holder = new(src, /particles/earth_pillar)
	particle_holder.pixel_y = -4
	animate(particle_holder, pixel_y = 4, time = 1.0 SECONDS)
	animate(alpha = 0, time = 0.6 SECONDS)
	QDEL_NULL_IN(src, particle_holder, 1.6 SECONDS)
	do_jitter_animation(jitter_loops = 5)
	RegisterSignals(src, list(COMSIG_ATOM_BULLET_ACT, COMSIG_ATOM_ATTACK_HAND, COMSIG_ATOM_ATTACK_HAND_ALTERNATE, COMSIG_ATOM_ATTACKBY), PROC_REF(call_update_icon_state))

/obj/structure/earth_pillar/ex_act(severity)
	. = ..()
	update_icon_state()
