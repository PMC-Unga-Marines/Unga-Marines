/datum/surgery_step/mcomp_wounds
	var/required_trait = TRAIT_YAUTJA_TECH// Only predators can do this
	var/depth_op = 0

/datum/surgery_step/mcomp_wounds/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(target_zone != "chest")
		return SURGERY_CANNOT_USE
	if(HAS_TRAIT(user, required_trait) && (target.getBruteLoss() || target.getFireLoss() || depth_op) && affected.surgery_open_stage == depth_op) //Heals brute or burn
		return SURGERY_CAN_USE
	return SURGERY_CANNOT_USE

//------------------------------------

/datum/surgery_step/mcomp_wounds/mstabilize_wounds
	allowed_tools = list(
		/obj/item/tool/surgery/stabilizer_gel = 100,
		/obj/item/tool/surgery/bonegel = 60,
		/obj/item/stack/cable_coil = 40,
	)
	min_duration = 1 SECONDS
	max_duration = 5 SECONDS

	blood_level = 1
	depth_op = 0

/datum/surgery_step/mcomp_wounds/mstabilize_wounds/begin_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(user == target)
		user.visible_message(span_notice("[user] begins to stabilize wounds on their body with [tool]."),
		span_notice("You begin to stabilize your wounds with [tool]."))
	else
		user.affected_message(target,
		span_notice("You begin to stabilize the wounds on [target]'s body with [tool]."),
		span_notice("[user] begins to stabilize the wounds on your body with [tool]."),
		span_notice("[user] begins to stabilize the wounds on [target]'s body with [tool]."))

/datum/surgery_step/mcomp_wounds/mstabilize_wounds/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	target.heal_overall_damage(40,40)
	playsound(target, 'modular_RUtgmc/sound/misc/cautery.ogg', 25)

	if(isyautja(target))
		target.emote("click2")
	else
		target.emote("pain")

	affected.surgery_open_stage = 0.25
	if(user == target)
		user.visible_message(span_notice("[user] finishes stabilizing the wounds on their body with [tool]."),
			span_notice("You finish stabilizing your wounds with [tool]."))
	else
		user.affected_message(target,
			span_notice("You finish stabilizing [target]'s wounds with [tool]."),
			span_notice("[user] finished stabilizing your wounds with [tool]."),
			span_notice("[user] finished treating [target]'s wounds with [tool]."))

/datum/surgery_step/mcomp_wounds/mstabilize_wounds/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	return FALSE

/datum/surgery_step/mcomp_wounds/mtend_wounds
	allowed_tools = list(
		/obj/item/tool/surgery/healing_gun = 100,
	)
	min_duration = 12 SECONDS
	max_duration = 15 SECONDS

	blood_level = 1
	depth_op = 0.25

/datum/surgery_step/mcomp_wounds/mtend_wounds/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	. = ..()

	if(!.)
		return FALSE

	var/obj/item/tool/surgery/healing_gun/gun = tool
	if(!gun.loaded)
		to_chat(user, span_warning("You can't heal yourself without a capsule in the gun!"))
		return FALSE
	return TRUE

/datum/surgery_step/mcomp_wounds/mtend_wounds/begin_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	playsound(target, 'modular_RUtgmc/sound/misc/heal_gun.ogg', 25)
	flick("healing_gun_on", tool)

	if(user == target)
		user.visible_message(span_notice("[user] begins to treat the stabilized wounds on their body with [tool]."),
		span_notice("You begin to treat your stabilized wounds with [tool]."))
	else
		user.affected_message(target,
			span_notice("You begin to treat the stabilized wounds on [target]'s body with [tool]."),
			span_notice("[user] begins to treat the stabilized wounds on your body with [tool]."),
			span_notice("[user] begins to treat the stabilized wounds on [target]'s body with [tool]."))

	target.custom_pain("It feels like your body is being stabbed with needles - because it is!")

/datum/surgery_step/mcomp_wounds/mtend_wounds/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	target.heal_overall_damage(65,65)

	for(var/datum/internal_organ/organ in target.internal_organs) //Fixes all organs
		organ.heal_organ_damage(100)

	affected.surgery_open_stage = 0.75
	if(isyautja(target))
		target.emote("click")
	else
		target.emote("pain")

	if(user == target)
		user.visible_message(span_notice("[user] finishes treating the stabilized wounds on their body with [tool]."),
			span_notice("You finish treating the stabilized wounds on your body with [tool]."))
	else
		user.affected_message(target,
			span_notice("You finish treating [target]'s stabilized wounds with [tool]."),
			span_notice("[user] finished treating your stabilized wounds with [tool]."),
			span_notice("[user] finished treating [target]'s stabilized wounds with [tool]."))

	if(!istype(tool, /obj/item/tool/surgery/healing_gun))
		return
	var/obj/item/tool/surgery/healing_gun/gun = tool
	gun.loaded = FALSE
	gun.update_icon()

/datum/surgery_step/mcomp_wounds/mtend_wounds/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	return FALSE

/datum/surgery_step/mcomp_wounds/mclamp_wound
	allowed_tools = list(
		/obj/item/tool/surgery/wound_clamp = 100,
		/obj/item/tool/surgery/cautery = 60,
	)
	min_duration = 4 SECONDS
	max_duration = 10 SECONDS

	depth_op = 0.75

/datum/surgery_step/mcomp_wounds/mclamp_wound/begin_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	playsound(target, 'modular_RUtgmc/sound/misc/cautery2.ogg', 25)
	flick("wound_clamp_on", tool)

	if(user == target)
		user.visible_message(span_notice("[user] begins to close the treated wounds on their body with [tool]."),
			span_notice("You begin to close your treated wounds with [tool]."))
	else
		user.affected_message(target,
			span_notice("You begin to close the treated wounds on [target]'s body with [tool]."),
			span_notice("[user] begins to clamp the treated wounds on your body with [tool]."),
			span_notice("[user] begns to clamp the treated wounds on [target]'s body with [tool]."))

/datum/surgery_step/mcomp_wounds/mclamp_wound/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	target.heal_overall_damage(65,65) //makes sure that all damage is healed
	playsound(target, 'modular_RUtgmc/sound/misc/cautery.ogg', 25)

	if(user == target)
		user.visible_message(span_notice("[user] finshes closing the treated wounds on their body with [tool]."),
			span_notice("You finish closing the treated wounds on your body with [tool]"))
	else
		user.affected_message(target,
			span_notice("You finish closing [target]'s treated wounds with [tool]."),
			span_notice("[user] finished closing your treated wounds with [tool]."),
			span_notice("[user] finished closing [target]'s treated wounds with [tool]."))

	if(isyautja(target))
		target.emote("loudroar")
	else
		target.emote("pain")

	affected.surgery_open_stage = 0

/datum/surgery_step/mcomp_wounds/mclamp_wound/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	return FALSE
