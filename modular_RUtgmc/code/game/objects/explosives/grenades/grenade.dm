/obj/item/explosive/grenade
	arm_sound = 'modular_RUtgmc/sound/weapons/grenade/grenade_pinout.ogg'
	var/G_hit_sound = 'modular_RUtgmc/sound/weapons/grenade/grenade_hit.ogg'
	var/G_throw_sound = 'modular_RUtgmc/sound/weapons/grenade/grenade_throw.ogg'

/obj/item/explosive/grenade/throw_at()
	. = ..()
	playsound(thrower, G_throw_sound, 25, 1, 6)
	sleep(0.3 SECONDS)
	playsound(loc, G_hit_sound, 20, 1, 9)

