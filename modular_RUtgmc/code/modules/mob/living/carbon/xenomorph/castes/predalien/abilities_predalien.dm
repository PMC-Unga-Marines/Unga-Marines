// ***************************************
// *********** Pouncey
// ***************************************
/datum/action/ability/activable/xeno/pounce/predalien
	name = "Leap"
	desc = "Leap at your targer stunning and slashing them. Stun duration and damage increases with each stack of hunted prey."
	action_icon_state = "powerful_pounce"

	pounce_range = 5

	var/base_damage = 25
	var/damage_scale = 10 // How much it scales by every kill

/datum/action/ability/activable/xeno/pounce/predalien/mob_hit(datum/source, mob/living/M)
	. = ..()
	var/mob/living/carbon/xenomorph/predalien/xeno = owner
	if(ishuman(target) || isdroid(target))
		M.apply_damage(base_damage + damage_scale * min(xeno.life_kills_total, xeno.max_bonus_life_kills), BRUTE, "chest", MELEE, FALSE, FALSE, TRUE, 20)

///Triggers the effect of a successful pounce on the target.
/datum/action/ability/activable/xeno/pounce/predalien/trigger_pounce_effect(mob/living/living_target)
	playsound(get_turf(living_target), 'sound/voice/predalien_pounce.ogg', 25, TRUE)
	var/mob/living/carbon/xenomorph/xeno_owner = owner
	xeno_owner.set_throwing(FALSE)
	xeno_owner.Immobilize(XENO_POUNCE_STANDBY_DURATION)
	xeno_owner.forceMove(get_turf(living_target))
	living_target.Knockdown(XENO_POUNCE_STUN_DURATION)

// ***************************************
// *********** Roar
// ***************************************

/datum/action/ability/activable/xeno/predalien_roar
	name = "Roar"
	desc = "Buffs nearby xenomorphs with increased slash damage and movement speed, additionally removes invisibility from any prey nearby. Buff strength and duration increases with each stack of hunted prey."
	action_icon_state = "rage_screech"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_ROAR,
	)
	cooldown_duration = 25 SECONDS
	ability_cost = 50

	var/predalien_roar = list("sound/voice/predalien_roar.ogg")
	var/bonus_damage_scale = 2.5
	var/bonus_speed_scale = 0.05

/datum/action/ability/activable/xeno/predalien_roar/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/predalien/xeno = owner

	playsound(xeno.loc, pick(predalien_roar), 75, 0)
	xeno.visible_message(span_xenohighdanger("[xeno] emits a guttural roar!"))
	xeno.create_shriekwave(color = "#FF0000")

	for(var/mob/living/carbon/carbon in view(7, xeno))
		if(ishuman(carbon) || isdroid(carbon))
			var/mob/living/carbon/human/human = carbon
			human.disable_special_items()

			var/obj/item/clothing/gloves/yautja/hunter/YG = locate(/obj/item/clothing/gloves/yautja/hunter) in human
			if(isyautja(human) && YG)
				if(YG.cloaked)
					YG.decloak(human)

				YG.cloak_timer = cooldown_duration * 0.1
		else if(isxeno(carbon))
			var/mob/living/carbon/xenomorph/xeno_target = carbon
			if(xeno_target.stat == DEAD)
				continue
			new /datum/status_effect/xeno_buff(list(xeno_target, xeno, 0.25 SECONDS * min(xeno.life_kills_total, xeno.max_bonus_life_kills) + 3 SECONDS, bonus_damage_scale * min(xeno.life_kills_total, xeno.max_bonus_life_kills), (bonus_speed_scale * min(xeno.life_kills_total, xeno.max_bonus_life_kills))))

	for(var/mob/M in view(xeno))
		if(M && M.client)
			shake_camera(M, 10, 1)

	add_cooldown()
	succeed_activate()

// ***************************************
// *********** Smash
// ***************************************

/datum/action/ability/activable/xeno/smash
	name = "Smash"
	desc = "Stun a prey in front of you and paralyzes any prey around the target. Paralyze duration increases with each stack of hunted prey."
	action_icon_state = "super_stomp"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_SMASH,
	)
	cooldown_duration = 20 SECONDS
	ability_cost = 80

	var/freeze_duration = 1.5 SECONDS
	var/smash_sounds = list('sound/effects/alien_footstep_charge1.ogg', 'sound/effects/alien_footstep_charge2.ogg', 'sound/effects/alien_footstep_charge3.ogg')

/datum/action/ability/activable/xeno/smash/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return

	if(!ishuman(target) && !isdroid(target))
		to_chat(owner, span_xenowarning("You must target a hostile!"))
		return FALSE

	if(get_dist(target, owner) > 1)
		to_chat(owner, span_xenowarning("[target] is too far away!"))
		return FALSE

	var/mob/living/carbon/carbon = target
	if(carbon.stat == DEAD)
		to_chat(owner, span_xenowarning("[carbon] is dead, why would you want to touch them?"))
		return FALSE

	return TRUE

/datum/action/ability/activable/xeno/smash/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/predalien/xeno = owner

	playsound(xeno.loc, pick(smash_sounds), 50, 0)
	xeno.visible_message(span_xenohighdanger("[xeno] smashes into the ground!"))

	xeno.create_stomp()

	var/mob/living/carbon/carbon = target
	carbon.Immobilize(freeze_duration)
	carbon.apply_effect(0.5, WEAKEN)

	for(var/mob/living/carbon/human/human in oview(round(min(xeno.life_kills_total, xeno.max_bonus_life_kills) * 0.5 + 2), xeno))
		if(human.stat != DEAD)
			human.Immobilize(freeze_duration)

	for(var/mob/M in view(xeno))
		if(M && M.client)
			shake_camera(M, 0.2 SECONDS, 1)

	add_cooldown()
	succeed_activate()

// ***************************************
// *********** Devastate
// ***************************************

/datum/action/ability/activable/xeno/devastate
	name = "Devastate"
	desc = "Pull out the guts and viscera of your prey dealing brutal damage. Damage increases with each stack of hunted prey."
	action_icon_state = "butchering"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_DEVASTATE,
	)
	cooldown_duration = 20 SECONDS
	ability_cost = 110

	var/activation_delay = 1 SECONDS

	var/base_damage = 25
	var/damage_scale = 10 // How much it scales by every kill

/datum/action/ability/activable/xeno/devastate/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return

	if(!ishuman(target) && !isdroid(target))
		to_chat(owner, span_xenowarning("You must target a hostile!"))
		return FALSE

	if(get_dist(target, owner) > 1)
		to_chat(owner, span_xenowarning("[target] is too far away!"))
		return FALSE

	var/mob/living/carbon/carbon = target
	if(carbon.stat == DEAD)
		to_chat(owner, span_xenowarning("[carbon] is dead, why would you want to touch them?"))
		return FALSE

	return TRUE

/datum/action/ability/activable/xeno/devastate/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/predalien/xeno = owner
	var/mob/living/carbon/carbon = target

	carbon.Immobilize(30 SECONDS)
	xeno.anchored = TRUE
	xeno.Immobilize(30 SECONDS)

	if(do_after(xeno, activation_delay, NONE, carbon, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE))
		xeno.visible_message(span_xenohighdanger("[xeno] rips open the guts of [carbon]!"), span_xenohighdanger("You rip open the guts of [carbon]!"))
		carbon.spawn_gibs()
		playsound(get_turf(carbon), 'modular_RUtgmc/sound/effects/gibbed.ogg', 75, 1)
		carbon.apply_effect(0.5, WEAKEN)
		carbon.apply_damage(base_damage + damage_scale * min(xeno.life_kills_total, xeno.max_bonus_life_kills), BRUTE, "chest", MELEE, FALSE, FALSE, TRUE, 20)

		xeno.do_attack_animation(carbon, ATTACK_EFFECT_CLAW)
		spawn()
			for(var/x in 1 to 4)
				sleep(1)
				xeno.setDir(turn(xeno.dir, 90))
		xeno.do_attack_animation(carbon, ATTACK_EFFECT_BITE)

	playsound(xeno, 'modular_RUtgmc/sound/voice/predalien_growl.ogg', 75, 0)

	xeno.anchored = FALSE
	xeno.SetImmobilized(0)

	carbon.SetImmobilized(0)

	xeno.visible_message(span_xenodanger("[xeno] rapidly slices into [carbon]!"))

	add_cooldown()
	succeed_activate()
