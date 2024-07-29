// ***************************************
// *********** Scatterspit
// ***************************************

/datum/action/ability/activable/xeno/scatter_spit/praetorian
	name = "Scatter Spit"
	action_icon_state = "scatter_spit"
	desc = "Spits a spread of acid projectiles that splatter on the ground."
	ability_cost = 280
	cooldown_duration = 1 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_SCATTER_SPIT,
	)

/datum/action/ability/activable/xeno/scatter_spit/praetorian/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/X = owner

	if(!do_after(X, 0.5 SECONDS, NONE, target, BUSY_ICON_DANGER))
		return fail_activate()

	//Shoot at the thing
	playsound(X.loc, 'sound/effects/blobattack.ogg', 50, 1)

	var/datum/ammo/xeno/acid/heavy/scatter/praetorian/scatter_spit = GLOB.ammo_list[/datum/ammo/xeno/acid/heavy/scatter/praetorian]

	var/obj/projectile/newspit = new /obj/projectile(get_turf(X))
	newspit.generate_bullet(scatter_spit, scatter_spit.damage * SPIT_UPGRADE_BONUS(X))
	newspit.def_zone = X.get_limbzone_target()

	newspit.fire_at(target, X, null, newspit.ammo.max_range)

	succeed_activate()
	add_cooldown()

	GLOB.round_statistics.spitter_scatter_spits++ //Statistics
	SSblackbox.record_feedback("tally", "round_statistics", 1, "spitter_scatter_spits")

/datum/action/ability/activable/xeno/scatter_spit/on_cooldown_finish()
	to_chat(owner, span_xenodanger("Our auxiliary sacks fill to bursting; we can use scatter spit again."))
	owner.playsound_local(owner, 'sound/voice/alien/drool1.ogg', 25, 0, 1)
	return ..()

// ***************************************
// *********** Acid spray
// ***************************************

/datum/action/ability/activable/xeno/spray_acid/cone
	name = "Spray Acid Cone"
	action_icon_state = "spray_acid"
	desc = "Spray a cone of dangerous acid at your target."
	ability_cost = 300
	cooldown_duration = 20 SECONDS
/datum/action/ability/activable/xeno/spray_acid/cone/use_ability(atom/A)
	var/mob/living/carbon/xenomorph/X = owner
	var/turf/target = get_turf(A)

	if(!istype(target)) //Something went horribly wrong. Clicked off edge of map probably
		return

	if(!do_after(X, 0.5 SECONDS, NONE, target, BUSY_ICON_DANGER))
		return fail_activate()

	if(!can_use_ability(A, TRUE, override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return fail_activate()

	GLOB.round_statistics.praetorian_acid_sprays++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "praetorian_acid_sprays")

	succeed_activate()

	playsound(X.loc, 'sound/effects/refill.ogg', 25, 1)
	X.visible_message(span_xenowarning("\The [X] spews forth a wide cone of acid!"), \
	span_xenowarning("We spew forth a cone of acid!"), null, 5)

	start_acid_spray_cone(target, X.xeno_caste.acid_spray_range)
	add_cooldown()

	var/datum/action/ability/activable/xeno/spray = X.actions_by_path[/datum/action/ability/activable/xeno/spray_acid/line/short]
	if(spray)
		spray.add_cooldown(10 SECONDS)

/datum/action/ability/activable/xeno/spray_acid/ai_should_start_consider()
	return TRUE

/datum/action/ability/activable/xeno/spray_acid/ai_should_use(atom/target)
	if(owner.do_actions) //Chances are we're already spraying acid, don't override it
		return FALSE
	if(!iscarbon(target))
		return FALSE
	if(!line_of_sight(owner, target, 3))
		return FALSE
	if(!can_use_ability(target, override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(target.get_xeno_hivenumber() == owner.get_xeno_hivenumber())
		return FALSE
	return TRUE

GLOBAL_LIST_INIT(acid_spray_hit, typecacheof(list(/obj/structure/barricade, /obj/hitbox, /obj/structure/razorwire)))

#define CONE_PART_MIDDLE (1<<0)
#define CONE_PART_LEFT (1<<1)
#define CONE_PART_RIGHT (1<<2)
#define CONE_PART_DIAG_LEFT (1<<3)
#define CONE_PART_DIAG_RIGHT (1<<4)
#define CONE_PART_MIDDLE_DIAG (1<<5)

///Start the acid cone spray in the correct direction
/datum/action/ability/activable/xeno/spray_acid/cone/proc/start_acid_spray_cone(turf/T, range)
	var/facing = angle_to_dir(Get_Angle(owner, T))
	owner.setDir(facing)
	switch(facing)
		if(NORTH, SOUTH, EAST, WEST)
			do_acid_cone_spray(owner.loc, range, facing, CONE_PART_MIDDLE|CONE_PART_LEFT|CONE_PART_RIGHT, owner, TRUE)
		if(NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)
			do_acid_cone_spray(owner.loc, range, facing, CONE_PART_MIDDLE_DIAG, owner, TRUE)
			do_acid_cone_spray(owner.loc, range + 1, facing, CONE_PART_DIAG_LEFT|CONE_PART_DIAG_RIGHT, owner, TRUE)

///Check if it's possible to create a spray, and if yes, check if the spray must continue
/datum/action/ability/activable/xeno/spray_acid/cone/proc/do_acid_cone_spray(turf/T, distance_left, facing, direction_flag, source_spray, skip_timer = FALSE)
	if(distance_left <= 0)
		return
	if(T.density)
		return
	var/is_blocked = FALSE
	for (var/obj/O in T)
		if(!O.CanPass(source_spray, get_turf(source_spray)))
			is_blocked = TRUE
			O.acid_spray_act(owner)
			break
	if(is_blocked)
		return

	var/mob/living/carbon/xenomorph/praetorian/xeno_owner = owner

	var/obj/effect/xenomorph/spray/spray = new(T, xeno_owner.xeno_caste.acid_spray_duration, xeno_owner.xeno_caste.acid_spray_damage, xeno_owner)
	var/turf/next_normal_turf = get_step(T, facing)
	for (var/atom/movable/A AS in T)
		A.acid_spray_act(owner)
		if(((A.density && !(A.allow_pass_flags & PASS_PROJECTILE) && !(A.flags_atom & ON_BORDER)) || !A.Exit(source_spray, facing)) && !isxeno(A))
			is_blocked = TRUE
	if(!is_blocked)
		if(!skip_timer)
			addtimer(CALLBACK(src, PROC_REF(continue_acid_cone_spray), T, next_normal_turf, distance_left, facing, direction_flag, spray), 3)
			return
		continue_acid_cone_spray(T, next_normal_turf, distance_left, facing, direction_flag, spray)


///Call the next steps of the cone spray,
/datum/action/ability/activable/xeno/spray_acid/cone/proc/continue_acid_cone_spray(turf/current_turf, turf/next_normal_turf, distance_left, facing, direction_flag, spray)
	if(CHECK_BITFIELD(direction_flag, CONE_PART_MIDDLE))
		do_acid_cone_spray(next_normal_turf, distance_left - 1 , facing, CONE_PART_MIDDLE, spray)
	if(CHECK_BITFIELD(direction_flag, CONE_PART_RIGHT))
		do_acid_cone_spray(get_step(next_normal_turf, turn(facing, 90)), distance_left - 1, facing, CONE_PART_RIGHT|CONE_PART_MIDDLE, spray)
	if(CHECK_BITFIELD(direction_flag, CONE_PART_LEFT))
		do_acid_cone_spray(get_step(next_normal_turf, turn(facing, -90)), distance_left - 1, facing, CONE_PART_LEFT|CONE_PART_MIDDLE, spray)
	if(CHECK_BITFIELD(direction_flag, CONE_PART_DIAG_LEFT))
		do_acid_cone_spray(get_step(current_turf, turn(facing, 45)), distance_left - 1, turn(facing, 45), CONE_PART_MIDDLE, spray)
	if(CHECK_BITFIELD(direction_flag, CONE_PART_DIAG_RIGHT))
		do_acid_cone_spray(get_step(current_turf, turn(facing, -45)), distance_left - 1, turn(facing, -45), CONE_PART_MIDDLE, spray)
	if(CHECK_BITFIELD(direction_flag, CONE_PART_MIDDLE_DIAG))
		do_acid_cone_spray(next_normal_turf, distance_left - 1, facing, CONE_PART_DIAG_LEFT|CONE_PART_DIAG_RIGHT, spray)
		do_acid_cone_spray(next_normal_turf, distance_left - 2, facing, (distance_left < 5) ? CONE_PART_MIDDLE : CONE_PART_MIDDLE_DIAG, spray)

// ***************************************
// *********** Dash
// ***************************************
/datum/action/ability/activable/xeno/charge/dash
	name = "Dash"
	action_icon_state = "pounce"
	desc = "Instantly dash to the selected tile."
	ability_cost = 100
	cooldown_duration = 10 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_DASH,
	)
	charge_range = PRAE_CHARGEDISTANCE
	///Can we use the ability again
	var/recast_available = FALSE
	///Is this the recast
	var/recast = FALSE
	///The last tile we dashed through, used when swapping with a human
	var/turf/last_turf

/datum/action/ability/activable/xeno/charge/dash/use_ability(atom/A)
	if(!A)
		return
	var/mob/living/carbon/xenomorph/xeno_owner = owner
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_POST_THROW, PROC_REF(charge_complete))
	RegisterSignal(xeno_owner, COMSIG_XENOMORPH_LEAP_BUMP, PROC_REF(mob_hit))

	xeno_owner.xeno_flags |= XENO_LEAPING //This has to come before throw_at, which checks impact. So we don't do end-charge specials when thrown

	add_cooldown()
	succeed_activate()

	last_turf = get_turf(owner)
	owner.pass_flags = PASS_LOW_STRUCTURE|PASS_DEFENSIVE_STRUCTURE|PASS_FIRE
	owner.throw_at(A, charge_range, 2, owner)

	add_cooldown()
	succeed_activate()

/datum/action/ability/activable/xeno/charge/dash/mob_hit(datum/source, mob/living/living_target)
	. = TRUE
	if(living_target.stat || isxeno(living_target) || !(iscarbon(living_target))) //we leap past xenos
		return
	var/mob/living/carbon/carbon_victim = living_target
	carbon_victim.ParalyzeNoChain(0.1 SECONDS)

/datum/action/ability/activable/xeno/charge/dash/charge_complete()
	. = ..()
	var/mob/living/carbon/xenomorph/xeno_owner = owner
	xeno_owner.pass_flags = initial(xeno_owner.pass_flags)

// ***************************************
// *********** Short acid spray
// ***************************************
/datum/action/ability/activable/xeno/spray_acid/line/short
	name = "Spray Acid"
	action_icon_state = "spray_acid"
	desc = "Spray a short line of dangerous acid at your target."
	ability_cost = 100
	cooldown_duration = 10 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_SHORT_SPRAY_ACID,
	)

/datum/action/ability/activable/xeno/spray_acid/line/short/use_ability(atom/A)
	var/mob/living/carbon/xenomorph/X = owner
	var/turf/target = get_turf(A)

	if(!istype(target)) //Something went horribly wrong. Clicked off edge of map probably
		return

	X.face_atom(target) //Face target so we don't look stupid

	if(X.do_actions)
		return

	if(!can_use_ability(A, TRUE, override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return fail_activate()

	succeed_activate()

	playsound(X.loc, 'sound/effects/refill.ogg', 50, 1)
	var/turflist = getline(X, target)
	spray_turfs(turflist)
	add_cooldown()

	GLOB.round_statistics.spitter_acid_sprays++ //Statistics
	SSblackbox.record_feedback("tally", "round_statistics", 1, "spitter_acid_sprays")

	var/datum/action/ability/activable/xeno/spray = X.actions_by_path[/datum/action/ability/activable/xeno/spray_acid/cone]
	if(spray)
		spray.add_cooldown(10 SECONDS)

/datum/action/ability/activable/xeno/spray_acid/line/short/spray_turfs(list/turflist)
	set waitfor = FALSE

	if(isnull(turflist))
		return

	var/turf/prev_turf
	var/distance = 0

	for(var/X in turflist)
		var/turf/T = X

		if(!prev_turf && length(turflist) > 1)
			prev_turf = get_turf(owner)
			continue //So we don't burn the tile we be standin on

		for(var/obj/structure/barricade/B in prev_turf)
			if(get_dir(prev_turf, T) & B.dir)
				B.acid_spray_act(owner)

		if(T.density || isspaceturf(T))
			break

		var/blocked = FALSE
		for(var/obj/O in T)
			if(is_type_in_typecache(O, GLOB.acid_spray_hit) && O.acid_spray_act(owner))
				return // returned true if normal density applies
			if(O.density && !(O.allow_pass_flags & PASS_PROJECTILE) && !(O.flags_atom & ON_BORDER))
				blocked = TRUE
				break

		var/turf/TF
		if(!prev_turf.Adjacent(T) && (T.x != prev_turf.x || T.y != prev_turf.y)) //diagonally blocked, it will seek for a cardinal turf by the former target.
			blocked = TRUE
			var/turf/Ty = locate(prev_turf.x, T.y, prev_turf.z)
			var/turf/Tx = locate(T.x, prev_turf.y, prev_turf.z)
			for(var/turf/TB in shuffle(list(Ty, Tx)))
				if(prev_turf.Adjacent(TB) && !TB.density && !isspaceturf(TB))
					TF = TB
					break
			if(!TF)
				break
		else
			TF = T

		for(var/obj/structure/barricade/B in TF)
			if(get_dir(TF, prev_turf) & B.dir)
				B.acid_spray_act(owner)

		acid_splat_turf(TF)

		distance++
		if(distance > 3 || blocked)
			break

		prev_turf = T
		sleep(0.2 SECONDS)

/datum/action/ability/activable/xeno/spray_acid/line/short/acid_splat_turf(turf/T)
	. = locate(/obj/effect/xenomorph/spray) in T
	if(!.)
		var/mob/living/carbon/xenomorph/X = owner

		. = new /obj/effect/xenomorph/spray(T, 3 SECONDS, X.xeno_caste.acid_spray_damage, owner)

		for(var/i in T)
			var/atom/A = i
			if(!A)
				continue
			A.acid_spray_act(owner)
