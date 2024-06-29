/*

===========
D.O.R.E.C
===========

--------------
Damage-based
Ordinal
Recursive
Explosion
Code
--------------


NOTE: This explosion system has two main variables: Power and Falloff. Power is the amount of damage done at the center of the explosion,
and falloff is the amount by which power is decreased with each tile

For example, a 200 power, 50 falloff explosion will do 200 damage to an unarmored mob at the center, and 150 damage to an adjacent
mob, and will peter out after 4 tiles

For explosion resistance, an explosion should never go through a wall or window it cannot destroy. Walls, windows and airlocks should give an
explosion resistance exactly as much as their health
*/

/proc/explosion_rec(turf/epicenter, power, falloff = 20)
	var/obj/effect/explosion/Controller = new /obj/effect/explosion(epicenter)
	Controller.initiate_explosion(epicenter, power, falloff)

/obj/effect/explosion
	var/list/explosion_turfs = list()
	var/list/explosion_turf_directions = list()
	var/explosion_in_progress = 0
	var/active_spread_num = 0
	var/power = 0
	var/falloff = 20
	/// used to amplify explosions in confined areas
	var/reflected_power = 0
	/// 1 = 100% increase
	var/reflection_multiplier = 1.5
	var/reflection_amplification_limit = 1
	var/minimum_spread_power = 0

//the start of the explosion
/obj/effect/explosion/proc/initiate_explosion(turf/epicenter, our_power, our_falloff = 20)
	if(our_power <= 1)
		return
	power = our_power
	epicenter = get_turf(epicenter)
	if(!epicenter)
		return

	falloff = max(our_falloff, power / 100) //prevent explosions with a range larger than 100 tiles
	minimum_spread_power = -power * reflection_amplification_limit

	msg_admin_ff("Explosion with Power: [power], Falloff: [falloff] in area [epicenter.loc.name] ([epicenter.x],[epicenter.y],[epicenter.z]).", src.loc.x, src.loc.y, src.loc.z [ADMIN_JMP(epicenter)])

	playsound(epicenter, 'sound/effects/explosionfar.ogg', 100, 1, round(power ^ 2, 1))
	var/sound/explosion_sound = sound(get_sfx("explosion_large"))
	switch(power)
		if(0 to EXPLODE_LIGHT)
			explosion_sound = sound(get_sfx("explosion_small"))
		if(EXPLODE_LIGHT to EXPLODE_HEAVY)
			explosion_sound = sound(get_sfx("explosion_med"))
		if(EXPLODE_HEAVY to INFINITY)
			explosion_sound = sound(get_sfx("explosion_large"))
	playsound(epicenter, get_sfx("explosion"), 90, 1, max(round(power, 1), 7))
	playsound(epicenter, explosion_sound, 90, 1, falloff = 5)

	explosion_in_progress = 1
	explosion_turfs = list()
	explosion_turf_directions = list()

	epicenter.explosion_spread(src, power, null)

	spawn(2) //just in case something goes wrong
		if(explosion_in_progress)
			explosion_damage()
			QDEL_IN(src, 2 SECONDS)

//direction is the direction that the spread took to come to this tile. So it is pointing in the main blast direction - meaning where this tile should spread most of it's force.
/turf/proc/explosion_spread(obj/effect/explosion/Controller, power, direction)

	if(Controller.explosion_turfs[src] && Controller.explosion_turfs[src] + 1 >= power)
		return

	Controller.active_spread_num++

	var/resistance = 0
	var/obj/structure/ladder/our_ladder

	for(var/atom/our_atom in src)  //add resistance
		resistance += max(0, our_atom.get_explosion_resistance(direction))

		//check for stair-teleporters. If there is a stair teleporter, switch to the teleported-to tile instead
		if(istype(our_atom, /obj/effect/step_trigger/teleporter))
			var/obj/effect/step_trigger/teleporter/our_tp = our_atom
			var/turf/our_turf = locate(our_tp.x + our_tp.teleport_x, our_tp.y + our_tp.teleport_y, our_tp.z)
			if(our_turf)
				spawn(0)
					our_turf.explosion_spread(Controller, power, direction)
					Controller.active_spread_num--
					if(Controller.active_spread_num <= 0 && Controller.explosion_in_progress)
						Controller.explosion_damage()
				return

		if(istype(our_atom, /obj/structure/ladder)) //check for ladders
			our_ladder = our_atom

	Controller.explosion_turfs[src] = power  //recording the power applied
	Controller.explosion_turf_directions[src] = direction

	//at the epicenter of an explosion, resistance doesn't subtract from power. This prevents stuff like explosions directly on reinforced walls being completely neutralized
	if(direction)
		resistance += max(0, src.get_explosion_resistance(direction))
		Controller.reflected_power += max(0, min(resistance, power))
		power -= resistance


	//spawn(0) is important because it paces the explosion in an expanding circle, rather than a series of squiggly lines constantly checking overlap. Reduces lag by a lot. Note that INVOKE_ASYNC doesn't have the same effect as spawn(0) for this purpose.
	spawn(0)

		//spread in each ordinal direction
		var/direction_angle = dir2angle(direction)
		for(var/spread_direction in GLOB.alldirs)
			var/spread_power = power

			if(direction) //false if, for example, this turf was the explosion source
				var/spread_direction_angle = dir2angle(spread_direction)

				var/angle = 180 - abs( abs( direction_angle - spread_direction_angle ) - 180 ) // the angle difference between the spread direction and initial direction

				switch(angle) //this reduces power when the explosion is going around corners
					if (0)
						//no change
					if (45)
						if(spread_power >= 0)
							spread_power *= 0.75
						else
							spread_power *= 1.25
					if (90)
						if(spread_power >= 0)
							spread_power *= 0.50
						else
							spread_power *= 1.5
					else //turns out angles greater than 90 degrees almost never happen. This bit also prevents trying to spread backwards
						continue

			switch(spread_direction)
				if(NORTH,SOUTH,EAST,WEST)
					spread_power -= Controller.falloff
				else
					spread_power -= Controller.falloff * 1.414 //diagonal spreading

			if (spread_power <= Controller.minimum_spread_power)
				continue

			var/turf/T = get_step(src, spread_direction)

			if(!T) //prevents trying to spread into "null" (edge of the map?)
				continue

			T.explosion_spread(Controller, spread_power, spread_direction)


		//spreading up/down ladders
		if(our_ladder)
			var/ladder_spread_power
			if(direction)
				if(power >= 0)
					ladder_spread_power = power * 0.75 - Controller.falloff
				else
					ladder_spread_power = power * 1.25 - Controller.falloff
			else
				if(power >= 0)
					ladder_spread_power = power * 0.5 - Controller.falloff
				else
					ladder_spread_power = power * 1.5 - Controller.falloff

			if(ladder_spread_power > Controller.minimum_spread_power)
				if(our_ladder.up)
					var/turf/T_up = get_turf(our_ladder.up)
					if(T_up)
						T_up.explosion_spread(Controller, ladder_spread_power, null)
				if(our_ladder.down)
					var/turf/T_down = get_turf(our_ladder.down)
					if(T_down)
						T_down.explosion_spread(Controller, ladder_spread_power, null)

		//if this is the last explosion spread, initiate explosion damage
		Controller.active_spread_num--
		if(Controller.active_spread_num <= 0 && Controller.explosion_in_progress)
			Controller.explosion_damage()

/obj/effect/explosion/proc/explosion_damage() //This step applies the ex_act effects for the explosion
	explosion_in_progress = 0
	var/num_tiles_affected = 0

	for(var/turf/T in explosion_turfs)
		if(!T) continue
		if(explosion_turfs[T] >= 0)
			num_tiles_affected++

	reflected_power *= reflection_multiplier
	var/damage_addon = min(power * reflection_amplification_limit, reflected_power/num_tiles_affected)
	var/tiles_processed = 0
	var/increment = min(50, sqrt(num_tiles_affected) * 3)//how many tiles we damage per tick

	for(var/turf/our_turf in explosion_turfs)
		if(!our_turf) continue

		var/severity = explosion_turfs[our_turf] + damage_addon
		if (severity <= 0)
			continue

		var/direction = explosion_turf_directions[our_turf]
		var/x = our_turf.x
		var/y = our_turf.y
		var/z = our_turf.z

		our_turf.ex_act(severity, direction)
		if(!our_turf)
			our_turf = locate(x, y, z)

		for(var/atom/our_atom in our_turf)
			spawn(0)
				log_game("Explosion with power of [power] and falloff of [falloff] at [AREACOORD(our_turf)]!")
				if(is_mainship_level(our_turf.z))
					message_admins("Explosion with power of [power] and falloff of [falloff] in [ADMIN_VERBOSEJMP(our_turf)]!")

				our_atom.ex_act(severity, direction)

		tiles_processed++
		if(tiles_processed >= increment)
			tiles_processed = 0
			sleep(0.1 SECONDS)

	spawn(8)
		qdel(src)

/atom/proc/get_explosion_resistance()
	return 0

/mob/living/get_explosion_resistance()
	if(density)
		switch(mob_size)
			if(MOB_SIZE_SMALL)
				return 0
			if(MOB_SIZE_HUMAN)
				return 25
			if(MOB_SIZE_XENO)
				return 30
			if(MOB_SIZE_BIG)
				return 50
	return 0

/obj/proc/explosion_throw(severity, direction, scatter_multiplier = 1)
	if(!src || anchored || !isturf(loc))
		return

	if(!direction)
		direction = pick(GLOB.alldirs)
	var/range = min(round(severity * 0.2, 1), 14)
	if(!direction)
		range = round(range / 2, 1)

	if(range < 1)
		return

	var/speed = max(range * 2.5, 4)
	var/atom/target = get_ranged_target_turf(src, direction, range)

	if(range >= 2)
		var/scatter = range / 4 * scatter_multiplier
		var/scatter_x = rand(-scatter, scatter)
		var/scatter_y = rand(-scatter, scatter)
		target = locate(target.x + round(scatter_x, 1), target.y + round(scatter_y, 1), target.z) //Locate an adjacent turf.

	//time for the explosion to destroy windows, walls, etc which might be in the way
	throw_at(target, range, speed, null, TRUE)

/mob/proc/explosion_throw(severity, direction)
	if(anchored || !isturf(loc))
		return

	var/weight = 1
	switch(mob_size)
		if(MOB_SIZE_SMALL)
			weight = 0.25
		if(MOB_SIZE_HUMAN)
			weight = 1
		if(MOB_SIZE_XENO)
			weight = 1.5
		if(MOB_SIZE_BIG)
			weight = 4
	var/range = round(severity / weight * 0.02, 1)
	if(!direction)
		range = round(range / 1.5, 1)
		direction = pick(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)

	if(range <= 0)
		return

	var/speed = max(range * 1.5, 4)
	var/atom/target = get_ranged_target_turf(src, direction, range)
	var/spin = 0

	if(range > 1)
		spin = 1
	if(range >= 2)
		var/scatter = range / 4
		var/scatter_x = rand(-scatter, scatter)
		var/scatter_y = rand(-scatter, scatter)
		target = locate(target.x + round(scatter_x, 1),target.y + round(scatter_y, 1), target.z) //Locate an adjacent turf.

	//time for the explosion to destroy windows, walls, etc which might be in the way
	throw_at(target, range, speed, null, spin)
