#define STAGE_ONE_BLOODTHIRST 100
#define STAGE_TWO_BLOODTHIRST 300
#define STAGE_THREE_BLOODTHIRST 400

// ***************************************
// *********** Charge
// ***************************************
/datum/action/ability/activable/xeno/charge
	name = "Eviscerating Charge"
	action_icon_state = "pounce"
	desc = "Charge up to 4 tiles and viciously attack your target."
	cooldown_duration = 20 SECONDS
	ability_cost = 250 //Can't ignore pain/Charge and ravage in the same timeframe, but you can combo one of them. //RU TGMC EDIT
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_RAVAGER_CHARGE,
	)
	///charge distance
	var/charge_range = RAV_CHARGEDISTANCE

/datum/action/ability/activable/xeno/charge/nocost
	ability_cost = 0

/datum/action/ability/activable/xeno/charge/use_ability(atom/A)
	if(!A)
		return
	var/mob/living/carbon/xenomorph/ravager/X = owner

	RegisterSignal(X, COMSIG_XENO_OBJ_THROW_HIT, PROC_REF(obj_hit))
	RegisterSignal(X, COMSIG_MOVABLE_POST_THROW, PROC_REF(charge_complete))
	RegisterSignal(X, COMSIG_XENOMORPH_LEAP_BUMP, PROC_REF(mob_hit))

	X.visible_message(span_danger("[X] charges towards \the [A]!"), \
	span_danger("We charge towards \the [A]!") )
	X.emote("roar")
	X.xeno_flags |= XENO_LEAPING //This has to come before throw_at, which checks impact. So we don't do end-charge specials when thrown
	succeed_activate()

	var/multiplier = 1
	if(HAS_TRAIT(owner, TRAIT_BLOODTHIRSTER))
		if(X.plasma_stored >= STAGE_TWO_BLOODTHIRST)
			multiplier += 0.5
			if(X.plasma_stored >= STAGE_THREE_BLOODTHIRST)
				multiplier += 0.5

	X.throw_at(A, charge_range*multiplier, RAV_CHARGESPEED*multiplier, X)

	add_cooldown()

/datum/action/ability/activable/xeno/charge/on_cooldown_finish()
	to_chat(owner, span_xenodanger("Our exoskeleton quivers as we get ready to use [name] again."))
	playsound(owner, "sound/effects/alien/newlarva.ogg", 50, 0, 1)
	return ..()

/datum/action/ability/activable/xeno/charge/ai_should_start_consider()
	return TRUE

/datum/action/ability/activable/xeno/charge/ai_should_use(atom/target)
	if(!iscarbon(target))
		return FALSE
	if(!line_of_sight(owner, target, charge_range))
		return FALSE
	if(!can_use_ability(target, override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(target.get_xeno_hivenumber() == owner.get_xeno_hivenumber())
		return FALSE
	return TRUE

///Deals with hitting objects
/datum/action/ability/activable/xeno/charge/proc/obj_hit(datum/source, obj/target, speed)
	SIGNAL_HANDLER
	if(istype(target, /obj/structure/table))
		var/obj/structure/S = target
		owner.visible_message(span_danger("[owner] plows straight through [S]!"), null, null, 5)
		S.deconstruct(FALSE) //We want to continue moving, so we do not reset throwing.
		return //stay registered

	target.hitby(owner, speed) //This resets throwing.
	charge_complete()

///Deals with hitting mobs. Triggered by bump instead of throw impact as we want to plow past mobs
/datum/action/ability/activable/xeno/charge/proc/mob_hit(datum/source, mob/living/living_target)
	SIGNAL_HANDLER
	. = TRUE
	if(living_target.stat || isxeno(living_target)) //we leap past xenos
		return

	var/mob/living/carbon/xenomorph/xeno_owner = owner
	var/multiplier = 1
	if(HAS_TRAIT(xeno_owner, TRAIT_BLOODTHIRSTER))
		if(xeno_owner.plasma_stored >= STAGE_TWO_BLOODTHIRST)
			multiplier++
			if(xeno_owner.plasma_stored >= STAGE_THREE_BLOODTHIRST)
				multiplier++
	living_target.attack_alien_harm(xeno_owner, xeno_owner.xeno_caste.melee_damage * xeno_owner.xeno_melee_damage_modifier * 0.25 * multiplier, FALSE, TRUE, FALSE, TRUE, INTENT_HARM) //Location is always random, cannot crit, harm only
	var/target_turf = get_ranged_target_turf(living_target, get_dir(src, living_target), rand(1, 3)) //we blast our victim behind us
	target_turf = get_step_rand(target_turf) //Scatter
	if(iscarbon(living_target))
		var/mob/living/carbon/carbon_victim = living_target
		carbon_victim.Paralyze(2 SECONDS)
	living_target.throw_at(get_turf(target_turf), charge_range, RAV_CHARGESPEED, src)

///Cleans up after charge is finished
/datum/action/ability/activable/xeno/charge/proc/charge_complete()
	SIGNAL_HANDLER
	UnregisterSignal(owner, list(COMSIG_XENO_OBJ_THROW_HIT, COMSIG_MOVABLE_POST_THROW, COMSIG_XENOMORPH_LEAP_BUMP))
	var/mob/living/carbon/xenomorph/ravager/xeno_owner = owner
	xeno_owner.xeno_flags &= ~XENO_LEAPING

// ***************************************
// *********** Ravage
// ***************************************
/datum/action/ability/activable/xeno/ravage
	name = "Ravage"
	action_icon_state = "ravage"
	desc = "Attacks and knockbacks enemies in the direction your facing."
	ability_cost = 200
	cooldown_duration = 6 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY | ABILITY_IGNORE_SELECTED_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_RAVAGE,
		KEYBINDING_ALTERNATE = COMSIG_XENOABILITY_RAVAGE_SELECT,
	)
	/// Used for particles. Holds the particles instead of the mob. See particle_holder for documentation.
	var/obj/effect/abstract/particle_holder/particle_holder

/datum/action/ability/activable/xeno/ravage/nocost
	ability_cost = 0

/datum/action/ability/activable/xeno/ravage/on_cooldown_finish()
	to_chat(owner, span_xenodanger("We gather enough strength to Ravage again."))
	playsound(owner, "sound/effects/alien/newlarva.ogg", 50, 0, 1)
	return ..()

/datum/action/ability/activable/xeno/ravage/use_ability(atom/A)
	var/mob/living/carbon/xenomorph/ravager/X = owner

	X.emote("roar")
	X.visible_message(span_danger("\The [X] thrashes about in a murderous frenzy!"), \
	span_xenowarning("We thrash about in a murderous frenzy!"))

	X.face_atom(A)
	activate_particles(X.dir)

	var/list/atom/movable/atoms_to_ravage = get_step(owner, owner.dir).contents.Copy()
	atoms_to_ravage += get_step(owner, turn(owner.dir, -45)).contents
	atoms_to_ravage += get_step(owner, turn(owner.dir, 45)).contents
	///actual target we will check adjacency with
	var/atom/adjacent_relative = X
	if(HAS_TRAIT(owner, TRAIT_BLOODTHIRSTER))
		if(X.plasma_stored >= STAGE_TWO_BLOODTHIRST)
			var/turf/far = get_step(get_step(owner, owner.dir), owner.dir)
			atoms_to_ravage += far.contents
			atoms_to_ravage += get_step(far, turn(owner.dir, 90)).contents
			atoms_to_ravage += get_step(far, turn(owner.dir, -90)).contents
			var/turf/test = get_step(owner, owner.dir)
			if(X.plasma_stored >= STAGE_THREE_BLOODTHIRST && test.Adjacent(far))
				adjacent_relative = far
				var/turf/furthest = get_step(far, owner.dir)
				atoms_to_ravage += furthest.contents
				atoms_to_ravage += get_step(furthest, turn(owner.dir, 90)).contents
				atoms_to_ravage += get_step(furthest, turn(owner.dir, -90)).contents

	for(var/atom/movable/ravaged AS in atoms_to_ravage)
		if(ishitbox(ravaged) || isvehicle(ravaged))
			ravaged.attack_alien(X, X.xeno_caste.melee_damage) //Handles APC/Tank stuff. Has to be before the !ishuman check or else ravage does work properly on vehicles.
			continue
		if(!(ravaged.resistance_flags & XENO_DAMAGEABLE) || !adjacent_relative.Adjacent(ravaged))
			continue
		if(!ishuman(ravaged))
			ravaged.attack_alien(X, X.xeno_caste.melee_damage)
			ravaged.knockback(X, RAV_RAVAGE_THROW_RANGE, RAV_CHARGESPEED)
			continue
		var/mob/living/carbon/human/human_victim = ravaged
		if(human_victim.stat == DEAD)
			continue
		human_victim.attack_alien_harm(X, X.xeno_caste.melee_damage * X.xeno_melee_damage_modifier * 0.25, FALSE, TRUE, FALSE, TRUE)
		human_victim.knockback(X, RAV_RAVAGE_THROW_RANGE, RAV_CHARGESPEED)
		shake_camera(human_victim, 2, 1)
		human_victim.Paralyze(1 SECONDS)

	succeed_activate()
	add_cooldown()

/// Handles the activation and deactivation of particles, as well as their appearance.
/datum/action/ability/activable/xeno/ravage/proc/activate_particles(direction) // This could've been an animate()!
	particle_holder = new(get_turf(owner), /particles/ravager_slash)
	QDEL_NULL_IN(src, particle_holder, 5)
	particle_holder.particles.rotation += dir2angle(direction)
	switch(direction) // There's no shared logic here because sprites are magical.
		if(NORTH) // Gotta define stuff for each angle so it looks good.
			particle_holder.particles.position = list(8, 4)
			particle_holder.particles.velocity = list(0, 20)
		if(EAST)
			particle_holder.particles.position = list(3, -8)
			particle_holder.particles.velocity = list(20, 0)
		if(SOUTH)
			particle_holder.particles.position = list(-9, -3)
			particle_holder.particles.velocity = list(0, -20)
		if(WEST)
			particle_holder.particles.position = list(-4, 9)
			particle_holder.particles.velocity = list(-20, 0)

/datum/action/ability/activable/xeno/ravage/ai_should_start_consider()
	return TRUE

/datum/action/ability/activable/xeno/ravage/ai_should_use(atom/target)
	if(!iscarbon(target))
		return FALSE
	if(get_dist(target, owner) > 1)
		return FALSE
	if(!can_use_ability(target, override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(target.get_xeno_hivenumber() == owner.get_xeno_hivenumber())
		return FALSE
	return TRUE

/particles/ravager_slash
	icon = 'icons/effects/200x200.dmi'
	icon_state = "ravager_slash"
	width = 600
	height = 600
	count = 1
	spawning = 1
	lifespan = 4
	fade = 4
	scale = 0.6
	grow = -0.02
	rotation = -160
	friction = 0.6

// ***************************************
// *********** Endure
// ***************************************
/datum/action/ability/xeno_action/endure
	name = "Endure"
	action_icon_state = "ignore_pain"
	desc = "For the next few moments you will not go into crit and become resistant to explosives and immune to stagger and slowdown, but you still die if you take damage exceeding your crit health."
	ability_cost = 200
	cooldown_duration = 60 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_ENDURE,
	)
	use_state_flags = ABILITY_USE_STAGGERED //Can use this while staggered
	///How low the Ravager's health can go while under the effects of Endure before it dies
	var/endure_threshold = RAVAGER_ENDURE_HP_LIMIT
	///Timer for Endure's duration
	var/endure_duration
	///Timer for Endure's warning
	var/endure_warning_duration

/datum/action/ability/xeno_action/endure/nocost
	ability_cost = 0

/datum/action/ability/xeno_action/endure/on_cooldown_finish()
	to_chat(owner, span_xenodanger("We feel able to imbue ourselves with plasma to Endure once again!"))
	owner.playsound_local(owner, 'sound/effects/alien/newlarva.ogg', 25, 0, 1)
	return ..()

/datum/action/ability/xeno_action/endure/action_activate()
	var/mob/living/carbon/xenomorph/ravager/X = owner

	X.emote("roar")
	X.visible_message(span_danger("[X]'s skin begins to glow!"), \
	span_xenowarning("We feel the plasma coursing through our veins!"))

	X.endure = TRUE

	X.add_filter("ravager_endure_outline", 4, outline_filter(1, COLOR_PURPLE)) //Set our cool aura; also confirmation we have the buff

	endure_duration = addtimer(CALLBACK(src, PROC_REF(endure_warning)), RAVAGER_ENDURE_DURATION * RAVAGER_ENDURE_DURATION_WARNING, TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE) //Warn the ravager when the duration is about to expire.
	endure_warning_duration = addtimer(CALLBACK(src, PROC_REF(endure_deactivate)), RAVAGER_ENDURE_DURATION, TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE)

	X.set_stagger(0) //Remove stagger
	X.set_slowdown(0) //Remove slowdown
	X.soft_armor = X.soft_armor.modifyRating(bomb = 20) //Improved explosion resistance
	ADD_TRAIT(X, TRAIT_STAGGERIMMUNE, ENDURE_TRAIT) //Can now endure impacts/damages that would make lesser xenos flinch
	ADD_TRAIT(X, TRAIT_SLOWDOWNIMMUNE, ENDURE_TRAIT) //Can now endure slowdown

	RegisterSignal(X, COMSIG_XENOMORPH_BRUTE_DAMAGE, PROC_REF(damage_taken)) //Warns us if our health is critically low
	RegisterSignal(X, COMSIG_XENOMORPH_BURN_DAMAGE, PROC_REF(damage_taken))

	succeed_activate()
	add_cooldown()

	GLOB.round_statistics.ravager_endures++ //Statistics
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "ravager_endures")

///Warns the player when Endure is about to end
/datum/action/ability/xeno_action/endure/proc/endure_warning()
	if(QDELETED(owner))
		return
	to_chat(owner,span_highdanger("We feel the plasma draining from our veins... [initial(name)] will last for only [timeleft(endure_duration) * 0.1] more seconds!"))
	owner.playsound_local(owner, 'sound/voice/alien/hiss8.ogg', 50, 0, 1)

///Turns off the Endure buff
/datum/action/ability/xeno_action/endure/proc/endure_deactivate()
	if(QDELETED(owner))
		return
	var/mob/living/carbon/xenomorph/X = owner

	UnregisterSignal(X, COMSIG_XENOMORPH_BRUTE_DAMAGE)
	UnregisterSignal(X, COMSIG_XENOMORPH_BURN_DAMAGE)

	X.do_jitter_animation(1000)
	X.endure = FALSE
	X.clear_fullscreen("endure", 0.7 SECONDS)
	X.remove_filter("ravager_endure_outline")
	if(X.health < X.get_crit_threshold()) //If we have less health than our death threshold, but more than our Endure death threshold, set our HP to just a hair above insta dying
		var/total_damage = X.getFireLoss() + X.getBruteLoss()
		var/burn_percentile_damage = X.getFireLoss() / total_damage
		var/brute_percentile_damage = X.getBruteLoss() / total_damage
		X.setBruteLoss((X.xeno_caste.max_health - X.get_crit_threshold()-1) * brute_percentile_damage)
		X.setFireLoss((X.xeno_caste.max_health - X.get_crit_threshold()-1) * burn_percentile_damage)

	X.soft_armor = X.soft_armor.modifyRating(bomb = -20) //Remove resistances/immunities
	REMOVE_TRAIT(X, TRAIT_STAGGERIMMUNE, ENDURE_TRAIT)
	REMOVE_TRAIT(X, TRAIT_SLOWDOWNIMMUNE, ENDURE_TRAIT)
	endure_threshold = initial(endure_threshold) //Reset the endure vars to their initial states
	endure_duration = initial(endure_duration)
	endure_warning_duration = initial(endure_warning_duration)

	to_chat(owner,span_highdanger("The last of the plasma drains from our body... We can no longer endure beyond our normal limits!"))
	owner.playsound_local(owner, 'sound/voice/alien/hiss8.ogg', 50, 0, 1)

///Warns us when our health is critically low and tells us exactly how much more punishment we can take
/datum/action/ability/xeno_action/endure/proc/damage_taken(mob/living/carbon/xenomorph/X, damage_taken)
	SIGNAL_HANDLER
	if(X.health < 0)
		to_chat(X, "<span class='xenohighdanger' style='color: red;'>We are critically wounded! We can only withstand [(RAVAGER_ENDURE_HP_LIMIT-X.health) * -1] more damage before we perish!</span>")
		X.overlay_fullscreen("endure", /atom/movable/screen/fullscreen/animated/bloodlust)
	else
		X.clear_fullscreen("endure", 0.7 SECONDS)



/datum/action/ability/xeno_action/endure/ai_should_start_consider()
	return TRUE

/datum/action/ability/xeno_action/endure/ai_should_use(target)
	var/mob/living/carbon/xenomorph/ravager/X = owner
	if(!iscarbon(target))
		return FALSE
	if(get_dist(target, owner) > WORLD_VIEW_NUM) // If we can be seen.
		return FALSE
	if(X.health > 50)
		return FALSE
	if(!can_use_action(override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	return TRUE

// ***************************************
// *********** Vampirism
// ***************************************

/particles/xeno_slash/vampirism
	color = "#ff0000"
	grow = list(-0.2 ,0.5)
	fade = 10
	gravity = list(0, -5)
	velocity = list(1000, 1000)
	friction = 50
	lifespan = 10
	position = generator(GEN_SPHERE, 10, 30, NORMAL_RAND)
	scale = generator(GEN_VECTOR, list(1, 1), list(0.9, 0.9), NORMAL_RAND)

/datum/action/ability/xeno_action/vampirism
	name = "Toggle vampirism"
	action_icon_state = "neuroclaws_off"
	desc = "Toggle on to enable boosting on "
	ability_cost = 0 //We're limited by nothing, rip and tear
	cooldown_duration = 1 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY | ABILITY_IGNORE_SELECTED_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_VAMPIRISM,
	)
	/// how long we have to wait before healing again
	var/heal_delay = 2 SECONDS
	/// Used for particles. Holds the particles instead of the mob. See particle_holder for documentation.
	var/obj/effect/abstract/particle_holder/particle_holder
	/// Ref to our particle deletion timer
	var/timer_ref

/datum/action/ability/xeno_action/vampirism/clean_action()
	QDEL_NULL(particle_holder)
	timer_ref = null
	return ..()

/datum/action/ability/xeno_action/vampirism/update_button_icon()
	var/mob/living/carbon/xenomorph/xeno = owner
	action_icon_state = xeno.vampirism ? "neuroclaws_on" : "neuroclaws_off"
	return ..()

/datum/action/ability/xeno_action/vampirism/give_action(mob/living/L)
	. = ..()
	var/mob/living/carbon/xenomorph/xeno = L
	xeno.vampirism = TRUE
	RegisterSignal(L, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(on_slash))

/datum/action/ability/xeno_action/vampirism/remove_action(mob/living/L)
	. = ..()
	var/mob/living/carbon/xenomorph/xeno = L
	xeno.vampirism = FALSE
	UnregisterSignal(L, COMSIG_XENOMORPH_ATTACK_LIVING)

/datum/action/ability/xeno_action/vampirism/action_activate()
	. = ..()
	var/mob/living/carbon/xenomorph/xeno = owner
	xeno.vampirism = !xeno.vampirism
	if(xeno.vampirism)
		RegisterSignal(xeno, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(on_slash))
	else
		UnregisterSignal(xeno, COMSIG_XENOMORPH_ATTACK_LIVING)
	to_chat(xeno, span_xenonotice("You will now[xeno.vampirism ? "" : " no longer"] heal from attacking"))

///Adds the slashed mob to tracked damage mobs
/datum/action/ability/xeno_action/vampirism/proc/on_slash(datum/source, mob/living/target, damage, list/damage_mod, list/armor_mod)
	SIGNAL_HANDLER
	if(target.stat == DEAD)
		return
	if(!ishuman(target)) // no farming on animals/dead
		return
	if(timeleft(timer_ref) > 0)
		return
	var/mob/living/carbon/human/human_target = target // RUTGMC ADDITION START
	human_target.blood_volume -= 5 // something about 1% // RUTGMC ADDITION END
	var/mob/living/carbon/xenomorph/x = owner
	x.adjustBruteLoss(-x.bruteloss * 0.125)
	x.adjustFireLoss(-x.fireloss * 0.125)
	update_button_icon()
	particle_holder = new(x, /particles/xeno_slash/vampirism)
	particle_holder.pixel_y = 18
	particle_holder.pixel_x = 18
	timer_ref = QDEL_NULL_IN(src, particle_holder, heal_delay)

// ***************************************
// *********** Immortality
// ***************************************
/datum/action/ability/xeno_action/immortality
	name = "Immortality"
	action_icon_state = "enhancement"
	desc = "We are too angry to die."
	ability_cost = 666
	cooldown_duration = 35 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_IMMORTALITY,
	)
	use_state_flags = ABILITY_USE_STAGGERED

/datum/action/ability/xeno_action/immortality/on_cooldown_finish()
	to_chat(owner, span_xenodanger("We are able to become immortal once again."))
	owner.playsound_local(owner, 'sound/effects/alien/newlarva.ogg', 25, 0, 1)
	return ..()

/datum/action/ability/xeno_action/immortality/action_activate()
	var/mob/living/carbon/xenomorph/ravager/X = owner

	X.emote("roar")
	X.visible_message(span_danger("[X]'s skin begins to glow!"), \
	span_xenowarning("We are too angry to die!"))

	X.add_filter("ravager_immortality_outline", 4, outline_filter(0.5, COLOR_TRANSPARENT_SHADOW))

	ENABLE_BITFIELD(X.status_flags, GODMODE)

	addtimer(CALLBACK(src, PROC_REF(immortality_deactivate)), RAVAGER_IMMORTALITY_DURATION, TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE)

	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/immortality/proc/immortality_deactivate()
	if(QDELETED(owner))
		return
	var/mob/living/carbon/xenomorph/X = owner

	DISABLE_BITFIELD(X.status_flags, GODMODE)

	X.do_jitter_animation(500)

	X.remove_filter("ravager_immortality_outline")

	to_chat(owner,span_highdanger("We are now mortal again."))
	owner.playsound_local(owner, 'sound/voice/alien/hiss8.ogg', 50, 0, 1)

#define BLOODTHIRST_DECAY_PER_TICK 30
#define LOWEST_BLOODTHIRST_HP_ALLOWED 100
#define MAX_DAMAGE_PER_DISINTEGRATING 25

/datum/action/ability/xeno_action/bloodthirst
	name = "bloodthirst"
	desc = "tivi todo"
	///tick time of last time we attacked a human
	var/last_fight_time
	///time when we last hit 0 bloodthirst/plasma
	var/hit_zero_time
	/// delay until decaying starts
	var/decay_delay = 30 SECONDS
	///once bloodthirst hits 0 how long
	var/damage_delay = 30 SECONDS
	///used to track if effects played for disintegration start
	var/disintegrating = FALSE

/datum/action/ability/xeno_action/bloodthirst/give_action(mob/living/L)
	. = ..()
	RegisterSignal(L, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(on_attack))
	RegisterSignal(L, COMSIG_XENOMORPH_TAKING_DAMAGE, PROC_REF(on_take_damage))
	ADD_TRAIT(L, TRAIT_BLOODTHIRSTER, TRAIT_GENERIC)
	START_PROCESSING(SSprocessing, src)
	last_fight_time = world.time

/datum/action/ability/xeno_action/bloodthirst/remove_action(mob/living/L)
	. = ..()
	REMOVE_TRAIT(L, TRAIT_BLOODTHIRSTER, TRAIT_GENERIC)
	UnregisterSignal(L, list(COMSIG_XENOMORPH_ATTACK_LIVING, COMSIG_XENOMORPH_TAKING_DAMAGE))
	STOP_PROCESSING(SSprocessing, src)

/// sig handler to track attacks for bloodthirst
/datum/action/ability/xeno_action/bloodthirst/proc/on_attack(datum/source, mob/living/attacked, damage)
	SIGNAL_HANDLER
	if(!ishuman(attacked) || attacked.stat == DEAD)
		return
	last_fight_time = world.time

///sig handler to track last attacked for bloodthirst
/datum/action/ability/xeno_action/bloodthirst/proc/on_take_damage(datum/source, damage)
	SIGNAL_HANDLER
	last_fight_time = world.time

/datum/action/ability/xeno_action/bloodthirst/process()
	var/mob/living/carbon/xenomorph/xeno = owner
	if(!last_fight_time) // you may live until first attack happens
		return
	if(last_fight_time + decay_delay > world.time)
		return
	if(xeno.use_plasma(BLOODTHIRST_DECAY_PER_TICK))
		disintegrating = FALSE
		return
	if(!disintegrating)
		hit_zero_time = world.time
		owner.balloon_alert(owner, "disintegrating...")
		xeno.playsound_local(xeno, 'sound/voice/alien/hiss5.ogg', 50)
		disintegrating = TRUE
		return
	if((hit_zero_time + damage_delay) < world.time)
		//take  damage per tick down to a minimum allowed hp
		var/damage_taken = min(MAX_DAMAGE_PER_DISINTEGRATING, (xeno.health - xeno.health_threshold_crit - LOWEST_BLOODTHIRST_HP_ALLOWED))
		xeno.take_overall_damage(damage_taken)


#define DEATHMARK_DAMAGE_OR_DIE 400
#define DEATHMARK_DURATION 40 SECONDS
#define DEATHMARK_MESSAGE_COOLDOWN 2 SECONDS

/datum/action/ability/xeno_action/deathmark
	name = "deathmark"
	desc = "Mark yourself for death, filling your bloodthirst, but failing to deal enough damage to living creatures while it is active instantly kills you."
	cooldown_duration = DEATHMARK_DURATION*3
	COOLDOWN_DECLARE(message_cooldown)
	//tracker for damage dealt during deathmark
	var/damage_dealt = 0

/datum/action/ability/xeno_action/deathmark/action_activate()
	var/mob/living/carbon/xenomorph/xeno = owner
	addtimer(CALLBACK(src, PROC_REF(on_deathmark_expire)), DEATHMARK_DURATION)

	xeno.overlays_standing[SUIT_LAYER] = image('icons/Xeno/64x64_Xeno_overlays.dmi', icon_state = "deathmark")
	xeno.apply_temp_overlay(SUIT_LAYER, DEATHMARK_DURATION)

	RegisterSignal(owner, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(on_attack))
	damage_dealt = 0
	xeno.use_plasma(-xeno.xeno_caste.plasma_max) // fill it to the max so they can kill better
	xeno.add_movespeed_modifier(MOVESPEED_ID_RAVAGER_DEATHMARK, TRUE, 0, NONE, TRUE, -1.5) //Extra speed so they can get to where to kill better
	xeno.emote("roar")
	add_cooldown()

/// on attack for deathmark, tracks the amount of dmg dealt
/datum/action/ability/xeno_action/deathmark/proc/on_attack(datum/source, mob/living/attacked, damage)
	if(!ishuman(attacked) || attacked.stat == DEAD)
		return
	damage_dealt += damage
	if(COOLDOWN_CHECK(src, message_cooldown))
		var/percent_dealt = round((damage_dealt/DEATHMARK_DAMAGE_OR_DIE)*100)
		owner.balloon_alert(owner, "[percent_dealt]%")
		COOLDOWN_START(src, message_cooldown, DEATHMARK_MESSAGE_COOLDOWN)

/// on expire after the timer, execute the owner if they gambled bad
/datum/action/ability/xeno_action/deathmark/proc/on_deathmark_expire()
	var/mob/living/carbon/xenomorph/xeno = owner
	UnregisterSignal(owner, COMSIG_XENOMORPH_ATTACK_LIVING)
	xeno.remove_movespeed_modifier(MOVESPEED_ID_RAVAGER_DEATHMARK)
	if(damage_dealt < DEATHMARK_DAMAGE_OR_DIE)
		to_chat(owner, span_highdanger("THE QUEEN MOTHER IS DISPLEASED WITH YOUR PERFORMANCE ([damage_dealt]/[DEATHMARK_DAMAGE_OR_DIE]). DEATH COMES TO TAKE ITS DUE."))
		xeno.take_overall_damage(999)
		var/turf/balloonloc = get_turf(xeno)
		balloonloc.balloon_alert_to_viewers("JUDGEMENT")
		return
	xeno.playsound_local(xeno, 'sound/voice/alien/hiss5.ogg', 50)
	to_chat(owner, span_highdanger("THE QUEEN MOTHER IS PLEASED WITH YOUR PERFORMANCE ([damage_dealt]/[DEATHMARK_DAMAGE_OR_DIE])."))
	owner.balloon_alert(owner, "deathmark expired")
