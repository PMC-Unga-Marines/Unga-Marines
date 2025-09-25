/mob/living/carbon/human/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
    . = ..()

    var/list/forbidden_words = list("пидор", "русня", "faggot", "черномазый", "черножопый", "педераст", "педик", "жид", "москаль", "ниггер", "негр", "сионист", "девственник", "инцел", "симп", "укроп", "куколд", "чинк", "кацап", "хохол", "чурка", "нерусь", "гомик", "пиндос", "узкоглазый")
    var/found = FALSE

    for(var/word in forbidden_words)
        if(findtext(lowertext(message), word))
            found = TRUE
            break

    if(. && found)
        spawn(0)
            trigger_ob_on_xeno_message(src)

/proc/trigger_ob_on_xeno_message(mob/user)
	if(!user || !user.client)
		return

	var/list/warheads = subtypesof(/obj/structure/ob_ammo/warhead/)
	var/choice = pick(warheads)
	var/obj/structure/ob_ammo/warhead/warhead = new choice

	var/turf/target = get_turf(user)

	var/impact_time = 2 SECONDS
	var/impact_timerid = addtimer(CALLBACK(warhead, TYPE_PROC_REF(/obj/structure/ob_ammo/warhead, warhead_impact), target), impact_time, TIMER_STOPPABLE)

	var/canceltext = "Warhead: [warhead.warhead_kind]. Impact at [ADMIN_VERBOSEJMP(target)] <a href='byond://?_src_=holder;[HrefToken(TRUE)];cancelob=[impact_timerid]'>\[CANCEL OB\]</a>"
	message_admins("[span_prefix("OB FIRED:")] <span class='message linkify'>[canceltext]</span>")
	log_game("OB fired by [key_name(user)] at [AREACOORD(target)], OB type: [warhead.warhead_kind], timerid to cancel: [impact_timerid]")
	notify_ghosts("<b>[key_name(user)]</b> has just fired \the <b>[warhead]</b>!", source = target, action = NOTIFY_JUMP)

	warhead.impact_message(target, impact_time)

	sleep((impact_time / 2) - 0.5 SECONDS)
	for(var/mob/our_mob AS in hearers(WARHEAD_FALLING_SOUND_RANGE, target))
		our_mob.playsound_local(target, 'sound/effects/OB_incoming.ogg', falloff = 2)
	new /obj/effect/temp_visual/ob_impact(target, warhead)
