/obj/alien/resin
	name = "resin"
	desc = "Looks like some kind of slimy growth."
	icon_state = "Resin1"
	max_integrity = 200
	resistance_flags = XENO_DAMAGEABLE

/obj/alien/resin/attack_hand(mob/living/user)
	balloon_alert(user, "You only scrape at it")
	return TRUE

/obj/alien/resin/sticky
	name = STICKY_RESIN
	desc = "A layer of disgusting sticky slime."
	icon_state = "sticky"
	density = FALSE
	opacity = FALSE
	max_integrity = 36
	plane = FLOOR_PLANE
	layer = ABOVE_WEEDS_LAYER
	hit_sound = SFX_ALIEN_RESIN_MOVE
	var/slow_amt = 8
	/// Does this refund build points when destoryed?
	var/refundable = TRUE

	ignore_weed_destruction = TRUE

/obj/alien/resin/sticky/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(slow_down_crosser)
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/alien/resin/sticky/proc/slow_down_crosser(datum/source, atom/movable/crosser)
	SIGNAL_HANDLER
	if(crosser.throwing || crosser.buckled)
		return

	if(isvehicle(crosser))
		var/obj/vehicle/vehicle = crosser
		vehicle.last_move_time += slow_amt
		return

	if(!ishuman(crosser))
		return

	if(HAS_TRAIT(crosser, TRAIT_TANK_DESANT))
		return

	if(CHECK_MULTIPLE_BITFIELDS(crosser.allow_pass_flags, HOVERING))
		return

	var/mob/living/carbon/human/victim = crosser

	if(victim.lying_angle)
		return

	victim.next_move_slowdown += slow_amt

/obj/alien/resin/sticky/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(xeno_attacker.status_flags & INCORPOREAL)
		return FALSE

	if(xeno_attacker.a_intent == INTENT_HARM)
		if(CHECK_BITFIELD(SSticker.mode?.round_type_flags, MODE_ALLOW_XENO_QUICKBUILD) && SSresinshaping.should_refund(src, xeno_attacker) && refundable)
			SSresinshaping.decrement_build_counter(xeno_attacker)
		xeno_attacker.do_attack_animation(src, ATTACK_EFFECT_CLAW)
		playsound(src, SFX_ALIEN_RESIN_BREAK, 25)
		deconstruct(TRUE)
		return

	return ..()

// Praetorian Sticky Resin spit uses this.
/obj/alien/resin/sticky/thin
	name = "thin sticky resin"
	desc = "A thin layer of disgusting sticky slime."
	max_integrity = 6
	slow_amt = 4

	ignore_weed_destruction = FALSE
	refundable = FALSE

/obj/alien/resin/sticky/thin/temporary/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(obj_destruction), MELEE), 3 SECONDS)
