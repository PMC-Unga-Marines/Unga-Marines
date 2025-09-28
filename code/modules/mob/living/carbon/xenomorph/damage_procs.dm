/mob/living/carbon/xenomorph/fire_act(burn_level, flame_color)
	if(status_flags & GODMODE)
		return
	if(xeno_caste.caste_flags & CASTE_FIRE_IMMUNE)
		return
	return ..()

/mob/living/carbon/xenomorph/modify_by_armor(damage_amount, armor_type, penetration, def_zone, attack_dir)
	var/hard_armor_remaining = get_hard_armor(armor_type, def_zone)

	var/effective_penetration = max(0, penetration - hard_armor_remaining)
	hard_armor_remaining -= (penetration - effective_penetration)

	if(penetration < 0) //hollow-point
		effective_penetration = penetration

	var/sunder_ratio = clamp(1 - ((sunder - hard_armor_remaining) * 0.01), 0, 1) //sunder is reduced by whatever remaining hardarmour there is

	return clamp(damage_amount * (1 - ((get_soft_armor(armor_type, def_zone) * sunder_ratio - effective_penetration) * 0.01)), 0, damage_amount)

/mob/living/carbon/xenomorph/ex_act(severity, direction)
	if(severity <= 0)
		return

	if(status_flags & (INCORPOREAL|GODMODE))
		return

	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_MOB_EX_ACT))
		return

	if(lying_angle)
		severity *= EXPLOSION_PRONE_MULTIPLIER

	if(severity >= max(health, EXPLOSION_THRESHOLD_GIB + get_soft_armor(BOMB) * 2))
		var/oldloc = loc
		gib()
		if(mob_size > MOB_SIZE_SMALL) // cause the size of 0 will cause errors
			create_shrapnel(oldloc, rand(4, 8) * mob_size, direction, shrapnel_type = /datum/ammo/bullet/shrapnel/light/xeno)
		return

	var/sunder_amount = severity * 0.125
	adjust_sunder(sunder_amount)

	apply_damages(severity * 0.5, severity * 0.5, blocked = BOMB, updating_health = TRUE)

	var/modified_severity = modify_by_armor(severity, BOMB)
	INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, explosion_throw), modified_severity, direction)

	var/powerfactor_value = modified_severity * 0.01
	if(mob_size < MOB_SIZE_BIG)
		adjust_stagger(powerfactor_value SECONDS * 0.5)
	adjust_slowdown(powerfactor_value)

	TIMER_COOLDOWN_START(src, COOLDOWN_MOB_EX_ACT, 0.1 SECONDS) // this is to prevent x2 damage from mob getting thrown into the explosions wave

/mob/living/carbon/xenomorph/apply_damage(damage = 0, damagetype = BRUTE, def_zone, blocked = 0, sharp = FALSE, edge = FALSE, updating_health = FALSE, penetration)
	if(status_flags & GODMODE)
		return
	if(damagetype != BRUTE && damagetype != BURN)
		return
	if(isnum(blocked))
		damage -= clamp(damage * (blocked - penetration) * 0.01, 0, damage)
	else
		damage = modify_by_armor(damage, blocked, penetration, def_zone)

	// WARDING PHEROMONES EFFECT
	if(warding_aura)
		damage *= (1 - warding_aura * 0.025) // %damage decrease per level. Max base level is 6 (king)

	if(!damage) //no damage
		return FALSE

	if(damage > 12) //Light damage won't splash.
		check_blood_splash(damage, damagetype, 0, sharp, edge)

	SEND_SIGNAL(src, COMSIG_XENOMORPH_TAKING_DAMAGE, damage)

	if(stat == DEAD)
		return FALSE

	switch(damagetype)
		if(BRUTE)
			adjust_brute_loss(damage)
		if(BURN)
			adjust_fire_loss(damage)

	last_damage_source = usr

	if(updating_health)
		update_health()

	regen_power = -xeno_caste.regen_delay //Remember, this is in deciseconds.

	if(isobj(pulling))
		stop_pulling()

	return damage

/// Handles overheal for xeno receiving damage
/mob/living/carbon/xenomorph/proc/handle_overheal(amount)
	if(overheal && amount > 0)
		var/reduction = min(amount, overheal)
		amount -= reduction
		adjust_overheal(-reduction)

/// Adjusts overheal and returns the amount by which it was adjusted
/mob/living/carbon/xenomorph/proc/adjust_overheal(amount)
	overheal = max(min(overheal + amount, xeno_caste.overheal_max), 0)
	if(overheal > 0)
		add_filter("overheal_vis", 1, outline_filter(4 * (overheal / xeno_caste.overheal_max), "#60ce6f60"))
	else
		remove_filter("overheal_vis")

/// Heals a xeno, respecting different types of damage
/mob/living/carbon/xenomorph/proc/heal_xeno_damage(amount, passive)
	var/fire_loss = get_fire_loss()
	if(fire_loss)
		var/fire_heal = min(fire_loss, amount)
		amount -= fire_heal
		adjust_fire_loss(-fire_heal, TRUE, passive)
	var/brute_loss = get_brute_loss()
	if(brute_loss)
		var/brute_heal = min(brute_loss, amount)
		amount -= brute_heal
		adjust_brute_loss(-brute_heal, TRUE, passive)

/mob/living/carbon/xenomorph/adjust_brute_loss(amount, updating_health = FALSE, passive = FALSE)
	var/list/amount_mod = list()
	SEND_SIGNAL(src, COMSIG_XENOMORPH_BRUTE_DAMAGE, amount, amount_mod, passive)
	for(var/i in amount_mod)
		amount -= i

	handle_overheal(amount)

	bruteloss = max(bruteloss + amount, 0)

	if(updating_health)
		update_health()

/mob/living/carbon/xenomorph/adjust_fire_loss(amount, updating_health = FALSE, passive = FALSE)
	var/list/amount_mod = list()
	SEND_SIGNAL(src, COMSIG_XENOMORPH_BURN_DAMAGE, amount, amount_mod, passive)
	for(var/i in amount_mod)
		amount -= i

	handle_overheal(amount)

	fireloss = max(fireloss + amount, 0)

	if(updating_health)
		update_health()

///Splashes living mob in 1 tile radius with acid, spawns
/mob/living/carbon/xenomorph/proc/check_blood_splash(damage = 0, damtype = BRUTE, chancemod = 0, sharp = FALSE, edge = FALSE)
	if(!damage)
		return FALSE

	if(damtype == BURN) //no splash from burn wounds
		return FALSE

	if(!(xeno_caste.caste_flags & CASTE_ACID_BLOOD))
		return FALSE

	if(!isturf(loc))
		return FALSE

	var/chance = 25 //base chance
	if(sharp)
		chancemod += 10
	if(edge) //Pierce weapons give the most bonus
		chancemod += 15
	if(stat == DEAD) // pressure in dead body is lower than usual
		chancemod *= 0.5
	chance += chancemod + (damage * 0.33)
	if(!prob(chance))
		return FALSE

	var/obj/effect/decal/cleanable/blood/xeno/decal = locate(/obj/effect/decal/cleanable/blood/xeno) in loc
	if(!decal) //Let's not stack blood, it just makes lags.
		add_splatter_floor(loc) //Drop some on the ground first.
	else if(decal.random_icon_states) //If there's already one, just randomize it so it changes.
		decal.icon_state = pick(decal.random_icon_states)

	for(var/mob/living/carbon/human/victim in range(1, src)) //Loop through all nearby victims, including the tile.
		if(!Adjacent(victim))
			continue

		if(!prob((chance * 2) - 20))
			continue
		victim.visible_message(span_danger("\The [victim] is scalded with hissing green blood!"), \
		span_danger("You are splattered with sizzling blood! IT BURNS!"))
		if(victim.stat == CONSCIOUS && !(victim.species.species_flags & NO_PAIN))
			victim.emote("scream")
		victim.take_overall_damage(rand(5, 15), BURN, ACID, updating_health = TRUE)
