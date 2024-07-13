/obj/item/explosive/grenade/pmc
	power = 125
	falloff = 40

/obj/item/explosive/grenade/pmc/prime()
	create_shrapnel(loc, 15, shrapnel_spread = 30, shrapnel_type = /datum/ammo/bullet/shrapnel/metal)
	return ..()

/obj/item/explosive/grenade/m15
	power = 125
	falloff = 40

/obj/item/explosive/grenade/m15/prime()
	create_shrapnel(loc, 15, shrapnel_spread = 30, shrapnel_type = /datum/ammo/bullet/shrapnel/metal)
	return ..()

/obj/item/explosive/grenade/sectoid
	power = 150
	falloff = 25

/obj/item/explosive/grenade/sticky
	icon_state_mini = "grenade_sticky"
	arm_sound = 'modular_RUtgmc/sound/weapons/grenade/grenade_pinout4.ogg'
	G_hit_sound = null
	power = 90
	falloff = 40

/obj/item/explosive/grenade/sticky/trailblazer
	icon_state_mini = "grenade_trailblazer"
	var/fire_level = 25
	var/burn_level = 25
	var/fire_color = "red"
	var/our_fire_stacks = 0
	var/our_fire_damage = 0

/obj/item/explosive/grenade/sticky/trailblazer/stuck_to(atom/hit_atom)
	. = ..()
	RegisterSignal(stuck_to, COMSIG_MOVABLE_MOVED, PROC_REF(make_fire))
	var/turf/T = get_turf(src)
	T.ignite(fire_level, burn_level, fire_color, our_fire_stacks, our_fire_damage)

/obj/item/explosive/grenade/sticky/trailblazer/proc/make_fire(datum/source, old_loc, movement_dir, forced, old_locs)
	SIGNAL_HANDLER
	var/turf/T = get_turf(src)
	T.ignite(fire_level, burn_level, fire_color, our_fire_stacks, our_fire_damage)

/obj/item/explosive/grenade/sticky/trailblazer/phosphorus
	name = "\improper M45 Phosphorus trailblazer grenade"
	desc = "Capsule based grenade that sticks to sufficiently hard surfaces, causing a trail of air combustable gel to form. But with phosphorus. It is set to detonate in 5 seconds."
	icon = 'modular_RUtgmc/icons/obj/items/grenade.dmi'
	icon_state = "grenade_sticky_phosphorus"
	item_state = "grenade_sticky_phosphorus"
	icon_state_mini = "grenade_trailblazer_phosphorus"
	fire_level = 45
	burn_level = 45
	fire_color = "blue"

/obj/item/explosive/grenade/sticky/trailblazer/phosphorus/activate(mob/user)
	. = ..()
	if(!.)
		return FALSE
	user?.record_war_crime()

/obj/item/explosive/grenade/sticky/trailblazer/phosphorus/prime()
	flame_radius(0.5, get_turf(src), colour = "blue")
	playsound(loc, "incendiary_explosion", 35)
	if(stuck_to)
		clean_refs()
	qdel(src)

/obj/item/explosive/grenade/ags
	power = 80
	falloff = 20

/obj/item/explosive/grenade/impact
	power = 80
	falloff = 30

/obj/item/explosive/grenade/impact/throw_impact(atom/hit_atom, speed)
	. = ..()
	if(!.)
		return
	if(launched && active && !istype(hit_atom, /turf/open)) //Only contact det if active, we actually hit something, and we're fired from a grenade launcher.
		cell_explosion(loc, 50, 25)
		qdel(src)

/obj/item/explosive/grenade/smokebomb
	arm_sound = 'modular_RUtgmc/sound/weapons/grenade/grenade_pinout4.ogg'
	G_hit_sound = 'modular_RUtgmc/sound/weapons/grenade/grenade_hit4.ogg'

/obj/item/explosive/grenade/phosphorus
	arm_sound = 'modular_RUtgmc/sound/weapons/grenade/grenade_pinout4.ogg'
	G_hit_sound = 'modular_RUtgmc/sound/weapons/grenade/grenade_hit4.ogg'

/obj/item/explosive/grenade/smokebomb/drain
	icon_state_mini = "grenade_purple"

/obj/item/explosive/grenade/flare
	lower_fuel_limit = 450 // 450 * 2 (ticks) / 60 (seconds) = 15 minutes
	upper_fuel_limit = 750 // 750 * 2 (ticks) / 60 (seconds) = 25 minutes
	G_hit_sound = null
	G_throw_sound = null
