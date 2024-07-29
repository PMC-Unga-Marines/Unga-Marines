/datum/ammo/energy/yautja
	accurate_range = 12
	shell_speed = 2
	bullet_color = COLOR_STRONG_VIOLET
	damage_type = BURN
	flags_ammo_behavior = AMMO_IGNORE_RESIST

	hud_state = "plasma"
	hud_state_empty = "electrothermal_empty"

/datum/ammo/energy/yautja/alloy_spike
	name = "alloy spike"
	ping = "ping_s"
	icon_state = "MSpearFlight"
	hud_state = "alloy_spike"
	sound_hit = "alloy_hit"
	sound_armor = "alloy_armor"
	sound_bounce = "alloy_bounce"
	bullet_color = COLOR_MAGENTA
	armor_type = BULLET
	accuracy = 20
	accurate_range = 15
	max_range = 15
	damage = 40
	penetration = 50
	shrapnel_chance = 75

/datum/ammo/energy/yautja/pistol
	name = "plasma pistol bolt"
	icon_state = "ion"

	hud_state = "plasma_pistol"

	bullet_color = COLOR_MAGENTA
	damage = 40
	shell_speed = 1.5

/datum/ammo/energy/yautja/caster
	name = "root caster bolt"
	icon_state = "ion"

/datum/ammo/energy/yautja/caster/stun
	name = "low power stun bolt"
	hud_state = "plasma_pistol"

	bullet_color = COLOR_VIOLET
	damage = 0
	flags_ammo_behavior = AMMO_ENERGY|AMMO_IGNORE_RESIST
	var/stun_time = 5 SECONDS

/datum/ammo/energy/yautja/caster/stun/on_hit_mob(mob/M, obj/projectile/P)
	var/mob/living/carbon/C = M
	if(istype(C))
		if(isyautja(C) || ispredalien(C))
			return
		to_chat(C, span_danger("An electric shock ripples through your body, freezing you in place!"))
		log_attack("[key_name(C)] was stunned by a high power stun bolt from [key_name(P.firer)] at [get_area(P)]")

		if(ishuman(C))
			var/mob/living/carbon/human/H = C
			H.apply_effect(stun_time + 10 SECONDS, WEAKEN)
		else
			C.apply_effect(stun_time, WEAKEN)

		C.apply_effect(stun_time, STUN)
	..()

/datum/ammo/energy/yautja/caster/bolt
	name = "plasma bolt"
	icon_state = "pulse1"
	flags_ammo_behavior = AMMO_IGNORE_RESIST
	bullet_color = COLOR_BRIGHT_BLUE
	shell_speed = 3
	damage = 35

/datum/ammo/energy/yautja/caster/bolt/stun
	name = "high power stun bolt"
	icon_state = "pred_stun"
	var/stun_time = 20 SECONDS
	bullet_color = COLOR_MAGENTA

	hud_state = "plasma_rifle"

	damage = 0
	flags_ammo_behavior = AMMO_ENERGY|AMMO_IGNORE_RESIST

/datum/ammo/energy/yautja/caster/bolt/stun/on_hit_mob(mob/M, obj/projectile/P)
	var/mob/living/carbon/C = M
	if(istype(C))
		if(isyautja(C) || ispredalien(C))
			return
		to_chat(C, span_danger("An electric shock ripples through your body, freezing you in place!"))
		log_attack("[key_name(C)] was stunned by a high power stun bolt from [key_name(P.firer)] at [get_area(P)]")

		if(ishuman(C))
			var/mob/living/carbon/human/H = C
			H.apply_effect(stun_time + 10 SECONDS, WEAKEN)
		else
			C.apply_effect(stun_time, WEAKEN)

		C.apply_effect(stun_time, STUN)
	..()

/datum/ammo/energy/yautja/caster/sphere
	name = "plasma eradicator"
	icon_state = "bluespace"
	bullet_color = COLOR_BRIGHT_BLUE
	flags_ammo_behavior = AMMO_EXPLOSIVE
	shell_speed = 2
	accuracy = 40

	hud_state = "plasma_sphere"

	damage = 55

	accurate_range = 8
	max_range = 8

/datum/ammo/energy/yautja/caster/sphere/on_hit_mob(mob/M, obj/projectile/P)
	cell_explosion(get_turf(M), 50, 25)

/datum/ammo/energy/yautja/caster/sphere/on_hit_turf(turf/T, obj/projectile/P)
	cell_explosion(get_turf(T), 50, 25)

/datum/ammo/energy/yautja/caster/sphere/on_hit_obj(obj/O, obj/projectile/P)
	cell_explosion(get_turf(O), 50, 25)

/datum/ammo/energy/yautja/caster/sphere/do_at_max_range(obj/projectile/P)
	cell_explosion(get_turf(P), 50, 25)

/datum/ammo/energy/yautja/caster/sphere/stun
	name = "plasma immobilizer"
	bullet_color = COLOR_MAGENTA
	damage = 0
	flags_ammo_behavior = AMMO_ENERGY|AMMO_IGNORE_RESIST
	hud_state = "plasma_rifle_blast"
	accurate_range = 20
	max_range = 20
	var/stun_range = 4
	var/stun_time = 6 SECONDS

/datum/ammo/energy/yautja/caster/sphere/stun/on_hit_mob(mob/M, obj/projectile/P)
	do_area_stun(P)

/datum/ammo/energy/yautja/caster/sphere/stun/on_hit_turf(turf/T, obj/projectile/P)
	do_area_stun(P)

/datum/ammo/energy/yautja/caster/sphere/stun/on_hit_obj(obj/O, obj/projectile/P)
	do_area_stun(P)

/datum/ammo/energy/yautja/caster/sphere/stun/do_at_max_range(obj/projectile/P)
	do_area_stun(P)

/datum/ammo/energy/yautja/caster/sphere/stun/proc/do_area_stun(obj/projectile/P)
	playsound(P, 'sound/weapons/wave.ogg', 75, 1, 25)
	for(var/mob/living/carbon/M in view(stun_range, get_turf(P)))
		var/f_stun_time = stun_time
		log_attack("[key_name(M)] was stunned by a plasma immobilizer from [key_name(P.firer)] at [get_area(P)]")
		if(isyautja(M))
			f_stun_time -= 2 SECONDS
		if(ispredalien(M))
			continue
		to_chat(M, span_danger("A powerful electric shock ripples through your body, freezing you in place!"))
		M.apply_effect(f_stun_time, STUN)

		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			H.apply_effect(f_stun_time, WEAKEN)
		else
			M.apply_effect(f_stun_time, WEAKEN)

/datum/ammo/energy/yautja/rifle/bolt
	name = "plasma rifle bolt"
	icon_state = "ion"
	damage_type = BURN
	flags_ammo_behavior = AMMO_IGNORE_RESIST

	hud_state = "plasma_rifle"

	damage = 70
	penetration = 55
