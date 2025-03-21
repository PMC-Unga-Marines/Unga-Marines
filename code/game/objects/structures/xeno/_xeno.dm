/obj/alien
	name = "alien thing"
	desc = "theres something alien about this"
	icon = 'icons/Xeno/Effects.dmi'
	hit_sound = SFX_ALIEN_RESIN_BREAK
	anchored = TRUE
	max_integrity = 1
	resistance_flags = UNACIDABLE
	obj_flags = CAN_BE_HIT
	var/on_fire = FALSE
	///Set this to true if this object isn't destroyed when the weeds under it is.
	var/ignore_weed_destruction = FALSE

/obj/alien/Initialize(mapload)
	. = ..()
	if(!ignore_weed_destruction)
		RegisterSignal(loc, COMSIG_TURF_WEED_REMOVED, PROC_REF(weed_removed))

/// Destroy the alien effect when the weed it was on is destroyed
/obj/alien/proc/weed_removed()
	SIGNAL_HANDLER
	obj_destruction(damage_flag = MELEE)

/obj/alien/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(user.a_intent == INTENT_HARM) //Already handled at the parent level.
		return

	if(obj_flags & CAN_BE_HIT)
		return I.attack_obj(src, user)

/obj/alien/fire_act(burn_level, flame_color)
	take_damage(burn_level * 2, BURN, FIRE)

/obj/alien/ex_act(severity)
	take_damage(severity, BRUTE, BOMB)

/obj/alien/effect_smoke(obj/effect/particle_effect/smoke/S)
	. = ..()
	if(!.)
		return
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_BLISTERING))
		take_damage(rand(2, 20) * 0.1, BURN, ACID)
