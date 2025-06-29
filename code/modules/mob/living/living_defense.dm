/mob/living/grab_interact(obj/item/grab/grab, mob/user, base_damage = BASE_MOB_SLAM_DAMAGE, is_sharp = FALSE)
	if(!isliving(grab.grabbed_thing))
		return
	if(grab.grabbed_thing == src)
		return
	if(user == src)
		return

	var/mob/living/grabbed_mob = grab.grabbed_thing
	step_towards(grabbed_mob, src)
	user.drop_held_item()
	var/state = user.grab_state

	if(state >= GRAB_AGGRESSIVE)
		var/own_stun_chance = 0
		var/grabbed_stun_chance = 0
		if(grabbed_mob.mob_size > mob_size)
			own_stun_chance = 25
			grabbed_stun_chance = 10
		else if(grabbed_mob.mob_size < mob_size)
			own_stun_chance = 0
			grabbed_stun_chance = 25
		else
			own_stun_chance = 25
			grabbed_stun_chance = 25

		if(prob(own_stun_chance))
			Paralyze(1 SECONDS)
		if(prob(grabbed_stun_chance))
			grabbed_mob.Paralyze(1 SECONDS)

	var/damage = (user.skills.getRating(SKILL_CQC) * CQC_SKILL_DAMAGE_MOD)
	switch(state)
		if(GRAB_PASSIVE)
			damage += base_damage
			grabbed_mob.visible_message(span_warning("[user] slams [grabbed_mob] against [src]!"))
			log_combat(user, grabbed_mob, "slammed", "", "against [src]")
		if(GRAB_AGGRESSIVE)
			damage += base_damage * 1.5
			grabbed_mob.visible_message(span_danger("[user] bashes [grabbed_mob] against [src]!"))
			log_combat(user, grabbed_mob, "bashed", "", "against [src]")
		if(GRAB_NECK)
			damage += base_damage * 2
			grabbed_mob.visible_message(span_danger("<big>[user] crushes [grabbed_mob] against [src]!</big>"))
			log_combat(user, grabbed_mob, "crushed", "", "against [src]")
	grabbed_mob.apply_damage(damage, blocked = MELEE, updating_health = TRUE)
	apply_damage(damage, blocked = MELEE, updating_health = TRUE)
	playsound(src, 'sound/weapons/heavyhit.ogg', 40)
	return TRUE

/mob/living/proc/electrocute_act(shock_damage, obj/source, siemens_coeff = 1.0)
	return FALSE //only carbon liveforms have this proc

/mob/living/emp_act(severity)
	. = ..()
	var/list/L = GetAllContents()
	for(var/obj/O in L)
		O.emp_act(severity)

//this proc handles being hit by a thrown atom
/mob/living/hitby(atom/movable/AM, speed = 5)
	. = TRUE
	if(isliving(AM))
		var/mob/living/thrown_mob = AM
		if(thrown_mob.mob_size >= mob_size)
			apply_damage((thrown_mob.mob_size + 1 - mob_size) * speed, BRUTE, BODY_ZONE_CHEST, MELEE, updating_health = TRUE)
		if(thrown_mob.mob_size <= mob_size)
			thrown_mob.stop_throw()
			thrown_mob.apply_damage(speed, BRUTE, BODY_ZONE_CHEST, MELEE, updating_health = TRUE)
	else if(isobj(AM))
		var/obj/O = AM
		O.stop_throw()
		apply_damage(O.throwforce*(speed * 0.2), O.damtype, BODY_ZONE_CHEST, MELEE, is_sharp(O), has_edge(O), TRUE, O.penetration)

	visible_message(span_warning(" [src] has been hit by [AM]."), null, null, 5)
	if(ismob(AM.thrower))
		var/mob/M = AM.thrower
		if(M.client)
			log_combat(M, src, "hit", AM, "(thrown)")

	if(speed < 15)
		return
	if(isitem(AM))
		var/obj/item/W = AM
		if(W.sharp && prob(W.embedding.embed_chance))
			W.embed_into(src)
	if(AM.throw_source)
		visible_message(span_warning(" [src] staggers under the impact!"),span_warning(" You stagger under the impact!"), null, 5)
		src.throw_at(get_edge_target_turf(src, get_dir(AM.throw_source, src)), 1, speed * 0.5)

/mob/living/turf_collision(turf/T, speed)
	take_overall_damage(speed * 5, BRUTE, MELEE, FALSE, FALSE, TRUE, 0, 2)
	playsound(src, get_sfx("slam"), 40)

/mob/living/proc/near_wall(direction,distance=1)
	var/turf/T = get_step(get_turf(src),direction)
	var/turf/last_turf = src.loc
	var/i = 1

	while(i > 0 && i<=distance)
		if(T.density) //Turf is a wall!
			return last_turf
		i++
		last_turf = T
		T = get_step(T,direction)

	return FALSE

// End BS12 momentum-transfer code.

//Mobs on Fire
/mob/living/proc/IgniteMob()
	if(status_flags & GODMODE) //Invulnerable mobs don't get ignited
		return FALSE
	if(HAS_TRAIT(src, TRAIT_NON_FLAMMABLE))
		return FALSE
	if(!CHECK_BITFIELD(datum_flags, DF_ISPROCESSING))
		return FALSE
	if(fire_stacks > 0 && !on_fire)
		on_fire = TRUE
		RegisterSignal(src, COMSIG_LIVING_DO_RESIST, PROC_REF(resist_fire))
		to_chat(src, span_danger("You are on fire! Use Resist to put yourself out!"))
		visible_message(span_danger("[src] bursts into flames!"), isxeno(src) ? span_xenodanger("You burst into flames!") : span_userdanger("You burst into flames!"))
		update_fire()
		SEND_SIGNAL(src, COMSIG_LIVING_IGNITED, fire_stacks)
		return TRUE

///Updates fire visuals
/mob/living/proc/update_fire()
	return

///Puts out any fire on the mob
/mob/living/proc/ExtinguishMob()
	var/datum/status_effect/stacking/melting_fire/xeno_fire = has_status_effect(STATUS_EFFECT_MELTING_FIRE)
	if(xeno_fire)
		remove_status_effect(STATUS_EFFECT_MELTING_FIRE)
	if(!on_fire)
		return FALSE
	on_fire = FALSE
	adjust_bodytemperature(-80, 300)
	fire_stacks = 0
	update_fire()
	UnregisterSignal(src, COMSIG_LIVING_DO_RESIST)

///Adjusting the amount of fire_stacks we have on person
/mob/living/proc/adjust_fire_stacks(add_fire_stacks)
	if(QDELETED(src))
		return
	if(add_fire_stacks > 0)	//Fire stack increases are affected by armor, end result rounded up.
		if(status_flags & GODMODE)
			return
		add_fire_stacks = CEILING(modify_by_armor(add_fire_stacks, FIRE), 1)
	fire_stacks = clamp(fire_stacks + add_fire_stacks, -20, 20)
	if(on_fire && fire_stacks <= 0)
		ExtinguishMob()
		return
	update_fire()

///Update fire stacks on life tick
/mob/living/proc/handle_fire()
	if(fire_stacks < 0)
		fire_stacks++ //If we've doused ourselves in water to avoid fire, dry off slowly
		fire_stacks = min(0, fire_stacks)//So we dry ourselves back to default, nonflammable.
	if(!on_fire)
		return 1
	if(fire_stacks > 0)
		adjust_fire_stacks(-1) //the fire is consumed slowly

/mob/living/lava_act()
	if(resistance_flags & INDESTRUCTIBLE)
		return FALSE
	if(stat == DEAD)
		return FALSE
	if(status_flags & GODMODE)
		return TRUE //while godmode will stop the damage, we don't want the process to stop in case godmode is removed

	var/lava_damage = 20
	take_overall_damage(max(modify_by_armor(lava_damage, FIRE), lava_damage * 0.3), BURN, updating_health = TRUE, max_limbs = 3) //snowflakey interaction to stop complete lava immunity
	if(!CHECK_BITFIELD(pass_flags, PASS_FIRE))//Pass fire allow to cross lava without igniting
		adjust_fire_stacks(20)
		IgniteMob()
	return TRUE

/mob/living/fire_act(burn_level, flame_color)
	if(!burn_level)
		return
	if(status_flags & (INCORPOREAL|GODMODE))
		return FALSE
	if(pass_flags & PASS_FIRE)
		return FALSE
	if(hard_armor.getRating(FIRE) >= 100)
		to_chat(src, span_warning("You are untouched by the flames."))
		return FALSE

	. = TRUE
	//TODO: Make firetypes, colour types are terrible
	if(flame_color == FLAME_COLOR_LIME)
		if(has_status_effect(STATUS_EFFECT_MELTING))
			var/datum/status_effect/stacking/melting/debuff = has_status_effect(STATUS_EFFECT_MELTING)
			debuff.add_stacks(2)
		else
			apply_status_effect(STATUS_EFFECT_MELTING, 2)

	take_overall_damage(rand(10, burn_level), BURN, FIRE, updating_health = TRUE, max_limbs = 4)
	to_chat(src, span_warning("You are burned!"))

	adjust_fire_stacks(burn_level)
	if(on_fire || !fire_stacks)
		return
	IgniteMob()

///Try and remove fire from ourselves
/mob/living/proc/resist_fire(datum/source)
	SIGNAL_HANDLER
	fire_stacks = max(fire_stacks - rand(3, 6), 0)
	var/turf/T = get_turf(src)
	if(istype(T, /turf/open/floor/plating/ground/snow))
		visible_message(span_danger("[src] rolls in the snow, putting themselves out!"), \
		span_notice("You extinguish yourself in the snow!"), null, 5)
		ExtinguishMob()
	else
		visible_message(span_danger("[src] rolls on the floor, trying to put themselves out!"), \
		span_notice("You stop, drop, and roll!"), null, 5)
		if(fire_stacks <= 0)
			visible_message(span_danger("[src] has successfully extinguished themselves!"), \
			span_notice("You extinguish yourself."), null, 5)
			ExtinguishMob()
	Paralyze(3 SECONDS)

//Mobs on Fire end
// When they are affected by a queens screech
/mob/living/proc/screech_act(mob/living/carbon/xenomorph/queen/Q)
	shake_camera(src, 3 SECONDS, 1)

/mob/living/effect_smoke(obj/effect/particle_effect/smoke/S)
	. = ..()
	if(!.)
		if(CHECK_BITFIELD(S.smoke_traits, SMOKE_CAMO))
			smokecloak_off()
		return
	if(status_flags & GODMODE)
		return FALSE
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_XENO) && (stat == DEAD || isnestedhost(src)))
		return FALSE
	if(LAZYACCESS(smoke_delays, S.type) > world.time)
		return FALSE
	LAZYSET(smoke_delays, S.type, world.time + S.minimum_effect_delay)
	smoke_contact(S)

/mob/living/proc/smoke_contact(obj/effect/particle_effect/smoke/S)
	var/bio_protection = max(1 - get_permeability_protection() * S.bio_protection, 0)
	var/acid_protection = max(1 - get_soft_acid_protection(), 0)
	var/acid_hard_protection = get_hard_acid_protection()
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_EXTINGUISH))
		ExtinguishMob()
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_BLISTERING))
		adjust_fire_loss(15 * bio_protection)
		to_chat(src, span_danger("It feels as if you've been dumped into an open fire!"))
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_XENO_ACID))
		if(prob(25 * acid_protection))
			to_chat(src, span_danger("Your skin feels like it is melting away!"))
		adjust_fire_loss(max(S.strength * rand(20, 23) * acid_protection - acid_hard_protection), 0)
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_XENO_TOXIC))
		if(HAS_TRAIT(src, TRAIT_INTOXICATION_IMMUNE))
			return
		if(has_status_effect(STATUS_EFFECT_INTOXICATED))
			var/datum/status_effect/stacking/intoxicated/debuff = has_status_effect(STATUS_EFFECT_INTOXICATED)
			debuff.add_stacks(SENTINEL_TOXIC_GRENADE_STACKS_PER)
		apply_status_effect(STATUS_EFFECT_INTOXICATED, SENTINEL_TOXIC_GRENADE_STACKS_PER)
		adjust_fire_loss(SENTINEL_TOXIC_GRENADE_GAS_DAMAGE * bio_protection)
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_CHEM))
		S.reagents?.reaction(src, TOUCH, S.fraction)
	return bio_protection

/mob/living/proc/check_shields(attack_type, damage, damage_type = MELEE, silent, penetration = 0)
	if(!damage)
		stack_trace("check_shields called without a damage value")
		return 0
	. = damage
	var/list/affecting_shields = list()
	SEND_SIGNAL(src, COMSIG_LIVING_SHIELDCALL, affecting_shields, damage_type)
	if(length(affecting_shields) > 1)
		sortTim(affecting_shields, GLOBAL_PROC_REF(cmp_numeric_dsc), associative = TRUE)
	for(var/shield in affecting_shields)
		var/datum/callback/shield_check = shield
		. = shield_check.Invoke(attack_type, ., damage_type, silent, penetration)
		if(!.)
			break

///Applies radiation effects to a mob
/mob/living/proc/apply_radiation(rad_strength = 7, sound_level = null)
	var/datum/looping_sound/geiger/geiger_counter = new(null, TRUE)
	geiger_counter.severity = sound_level ? sound_level : clamp(round(rad_strength * 0.15, 1), 1, 4)
	geiger_counter.start(src)

	adjust_clone_loss(rad_strength)
	adjust_stamina_loss(rad_strength * 7)
	adjust_stagger(rad_strength SECONDS * 0.5)
	add_slowdown(rad_strength * 0.5)
	blur_eyes(rad_strength) //adds a visual indicator that you've just been irradiated
	adjust_radiation(rad_strength * 20) //Radiation status effect, duration is in deciseconds
	to_chat(src, span_warning("Your body tingles as you suddenly feel the strength drain from your body!"))

/mob/living/pre_crush_act(mob/living/carbon/xenomorph/charger, datum/action/ability/xeno_action/ready_charge/charge_datum)
	return (stat == DEAD ? 0 : CHARGE_SPEED(charge_datum) * charge_datum.crush_living_damage)

/mob/living/post_crush_act(mob/living/carbon/xenomorph/charger, datum/action/ability/xeno_action/ready_charge/charge_datum)
	if(density && ((mob_size == charger.mob_size && charger.is_charging <= CHARGE_MAX) || mob_size > charger.mob_size))
		charger.visible_message(span_danger("[charger] rams into [src] and skids to a halt!"),
		span_xenowarning("We ram into [src] and skid to a halt!"))
		charge_datum.do_stop_momentum(FALSE)
		step(src, charger.dir)
		return PRECRUSH_STOPPED

	switch(charge_datum.charge_type)
		if(CHARGE_CRUSH)
			Paralyze(CHARGE_SPEED(charge_datum) * 2 SECONDS)
		if(CHARGE_BULL_HEADBUTT)
			Paralyze(CHARGE_SPEED(charge_datum) * 2.5 SECONDS)

	if(anchored)
		charge_datum.do_stop_momentum(FALSE)
		charger.visible_message(span_danger("[charger] rams into [src] and skids to a halt!"),
			span_xenowarning("We ram into [src] and skid to a halt!"))
		return PRECRUSH_STOPPED

	switch(charge_datum.charge_type)
		if(CHARGE_CRUSH, CHARGE_BULL, CHARGE_BEHEMOTH)
			var/fling_dir = pick((charger.dir & (NORTH|SOUTH)) ? list(WEST, EAST, charger.dir|WEST, charger.dir|EAST) : list(NORTH, SOUTH, charger.dir|NORTH, charger.dir|SOUTH)) //Fling them somewhere not behind nor ahead of the charger.
			var/fling_dist = min(round(CHARGE_SPEED(charge_datum)) + 1, 3)
			var/turf/destination = loc
			var/turf/temp

			for(var/i in 1 to fling_dist)
				temp = get_step(destination, fling_dir)
				if(!temp)
					break
				destination = temp
			if(destination != loc)
				throw_at(destination, fling_dist, 1, charger, TRUE)

			charger.visible_message(span_danger("[charger] rams [src]!"),
			span_xenodanger("We ram [src]!"))
			charge_datum.speed_down(1) //Lose one turf worth of speed.
			GLOB.round_statistics.bull_crush_hit++
			SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "bull_crush_hit")
			return PRECRUSH_PLOWED

		if(CHARGE_BULL_GORE)
			if(world.time > charge_datum.next_special_attack)
				charge_datum.next_special_attack = world.time + 2 SECONDS
				attack_alien_harm(charger, charger.xeno_caste.melee_damage * charger.xeno_melee_damage_modifier, charger.zone_selected, FALSE, TRUE, TRUE) //Free gore attack.
				emote_gored()
				var/turf/destination = get_step(loc, charger.dir)
				if(destination)
					throw_at(destination, 1, 1, charger, FALSE)
				charger.visible_message(span_danger("[charger] gores [src]!"),
					span_xenowarning("We gore [src] and skid to a halt!"))
				GLOB.round_statistics.bull_gore_hit++
				SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "bull_gore_hit")

		if(CHARGE_BULL_HEADBUTT)
			var/fling_dir = charger.a_intent == INTENT_HARM ? charger.dir : REVERSE_DIR(charger.dir)
			var/fling_dist = min(round(CHARGE_SPEED(charge_datum)) + 1, 3)
			var/turf/destination = loc
			var/turf/temp

			for(var/i in 1 to fling_dist)
				temp = get_step(destination, fling_dir)
				if(!temp)
					break
				destination = temp
			if(destination != loc)
				throw_at(destination, fling_dist, 1, charger, TRUE)

			charger.visible_message(span_danger("[charger] rams into [src] and flings [p_them()] away!"),
				span_xenowarning("We ram into [src] and skid to a halt!"))
			GLOB.round_statistics.bull_headbutt_hit++
			SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "bull_headbutt_hit")

	charge_datum.do_stop_momentum(FALSE)
	return PRECRUSH_STOPPED

/mob/living/proc/emote_gored()
	return

/mob/living/punch_act(mob/living/carbon/xenomorph/warrior/xeno, punch_damage, push = TRUE)
	. = ..()
	var/slowdown_stacks = WARRIOR_PUNCH_SLOWDOWN
	var/stagger_stacks = WARRIOR_PUNCH_STAGGER
	var/visual_effect = /obj/effect/temp_visual/warrior/punch/weak
	var/sound_effect = 'sound/weapons/punch1.ogg'
	if(pulledby == xeno)
		xeno.stop_pulling()
		punch_damage *= WARRIOR_PUNCH_GRAPPLED_DAMAGE_MULTIPLIER
		slowdown_stacks *= WARRIOR_PUNCH_GRAPPLED_DEBUFF_MULTIPLIER
		stagger_stacks *= WARRIOR_PUNCH_GRAPPLED_DEBUFF_MULTIPLIER
		visual_effect = /obj/effect/temp_visual/warrior/punch/strong
		sound_effect = 'sound/weapons/punch2.ogg'
		Paralyze(WARRIOR_PUNCH_GRAPPLED_PARALYZE)
		Shake(duration = 0.5 SECONDS)
	var/datum/limb/target_limb
	if(!iscarbon(src))
		var/mob/living/carbon/carbon_target = src
		target_limb = carbon_target.get_limb(xeno.zone_selected)
		if(!target_limb || (target_limb.limb_status & LIMB_DESTROYED))
			target_limb = carbon_target.get_limb(BODY_ZONE_CHEST)
	xeno.face_atom(src)
	xeno.do_attack_animation(src)
	new visual_effect(get_turf(src))
	playsound(src, sound_effect, 50, 1)
	shake_camera(src, 1, 1)
	add_slowdown(slowdown_stacks)
	adjust_stagger(stagger_stacks SECONDS)
	adjust_blurriness(slowdown_stacks)
	apply_damage(punch_damage, BRUTE, target_limb ? target_limb : 0, MELEE)
	apply_damage(punch_damage, STAMINA, updating_health = TRUE)
	var/turf_behind = get_step(src, REVERSE_DIR(get_dir(src, xeno)))
	if(!push)
		return
	if(LinkBlocked(get_turf(src), turf_behind))
		do_attack_animation(turf_behind)
		return
	knockback(xeno, WARRIOR_PUNCH_KNOCKBACK_DISTANCE, WARRIOR_PUNCH_KNOCKBACK_SPEED)
