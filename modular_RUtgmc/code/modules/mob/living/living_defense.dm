/mob/living/flamer_fire_act(burnlevel)
	if(!burnlevel)
		return
	if(status_flags & (INCORPOREAL|GODMODE)) //Ignore incorporeal/invul targets
		return
	if(hard_armor.getRating(FIRE) >= 100)
		to_chat(src, span_warning("You are untouched by the flames."))
		return

	if(pass_flags & PASS_FIRE) //Pass fire allow to cross fire without being ignited
		return

	take_overall_damage(rand(10, burnlevel), BURN, FIRE, updating_health = TRUE, max_limbs = 4)
	to_chat(src, span_warning("You are burned!"))

	adjust_fire_stacks(burnlevel)
	IgniteMob()
