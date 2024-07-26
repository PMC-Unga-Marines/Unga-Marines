/mob/living/carbon/human/blind_eyes(amount, forced = FALSE)
	if(isspeciessynthetic(src))
		return
	if(!forced)
		if(has_vision() && !has_eyes() && stat == CONSCIOUS)
			set_blindness(0, TRUE)
	return ..()

/mob/living/carbon/human/adjust_blindness(amount, forced = FALSE)
	if(isspeciessynthetic(src))
		return
	if(!forced)
		if(has_vision() && !has_eyes() && stat == CONSCIOUS)
			set_blindness(0, TRUE)
	return ..()

/mob/living/carbon/human/set_blindness(amount, forced = FALSE)
	if(isspeciessynthetic(src))
		return
	if(!forced)
		if(has_vision() && !has_eyes() && stat == CONSCIOUS)
			return
	return ..()

/mob/living/carbon/human/blur_eyes(amount, forced = FALSE)
	if(isspeciessynthetic(src))
		return
	if(!forced)
		if(has_vision() && !has_eyes() && stat == CONSCIOUS)
			set_blurriness(0, TRUE)
	return ..()

/mob/living/carbon/human/adjust_blurriness(amount, forced = FALSE)
	if(isspeciessynthetic(src))
		return
	if(!forced)
		if(has_vision() && !has_eyes() && stat == CONSCIOUS)
			set_blurriness(0, TRUE)
	return ..()

/mob/living/carbon/human/set_blurriness(amount, forced = FALSE)
	if(isspeciessynthetic(src))
		return
	if(!forced)
		if(has_vision() && !has_eyes() && stat == CONSCIOUS)
			return
	return ..()

/mob/living/carbon/human/Losebreath(amount, forced = FALSE)
	if(!(species.species_flags & NO_BREATHE) || forced)
		return ..()

/mob/living/carbon/human/adjust_Losebreath(amount, forced = FALSE)
	if(!(species.species_flags & NO_BREATHE) || forced)
		return ..()

/mob/living/carbon/human/set_Losebreath(amount, forced = FALSE)
	if(!(species.species_flags & NO_BREATHE) || forced)
		return ..()

/mob/living/carbon/human/proc/vomit()
	if(isspeciessynthetic(src))
		return //Machines don't throw up.

	if(stat == DEAD) //Corpses don't puke
		return

	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_PUKE))
		return

	TIMER_COOLDOWN_START(src, COOLDOWN_PUKE, 40 SECONDS) //5 seconds before the actual action plus 35 before the next one.
	to_chat(src, span_warning("You feel like you are about to throw up!"))
	addtimer(CALLBACK(src, PROC_REF(do_vomit)), 5 SECONDS)

/mob/living/carbon/human/proc/do_vomit()
	adjust_stagger(3 SECONDS)
	add_slowdown(3)

	visible_message(span_warning("[src] throws up!"), span_warning("You throw up!"), null, 5)
	playsound(loc, 'sound/effects/splat.ogg', 25, TRUE, 7)

	var/turf/location = loc
	if(istype(location, /turf))
		location.add_vomit_floor(src, 1)

	adjust_nutrition(-40)
	adjustToxLoss(-3)

/**
 * Expel the reagents you just tried to ingest
 *
 * When you try to ingest reagents but you do not have a stomach
 * you will spew the reagents on the floor.
 *
 * Vars:
 * * bite: /atom the reagents to expel
 * * amount: int The amount of reagent
 */
/mob/living/carbon/proc/expel_ingested(atom/bite, amount)
	visible_message(span_danger("[src] throws up all over [p_them()]self!"), span_userdanger("You are unable to keep the [bite] down without a stomach!"))

	var/obj/effect/decal/cleanable/vomit/spew = new(get_turf(src))
	bite.reagents.trans_to(spew, amount)

/mob/living/carbon/human/adjust_ear_damage(damage = 0, deaf = 0)
	if(isspeciessynthetic(src))
		return
	return ..()

/mob/living/carbon/human/set_ear_damage(damage = 0, deaf = 0)
	if(isspeciessynthetic(src))
		return
	return ..()
