/obj/item/explosive/grenade
	name = "\improper M40 HEDP grenade"
	desc = "A small, but deceptively strong high explosive grenade that has been phasing out the M15 fragmentation grenades. Capable of being loaded in the any grenade launcher, or thrown by hand."
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/items/grenade.dmi'
	icon_state = "grenade"
	worn_icon_lists = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/grenades_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/grenades_right.dmi',
	)
	worn_icon_state = "grenade"
	throw_speed = 3
	throw_range = 7
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	hitsound = 'sound/weapons/smash.ogg'
	icon_state_mini = "grenade_red"
	///if launched from a UGL/grenade launcher
	var/launched = FALSE
	///bonus impact damage if launched from a UGL/grenade launcher
	var/launchforce = 10
	var/det_time = 4 SECONDS
	///Does it make a danger overlay for humans? Can synths use it?
	var/dangerous = TRUE
	var/arm_sound = 'sound/weapons/grenade/grenade_pinout.ogg'
	var/hud_state = "grenade_he"
	var/hud_state_empty = "grenade_empty"
	var/G_throw_sound = 'sound/weapons/grenade/grenade_throw.ogg'
	/// Power of the explosion
	var/power = 105
	/// Falloff of our explosion, aka distance, by the formula of power / falloff
	var/falloff = 30
	var/overlay_type = "red"

/obj/item/explosive/grenade/Initialize(mapload)
	. = ..()
	det_time = rand(det_time - 1 SECONDS, det_time + 1 SECONDS)

/obj/item/explosive/grenade/attack_self(mob/user)
	if(active)
		return

	if(!user.dextrous)
		balloon_alert(user, "not enough dexterity")
		return

	if(issynth(user) && dangerous && !CONFIG_GET(flag/allow_synthetic_gun_use))
		balloon_alert(user, "can't, against your programming")
		return

	activate(user)

	balloon_alert_to_viewers("primes grenade")
	if(dangerous && ishumanbasic(user))
		var/nade_sound = user.gender == FEMALE ? SFX_FEMALE_FRAGOUT : SFX_MALE_FRAGOUT

		for(var/mob/living/carbon/human/H in hearers(6,user))
			H.playsound_local(user, nade_sound, 35)

		var/image/grenade = image('icons/mob/talk.dmi', user, "grenade")
		user.add_emote_overlay(grenade)

/obj/item/explosive/grenade/afterattack(atom/target, mob/user, has_proximity, click_parameters)
	. = ..()
	if(!active)
		return
	user.throw_item(target)

/obj/item/explosive/grenade/proc/activate(mob/user)
	if(active)
		return

	if(user)
		log_bomber(user, "primed", src)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[user.ckey]
		personal_statistics.grenades_primed++

	icon_state = initial(icon_state) + "_active"
	active = TRUE
	playsound(loc, arm_sound, 30, 1, 6)
	if(dangerous)
		GLOB.round_statistics.grenades_thrown++
		SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "grenades_thrown")
		update_icon()
	addtimer(CALLBACK(src, PROC_REF(prime)), det_time)
	return TRUE

/obj/item/explosive/grenade/update_overlays()
	. = ..()
	if(!dangerous)
		return
	if(active && overlay_type)
		. += image('icons/effects/danger.dmi', icon_state = "danger_[overlay_type]")

/obj/item/explosive/grenade/proc/prime()
	cell_explosion(loc, power = src.power, falloff = src.falloff)
	qdel(src)

/obj/item/explosive/grenade/fire_act(burn_level, flame_color)
	activate()

///Adjusts det time, used for grenade launchers
/obj/item/explosive/grenade/proc/launched_det_time()
	det_time = min(12, det_time)

/obj/item/explosive/grenade/throw_at(target, range, speed, thrower, spin, flying, targetted_throw)
	. = ..()
	playsound(thrower, G_throw_sound, 25, 1, 6)
