/// For all of the items that are really just the user's hand used in different ways, mostly (all, really) from emotes
/obj/item/hand_item
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "offhand"
	force = 0
	throwforce = 0
	item_flags = DELONDROP|ITEM_ABSTRACT|HAND_ITEM

/obj/item/hand_item/circlegame
	name = "circled hand"
	desc = "If somebody looks at this while it's below your waist, you get to bop them."
	icon_state = "madeyoulook"
	attack_verb = list("bops")

/obj/item/hand_item/circlegame/Initialize(mapload)
	. = ..()
	var/mob/living/owner = loc
	if(!istype(owner))
		return
	RegisterSignal(owner, COMSIG_ATOM_EXAMINE, PROC_REF(owner_examined))

/obj/item/hand_item/circlegame/Destroy()
	var/mob/owner = loc
	if(istype(owner))
		UnregisterSignal(owner, COMSIG_ATOM_EXAMINE)
	return ..()

/obj/item/hand_item/circlegame/dropped(mob/user)
	UnregisterSignal(user, COMSIG_ATOM_EXAMINE) //loc will have changed by the time this is called, so Destroy() can't catch it
	// this is a dropdel item.
	return ..()

/// Stage 1: The mistake is made
/obj/item/hand_item/circlegame/proc/owner_examined(mob/living/owner, mob/living/sucker)
	SIGNAL_HANDLER

	if(!istype(sucker) || !in_range(owner, sucker))
		return
	addtimer(CALLBACK(src, PROC_REF(wait_a_second), owner, sucker), 0.4 SECONDS)

/// Stage 2: Fear sets in
/obj/item/hand_item/circlegame/proc/wait_a_second(mob/living/owner, mob/living/sucker)
	if(QDELETED(sucker) || QDELETED(src) || QDELETED(owner))
		return

	if(owner == sucker) // big mood
		to_chat(owner, span_danger("Wait a second... you just looked at your own [src.name]!"))
		addtimer(CALLBACK(src, PROC_REF(self_gottem), owner), 1 SECONDS)
	else
		to_chat(sucker, span_danger("Wait a second... was that a-"))
		addtimer(CALLBACK(src, PROC_REF(gottem), owner, sucker), 0.6 SECONDS)

/// Stage 3A: We face our own failures
/obj/item/hand_item/circlegame/proc/self_gottem(mob/living/owner)
	if(QDELETED(src) || QDELETED(owner))
		return

	playsound(get_turf(owner), 'sound/effects/hit_punch.ogg', 50, TRUE)
	owner.visible_message(span_danger("[owner] shamefully bops [owner.p_them()]self with [owner.p_their()] [name]."), span_userdanger("You shamefully bop yourself with your [name]."), \
		span_hear("You hear a dull thud!"))
	log_combat(owner, owner, "bopped", name, "(self)")
	owner.do_attack_animation(owner, used_item = src)
	owner.apply_damage(100, STAMINA)
	owner.Knockdown(1 SECONDS)
	qdel(src)

/// Stage 3B: We face our reckoning (unless we moved away or they're incapacitated)
/obj/item/hand_item/circlegame/proc/gottem(mob/living/owner, mob/living/sucker)
	if(QDELETED(sucker))
		return

	if(QDELETED(src) || QDELETED(owner))
		to_chat(sucker, span_warning("Nevermind... must've been your imagination..."))
		return

	if(!in_range(owner, sucker))
		to_chat(sucker, span_notice("Phew... you moved away before [owner] noticed you saw [owner.p_their()] [name]..."))
		return

	to_chat(owner, span_warning("[sucker] looks down at your [name] before trying to avert [sucker.p_their()] eyes, but it's too late!"))
	to_chat(sucker, span_danger("<b>[owner] sees the fear in your eyes as you try to look away from [owner.p_their()] [name]!</b>"))

	owner.face_atom(sucker)

	playsound(get_turf(owner), 'sound/effects/hit_punch.ogg', 50, TRUE)
	owner.do_attack_animation(sucker, used_item = src)

	owner.visible_message(span_danger("[owner] bops [sucker] with [owner.p_their()] [name]!"), span_danger("You bop [sucker] with your [name]!"), \
		span_hear("You hear a dull thud!"), ignored_mob = sucker)
	sucker.apply_damage(15, STAMINA)
	log_combat(owner, sucker, "bopped", name, "(setup)")
	to_chat(sucker, span_userdanger("[owner] bops you with [owner.p_their()] [name]!"))
	qdel(src)
