GLOBAL_LIST_INIT(no_sticky_resin, typecacheof(list(/obj/item/clothing/mask/facehugger, /obj/alien/egg, /obj/structure/mineral_door, /obj/alien/resin, /obj/structure/bed/nest))) //For sticky/acid spit

/datum/ammo/xeno
	icon_state = "neurotoxin"
	ping = "ping_x"
	damage_type = TOX
	flags_ammo_behavior = AMMO_XENO
	var/added_spit_delay = 0 //used to make cooldown of the different spits vary.
	var/spit_cost = 5
	armor_type = BIO
	shell_speed = 1
	accuracy = 40
	accurate_range = 15
	max_range = 15
	accuracy_var_low = 3
	accuracy_var_high = 3
	bullet_color = COLOR_LIME
	///List of reagents transferred upon spit impact if any
	var/list/datum/reagent/spit_reagents
	///Amount of reagents transferred upon spit impact if any
	var/reagent_transfer_amount
	///Amount of stagger stacks imposed on impact if any
	var/stagger_stacks
	///Amount of slowdown stacks imposed on impact if any
	var/slowdown_stacks
	///These define the reagent transfer strength of the smoke caused by the spit, if any, and its aoe
	var/datum/effect_system/smoke_spread/xeno/smoke_system
	var/smoke_strength
	var/smoke_range
	///The hivenumber of this ammo
	var/hivenumber = XENO_HIVE_NORMAL

/datum/ammo/xeno/toxin
	name = "neurotoxic spit"
	flags_ammo_behavior = AMMO_XENO|AMMO_EXPLOSIVE|AMMO_SKIPS_ALIENS
	spit_cost = 55
	added_spit_delay = 0
	damage_type = STAMINA
	accurate_range = 5
	max_range = 10
	accuracy_var_low = 3
	accuracy_var_high = 3
	damage = 40
	stagger_stacks = 1.1 SECONDS
	slowdown_stacks = 1.5
	smoke_strength = 0.5
	smoke_range = 0
	reagent_transfer_amount = 4
	bullet_color = COLOR_LIGHT_ORANGE

///Set up the list of reagents the spit transfers upon impact
/datum/ammo/xeno/toxin/proc/set_reagents()
	spit_reagents = list(/datum/reagent/toxin/xeno_neurotoxin = reagent_transfer_amount)

/datum/ammo/xeno/toxin/on_hit_mob(mob/living/carbon/carbon_victim, obj/projectile/proj)
	drop_neuro_smoke(get_turf(carbon_victim))

	if(!istype(carbon_victim) || carbon_victim.stat == DEAD || carbon_victim.issamexenohive(proj.firer) )
		return

	if(isnestedhost(carbon_victim))
		return

	carbon_victim.adjust_stagger(stagger_stacks)
	carbon_victim.add_slowdown(slowdown_stacks)

	set_reagents()
	for(var/reagent_id in spit_reagents)
		spit_reagents[reagent_id] = carbon_victim.modify_by_armor(spit_reagents[reagent_id], armor_type, penetration, proj.def_zone)

	carbon_victim.reagents.add_reagent_list(spit_reagents)

	return ..()

/datum/ammo/xeno/toxin/on_hit_obj(obj/O, obj/projectile/P)
	var/turf/T = get_turf(O)
	drop_neuro_smoke(T.density ? P.loc : T)

/datum/ammo/xeno/toxin/on_hit_turf(turf/T, obj/projectile/P)
	drop_neuro_smoke(T.density ? P.loc : T)

/datum/ammo/xeno/toxin/do_at_max_range(turf/T, obj/projectile/P)
	drop_neuro_smoke(T.density ? P.loc : T)

/datum/ammo/xeno/toxin/set_smoke()
	smoke_system = new /datum/effect_system/smoke_spread/xeno/neuro/light()

/datum/ammo/xeno/toxin/proc/drop_neuro_smoke(turf/T)
	if(T.density)
		return

	set_smoke()
	smoke_system.strength = smoke_strength
	smoke_system.set_up(smoke_range, T)
	smoke_system.start()
	smoke_system = null

/datum/ammo/xeno/toxin/sent //Sentinel
	spit_cost = 70
	icon_state = "xeno_sent_neuro"

/datum/ammo/xeno/toxin/upgrade1
	smoke_strength = 0.6
	reagent_transfer_amount = 5

/datum/ammo/xeno/toxin/upgrade2
	smoke_strength = 0.7
	reagent_transfer_amount = 6

/datum/ammo/xeno/toxin/upgrade3
	smoke_strength = 0.75
	reagent_transfer_amount = 6.5

/datum/ammo/xeno/toxin/heavy //Praetorian
	name = "neurotoxic splash"
	added_spit_delay = 0
	spit_cost = 200
	damage = 80
	smoke_strength = 1
	reagent_transfer_amount = 18
	smoke_range = 1

/datum/ammo/xeno/sticky
	name = "sticky resin spit"
	icon_state = "sticky"
	ping = null
	flags_ammo_behavior = AMMO_SKIPS_ALIENS|AMMO_EXPLOSIVE|AMMO_XENO
	damage_type = STAMINA
	armor_type = BIO
	spit_cost = 50
	sound_hit = "alien_resin_build2"
	sound_bounce = "alien_resin_build3"
	damage = 20 //minor; this is mostly just to provide confirmation of a hit
	max_range = 40
	bullet_color = COLOR_PURPLE
	stagger_stacks = 2
	slowdown_stacks = 3

/datum/ammo/xeno/sticky/on_hit_mob(mob/M, obj/projectile/P)
	drop_resin(get_turf(M))
	if(istype(M,/mob/living/carbon))
		var/mob/living/carbon/C = M
		if(C.issamexenohive(P.firer))
			return
		C.adjust_stagger(stagger_stacks) //stagger briefly; useful for support
		C.add_slowdown(slowdown_stacks) //slow em down

/datum/ammo/xeno/sticky/on_hit_obj(obj/O, obj/projectile/P)
	if(isarmoredvehicle(O))
		var/obj/vehicle/sealed/armored/tank = O
		COOLDOWN_START(tank, cooldown_vehicle_move, tank.move_delay)
	var/turf/T = get_turf(O)
	drop_resin(T.density ? P.loc : T)

/datum/ammo/xeno/sticky/on_hit_turf(turf/T, obj/projectile/P)
	drop_resin(T.density ? P.loc : T)

/datum/ammo/xeno/sticky/do_at_max_range(turf/T, obj/projectile/P)
	drop_resin(T.density ? P.loc : T)

/datum/ammo/xeno/sticky/proc/drop_resin(turf/T)
	if(T.density || istype(T, /turf/open/space)) // No structures in space
		return

	for(var/obj/O in T.contents)
		if(is_type_in_typecache(O, GLOB.no_sticky_resin))
			return

	new /obj/alien/resin/sticky/thin(T)

/datum/ammo/xeno/sticky/turret
	max_range = 9

/datum/ammo/xeno/sticky/globe
	name = "sticky resin globe"
	icon_state = "sticky_globe"
	damage = 40
	max_range = 7
	spit_cost = 200
	added_spit_delay = 8 SECONDS
	bonus_projectiles_type = /datum/ammo/xeno/sticky/mini
	bonus_projectiles_scatter = 22
	var/bonus_projectile_quantity = 16
	var/bonus_projectile_range = 3
	var/bonus_projectile_speed = 1

/datum/ammo/xeno/sticky/mini
	damage = 5
	max_range = 3

/datum/ammo/xeno/sticky/globe/on_hit_obj(obj/O, obj/projectile/P)
	var/turf/initial_turf = O.density ? P.loc : get_turf(O)
	drop_resin(initial_turf)
	fire_directionalburst(P, P.firer, P.shot_from, bonus_projectile_quantity, bonus_projectile_range, bonus_projectile_speed, Get_Angle(P.firer, initial_turf))

/datum/ammo/xeno/sticky/globe/on_hit_turf(turf/T, obj/projectile/P)
	var/turf/initial_turf = T.density ? P.loc : T
	drop_resin(initial_turf)
	fire_directionalburst(P, P.firer, P.shot_from, bonus_projectile_quantity, bonus_projectile_range, bonus_projectile_speed, Get_Angle(P.firer, initial_turf))

/datum/ammo/xeno/sticky/globe/on_hit_mob(mob/M, obj/projectile/P)
	var/turf/initial_turf = get_turf(M)
	drop_resin(initial_turf)
	fire_directionalburst(P, P.firer, P.shot_from, bonus_projectile_quantity, bonus_projectile_range, bonus_projectile_speed, Get_Angle(P.firer, initial_turf))

/datum/ammo/xeno/sticky/globe/do_at_max_range(turf/T, obj/projectile/P)
	var/turf/initial_turf = T.density ? P.loc : T
	drop_resin(initial_turf)
	fire_directionalburst(P, P.firer, P.shot_from, bonus_projectile_quantity, bonus_projectile_range, bonus_projectile_speed, Get_Angle(P.firer, initial_turf))

/datum/ammo/xeno/acid
	name = "acid spit"
	icon_state = "xeno_acid_weak"
	sound_hit 	 = "acid_hit"
	sound_bounce = "acid_bounce"
	damage_type = BURN
	added_spit_delay = 5
	spit_cost = 50
	flags_ammo_behavior = AMMO_XENO|AMMO_EXPLOSIVE
	armor_type = ACID
	damage = 18
	max_range = 8
	bullet_color = COLOR_PALE_GREEN_GRAY
	///Duration of the acid puddles
	var/puddle_duration = 1 SECONDS //Lasts 1-3 seconds
	///Damage dealt by acid puddles
	var/puddle_acid_damage = XENO_DEFAULT_ACID_PUDDLE_DAMAGE

/datum/ammo/xeno/acid/on_shield_block(mob/victim, obj/projectile/proj)
	airburst(victim, proj)

/datum/ammo/xeno/acid/drop_nade(turf/T) //Leaves behind an acid pool; defaults to 1-3 seconds.
	if(T.density)
		return
	new /obj/effect/xenomorph/spray/weak(T, puddle_duration, puddle_acid_damage)

/datum/ammo/xeno/acid/medium
	name = "acid spatter"
	damage = 30
	flags_ammo_behavior = AMMO_XENO
	icon_state = "xeno_acid_normal"
	bullet_color = COLOR_VERY_PALE_LIME_GREEN

/datum/ammo/xeno/acid/medium/drop_nade(turf/T) //Leaves behind an acid pool; defaults to 1-3 seconds.
	if(T.density)
		return
	new /obj/effect/xenomorph/spray(T, puddle_duration, puddle_acid_damage)

/datum/ammo/xeno/acid/medium/passthrough //Spitter
	flags_ammo_behavior = AMMO_XENO|AMMO_SKIPS_ALIENS

/datum/ammo/xeno/acid/auto
	name = "light acid spatter"
	damage = 10
	damage_falloff = 0.3
	spit_cost = 25
	added_spit_delay = 0
	flags_ammo_behavior = AMMO_XENO|AMMO_EXPLOSIVE|AMMO_SKIPS_ALIENS

/datum/ammo/xeno/acid/auto/on_hit_mob(mob/M, obj/projectile/P)
	var/turf/T = get_turf(M)
	drop_nade(T.density ? P.loc : T)

/datum/ammo/xeno/acid/auto/on_hit_obj(obj/O, obj/projectile/P)
	drop_nade(O.density ? P.loc : get_turf(O))

/datum/ammo/xeno/acid/auto/on_hit_turf(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T)

/datum/ammo/xeno/acid/auto/do_at_max_range(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T)

/datum/ammo/xeno/acid/passthrough
	name = "acid spittle"
	damage = 20
	flags_ammo_behavior = AMMO_XENO|AMMO_SKIPS_ALIENS

/datum/ammo/xeno/acid/heavy
	name = "acid splash"
	added_spit_delay = 2
	spit_cost = 70
	damage = 30
	icon_state = "xeno_acid_strong"
	bullet_color = COLOR_ASSEMBLY_YELLOW

/datum/ammo/xeno/acid/heavy/drop_nade(turf/T) //Leaves behind an acid pool; defaults to 1-3 seconds.
	if(T.density)
		return
	new /obj/effect/xenomorph/spray/strong(T, puddle_duration, puddle_acid_damage)

/datum/ammo/xeno/acid/heavy/passthrough //Praetorian
	flags_ammo_behavior = AMMO_XENO|AMMO_EXPLOSIVE|AMMO_SKIPS_ALIENS

/datum/ammo/xeno/acid/heavy/turret
	damage = 20
	name = "acid turret splash"
	shell_speed = 2
	max_range = 9
	icon_state = "xeno_acid_weak"
	bullet_color = COLOR_PALE_GREEN_GRAY

/datum/ammo/xeno/acid/heavy/turret/drop_nade(turf/T) //Leaves behind an acid pool; defaults to 1-3 seconds.
	if(T.density)
		return
	new /obj/effect/xenomorph/spray/weak(T, puddle_duration, puddle_acid_damage)

/datum/ammo/xeno/acid/heavy/on_hit_mob(mob/M, obj/projectile/P)
	var/turf/T = get_turf(M)
	drop_nade(T.density ? P.loc : T)

/datum/ammo/xeno/acid/heavy/on_hit_obj(obj/O, obj/projectile/P)
	drop_nade(O.density ? P.loc : get_turf(O))

/datum/ammo/xeno/acid/heavy/on_hit_turf(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T)

/datum/ammo/xeno/acid/heavy/do_at_max_range(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T)

///For the Spitter's Scatterspit ability
/datum/ammo/xeno/acid/heavy/scatter
	damage = 20
	flags_ammo_behavior = AMMO_XENO|AMMO_EXPLOSIVE|AMMO_SKIPS_ALIENS
	bonus_projectiles_type = /datum/ammo/xeno/acid/heavy/scatter
	bonus_projectiles_amount = 6
	bonus_projectiles_scatter = 2
	max_range = 8
	puddle_duration = 1 SECONDS //Lasts 2-4 seconds
	icon_state = "xeno_acid_normal"
	bullet_color = COLOR_VERY_PALE_LIME_GREEN

/datum/ammo/xeno/acid/heavy/scatter/drop_nade(turf/T) //Leaves behind an acid pool; defaults to 1-3 seconds.
	if(T.density)
		return
	new /obj/effect/xenomorph/spray(T, puddle_duration, puddle_acid_damage)

/datum/ammo/xeno/acid/heavy/scatter/praetorian
	max_range = 5
	damage = 15
	puddle_duration = 0.5 SECONDS
	bonus_projectiles_amount = 3

/datum/ammo/xeno/boiler_gas
	name = "glob of gas"
	icon_state = "boiler_gas2"
	ping = "ping_x"
	///Key used for icon stuff during bombard ammo selection.
	var/icon_key = BOILER_GLOB_NEURO
	///This text will show up when a boiler selects this ammo. Span proc should be applied when this var is used.
	var/select_text = "We will now fire neurotoxic gas. This is nonlethal."
	flags_ammo_behavior = AMMO_XENO|AMMO_SKIPS_ALIENS|AMMO_EXPLOSIVE
	var/danger_message = span_danger("A glob of acid lands with a splat and explodes into noxious fumes!")
	armor_type = BIO
	accuracy_var_high = 10
	max_range = 30
	damage = 50
	damage_type = STAMINA
	damage_falloff = 0
	penetration = 40
	bullet_color = BOILER_LUMINOSITY_AMMO_NEUROTOXIN_COLOR
	reagent_transfer_amount = 30
	///On a direct hit, how long is the target paralyzed?
	var/hit_paralyze_time = 1 SECONDS
	///On a direct hit, how much do the victim's eyes get blurred?
	var/hit_eye_blur = 11
	///On a direct hit, how much drowsyness gets added to the target?
	var/hit_drowsyness = 12
	///Base spread range
	var/fixed_spread_range = 4
	///Which type is the smoke we leave on passed tiles, provided the projectile has AMMO_LEAVE_TURF enabled?
	var/passed_turf_smoke_type = /datum/effect_system/smoke_spread/xeno/neuro/light
	///We're going to reuse one smoke spread system repeatedly to cut down on processing.
	var/datum/effect_system/smoke_spread/xeno/trail_spread_system

/datum/ammo/xeno/boiler_gas/on_leave_turf(turf/T, atom/firer, obj/projectile/proj)
	if(isxeno(firer))
		var/mob/living/carbon/xenomorph/X = firer
		trail_spread_system.strength = X.xeno_caste.bomb_strength
	trail_spread_system.set_up(0, T)
	trail_spread_system.start()

/**
 * Loads a trap with a gas cloud depending on current glob type
 * Called when something with a boiler glob as current ammo interacts with an empty resin trap.
 * * Args:
 * * trap: The trap being loaded
 * * user_xeno: The xeno interacting with the trap
 * * Returns: TRUE on success, FALSE on failure.
**/
/datum/ammo/xeno/boiler_gas/proc/enhance_trap(obj/structure/xeno/trap/trap, mob/living/carbon/xenomorph/user_xeno)
	if(!do_after(user_xeno, 2 SECONDS, NONE, trap))
		return FALSE
	trap.set_trap_type(TRAP_SMOKE_NEURO)
	trap.smoke = new /datum/effect_system/smoke_spread/xeno/neuro/medium
	trap.smoke.set_up(2, get_turf(trap))
	return TRUE

/datum/ammo/xeno/boiler_gas/New()
	. = ..()
	if((flags_ammo_behavior & AMMO_LEAVE_TURF) && passed_turf_smoke_type)
		trail_spread_system = new passed_turf_smoke_type(only_once = FALSE)

/datum/ammo/xeno/boiler_gas/Destroy()
	if(trail_spread_system)
		QDEL_NULL(trail_spread_system)
	return ..()

///Set up the list of reagents the spit transfers upon impact
/datum/ammo/xeno/boiler_gas/proc/set_reagents()
	spit_reagents = list(/datum/reagent/toxin/xeno_neurotoxin = reagent_transfer_amount)

/datum/ammo/xeno/boiler_gas/on_hit_mob(mob/living/victim, obj/projectile/proj)
	var/turf/target_turf = get_turf(victim)
	drop_nade(target_turf.density ? proj.loc : target_turf, proj.firer)

	if(!istype(victim) || victim.stat == DEAD || victim.issamexenohive(proj.firer))
		return

	victim.Paralyze(hit_paralyze_time)
	victim.blur_eyes(hit_eye_blur)
	victim.adjustDrowsyness(hit_drowsyness)

	if(!reagent_transfer_amount || !iscarbon(victim))
		return

	var/mob/living/carbon/carbon_victim = victim
	set_reagents()
	for(var/reagent_id in spit_reagents)
		spit_reagents[reagent_id] = carbon_victim.modify_by_armor(spit_reagents[reagent_id], armor_type, penetration, proj.def_zone)

	carbon_victim.reagents.add_reagent_list(spit_reagents)

/datum/ammo/xeno/boiler_gas/on_hit_obj(obj/O, obj/projectile/P)
	if(ismecha(O))
		P.damage *= 7 //Globs deal much higher damage to mechs.
	var/turf/target_turf = get_turf(O)
	drop_nade(O.density ? P.loc : target_turf, P.firer)

/datum/ammo/xeno/boiler_gas/on_hit_turf(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T, P.firer) //we don't want the gas globs to land on dense turfs, they block smoke expansion.

/datum/ammo/xeno/boiler_gas/do_at_max_range(turf/T, obj/projectile/P)
	drop_nade(T.density ? P.loc : T, P.firer)

/datum/ammo/xeno/boiler_gas/set_smoke()
	smoke_system = new /datum/effect_system/smoke_spread/xeno/neuro()

/datum/ammo/xeno/boiler_gas/drop_nade(turf/T, atom/firer, range = 1)
	set_smoke()
	if(isxeno(firer))
		var/mob/living/carbon/xenomorph/X = firer
		smoke_system.strength = X.xeno_caste.bomb_strength
		range = fixed_spread_range
	smoke_system.set_up(range, T)
	smoke_system.start()
	smoke_system = null
	T.visible_message(danger_message)

/datum/ammo/xeno/boiler_gas/corrosive
	name = "glob of acid"
	icon_state = "boiler_gas"
	sound_hit 	 = "acid_hit"
	sound_bounce = "acid_bounce"
	icon_key = BOILER_GLOB_ACID
	select_text = "We will now fire corrosive acid. This is lethal!"
	flags_ammo_behavior = AMMO_XENO|AMMO_SKIPS_ALIENS|AMMO_EXPLOSIVE
	armor_type = ACID
	danger_message = span_danger("A glob of acid lands with a splat and explodes into corrosive bile!")
	damage = 50
	damage_type = BURN
	penetration = 40
	bullet_color = BOILER_LUMINOSITY_AMMO_CORROSIVE_COLOR
	hit_paralyze_time = 1 SECONDS
	hit_eye_blur = 1
	hit_drowsyness = 1
	reagent_transfer_amount = 0

/datum/ammo/xeno/boiler_gas/corrosive/enhance_trap(obj/structure/xeno/trap/trap, mob/living/carbon/xenomorph/user_xeno)
	if(!do_after(user_xeno, 3 SECONDS, NONE, trap))
		return FALSE
	trap.set_trap_type(TRAP_SMOKE_ACID)
	trap.smoke = new /datum/effect_system/smoke_spread/xeno/acid
	trap.smoke.set_up(1, get_turf(trap))
	return TRUE

/datum/ammo/xeno/boiler_gas/corrosive/on_shield_block(mob/victim, obj/projectile/proj)
	airburst(victim, proj)

/datum/ammo/xeno/boiler_gas/corrosive/set_smoke()
	smoke_system = new /datum/effect_system/smoke_spread/xeno/acid()

/datum/ammo/xeno/boiler_gas/lance
	name = "pressurized glob of gas"
	icon_key = BOILER_GLOB_NEURO_LANCE
	select_text = "We will now fire a pressurized neurotoxic lance. This is barely nonlethal."
	///As opposed to normal globs, this will pass by the target tile if they hit nothing.
	flags_ammo_behavior = AMMO_XENO|AMMO_SKIPS_ALIENS|AMMO_LEAVE_TURF
	danger_message = span_danger("A pressurized glob of acid lands with a nasty splat and explodes into noxious fumes!")
	max_range = 40
	damage = 75
	penetration = 60
	reagent_transfer_amount = 55
	passed_turf_smoke_type = /datum/effect_system/smoke_spread/xeno/neuro/light
	hit_paralyze_time = 2 SECONDS
	hit_eye_blur = 16
	hit_drowsyness = 18
	fixed_spread_range = 2
	accuracy = 100
	accurate_range = 30
	shell_speed = 1.5

/datum/ammo/xeno/boiler_gas/corrosive/lance
	name = "pressurized glob of acid"
	icon_key = BOILER_GLOB_ACID_LANCE
	select_text = "We will now fire a pressurized corrosive lance. This lethal!"
	///As opposed to normal globs, this will pass by the target tile if they hit nothing.
	flags_ammo_behavior = AMMO_XENO|AMMO_SKIPS_ALIENS|AMMO_LEAVE_TURF
	danger_message = span_danger("A pressurized glob of acid lands with a concerning hissing sound and explodes into corrosive bile!")
	max_range = 40
	damage = 75
	penetration = 60
	passed_turf_smoke_type = /datum/effect_system/smoke_spread/xeno/acid/light
	hit_paralyze_time = 1.5 SECONDS
	hit_eye_blur = 4
	hit_drowsyness = 2
	fixed_spread_range = 2
	accuracy = 100
	accurate_range = 30
	shell_speed = 1.5

/datum/ammo/xeno/hugger
	name = "hugger ammo"
	ping = ""
	flags_ammo_behavior = AMMO_XENO
	damage = 0
	max_range = 6
	shell_speed = 1
	bullet_color = ""
	icon_state = "facehugger"
	///The type of hugger thrown
	var/obj/item/clothing/mask/facehugger/hugger_type = /obj/item/clothing/mask/facehugger

/datum/ammo/xeno/hugger/on_hit_mob(mob/M, obj/projectile/proj)
	var/obj/item/clothing/mask/facehugger/hugger = new hugger_type(get_turf(M), hivenumber)
	hugger.go_idle()

/datum/ammo/xeno/hugger/on_hit_obj(obj/O, obj/projectile/proj)
	var/obj/item/clothing/mask/facehugger/hugger = new hugger_type(get_turf(O), hivenumber)
	hugger.go_idle()

/datum/ammo/xeno/hugger/on_hit_turf(turf/T, obj/projectile/P)
	var/obj/item/clothing/mask/facehugger/hugger = new hugger_type(T.density ? P.loc : T, hivenumber)
	hugger.go_idle()

/datum/ammo/xeno/hugger/do_at_max_range(turf/T, obj/projectile/P)
	var/obj/item/clothing/mask/facehugger/hugger = new hugger_type(T.density ? P.loc : T, hivenumber)
	hugger.go_idle()

/datum/ammo/xeno/hugger/slash
	hugger_type = /obj/item/clothing/mask/facehugger/combat/slash

/datum/ammo/xeno/hugger/neuro
	hugger_type = /obj/item/clothing/mask/facehugger/combat/neuro

/datum/ammo/xeno/hugger/resin
	hugger_type = /obj/item/clothing/mask/facehugger/combat/resin

/datum/ammo/xeno/hugger/acid
	hugger_type = /obj/item/clothing/mask/facehugger/combat/acid
