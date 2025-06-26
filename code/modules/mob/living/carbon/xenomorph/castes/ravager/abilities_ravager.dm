// ***************************************
// *********** Charge
// ***************************************
/datum/action/ability/activable/xeno/charge
	name = "Eviscerating Charge"
	desc = "Charge up to 4 tiles and viciously attack your target."
	action_icon_state = "pounce"
	action_icon = 'icons/Xeno/actions/runner.dmi'
	cooldown_duration = 20 SECONDS
	ability_cost = 250 //Can't ignore pain/Charge and ravage in the same timeframe, but you can combo one of them. //RU TGMC EDIT
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_RAVAGER_CHARGE,
	)
	///charge distance
	var/charge_range = RAV_CHARGEDISTANCE

/datum/action/ability/activable/xeno/charge/use_ability(atom/A)
	if(!A)
		return
	RegisterSignal(xeno_owner, COMSIG_XENO_OBJ_THROW_HIT, PROC_REF(obj_hit))
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_POST_THROW, PROC_REF(charge_complete))
	RegisterSignal(xeno_owner, COMSIG_XENOMORPH_LEAP_BUMP, PROC_REF(mob_hit))

	xeno_owner.visible_message(span_danger("[xeno_owner] charges towards \the [A]!"), \
	span_danger("We charge towards \the [A]!") )
	xeno_owner.emote("roar")
	xeno_owner.xeno_flags |= XENO_LEAPING //This has to come before throw_at, which checks impact. So we don't do end-charge specials when thrown
	succeed_activate()

	xeno_owner.throw_at(A, charge_range, RAV_CHARGESPEED, xeno_owner)

	add_cooldown()

/datum/action/ability/activable/xeno/charge/on_cooldown_finish()
	to_chat(owner, span_xenodanger("Our exoskeleton quivers as we get ready to use [name] again."))
	playsound(owner, 'sound/effects/alien/newlarva.ogg', 50, 0, 1)
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

	living_target.attack_alien_harm(xeno_owner, xeno_owner.xeno_caste.melee_damage * xeno_owner.xeno_melee_damage_modifier * 0.25, FALSE, TRUE, FALSE, TRUE, INTENT_HARM) //Location is always random, cannot crit, harm only
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
	xeno_owner.xeno_flags &= ~XENO_LEAPING

// ***************************************
// *********** Ravage
// ***************************************
/datum/action/ability/activable/xeno/ravage
	name = "Ravage"
	desc = "Attacks and knockbacks enemies in the direction your facing."
	action_icon_state = "ravage"
	action_icon = 'icons/Xeno/actions/ravager.dmi'
	ability_cost = 200
	cooldown_duration = 6 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY | ABILITY_IGNORE_SELECTED_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_RAVAGE,
		KEYBINDING_ALTERNATE = COMSIG_XENOABILITY_RAVAGE_SELECT,
	)
	/// Used for particles. Holds the particles instead of the mob. See particle_holder for documentation.
	var/obj/effect/abstract/particle_holder/particle_holder

/datum/action/ability/activable/xeno/ravage/on_cooldown_finish()
	to_chat(owner, span_xenodanger("We gather enough strength to Ravage again."))
	playsound(owner, 'sound/effects/alien/newlarva.ogg', 50, 0, 1)
	return ..()

/datum/action/ability/activable/xeno/ravage/use_ability(atom/A)
	xeno_owner.emote("roar")
	xeno_owner.visible_message(span_danger("\The [xeno_owner] thrashes about in a murderous frenzy!"), \
	span_xenowarning("We thrash about in a murderous frenzy!"))

	xeno_owner.face_atom(A)
	activate_particles(xeno_owner.dir)

	var/list/atom/movable/atoms_to_ravage = get_step(owner, owner.dir).contents.Copy()
	atoms_to_ravage += get_step(owner, turn(owner.dir, -45)).contents
	atoms_to_ravage += get_step(owner, turn(owner.dir, 45)).contents
	for(var/atom/movable/ravaged AS in atoms_to_ravage)
		if(ishitbox(ravaged) || isvehicle(ravaged))
			ravaged.attack_alien(xeno_owner, xeno_owner.xeno_caste.melee_damage) //Handles APC/Tank stuff. Has to be before the !ishuman check or else ravage does work properly on vehicles.
			continue
		if(!(ravaged.resistance_flags & XENO_DAMAGEABLE) || !xeno_owner.Adjacent(ravaged))
			continue
		if(!ishuman(ravaged))
			ravaged.attack_alien(xeno_owner, xeno_owner.xeno_caste.melee_damage)
			ravaged.knockback(xeno_owner, RAV_RAVAGE_THROW_RANGE, RAV_CHARGESPEED)
			continue
		var/mob/living/carbon/human/human_victim = ravaged
		if(human_victim.stat == DEAD)
			continue
		human_victim.attack_alien_harm(xeno_owner, xeno_owner.xeno_caste.melee_damage * xeno_owner.xeno_melee_damage_modifier * 0.25, FALSE, TRUE, FALSE, TRUE)
		human_victim.knockback(xeno_owner, RAV_RAVAGE_THROW_RANGE, RAV_CHARGESPEED)
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
	desc = "For the next few moments you will not go into crit and become resistant to explosives and immune to stagger and slowdown, but you still die if you take damage exceeding your crit health."
	action_icon_state = "ignore_pain"
	action_icon = 'icons/Xeno/actions/ravager.dmi'
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

/datum/action/ability/xeno_action/endure/on_cooldown_finish()
	to_chat(owner, span_xenodanger("We feel able to imbue ourselves with plasma to Endure once again!"))
	owner.playsound_local(owner, 'sound/effects/alien/newlarva.ogg', 25, 0, 1)
	return ..()

/datum/action/ability/xeno_action/endure/action_activate()
	xeno_owner.emote("roar")
	xeno_owner.visible_message(span_danger("[xeno_owner]'s skin begins to glow!"), \
	span_xenowarning("We feel the plasma coursing through our veins!"))

	xeno_owner.endure = TRUE

	xeno_owner.add_filter("ravager_endure_outline", 4, outline_filter(1, COLOR_PURPLE)) //Set our cool aura; also confirmation we have the buff

	endure_duration = addtimer(CALLBACK(src, PROC_REF(endure_warning)), RAVAGER_ENDURE_DURATION * RAVAGER_ENDURE_DURATION_WARNING, TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE) //Warn the ravager when the duration is about to expire.
	endure_warning_duration = addtimer(CALLBACK(src, PROC_REF(endure_deactivate)), RAVAGER_ENDURE_DURATION, TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE)

	xeno_owner.set_stagger(0) //Remove stagger
	xeno_owner.set_slowdown(0) //Remove slowdown
	xeno_owner.soft_armor = xeno_owner.soft_armor.modifyRating(bomb = 20) //Improved explosion resistance
	ADD_TRAIT(xeno_owner, TRAIT_STAGGERIMMUNE, ENDURE_TRAIT) //Can now endure impacts/damages that would make lesser xenos flinch
	ADD_TRAIT(xeno_owner, TRAIT_SLOWDOWNIMMUNE, ENDURE_TRAIT) //Can now endure slowdown

	RegisterSignal(xeno_owner, COMSIG_XENOMORPH_BRUTE_DAMAGE, PROC_REF(damage_taken)) //Warns us if our health is critically low
	RegisterSignal(xeno_owner, COMSIG_XENOMORPH_BURN_DAMAGE, PROC_REF(damage_taken))

	succeed_activate()
	add_cooldown()

	GLOB.round_statistics.ravager_endures++ //Statistics
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "ravager_endures")

///Warns the player when Endure is about to end
/datum/action/ability/xeno_action/endure/proc/endure_warning()
	if(QDELETED(owner))
		return
	to_chat(owner,span_userdanger("We feel the plasma draining from our veins... [initial(name)] will last for only [timeleft(endure_duration) * 0.1] more seconds!"))
	owner.playsound_local(owner, 'sound/voice/alien/hiss8.ogg', 50, 0, 1)

///Turns off the Endure buff
/datum/action/ability/xeno_action/endure/proc/endure_deactivate()
	if(QDELETED(owner))
		return
	UnregisterSignal(xeno_owner, COMSIG_XENOMORPH_BRUTE_DAMAGE)
	UnregisterSignal(xeno_owner, COMSIG_XENOMORPH_BURN_DAMAGE)

	xeno_owner.do_jitter_animation(1000)
	xeno_owner.endure = FALSE
	xeno_owner.clear_fullscreen("endure", 0.7 SECONDS)
	xeno_owner.remove_filter("ravager_endure_outline")
	if(xeno_owner.health < xeno_owner.get_crit_threshold()) //If we have less health than our death threshold, but more than our Endure death threshold, set our HP to just a hair above insta dying
		var/total_damage = xeno_owner.get_fire_loss() + xeno_owner.get_brute_loss()
		var/burn_percentile_damage = xeno_owner.get_fire_loss() / total_damage
		var/brute_percentile_damage = xeno_owner.get_brute_loss() / total_damage
		xeno_owner.set_brute_loss((xeno_owner.xeno_caste.max_health - xeno_owner.get_crit_threshold() - 1) * brute_percentile_damage)
		xeno_owner.set_fire_loss((xeno_owner.xeno_caste.max_health - xeno_owner.get_crit_threshold() - 1) * burn_percentile_damage)

	xeno_owner.do_jitter_animation(1000)
	xeno_owner.endure = FALSE
	xeno_owner.clear_fullscreen("endure", 0.7 SECONDS)
	xeno_owner.remove_filter("ravager_endure_outline")
	if(xeno_owner.health < xeno_owner.get_crit_threshold()) //If we have less health than our death threshold, but more than our Endure death threshold, set our HP to just a hair above insta dying
		var/total_damage = xeno_owner.get_fire_loss() + xeno_owner.get_brute_loss()
		var/burn_percentile_damage = xeno_owner.get_fire_loss() / total_damage
		var/brute_percentile_damage = xeno_owner.get_brute_loss() / total_damage
		xeno_owner.set_brute_loss((xeno_owner.xeno_caste.max_health - xeno_owner.get_crit_threshold()-1) * brute_percentile_damage)
		xeno_owner.set_fire_loss((xeno_owner.xeno_caste.max_health - xeno_owner.get_crit_threshold()-1) * burn_percentile_damage)

	xeno_owner.soft_armor = xeno_owner.soft_armor.modifyRating(bomb = -20) //Remove resistances/immunities
	REMOVE_TRAIT(xeno_owner, TRAIT_STAGGERIMMUNE, ENDURE_TRAIT)
	REMOVE_TRAIT(xeno_owner, TRAIT_SLOWDOWNIMMUNE, ENDURE_TRAIT)
	endure_threshold = initial(endure_threshold) //Reset the endure vars to their initial states
	endure_duration = initial(endure_duration)
	endure_warning_duration = initial(endure_warning_duration)

	to_chat(owner,span_userdanger("The last of the plasma drains from our body... We can no longer endure beyond our normal limits!"))
	owner.playsound_local(owner, 'sound/voice/alien/hiss8.ogg', 50, 0, 1)

///Warns us when our health is critically low and tells us exactly how much more punishment we can take
/datum/action/ability/xeno_action/endure/proc/damage_taken(mob/living/carbon/xenomorph/xeno_owner, damage_taken)
	SIGNAL_HANDLER
	if(xeno_owner.health < 0)
		to_chat(xeno_owner, "<span class='xenouserdanger' style='color: red;'>We are critically wounded! We can only withstand [(RAVAGER_ENDURE_HP_LIMIT-xeno_owner.health) * -1] more damage before we perish!</span>")
		xeno_owner.overlay_fullscreen("endure", /atom/movable/screen/fullscreen/animated/bloodlust)
	else
		xeno_owner.clear_fullscreen("endure", 0.7 SECONDS)

/datum/action/ability/xeno_action/endure/ai_should_start_consider()
	return TRUE

/datum/action/ability/xeno_action/endure/ai_should_use(target)
	if(!iscarbon(target))
		return FALSE
	if(get_dist(target, owner) > WORLD_VIEW_NUM) // If we can be seen.
		return FALSE
	if(xeno_owner.health > 50)
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
	desc = "Toggle on to enable boosting on "
	action_icon_state = "neuroclaws_off"
	action_icon = 'icons/Xeno/actions/sentinel.dmi'
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
	action_icon_state = xeno_owner.vampirism ? "neuroclaws_on" : "neuroclaws_off"
	return ..()

/datum/action/ability/xeno_action/vampirism/give_action(mob/living/L)
	. = ..()
	xeno_owner.vampirism = TRUE
	RegisterSignal(L, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(on_slash))

/datum/action/ability/xeno_action/vampirism/remove_action(mob/living/L)
	xeno_owner.vampirism = FALSE
	UnregisterSignal(L, COMSIG_XENOMORPH_ATTACK_LIVING)
	return ..()

/datum/action/ability/xeno_action/vampirism/action_activate()
	. = ..()
	xeno_owner.vampirism = !xeno_owner.vampirism
	if(xeno_owner.vampirism)
		RegisterSignal(xeno_owner, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(on_slash))
	else
		UnregisterSignal(xeno_owner, COMSIG_XENOMORPH_ATTACK_LIVING)
	to_chat(xeno_owner, span_xenonotice("You will now[xeno_owner.vampirism ? "" : " no longer"] heal from attacking"))
	update_button_icon()

///Adds the slashed mob to tracked damage mobs
/datum/action/ability/xeno_action/vampirism/proc/on_slash(datum/source, mob/living/target, damage, list/damage_mod, list/armor_mod)
	SIGNAL_HANDLER
	if(target.stat == DEAD)
		return
	if(!ishuman(target)) // no farming on animals/dead
		return
	if(timeleft(timer_ref) > 0)
		return
	var/mob/living/carbon/human/human_target = target
	human_target.blood_volume -= 5 // something about 1%
	xeno_owner.adjust_brute_loss(-xeno_owner.bruteloss * 0.125)
	xeno_owner.adjust_fire_loss(-xeno_owner.fireloss * 0.125)
	update_button_icon()
	particle_holder = new(xeno_owner, /particles/xeno_slash/vampirism)
	particle_holder.pixel_y = 18
	particle_holder.pixel_x = 18
	timer_ref = QDEL_NULL_IN(src, particle_holder, heal_delay)

// ***************************************
// *********** Immortality
// ***************************************
/datum/action/ability/xeno_action/immortality
	name = "Immortality"
	desc = "We are too angry to die."
	action_icon_state = "enhancement"
	action_icon = 'icons/Xeno/actions/drone.dmi'
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
	xeno_owner.emote("roar")
	xeno_owner.visible_message(span_danger("[xeno_owner]'s skin begins to glow!"), \
	span_xenowarning("We are too angry to die!"))

	xeno_owner.add_filter("ravager_immortality_outline", 4, outline_filter(0.5, COLOR_TRANSPARENT_SHADOW))

	ENABLE_BITFIELD(xeno_owner.status_flags, GODMODE)

	addtimer(CALLBACK(src, PROC_REF(immortality_deactivate)), RAVAGER_IMMORTALITY_DURATION, TIMER_UNIQUE|TIMER_STOPPABLE|TIMER_OVERRIDE)

	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/immortality/proc/immortality_deactivate()
	if(QDELETED(owner))
		return

	DISABLE_BITFIELD(xeno_owner.status_flags, GODMODE)

	xeno_owner.do_jitter_animation(500)

	xeno_owner.remove_filter("ravager_immortality_outline")

	to_chat(owner,span_userdanger("We are now mortal again."))
	owner.playsound_local(owner, 'sound/voice/alien/hiss8.ogg', 50, 0, 1)
