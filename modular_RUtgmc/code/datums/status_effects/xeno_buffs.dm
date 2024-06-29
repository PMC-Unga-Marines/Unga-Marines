
// ***************************************
// *********** Feast
// ***************************************

/datum/status_effect/xeno_feast/tick()
	. = ..()
	var/mob/living/carbon/xenomorph/X = owner
	if(!X)
		return
	var/heal_amount = X.maxHealth*0.08
	for(var/mob/living/carbon/xenomorph/target_xeno AS in cheap_get_xenos_near(X, 4))
		if(target_xeno == X)
			continue
		if(target_xeno.faction != X.faction)
			continue
		HEAL_XENO_DAMAGE(target_xeno, heal_amount, FALSE)
		adjustOverheal(target_xeno, heal_amount / 2)
		new /obj/effect/temp_visual/healing(get_turf(target_xeno))

/datum/status_effect/frenzy_screech
	id = "frenzy_screech"
	status_type = STATUS_EFFECT_REFRESH
	var/mob/living/carbon/xenomorph/buff_owner
	var/modifier

/datum/status_effect/frenzy_screech/on_creation(mob/living/new_owner, set_duration, damage_modifier)
	duration = set_duration
	owner = new_owner
	modifier = damage_modifier
	return ..()

/datum/status_effect/frenzy_screech/on_apply()
	if(!isxeno(owner))
		return FALSE
	buff_owner = owner
	buff_owner.xeno_melee_damage_modifier += modifier
	owner.add_filter("frenzy_screech_outline", 3, outline_filter(1, COLOR_VIVID_RED))
	return TRUE

/datum/status_effect/frenzy_screech/on_remove()
	buff_owner.xeno_melee_damage_modifier -= modifier
	owner.remove_filter("frenzy_screech_outline")
	return ..()

// ***************************************
// *********** Buff
// ***************************************
/atom/movable/screen/alert/status_effect/xeno_buff
	name = "Empowered"
	desc = "Your damage ands speed boosted for short time period."

/datum/status_effect/xeno_buff
	id = "buff"
	duration = -1
	status_type = STATUS_EFFECT_MULTIPLE
	alert_type = /atom/movable/screen/alert/status_effect/xeno_buff

	var/bonus_damage = 0
	var/bonus_speed = 0

/datum/status_effect/xeno_buff/on_creation(atom/A, mob/from = null, ttl = 35, bonus_damage = 0, bonus_speed = 0)
	if(!isxeno(A))
		qdel(src)
		return

	. = ..()

	to_chat(A, span_xenonotice("You feel empowered"))

	var/mob/living/carbon/xenomorph/X = A
	X.melee_damage += bonus_damage

	X.xeno_caste.speed -= bonus_speed

	src.bonus_damage = bonus_damage
	src.bonus_speed = bonus_speed


	X.add_filter("overbonus_vis", 1, outline_filter(4 * (bonus_damage / 50), "#cf0b0b60")); \

	addtimer(CALLBACK(src, PROC_REF(end_bonuses)), ttl)

/datum/status_effect/xeno_buff/proc/end_bonuses()
	if(owner)
		to_chat(owner, span_xenonotice("You no longer feel empowered"))
		var/mob/living/carbon/xenomorph/X = owner
		X.melee_damage -= bonus_damage

		X.xeno_caste.speed += bonus_speed

		X.remove_filter("overbonus_vis");

	qdel(src)
