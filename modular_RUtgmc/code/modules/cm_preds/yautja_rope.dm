/obj/item/stack/yautja_rope
	name = "strange rope"
	singular_name = "rope meter"
	desc = "This unassuming rope seems to be covered in markings depicting strange humanoid forms."
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "brutepack"
	item_state = "coil"
	force = 2
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("whipped", "lashed", "disciplined", "flogged")
	color = "#D2B48C"
	attack_speed = 1.4 SECONDS //stop spam
	amount = 8
	max_amount = 8

/obj/item/stack/yautja_rope/attack(mob/living/mob_victim, mob/living/carbon/human/user)
	if(mob_victim.stat != DEAD)
		return ..()

	if(mob_victim.mob_size != MOB_SIZE_HUMAN)
		to_chat(user, span_warning("[mob_victim] has the wrong body plan to hang up."))
		return TRUE

	if(!HAS_TRAIT(user, TRAIT_SUPER_STRONG))
		to_chat(user, span_warning("You're not strong enough to lift [mob_victim] up with a rope. Also, that's kind of fucked up."))
		return TRUE

	var/mob/living/carbon/human/victim = mob_victim

	if(!do_after(user, 1 SECONDS, NONE, victim, BUSY_ICON_HOSTILE))
		return TRUE

	user.visible_message(span_notice("[user] starts to secure \his rope to the ceiling..."),
		span_notice("You start securing the rope to the ceiling..."))

	if(do_after(user, 4 SECONDS, NONE, victim, BUSY_ICON_HOSTILE))
		var/turf/rturf = get_turf(victim)
		var/area/rarea = get_area(victim)
		if(rturf.density)
			to_chat(user, span_warning("They're in a wall!"))
			return TRUE
		if(rarea.ceiling == CEILING_NONE)
			to_chat(user, span_warning("There's no ceiling to hang them from!"))
			return TRUE
		user.visible_message(span_notice("[user] secures the rope."),
			span_notice("You secure the rope."))
		if(!do_after(user, 1 SECONDS, NONE, victim, BUSY_ICON_HOSTILE))
			return
		user.visible_message(span_warning("[user] begins hanging [victim] up by the rope..."),
			span_notice("You start hanging [victim] up by the rope..."))
		if(!do_after(user, 3 SECONDS, NONE, victim, BUSY_ICON_HOSTILE))
			return
		user.visible_message(span_warning("[user] hangs [victim] from the ceiling!"), span_notice("You finish hanging [victim]."))
		playsound(loc, 'modular_RUtgmc/sound/effects/noosed.ogg', 15, 1)
		user.stop_pulling()
		victim.get_hung()
		use(1)
	return TRUE

/mob/living/carbon/human/proc/get_hung()
	animate(src, pixel_y = 9, time = 0.5 SECONDS, easing = SINE_EASING|EASE_OUT)
	setDir(SOUTH)
	var/matrix/A = matrix()
	A.Turn(180)
	status_flags |= INCORPOREAL
	initial_transform = transform
	transform = A
	var/rand_swing = rand(6, 3)
	//-6, -3
	animate(src, pixel_x = (rand_swing * -1), time = 3 SECONDS, loop = -1, easing = SINE_EASING|EASE_OUT)
	animate(pixel_x = rand_swing, time = 3 SECONDS,  easing = SINE_EASING|EASE_OUT)

	anchored = TRUE
	RegisterSignal(src, COMSIG_ATTEMPT_MOB_PULL, PROC_REF(deny_pull))
	RegisterSignals(src, list(
		COMSIG_ITEM_ATTEMPT_ATTACK,
		COMSIG_LIVING_POST_FULLY_HEAL
		), PROC_REF(cut_down))

/mob/living/carbon/human/proc/deny_pull()
	return COMPONENT_CANCEL_MOB_PULL

/mob/living/carbon/human/proc/cut_down(mob/living/carbon/human/target, mob/living/user, obj/item/source)
	//source = item, target = src
	SIGNAL_HANDLER
	if(source && !source.sharp)
		return

	if(user)
		if(user.a_intent != INTENT_HELP)
			return
		user.visible_message(span_warning("[user] cuts down [src] with \the [source]."), span_warning("You cut down [src] with \the [source]."))
		user.do_attack_animation(src)
		playsound(src, 'sound/effects/vegetation_hit.ogg', 25, TRUE)
	else
		visible_message(span_danger("[src]'s body falls down from the hanging rope!"))
	UnregisterSignal(src, list(
			COMSIG_ATTEMPT_MOB_PULL,
			COMSIG_ITEM_ATTEMPT_ATTACK,
			COMSIG_LIVING_POST_FULLY_HEAL
		))
	animate(src) //remove the anims
	anchored = FALSE
	var/matrix/A = matrix()
	A.Turn(90)
	transform = A
	transform = initial_transform
	status_flags &= ~INCORPOREAL
	pixel_x = 0
	pixel_y = 0
	return COMPONENT_ITEM_NO_ATTACK
