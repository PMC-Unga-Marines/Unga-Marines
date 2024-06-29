/obj/structure/xeno/proc/weed_removed()
	SIGNAL_HANDLER
	var/obj/alien/weeds/found_weed = locate(/obj/alien/weeds) in loc
	if(found_weed.obj_integrity <= 0)
		obj_destruction(damage_flag = MELEE)
	else
		obj_destruction()

/obj/structure/xeno/ex_act(severity)
	take_damage(severity * 0.8, BRUTE, BOMB)

/obj/structure/xeno/silo
	plane = FLOOR_PLANE
	icon = 'modular_RUtgmc/icons/Xeno/resin_silo.dmi'

/obj/structure/xeno/silo/obj_destruction(damage_amount, damage_type, damage_flag)
	if(GLOB.hive_datums[hivenumber])
		INVOKE_NEXT_TICK(SSticker.mode, TYPE_PROC_REF(/datum/game_mode, update_silo_death_timer), GLOB.hive_datums[hivenumber]) // checks all silos next tick after this one is gone
	return ..()

/obj/structure/xeno/silo/LateInitialize()
	. = ..()
	if(GLOB.hive_datums[hivenumber])
		SSticker.mode.update_silo_death_timer(GLOB.hive_datums[hivenumber])

/obj/structure/xeno/silo/crash
	resistance_flags = UNACIDABLE | DROPSHIP_IMMUNE | PLASMACUTTER_IMMUNE | INDESTRUCTIBLE

/obj/structure/xeno/acidwell
	icon = 'modular_RUtgmc/icons/Xeno/acid_pool.dmi'
	plane = FLOOR_PLANE

/obj/structure/xeno/pherotower
	icon = 'modular_RUtgmc/icons/Xeno/1x1building.dmi'

/obj/structure/xeno/pherotower/crash
	name = "Recovery tower"
	resistance_flags = RESIST_ALL
	xeno_structure_flags = IGNORE_WEED_REMOVAL | CRITICAL_STRUCTURE

/obj/structure/xeno/pherotower/crash/attack_alien(isrightclick = FALSE)
	return

/obj/structure/xeno/pherotower/ex_act(severity)
	take_damage(severity * 2.5, BRUTE, BOMB)

/obj/structure/xeno/evotower/Initialize(mapload, _hivenumber)
	. = ..()
	SSminimaps.add_marker(src, MINIMAP_FLAG_XENO, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, "tower"))

/obj/structure/xeno/evotower/ex_act(severity)
	take_damage(severity * 2.5, BRUTE, BOMB)

/obj/structure/xeno/psychictower/Initialize(mapload, _hivenumber)
	. = ..()
	SSminimaps.add_marker(src, MINIMAP_FLAG_XENO, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, "tower"))

/obj/structure/xeno/psychictower/ex_act(severity)
	take_damage(severity * 2.5, BRUTE, BOMB)

/obj/structure/xeno/plant
	icon = 'modular_RUtgmc/icons/Xeno/plants.dmi'

/obj/structure/xeno/plant/Initialize(mapload, _hivenumber)
	. = ..()
	SSminimaps.add_marker(src, MINIMAP_FLAG_XENO, image('modular_RUtgmc/icons/UI_icons/map_blips.dmi', null, "[mature_icon_state]"))

/obj/structure/xeno/trap/ex_act(severity)
	take_damage(severity, BRUTE, BOMB)

//Sentient facehugger can get in the trap
/obj/structure/xeno/trap/attack_facehugger(mob/living/carbon/xenomorph/facehugger/F, isrightclick = FALSE)
	. = ..()
	if(tgui_alert(F, "Do you want to get into the trap?", "Get inside the trap", list("Yes", "No")) != "Yes")
		return

	if(trap_type)
		F.balloon_alert(F, "The trap is occupied")
		return

	var/obj/item/clothing/mask/facehugger/FH = new(src)
	FH.go_idle(TRUE)
	hugger = FH
	set_trap_type(TRAP_HUGGER)

	F.visible_message(span_xenowarning("[F] slides back into [src]."),span_xenonotice("You slides back into [src]."))
	F.ghostize()
	F.death(deathmessage = "get inside the trap", silent = TRUE)
	qdel(F)

/obj/structure/xeno/tunnel/attack_facehugger(mob/living/carbon/xenomorph/facehugger/F, isrightclick = FALSE)
	attack_alien(F)

/obj/structure/xeno/spawner
	icon = 'modular_RUtgmc/icons/Xeno/2x2building.dmi.dmi'
	bound_width = 64
	bound_height = 64
	plane = FLOOR_PLANE

/obj/structure/xeno/spawner/Initialize(mapload)
	. = ..()
	set_light(2, 2, LIGHT_COLOR_GREEN)

/obj/structure/xeno/thick_nest
	name = "thick resin nest"
	desc = "A very thick nest, oozing with a thick sticky substance."
	pixel_x = -8
	pixel_y = -8
	max_integrity = 400
	mouse_opacity = MOUSE_OPACITY_ICON

	icon = 'modular_RUtgmc/icons/Xeno/nest.dmi'
	icon_state = "reinforced_nest"
	layer = 2.5

	var/obj/structure/bed/nest/structure/pred_nest

/obj/structure/xeno/thick_nest/examine(mob/user)
	. = ..()
	if((isxeno(user) || isobserver(user)) && hivenumber)
		. += "Used to secure formidable hosts."

/obj/structure/xeno/thick_nest/Initialize(mapload, new_hivenumber)
	. = ..()
	if(new_hivenumber)
		hivenumber = new_hivenumber

	var/datum/hive_status/hive_ref = GLOB.hive_datums[hivenumber]
	if(hive_ref)
		hive_ref.thick_nests += src

	pred_nest = new /obj/structure/bed/nest/structure(loc, hive_ref, src) // Nest cannot be destroyed unless the structure itself is destroyed


/obj/structure/xeno/thick_nest/Destroy()
	. = ..()

	if(hivenumber)
		GLOB.hive_datums[hivenumber].thick_nests -= src

	pred_nest?.linked_structure = null
	QDEL_NULL(pred_nest)

/obj/structure/bed/nest
	var/force_nest = FALSE

/obj/structure/bed/nest/structure
	name = "thick alien nest"
	desc = "A very thick nest, oozing with a thick sticky substance."
	force_nest = TRUE
	var/obj/structure/xeno/thick_nest/linked_structure

/obj/structure/bed/nest/structure/Initialize(mapload, hive, obj/structure/xeno/thick_nest/to_link)
	. = ..()
	if(to_link)
		linked_structure = to_link
		max_integrity = linked_structure.max_integrity

/obj/structure/bed/nest/structure/Destroy()
	. = ..()
	if(linked_structure)
		linked_structure.pred_nest = null
		QDEL_NULL(linked_structure)

/obj/structure/bed/nest/structure/attack_hand(mob/user)
	if(!isxeno(user))
		to_chat(user, span_notice("The sticky resin is too strong for you to do anything to this nest"))
		return FALSE
	. = ..()

/obj/structure/xeno/acidwell/acid_well_fire_interaction()
	if(!charges)
		take_damage(50, BURN, FIRE)
		return

	charges--
	update_icon()
	var/turf/T = get_turf(src)
	var/datum/effect_system/smoke_spread/xeno/acid/extuingishing/acid_smoke = new(T) //spawn acid smoke when charges are actually used
	acid_smoke.set_up(0, src) //acid smoke in the immediate vicinity
	acid_smoke.start()

	for(var/obj/flamer_fire/F in T) //Extinguish all flames in turf
		qdel(F)

/obj/structure/xeno/acidwell/HasProximity(atom/movable/AM)
	if(!charges)
		return
	if(!isliving(AM))
		return
	var/mob/living/stepper = AM
	if(stepper.stat == DEAD)
		return

	var/charges_used = 0

	for(var/obj/item/explosive/grenade/sticky/sticky_bomb in stepper.contents)
		if(charges_used >= charges)
			break
		if(sticky_bomb.stuck_to == stepper)
			sticky_bomb.clean_refs()
			sticky_bomb.forceMove(loc) // i'm not sure if this is even needed, but just to prevent possible bugs
			visible_message(span_danger("[src] sizzles as [sticky_bomb] melts down in the acid."))
			qdel(sticky_bomb)
			charges_used ++

	if(stepper.on_fire && (charges_used < charges))
		stepper.ExtinguishMob()
		charges_used ++

	if(!isxeno(stepper))
		stepper.next_move_slowdown += charges * 2 //Acid spray has slow down so this should too; scales with charges, Min 2 slowdown, Max 10
		stepper.apply_damage(charges * 10, BURN, BODY_ZONE_PRECISE_L_FOOT, ACID,  penetration = 33)
		stepper.apply_damage(charges * 10, BURN, BODY_ZONE_PRECISE_R_FOOT, ACID,  penetration = 33)
		stepper.visible_message(span_danger("[stepper] is immersed in [src]'s acid!") , \
		span_danger("We are immersed in [src]'s acid!") , null, 5)
		playsound(stepper, "sound/bullets/acid_impact1.ogg", 10 * charges)
		new /obj/effect/temp_visual/acid_bath(get_turf(stepper))
		charges_used = charges //humans stepping on it empties it out

	if(!charges_used)
		return

	var/datum/effect_system/smoke_spread/xeno/acid/extuingishing/acid_smoke
	acid_smoke = new(get_turf(stepper)) //spawn acid smoke when charges are actually used
	acid_smoke.set_up(0, src) //acid smoke in the immediate vicinity
	acid_smoke.start()

	charges -= charges_used
	update_icon()

/obj/structure/xeno/xeno_turret/ex_act(severity)
	take_damage(severity * 3, BRUTE, BOMB)

/obj/structure/xeno/xeno_turret/obj_destruction(damage_amount, damage_type, damage_flag)
	if(damage_amount) //Spawn effects only if we actually get destroyed by damage
		on_destruction()
	return ..()

/obj/structure/xeno/xeno_turret/proc/on_destruction()
	var/datum/effect_system/smoke_spread/xeno/smoke = new /datum/effect_system/smoke_spread/xeno/acid(src)
	smoke.set_up(1, get_turf(src))
	smoke.start()

/obj/structure/xeno/xeno_turret/sticky/on_destruction()
	for(var/i = 1 to 20) // maybe a bit laggy
		var/obj/projectile/new_proj = new(src)
		new_proj.generate_bullet(ammo)
		new_proj.fire_at(null, src, range = rand(1, 4), angle = rand(1, 360), recursivity = TRUE)

/obj/structure/xeno/xeno_turret/hugger_turret/on_destruction()
	for(var/i = 1 to 5)
		var/obj/projectile/new_proj = new(src)
		new_proj.generate_bullet(ammo)
		new_proj.fire_at(null, src, range = rand(1, 3), angle = rand(1, 360), recursivity = TRUE)
