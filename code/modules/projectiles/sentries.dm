GLOBAL_LIST_INIT(sentry_ignore_List, set_sentry_ignore_List())

///Creates the list of atoms that will be ignored by sentry target pathing
/proc/set_sentry_ignore_List()
	. = list(
		/obj/machinery/deployable/mounted,
		/obj/machinery/miner,
	)
	. += typesof(/obj/hitbox)
	. += typesof(/obj/vehicle/sealed/armored/multitile)

/obj/machinery/deployable/mounted/sentry
	resistance_flags = UNACIDABLE|XENO_DAMAGEABLE
	use_power = 0
	req_one_access = list(ACCESS_MARINE_ENGINEERING, ACCESS_MARINE_ENGPREP, ACCESS_MARINE_LEADER)
	hud_possible = list(MACHINE_HEALTH_HUD, MACHINE_AMMO_HUD)
	///Spark system for making sparks
	var/datum/effect_system/spark_spread/spark_system
	///Camera for viewing with cam consoles
	var/obj/machinery/camera/camera
	///View and fire range of the sentry
	var/range = 7
	///Damage required to knock the sentry over and disable it
	var/knockdown_threshold = 150
	///List of targets that can be shot at
	var/list/atom/potential_targets = list()
	///Time of last alert
	var/last_alert = 0
	///Time of last fire
	var/last_fire = 0
	///Time of last damage alert
	var/last_damage_alert = 0
	///Radio so that the sentry can scream for help
	var/obj/item/radio/headset/mainship/radio
	///Iff signal of the sentry. If the /gun has a set IFF then this will be the same as that. If not the sentry will get its IFF signal from the deployer
	var/iff_signal = NONE
	///For minimap icon change if sentry is firing
	var/firing
	///Scan effect sound loop, when the turret is on
	var/datum/looping_sound/sentry_scan/soundloop

//------------------------------------------------------------------
//Setup and Deletion

/obj/machinery/deployable/mounted/sentry/Initialize(mapload, obj/item/_internal_item, mob/deployer)
	. = ..()
	var/obj/item/weapon/gun/gun = get_internal_item()
	soundloop = new(list(src))

	iff_signal = gun?.sentry_iff_signal ? gun.sentry_iff_signal : initial(iff_signal)
	if(deployer)
		var/mob/living/carbon/human/_deployer = deployer
		var/obj/item/card/id/id = _deployer.get_idcard(TRUE)
		iff_signal = id?.iff_signal
	if(deployer)
		faction = deployer.faction

	knockdown_threshold = gun?.knockdown_threshold ? gun.knockdown_threshold : initial(gun.knockdown_threshold)
	range = CHECK_BITFIELD(gun.turret_flags, TURRET_RADIAL) ?  gun.turret_range - 2 : gun.turret_range

	radio = new(src)

	spark_system = new /datum/effect_system/spark_spread
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)

	if(CHECK_BITFIELD(gun?.turret_flags, TURRET_INACCURATE))
		gun.accuracy_mult -= 0.15
		gun.scatter += 10

	if(CHECK_BITFIELD(gun?.turret_flags, TURRET_HAS_CAMERA))
		camera = new (src)
		camera.network = list("military")
		camera.c_tag = "[name] ([rand(0, 1000)])"

	GLOB.marine_turrets += src
	set_on(TRUE)

///Change minimap icon if its firing or not firing
/obj/machinery/deployable/mounted/sentry/proc/update_minimap_icon()
	SSminimaps.remove_marker(src)
	if(!z)
		return
	SSminimaps.add_marker(src, MINIMAP_FLAG_MARINE, image('icons/UI_icons/map_blips.dmi', null, "sentry[firing ? "_firing" : "_passive"]", MINIMAP_BLIPS_LAYER))

/obj/machinery/deployable/mounted/sentry/update_icon_state()
	. = ..()
	if(!CHECK_BITFIELD(machine_stat, KNOCKED_DOWN))
		return
	icon_state += "_f"

/obj/machinery/deployable/mounted/sentry/update_overlays()
	. = ..()
	if(machine_stat & EMPED)
		. += image('icons/effects/effects.dmi', src, "shieldsparkles")

/obj/machinery/deployable/mounted/sentry/Destroy()
	QDEL_NULL(radio)
	QDEL_NULL(camera)
	QDEL_NULL(spark_system)
	QDEL_NULL(soundloop)
	STOP_PROCESSING(SSobj, src)
	if(get_internal_item())
		var/obj/item/internal_sentry = get_internal_item()
		if(internal_sentry)
			UnregisterSignal(internal_sentry, COMSIG_MOB_GUN_FIRED)
	GLOB.marine_turrets -= src
	return ..()

/obj/machinery/deployable/mounted/sentry/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(!disassembled)
		cell_explosion(loc, 45, 15)
	return ..()

/obj/machinery/deployable/mounted/sentry/on_deconstruction()
	sentry_alert(SENTRY_ALERT_DESTROYED)
	return ..()

/obj/machinery/deployable/mounted/sentry/welder_act(mob/living/user, obj/item/I)
	return welder_repair_act(user, I, 50, 5 SECONDS)

/obj/machinery/deployable/mounted/sentry/AltClick(mob/user)
	if(!match_iff(user))
		to_chat(user, span_notice("Доступ запрещён."))
		return
	return ..()

//-----------------------------------------------------------------
// Interaction

/obj/machinery/deployable/mounted/sentry/on_set_interaction(mob/user)
	. = ..()
	to_chat(user, span_notice("Вы отключили ИИ [src] для перехода на ручное управление."))
	set_on(FALSE)

/obj/machinery/deployable/mounted/sentry/on_unset_interaction(mob/user)
	. = ..()
	to_chat(user, span_notice("Вы прекратили использовать [src], автоматика ИИ возобновляет работу."))
	set_on(TRUE)

/obj/machinery/deployable/mounted/sentry/attack_hand(mob/living/user)
	. = ..()
	if(!. || !CHECK_BITFIELD(machine_stat, KNOCKED_DOWN))
		return
	user.visible_message(span_notice("[user] начинает поднимать [src]."),
		span_notice("Вы начинаете поднимать [src].</span>"))

	if(!do_after(user, 2 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return

	user.visible_message(span_notice("[user] поднял [src] на место."),
		span_notice("Вы поставили [src] на место."))

	DISABLE_BITFIELD(machine_stat, KNOCKED_DOWN)
	density = initial(density)
	set_on(TRUE)

/obj/machinery/deployable/mounted/sentry/attack_ghost(mob/dead/observer/user)
	. = ..()
	ui_interact(user)
	update_static_data(user)

/obj/machinery/deployable/mounted/sentry/reload(mob/user, ammo_magazine)
	if(!match_iff(user)) //You can't pull the ammo out of hostile turrets
		to_chat(user, span_notice("Доступ запрещён."))
		return
	. = ..()
	update_static_data(user)

/obj/machinery/deployable/mounted/sentry/interact(mob/user, manual_mode = FALSE)
	if(!match_iff(user)) //You can't mess with hostile turrets
		to_chat(user, span_notice("Доступ запрещён."))
		return
	var/obj/item/weapon/gun/gun = get_internal_item()
	if(manual_mode)
		return ..()

	if(CHECK_BITFIELD(machine_stat, KNOCKED_DOWN))
		return TRUE

	if(CHECK_BITFIELD(gun?.turret_flags, TURRET_IMMOBILE))
		to_chat(user, span_warning("Панель управления [src] заблокирована."))
		return TRUE

	ui_interact(user)
	update_static_data(user)

/obj/machinery/deployable/mounted/sentry/ui_interact(mob/user, datum/tgui/ui)

	if(CHECK_BITFIELD(machine_stat, KNOCKED_DOWN))
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Sentry", "Sentry Gun")
		ui.open()

/obj/machinery/deployable/mounted/sentry/ui_data(mob/user)
	var/obj/item/weapon/gun/gun = get_internal_item()
	var/current_rounds
	current_rounds = gun?.rounds ? gun.rounds : 0
	. = list(
		"rounds" = current_rounds,
		"health" = obj_integrity
	)

/obj/machinery/deployable/mounted/sentry/ui_static_data(mob/user)
	var/obj/item/weapon/gun/gun = get_internal_item()
	var/rounds_max
	rounds_max = gun?.max_rounds ? gun.max_rounds : 0
	. = list(
		"name" = copytext(name, 2),
		"rounds_max" = rounds_max,
		"fire_mode" = gun?.gun_firemode ? gun.gun_firemode : initial(gun.gun_firemode),
		"health_max" = max_integrity,
		"safety_toggle" = CHECK_BITFIELD(gun.turret_flags, TURRET_SAFETY),
		"manual_override" = operator,
		"alerts_on" = CHECK_BITFIELD(gun.turret_flags, TURRET_ALERTS),
		"radial_mode" = CHECK_BITFIELD(gun.turret_flags, TURRET_RADIAL)
	)

/obj/machinery/deployable/mounted/sentry/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	var/obj/item/weapon/gun/gun = get_internal_item()
	if(isxeno(usr))
		return
	var/mob/living/user = usr
	if(!istype(user) || CHECK_BITFIELD(gun.turret_flags, TURRET_IMMOBILE) || CHECK_BITFIELD(machine_stat, KNOCKED_DOWN))
		return
	switch(action)
		if("safety")
			TOGGLE_BITFIELD(gun.turret_flags, TURRET_SAFETY)
			var/safe = CHECK_BITFIELD(gun.turret_flags, TURRET_SAFETY)
			user.visible_message(span_warning("[user] [safe ? "включ" : "отключ"]ил предокранитель у [src]."),
				span_warning("Вы [safe ? "включ" : "отключ"]или предохранитель у [src]</span>"))
			visible_message(span_warning("Красный светодиод на [src] ярко мигает!"))
			update_static_data(user)
			. = TRUE

		if("firemode")
			gun?.do_toggle_firemode(user)
			update_static_data(user)
			. = TRUE

		if("manual")
			if(isAI(user))
				return
			if(operator)
				user.unset_interaction()
			else
				interact(user, TRUE)
			update_static_data(user)
			. = TRUE

		if("toggle_alert")
			TOGGLE_BITFIELD(gun.turret_flags, TURRET_ALERTS)
			var/alert = CHECK_BITFIELD(gun.turret_flags, TURRET_ALERTS)
			user.visible_message(span_notice("[user] [alert ? "включ" : "отключ"]ил систему оповещений у [src]."),
				span_notice("Вы [alert ? "включ" : "отключ"]или систему оповещений [src]."))
			say("Система оповещений [alert ? "включена" : "отключена"]")
			update_static_data(user)
			. = TRUE

		if("toggle_radial")
			TOGGLE_BITFIELD(gun.turret_flags, TURRET_RADIAL)
			if(!CHECK_BITFIELD(gun.turret_flags, TURRET_RADIAL))
				range = gun.turret_range
			else
				range = gun.turret_range - 2
			var/rad_msg = CHECK_BITFIELD(gun.turret_flags, TURRET_RADIAL) ? "включ" : "отключ"
			user.visible_message(span_notice("[user] [rad_msg]ил  радиальный режим у [src]."), span_notice("Вы [rad_msg]или радиальный режим у [src]."))
			say("Радиальный режим [rad_msg]ён.")
			update_static_data(user)
			. = TRUE

	attack_hand(user)

///Handles turning the sentry ON and OFF. new_state is a bool
/obj/machinery/deployable/mounted/sentry/proc/set_on(new_state)
	var/obj/item/weapon/gun/gun = get_internal_item()
	if(!new_state)
		visible_message(span_notice("[name] выключается и затихает."))
		DISABLE_BITFIELD(gun.turret_flags, TURRET_ON)
		gun?.set_target(null)
		soundloop.stop()
		set_light(0)
		update_icon()
		STOP_PROCESSING(SSobj, src)
		if(gun)
			UnregisterSignal(gun, COMSIG_MOB_GUN_FIRED)
		return

	ENABLE_BITFIELD(gun?.turret_flags, TURRET_ON)
	soundloop.start()
	visible_message(span_notice("[name] включается и начинает жужжать."))
	set_light_range(initial(light_power))
	set_light_color(initial(light_color))
	set_light(SENTRY_LIGHT_POWER,SENTRY_LIGHT_POWER)
	update_icon()
	START_PROCESSING(SSobj, src)
	RegisterSignal(gun, COMSIG_MOB_GUN_FIRED, PROC_REF(check_next_shot))
	update_minimap_icon()

///Bonks the sentry onto its side. This currently is used here, and in /living/carbon/xeno/warrior/mob_abilities in punch
/obj/machinery/deployable/mounted/sentry/proc/knock_down()
	if(CHECK_BITFIELD(machine_stat, KNOCKED_DOWN))
		return
	sentry_stop_fire()
	visible_message(span_userdanger("[name] была опрокинута!"))
	sentry_alert(SENTRY_ALERT_FALLEN)
	playsound(loc, 'sound/items/turrets/turret_breakdown.ogg', 50, FALSE)
	ENABLE_BITFIELD(machine_stat, KNOCKED_DOWN)
	density = FALSE
	set_on(FALSE)
	update_icon()

/obj/machinery/deployable/mounted/sentry/take_damage(damage_amount, damage_type, damage_flag = null, effects, attack_dir, armour_penetration, mob/living/blame_mob)
	if(damage_amount <= 0)
		return
	if(prob(10))
		spark_system.start()
	if((damage_amount >= knockdown_threshold && damage_type != STAMINA) || (obj_integrity <= max_integrity * 0.25))
		knock_down() //Knocks if - 150 dmg at once or <25% health.
	if(world.time >= (last_damage_alert + 10 SECONDS))
		playsound(loc, 'sound/items/turrets/turret_lowammo.ogg', 50, FALSE)

	. = ..()
	if(!internal_item)
		return
	sentry_alert(SENTRY_ALERT_DAMAGE)
	update_icon()

/obj/machinery/deployable/mounted/sentry/emp_act(severity)
	. = ..()
	machine_stat |= EMPED
	playsound(loc, 'sound/magic/lightningshock.ogg', 50, FALSE)
	addtimer(CALLBACK(src, PROC_REF(remove_emp)), (5 - severity) * 2 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE) //will need to add something later to be additive or something
	update_appearance(UPDATE_OVERLAYS)

///Lifts EMP effects
/obj/machinery/deployable/mounted/sentry/proc/remove_emp()
	machine_stat &= ~EMPED
	update_appearance(UPDATE_OVERLAYS)
	playsound(loc, 'sound/machines/warning-buzzer.ogg', 50, FALSE)

//----------------------------------------------------------------------------
// Sentry Functions

///Sentry wants to scream for help.
/obj/machinery/deployable/mounted/sentry/proc/sentry_alert(alert_code, mob/mob)
	var/obj/item/weapon/gun/gun = get_internal_item()
	if(!gun)
		return
	if(!alert_code || !CHECK_BITFIELD(gun.turret_flags, TURRET_ALERTS) || !CHECK_BITFIELD(gun.turret_flags, TURRET_ON))
		return

	var/notice
	switch(alert_code)
		if(SENTRY_ALERT_HOSTILE)
			if(world.time < (last_alert + SENTRY_ALERT_DELAY))
				return
			notice = "<b>ALERT! [src] detected Hostile/Unknown: [mob.name] at: [AREACOORD_NO_Z(src)].</b>"
			last_alert = world.time
		if(SENTRY_ALERT_AMMO)
			if(world.time < (last_alert + SENTRY_ALERT_DELAY))
				return
			notice = "<b>ALERT! [src]'s ammo depleted at: [AREACOORD_NO_Z(src)].</b>"
			last_alert = world.time
		if(SENTRY_ALERT_FALLEN)
			notice = "<b>ALERT! [src] has been knocked over at: [AREACOORD_NO_Z(src)].</b>"
		if(SENTRY_ALERT_DAMAGE)
			if(world.time < (last_damage_alert + SENTRY_DAMAGE_ALERT_DELAY))
				return
			notice = "<b>ALERT! [src] has taken damage at: [AREACOORD_NO_Z(src)]. Remaining Structural Integrity: ([obj_integrity]/[max_integrity])[obj_integrity < 50 ? " CONDITION CRITICAL!!" : ""]</b>"
			last_damage_alert = world.time
		if(SENTRY_ALERT_DESTROYED)
			notice = "<b>ALERT! [src] at: [AREACOORD_NO_Z(src)] has been destroyed!</b>"

	radio.talk_into(src, "[notice]", FREQ_COMMON)

/obj/machinery/deployable/mounted/sentry/process()
	update_icon()
	if((machine_stat & EMPED) || !scan())
		sentry_stop_fire()
		return

	sentry_start_fire()

///Checks the nearby mobs for eligability. If they can be targets it stores them in potential_targets. Returns TRUE if there are targets, FALSE if not.
/obj/machinery/deployable/mounted/sentry/proc/scan()
	var/obj/item/weapon/gun/gun = get_internal_item()
	potential_targets.Cut()
	if(!gun)
		return FALSE
	for(var/mob/living/carbon/human/nearby_human AS in cheap_get_humans_near(src, range))
		if(nearby_human.faction != FACTION_ZOMBIE && (nearby_human.stat == DEAD || CHECK_BITFIELD(gun.turret_flags, TURRET_SAFETY)))
			continue
		if(CHECK_BITFIELD(nearby_human.status_flags, INCORPOREAL))
			continue
		if(nearby_human.wear_id?.iff_signal & iff_signal)
			continue
		if(HAS_TRAIT(nearby_human, TRAIT_STEALTH))
			continue
		potential_targets += nearby_human
	for(var/mob/living/carbon/xenomorph/nearby_xeno AS in cheap_get_xenos_near(src, range))
		if(nearby_xeno.stat == DEAD)
			continue
		if(HAS_TRAIT(nearby_xeno, TRAIT_STEALTH))
			continue
		if(CHECK_BITFIELD(nearby_xeno.status_flags, INCORPOREAL))
			continue
		if(CHECK_BITFIELD(nearby_xeno.xeno_iff_check(), iff_signal)) //So hiveminds wont be shot at when in phase shift
			continue
		potential_targets += nearby_xeno
	for(var/mob/illusion/nearby_illusion AS in cheap_get_illusions_near(src, range))
		potential_targets += nearby_illusion
	for(var/obj/vehicle/sealed/mecha/nearby_mech AS in cheap_get_mechs_near(src, range))
		var/list/driver_list = nearby_mech.return_drivers()
		if(!length(driver_list))
			continue
		var/mob/living/carbon/human/human_occupant = driver_list[1]
		if(human_occupant.wear_id?.iff_signal & iff_signal)
			continue
		potential_targets += nearby_mech
	for(var/obj/vehicle/sealed/armored/nearby_tank AS in cheap_get_tanks_near(src, range))
		var/list/driver_list = nearby_tank.return_drivers()
		if(!length(driver_list))
			continue
		var/mob/living/carbon/human/human_occupant = driver_list[1]
		if(human_occupant.wear_id?.iff_signal & iff_signal)
			continue
		potential_targets += nearby_tank
	return length(potential_targets)

///Checks the range and the path of the target currently being shot at to see if it is eligable for being shot at again. If not it will stop the firing.
/obj/machinery/deployable/mounted/sentry/proc/check_next_shot(datum/source, atom/gun_target, obj/item/weapon/gun/gun)
	SIGNAL_HANDLER
	var/obj/item/weapon/gun/internal_gun = get_internal_item()
	if(!internal_gun)
		return
	if(CHECK_BITFIELD(internal_gun.reciever_flags, AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION) && length(internal_gun.chamber_items))
		INVOKE_ASYNC(internal_gun, TYPE_PROC_REF(/obj/item/weapon/gun, do_unique_action))
	if(!CHECK_BITFIELD(internal_gun.deploy_flags, IS_DEPLOYED) || get_dist(src, gun_target) > range || (!CHECK_BITFIELD(get_dir(src, gun_target), dir) && !CHECK_BITFIELD(internal_gun.turret_flags, TURRET_RADIAL)) || !check_target_path(gun_target))
		sentry_stop_fire()
		return
	if(internal_gun.gun_firemode != GUN_FIREMODE_SEMIAUTO)
		return
	addtimer(CALLBACK(src, PROC_REF(sentry_start_fire)), internal_gun.fire_delay) //This schedules the next shot if the gun is on semi-automatic. This is so that semi-automatic guns don't fire once every two seconds.

///Sees if theres a target to shoot, then handles firing.
/obj/machinery/deployable/mounted/sentry/proc/sentry_start_fire()
	if(isclosedturf(loc) || CHECK_BITFIELD(machine_stat, KNOCKED_DOWN))
		sentry_stop_fire()
		return
	var/obj/item/weapon/gun/gun = get_internal_item()
	var/atom/target = get_target()
	if(!target)
		sentry_stop_fire()
		return
	sentry_alert(SENTRY_ALERT_HOSTILE, target)
	update_icon()
	if(target != gun.target)
		sentry_stop_fire()
	if(gun.rounds <= 0) //fucking lasers
		sentry_alert(SENTRY_ALERT_AMMO)
		return

	if(world.time >= (last_fire + 20 SECONDS))
		playsound(loc, 'sound/items/turrets/turret_fire.ogg', 50, TRUE, 20)
		sleep(5) //yes, its sleeping a bit before fire

	if(CHECK_BITFIELD(gun.turret_flags, TURRET_RADIAL))
		setDir(get_cardinal_dir(src, target))
	if(HAS_TRAIT(gun, TRAIT_GUN_BURST_FIRING))
		gun.set_target(target)
		return
	soundloop.stop()
	gun.start_fire(src, target, bypass_checks = TRUE)
	firing = TRUE
	last_fire = world.time
	update_minimap_icon()

///Ends firing
/obj/machinery/deployable/mounted/sentry/proc/sentry_stop_fire()
	var/obj/item/weapon/gun/gun = get_internal_item()
	gun?.stop_fire()
	firing = FALSE
	update_minimap_icon()

///Checks the path to the target for obstructions. Returns TRUE if the path is clear, FALSE if not.
/obj/machinery/deployable/mounted/sentry/proc/check_target_path(atom/target) //todo: this whole proc is giga stinky and can probably just use line_of_sight and check_path
	if(target.loc == loc)
		return TRUE
	var/turf/starting_turf = get_turf(src)
	var/list/turf/path = get_traversal_line(starting_turf, target)
	var/turf/target_turf = path[length(path)-1]
	path -= starting_turf
	if(!length(path))
		return FALSE

	var/old_turf_dir_to_us = get_dir(starting_turf, target_turf)
	if(ISDIAGONALDIR(old_turf_dir_to_us))
		for(var/i in 0 to 2)
			var/between_turf = get_step(target_turf, turn(old_turf_dir_to_us, i == 1 ? 45 : -45))
			if(can_see_through(starting_turf, between_turf))
				break
			if(i==2)
				return FALSE

	var/obj/item/weapon/gun/gun = get_internal_item()
	for(var/turf/path_turf AS in path)
		if(IS_OPAQUE_TURF(path_turf) || path_turf.density && !(path_turf.allow_pass_flags & PASS_PROJECTILE) && !(path_turf.type in GLOB.sentry_ignore_List))
			return FALSE

		for(var/atom/movable/AM AS in path_turf)
			if(AM == target)
				continue
			if(AM.opacity)
				return FALSE
			if(!AM.density)
				continue
			if(ismob(AM))
				continue
			if(AM.type in GLOB.sentry_ignore_List) //todo:accurately populate GLOB.sentry_ignore_List
				continue
			if(AM.allow_pass_flags & (gun.ammo_datum_type::ammo_behavior_flags  & AMMO_ENERGY ? (PASS_GLASS|PASS_PROJECTILE) : PASS_PROJECTILE))
				continue
			return FALSE

	return TRUE

///Works through potential targets. First checks if they are in range, and if they are friend/foe. Then checks the path to them. Returns the first eligable target.
/obj/machinery/deployable/mounted/sentry/proc/get_target()
	var/obj/item/weapon/gun/gun = get_internal_item()
	for(var/atom/nearby_target AS in potential_targets)
		if(nearby_target.loc == loc)
			return nearby_target

		if(!(get_dir(src, nearby_target) & dir) && !CHECK_BITFIELD(gun.turret_flags, TURRET_RADIAL))
			continue
		if(!check_target_path(nearby_target))
			continue
		return nearby_target

/obj/machinery/deployable/mounted/sentry/disassemble(mob/user)
	if(!match_iff(user)) //You can't steal other faction's turrets
		to_chat(user, span_notice("Доступ запрещён."))
		return
	var/obj/item/weapon/gun/internal_gun = get_internal_item()
	. = ..()
	if(!.)
		return
	if(internal_gun?.turret_flags & TURRET_INACCURATE)
		internal_gun.accuracy_mult += 0.15
		internal_gun.scatter -= 10


///Checks the users faction against turret IFF, used to stop hostile factions from interacting with turrets in ways they shouldn't.
/obj/machinery/deployable/mounted/sentry/proc/match_iff(mob/user)
	if(!user)
		return TRUE
	if((GLOB.faction_to_iff[user.faction] != iff_signal) && iff_signal) //You can't steal other faction's turrets
		return FALSE
	return TRUE

/obj/machinery/deployable/mounted/sentry/pre_crush_act(mob/living/carbon/xenomorph/charger, datum/action/ability/xeno_action/ready_charge/charge_datum)
	return (CHARGE_SPEED(charge_datum) * 50)

/obj/machinery/deployable/mounted/sentry/post_crush_act(mob/living/carbon/xenomorph/charger, datum/action/ability/xeno_action/ready_charge/charge_datum)
	knock_down()
	if(density)
		return PRECRUSH_STOPPED
	return PRECRUSH_PLOWED

/obj/machinery/deployable/mounted/sentry/buildasentry
	name = "broken build-a-sentry"
	desc = "You should not be seeing this unless a mapper, coder or admin screwed up."

/obj/machinery/deployable/mounted/sentry/buildasentry/Initialize(mapload, obj/item/_internal_item, mob/deployer) //I know the istype spam is a bit much, but I don't think there is a better way.
	. = ..()
	var/obj/item/internal_sentry = get_internal_item()
	if(internal_sentry)
		name = "Deployed " + internal_sentry.name
	icon = 'icons/obj/sentry.dmi'
	default_icon_state = "build_a_sentry"
	update_icon()

/obj/machinery/deployable/mounted/sentry/buildasentry/update_overlays()
	. = ..()
	var/obj/item/weapon/gun/internal_gun = get_internal_item()
	if(internal_gun)
		. += image('icons/obj/sentry.dmi', src, internal_gun.placed_overlay_iconstate, dir = dir)

//Throwable turret
/obj/machinery/deployable/mounted/sentry/cope
	density = FALSE

/obj/machinery/deployable/mounted/sentry/cope/sentry_start_fire()
	var/obj/item/weapon/gun/internal_gun = get_internal_item()
	internal_gun?.update_ammo_count() //checks if the battery has recharged enough to fire
	return ..()

/obj/machinery/deployable/mounted/sentry/cope/disassemble(mob/user)
	var/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/cope/internal_gun = get_internal_item()
	. = ..()
	if(!.)
		return
	internal_gun?.reset()
