/datum/action/ability/activable/xeno/off_guard/use_ability(atom/target)
	var/mob/living/carbon/human/human_target = target
	human_target.apply_status_effect(STATUS_EFFECT_GUN_SKILL_ACCURACY_DEBUFF, 8 SECONDS)
	human_target.apply_status_effect(STATUS_EFFECT_GUN_SKILL_SCATTER_DEBUFF, 8 SECONDS)
	human_target.apply_status_effect(/datum/status_effect/incapacitating/offguard_slowdown, 8 SECONDS)
	human_target.log_message("has been off-guarded by [owner]", LOG_ATTACK, color="pink")
	human_target.balloon_alert_to_viewers("confused")
	playsound(human_target, 'sound/effects/off_guard_ability.ogg', 50)

	add_cooldown()
	succeed_activate()

/datum/action/ability/xeno_action/petrify/action_activate()
	var/obj/effect/overlay/eye/eye = new
	owner.vis_contents += eye
	flick("eye_opening", eye)
	playsound(owner, 'sound/effects/petrify_charge.ogg', 50)
	REMOVE_TRAIT(owner, TRAIT_STAGGER_RESISTANT, XENO_TRAIT)
	ADD_TRAIT(owner, TRAIT_IMMOBILE, PETRIFY_ABILITY_TRAIT)

	if(!do_after(owner, PETRIFY_WINDUP_TIME, IGNORE_HELD_ITEM, owner, BUSY_ICON_DANGER, extra_checks = CALLBACK(src, PROC_REF(can_use_action), FALSE, ABILITY_USE_BUSY)))
		flick("eye_closing", eye)
		addtimer(CALLBACK(src, PROC_REF(remove_eye), eye), 7, TIMER_CLIENT_TIME)
		finish_charging()
		add_cooldown(10 SECONDS)
		return fail_activate()

	finish_charging()
	playsound(owner, 'sound/effects/petrify_activate.ogg', 50)
	var/list/mob/living/carbon/human/humans = list()
	for(var/mob/living/carbon/human/human in view(PETRIFY_RANGE, owner.loc))
		if(is_blind(human))
			continue

		human.notransform = TRUE
		human.status_flags |= GODMODE
		ADD_TRAIT(human, TRAIT_HANDS_BLOCKED, REF(src))
		human.move_resist = MOVE_FORCE_OVERPOWERING
		human.unset_interaction()
		human.add_atom_colour(COLOR_GRAY, TEMPORARY_COLOUR_PRIORITY)
		human.log_message("has been petrified by [owner] for [PETRIFY_DURATION] ticks", LOG_ATTACK, color="pink")

		var/image/stone_overlay = image('icons/effects/effects.dmi', null, "petrified_overlay")
		stone_overlay.filters += filter(arglist(alpha_mask_filter(render_source="*[REF(human)]",flags=MASK_INVERSE)))

		var/mutable_appearance/mask = mutable_appearance()
		mask.appearance = human.appearance
		mask.render_target = "*[REF(human)]"
		mask.alpha = 125
		stone_overlay.overlays += mask

		human.overlays += stone_overlay
		humans[human] = stone_overlay

	if(!length(humans))
		flick("eye_closing", eye)
		addtimer(CALLBACK(src, PROC_REF(remove_eye), eye), 7, TIMER_CLIENT_TIME)
		return

	addtimer(CALLBACK(src, PROC_REF(remove_eye), eye), 10, TIMER_CLIENT_TIME)
	flick("eye_explode", eye)
	addtimer(CALLBACK(src, PROC_REF(end_effects), humans), PETRIFY_DURATION)
	add_cooldown()
	succeed_activate()
