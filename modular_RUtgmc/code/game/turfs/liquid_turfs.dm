/turf/open/liquid/lava/proc/burn_stuff(AM)
	. = FALSE

	var/thing_to_check = src
	if (AM)
		thing_to_check = list(AM)
	for(var/thing in thing_to_check)
		if(ismecha(thing))
			var/obj/vehicle/sealed/mecha/burned_mech = thing
			burned_mech.take_damage(rand(40, 120), BURN, FIRE)
			. = TRUE

		else if(isobj(thing))
			var/obj/O = thing
			O.fire_act(10000, 1000)

		else if (isliving(thing))
			var/mob/living/L = thing

			if(L.stat == DEAD)
				continue

			if(!L.on_fire || L.getFireLoss() <= 200)
				if(!CHECK_BITFIELD(L.pass_flags, PASS_FIRE))//Pass fire allow to cross lava without igniting
					var/damage_amount = max(L.modify_by_armor(LAVA_TILE_BURN_DAMAGE, FIRE), LAVA_TILE_BURN_DAMAGE * 0.3)
					L.take_overall_damage(damage_amount, BURN, updating_health = TRUE, max_limbs = 3)
					L.adjust_fire_stacks(20)
					L.IgniteMob()
				. = TRUE
