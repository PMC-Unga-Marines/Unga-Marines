/obj/structure/barricade
	icon = 'icons/obj/structures/barricades/misc.dmi'
	climbable = TRUE
	anchored = TRUE
	density = TRUE
	layer = BELOW_OBJ_LAYER
	atom_flags = ON_BORDER
	obj_flags = CAN_BE_HIT | IGNORE_DENSITY | BLOCKS_CONSTRUCTION_DIR
	resistance_flags = XENO_DAMAGEABLE
	allow_pass_flags = PASS_DEFENSIVE_STRUCTURE|PASSABLE|PASS_WALKOVER
	climb_delay = 2 SECONDS //Leaping a barricade is universally much faster than clumsily climbing on a table or rack
	interaction_flags = INTERACT_CHECK_INCAPACITATED
	max_integrity = 100
	barrier_flags = HANDLE_BARRIER_CHANCE
	///The type of stack the barricade dropped when disassembled if any.
	var/stack_type
	///The amount of stack dropped when disassembled at full health
	var/stack_amount = 5
	///to specify a non-zero amount of stack to drop when destroyed
	var/destroyed_stack_amount = 0
	var/base_acid_damage = 2
	///"metal", "plasteel", etc.
	var/barricade_type = "barricade"
	///Whether this barricade has damaged states
	var/can_change_dmg_state = TRUE
	///Whether we can open/close this barrricade and thus go over it
	var/closed = FALSE
	///Can this barricade type be wired
	var/can_wire = FALSE
	///is this barricade wired?
	var/is_wired = FALSE
	/// Can this barricade be upgraded?
	var/can_upgrade = FALSE

/obj/structure/barricade/Initialize(mapload)
	. = ..()
	update_icon()
	var/static/list/connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_try_exit),
		COMSIG_OBJ_TRY_ALLOW_THROUGH = PROC_REF(can_climb_over),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/structure/barricade/handle_barrier_chance(mob/living/M)
	return prob(max(30,(100.0*obj_integrity)/max_integrity))

/obj/structure/barricade/examine(mob/user)
	. = ..()
	if(is_wired)
		. += span_info("There is a length of wire strewn across the top of this barricade.")
	switch((obj_integrity / max_integrity) * 100)
		if(75 to INFINITY)
			. += span_info("It appears to be in good shape.")
		if(50 to 75)
			. += span_warning("It's slightly damaged, but still very functional.")
		if(25 to 50)
			. += span_warning("It's quite beat up, but it's holding together.")
		if(-INFINITY to 25)
			. += span_warning("It's crumbling apart, just a few more blows will tear it apart.")

/obj/structure/barricade/on_try_exit(datum/source, atom/movable/mover, direction, list/knownblockers)
	. = ..()

	if(mover?.throwing && !CHECK_MULTIPLE_BITFIELDS(mover?.pass_flags, HOVERING) && density && is_wired && iscarbon(mover) && (direction & dir))
		knownblockers += src
		return COMPONENT_ATOM_BLOCK_EXIT

/obj/structure/barricade/CanAllowThrough(atom/movable/mover, turf/target)
	if(get_dir(loc, target) & dir)
		if(!CHECK_MULTIPLE_BITFIELDS(mover?.pass_flags, HOVERING) && is_wired && density && ismob(mover))
			return FALSE
		if(istype(mover, /obj/effect/xenomorph)) //cades stop xeno effects like acid spray
			return FALSE

	return ..()

/obj/structure/barricade/attack_animal(mob/user)
	return attack_alien(user)

/obj/structure/barricade/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(xeno_attacker.status_flags & INCORPOREAL)
		return FALSE

	if(is_wired)
		balloon_alert(xeno_attacker, "Wire slices into us")
		xeno_attacker.apply_damage(10, blocked = MELEE , sharp = TRUE, updating_health = TRUE)
	return ..()

/obj/structure/barricade/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(get_self_acid())
		balloon_alert(user, "It's melting!")
		return TRUE

	if(!istype(I, /obj/item/stack/barbed_wire) || !can_wire)
		return

	var/obj/item/stack/barbed_wire/B = I

	balloon_alert_to_viewers("Setting up wire...")
	if(!do_after(user, 2 SECONDS, NONE, src, BUSY_ICON_BUILD) || !can_wire)
		return

	if(get_self_acid())
		balloon_alert(user, "It's melting!")
		return TRUE

	playsound(loc, 'sound/effects/barbed_wire_movement.ogg', 25, 1)

	B.use(1)
	wire()

/obj/structure/barricade/attack_hand_alternate(mob/living/user)
	if(anchored)
		balloon_alert(usr, "It's fastened to the floor")
		return FALSE

	setDir(turn(dir, 270))

/obj/structure/barricade/wirecutter_act(mob/living/user, obj/item/I)
	if(!is_wired || LAZYACCESS(user.do_actions, src))
		return FALSE

	balloon_alert_to_viewers("Removing wire...")

	if(!do_after(user, 2 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return TRUE

	playsound(loc, 'sound/items/wirecutter.ogg', 25, TRUE)
	balloon_alert_to_viewers("Removes the barbed wire")
	modify_max_integrity(max_integrity - 50)
	can_wire = TRUE
	is_wired = FALSE
	climbable = TRUE
	update_icon()
	new /obj/item/stack/barbed_wire(loc)

/obj/structure/barricade/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(disassembled && is_wired)
		new /obj/item/stack/barbed_wire(loc)
	if(stack_type)
		var/stack_amt
		if(!disassembled && destroyed_stack_amount)
			stack_amt = destroyed_stack_amount
		else
			stack_amt = round(stack_amount * (obj_integrity / max_integrity)) //Get an amount of sheets back equivalent to remaining health. Obviously, fully destroyed means 0

		if(stack_amt)
			new stack_type (loc, stack_amt)
	return ..()

/obj/structure/barricade/on_explosion_destruction(severity, direction)
	create_shrapnel(get_turf(src), rand(2, 5), direction, shrapnel_type = /datum/ammo/bullet/shrapnel/light)
	if(prob(50)) // no message spam pls
		return
	visible_message(span_warning("[src] blows apart in the explosion, sending shards flying!"))

/obj/structure/barricade/get_explosion_resistance(direction)
	if(!density || direction == turn(dir, 90) || direction == turn(dir, -90))
		return 0
	return min(obj_integrity, 40)

/obj/structure/barricade/setDir(newdir)
	. = ..()
	update_icon()

/obj/structure/barricade/update_icon_state()
	. = ..()
	var/damage_state
	var/percentage = (obj_integrity / max_integrity) * 100
	switch(percentage)
		if(-INFINITY to 25)
			damage_state = 3
		if(25 to 50)
			damage_state = 2
		if(50 to 75)
			damage_state = 1
		if(75 to INFINITY)
			damage_state = 0
	if(!closed)
		if(can_change_dmg_state)
			icon_state = "[barricade_type]_[damage_state]"
		else
			icon_state = "[barricade_type]"
		switch(dir)
			if(SOUTH)
				layer = ABOVE_MOB_LAYER
			if(NORTH)
				layer = initial(layer) - 0.01
			else
				layer = initial(layer)
		if(!anchored)
			layer = initial(layer)
	else
		if(can_change_dmg_state)
			icon_state = "[barricade_type]_closed_[damage_state]"
		else
			icon_state = "[barricade_type]_closed"
		layer = OBJ_LAYER

/obj/structure/barricade/update_overlays()
	. = ..()
	if(!is_wired)
		return
	if(!closed)
		. += image(icon, icon_state = "[barricade_type]_wire")
	else
		. += image(icon, icon_state = "[barricade_type]_closed_wire")

/obj/structure/barricade/effect_smoke(obj/effect/particle_effect/smoke/S)
	. = ..()
	if(!.)
		return
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_XENO_ACID))
		take_damage(base_acid_damage * S.strength, BURN, ACID)

/obj/structure/barricade/hitby(atom/movable/atom_movable)
	if(!is_wired)
		return FALSE
	if(!isliving(atom_movable))
		return FALSE
	var/mob/living/living = atom_movable
	balloon_alert(living, "Wire slices into us")
	living.apply_damage(10, BRUTE, blocked = MELEE , sharp = TRUE, updating_health = TRUE)
	if(living.mob_size < MOB_SIZE_BIG)
		living.Knockdown(2 SECONDS) //Leaping into barbed wire is VERY bad
	playsound(living, 'sound/machines/bonk.ogg', 75, FALSE)

	atom_movable.stop_throw()
	take_damage(50, BRUTE, MELEE, 1, get_dir(src, atom_movable))
	visible_message(span_warning("[src] was hit by [atom_movable]."), visible_message_flags = COMBAT_MESSAGE)
	return TRUE

/obj/structure/barricade/verb/rotate()
	set name = "Rotate Barricade Counter-Clockwise"
	set category = "IC.Rotate"
	set src in oview(1)

	if(anchored)
		balloon_alert(usr, "It's fastened to the floor")
		return FALSE

	setDir(turn(dir, 90))

/obj/structure/barricade/verb/revrotate()
	set name = "Rotate Barricade Clockwise"
	set category = "IC.Rotate"
	set src in oview(1)

	if(anchored)
		balloon_alert(usr, "It's fastened to the floor")
		return FALSE

	setDir(turn(dir, 270))

/obj/structure/barricade/proc/wire()
	can_wire = FALSE
	is_wired = TRUE
	climbable = FALSE
	modify_max_integrity(max_integrity + 50)
	update_icon()
