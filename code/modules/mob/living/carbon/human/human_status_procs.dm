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

	var/datum/internal_organ/stomach/belly = get_organ_slot(ORGAN_SLOT_STOMACH)
	for(var/datum/reagent/our_reagent in belly.reagents.reagent_list)
		belly.reagents.remove_reagent(our_reagent.type, our_reagent.volume / rand(2, 5)) // vomit out some reagents from our stomach

	adjust_nutrition(-40)
	adjustToxLoss(-3)

/mob/living/carbon/human/adjust_ear_damage(damage = 0, deaf = 0)
	if(isspeciessynthetic(src))
		return
	return ..()

/mob/living/carbon/human/set_ear_damage(damage = 0, deaf = 0)
	if(isspeciessynthetic(src))
		return
	return ..()
