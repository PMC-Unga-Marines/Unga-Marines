/obj/vehicle/unmanned
	name = "UV-L Iguana"
	desc = "A small remote-controllable vehicle, usually owned by the TGMC and other major armies."
	icon = 'icons/obj/unmanned_vehicles.dmi'
	icon_state = "light_uv"
	anchored = FALSE
	buckle_flags = null
	light_range = 6
	light_power = 3
	light_system = MOVABLE_LIGHT
	move_delay = 2	//set this to limit the speed of the vehicle
	max_integrity = IGUANA_MAX_INTEGRITY
	hud_possible = list(MACHINE_HEALTH_HUD, MACHINE_AMMO_HUD)
	atom_flags = BUMP_ATTACKABLE
	soft_armor = list(MELEE = 25, BULLET = 85, LASER = 85, ENERGY = 85, BOMB = 50, BIO = 100, FIRE = 25, ACID = 25)
	allow_pass_flags = PASS_AIR|PASS_LOW_STRUCTURE|PASS_THROW
	faction = FACTION_TERRAGOV
	/// Needed to keep track of any slowdowns and/or diagonal movement
	var/next_move_delay = 0
	/// Path of "turret" attached
	var/obj/item/uav_turret/turret_path
	/// Type of the turret attached
	var/turret_type
	///Turret types we're allowed to attach
	var/turret_pattern = PATTERN_TRACKED
	/// If that vehicle can interact with cades
	var/can_interact = FALSE
	///Delay in byond ticks between weapon fires
	var/fire_delay = 5
	///Ammo remaining for the robot
	var/current_rounds = 0
	///max ammo the robot can hold
	var/max_rounds = 0
	///Buller type we fire, declared as type but set to a reference in Initialize
	var/datum/ammo/bullet/ammo
	///The currently loaded and ready to fire projectile
	var/atom/movable/projectile/in_chamber = null
	///Sound file or string type for playing the shooting sound
	var/gunnoise = SFX_GUN_SMARTGUN
	/// Serial number of the vehicle
	var/static/serial = 1
	/// If the vehicle should spawn with a weapon allready installed
	var/obj/item/uav_turret/spawn_equipped_type = null
	/// If something is already controlling the vehicle
	var/controlled = FALSE
	/// Flags for unmanned vehicules
	var/unmanned_flags = OVERLAY_TURRET|HAS_HEADLIGHTS|NEED_BATTERY
	/// Iff flags, to prevent friendly fire from sg and aiming marines
	var/iff_signal = TGMC_LOYALIST_IFF
	/// If explosives should be usable on the vehicle
	var/allow_explosives = TRUE
	/// Whether this vehicle is affected by sticky weed slowdown
	var/affected_by_sticky_weeds = TRUE
	/// Power cell for vehicle operation
	var/obj/item/cell/battery = null
	/// Power consumption per movement action
	var/power_per_move = 4
	/// Power consumption per shot fired
	var/power_per_shot = 12
	/// Additional slowdown from sticky weeds
	var/weed_slowdown = 0
	/// muzzleflash stuff
	var/atom/movable/vis_obj/effect/muzzle_flash/flash
	COOLDOWN_DECLARE(fire_cooldown)

/obj/vehicle/unmanned/Initialize(mapload, _internal_item, mob/deployer)
	. = ..()
	ammo = GLOB.ammo_list[ammo]
	name += " " + num2text(serial)
	serial++
	flash = new /atom/movable/vis_obj/effect/muzzle_flash(src)
	if(!is_centcom_level(loc.z))
		GLOB.unmanned_vehicles += src
	// Initialize with a charged battery
	if(unmanned_flags & NEED_BATTERY)
		battery = new /obj/item/cell/unmanned_vehicle(src)
	prepare_huds()
	hud_set_machine_health()
	if(spawn_equipped_type)
		turret_path = spawn_equipped_type
		turret_type = initial(spawn_equipped_type.turret_type)
		ammo = GLOB.ammo_list[initial(spawn_equipped_type.ammo_type)]
		fire_delay = initial(spawn_equipped_type.fire_delay)
		current_rounds = initial(spawn_equipped_type.max_rounds)
		max_rounds = initial(spawn_equipped_type.max_rounds)
		update_icon()
	hud_set_uav_ammo()
	if(deployer)
		faction = deployer.faction
	SSminimaps.add_marker(src, GLOB.faction_to_minimap_flag[faction], image('icons/UI_icons/map_blips.dmi', null, "uav", MINIMAP_BLIPS_LAYER))
	var/datum/atom_hud/sentry_status_hud = GLOB.huds[GLOB.faction_to_data_hud[faction]]
	if(sentry_status_hud)
		sentry_status_hud.add_to_hud(src)

/obj/vehicle/unmanned/Destroy()
	GLOB.unmanned_vehicles -= src
	QDEL_NULL(flash)
	QDEL_NULL(in_chamber)
	QDEL_NULL(battery)
	return ..()

/obj/vehicle/unmanned/obj_destruction(damage_amount, damage_type, damage_flag, mob/living/blame_mob)
	robogibs(src)
	return ..()

/obj/vehicle/unmanned/take_damage(damage_amount, damage_type, damage_flag = null, effects, attack_dir, armour_penetration, mob/living/blame_mob)
	. = ..()
	hud_set_machine_health()

/obj/vehicle/unmanned/repair_damage(repair_amount)
	. = ..()
	hud_set_machine_health()

/obj/vehicle/unmanned/update_overlays()
	. = ..()
	if(!(unmanned_flags & OVERLAY_TURRET))
		return
	switch(turret_type)
		if(TURRET_TYPE_HEAVY)
			. += image('icons/obj/unmanned_vehicles.dmi', src, "heavy_cannon")
		if(TURRET_TYPE_LIGHT)
			. += image('icons/obj/unmanned_vehicles.dmi', src, "light_cannon")
		if(TURRET_TYPE_EXPLOSIVE)
			. += image('icons/obj/unmanned_vehicles.dmi', src, "bomb")
		if(TURRET_TYPE_DROIDLASER)
			. += image('icons/obj/unmanned_vehicles.dmi', src, "droidlaser")
		if(TURRET_TYPE_CLAW)
			. += image('icons/obj/unmanned_vehicles.dmi', src, "claw")

/obj/vehicle/unmanned/examine(mob/user, distance, infix, suffix)
	. = ..()
	if(current_rounds > 0)
		. += "It has [current_rounds] shots left."
	switch(turret_type)
		if(TURRET_TYPE_LIGHT)
			. += "It is equipped with a light weapon system. It uses 11x35mm ammo."
		if(TURRET_TYPE_HEAVY)
			. += "It is equipped with a heavy weapon system. It uses 12x40mm ammo."
		if(TURRET_TYPE_EXPLOSIVE)
			. += "It is equipped with an explosive weapon system. "
		if(TURRET_TYPE_DROIDLASER)
			. += "It is equipped with a droid weapon system. It uses 11x35mm ammo."
		if(TURRET_TYPE_CLAW)
			. += "It is equipped with a mechanical claw system for grabbing and pulling objects and bodies."
	if(unmanned_flags & NEED_BATTERY)
		if(battery)
			. += "Battery: [round(battery.percent())]% charge remaining."
		else
			. += span_warning("No battery installed!")
		. += "Use a screwdriver to replace the battery."

/obj/vehicle/unmanned/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(istype(I, /obj/item/uav_turret))
		return equip_turret(I, user)
	if(istype(I, /obj/item/explosive/plastique) && allow_explosives)
		return equip_turret(I, user)
	if(istype(I, /obj/item/ammo_magazine))
		return reload_turret(I, user)
	if(unmanned_flags & NEED_BATTERY)
		if(istype(I, /obj/item/cell/unmanned_vehicle))
			return insert_battery(I, user)

/obj/vehicle/unmanned/relaymove(mob/living/user, direction)
	if(user.incapacitated())
		return FALSE

	// Check if battery has enough power
	if(unmanned_flags & NEED_BATTERY)
		if(!battery || !battery.use(power_per_move))
			to_chat(user, span_warning("[src] is out of power!"))
			return FALSE

	// Apply weed slowdown to the movement delay calculation
	var/total_delay = next_move_delay + weed_slowdown
	if(world.time < last_move_time + total_delay)
		return

	. = Move(get_step(src, direction))

	if(ISDIAGONALDIR(direction)) //moved diagonally successfully
		next_move_delay = move_delay * DIAG_MOVEMENT_ADDED_DELAY_MULTIPLIER
	else
		next_move_delay = move_delay

	// Decay weed slowdown over time
	if(weed_slowdown > 0)
		weed_slowdown = max(0, weed_slowdown - 1)

///Try to desequip the turret
/obj/vehicle/unmanned/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(!turret_path)
		to_chat(user,span_warning("There is nothing to remove from [src]!"))
		return
	user.visible_message(span_notice("[user] starts to remove [initial(turret_path.name)] from [src]"),	span_notice("You start to remove [initial(turret_path.name)] from [src]"))
	if(!do_after(user, 3 SECONDS, NONE, src))
		return
	var/obj/item/equipment = new turret_path
	user.visible_message(span_notice("[user] removes [equipment] from [src]."),
	span_notice("You remove [equipment] from [src]."))
	user.put_in_hands(equipment)
	if(istype(equipment, /obj/item/uav_turret))
		var/obj/item/uav_turret/turret = equipment
		turret.current_rounds = current_rounds
	turret_path = null
	turret_type = null
	current_rounds = 0
	max_rounds = 0
	update_icon()
	hud_set_uav_ammo()
	return

///Insert a new battery into the vehicle
/obj/vehicle/unmanned/proc/insert_battery(obj/item/cell/unmanned_vehicle/new_battery, mob/user)
	if(battery)
		to_chat(user, span_warning("[src] already has a battery installed!"))
		return
	user.visible_message(span_notice("[user] starts to install [new_battery] into [src]."), span_notice("You start to install [new_battery] into [src]."))
	if(!do_after(user, 3 SECONDS, NONE, src))
		return
	battery = new_battery
	user.transferItemToLoc(new_battery, src)
	user.visible_message(span_notice("[user] installs [new_battery] into [src]."), span_notice("You install [new_battery] into [src]."))
	playsound(loc, 'sound/items/ratchet.ogg', 25, 1)

///Try to remove/replace the battery with a screwdriver
/obj/vehicle/unmanned/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(unmanned_flags & NEED_BATTERY)
		return
	if(!battery)
		to_chat(user, span_warning("There is no battery to remove from [src]!"))
		return
	user.visible_message(span_notice("[user] starts to remove the battery from [src]."), span_notice("You start to remove the battery from [src]."))
	if(!do_after(user, 3 SECONDS, NONE, src))
		return
	var/obj/item/cell/removed_battery = battery
	battery = null
	removed_battery.forceMove(loc)
	user.visible_message(span_notice("[user] removes [removed_battery] from [src]."), span_notice("You remove [removed_battery] from [src]."))
	playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
	if(user.put_in_hands(removed_battery))
		to_chat(user, span_notice("You take [removed_battery]."))

///Try to reload the turret of our vehicule
/obj/vehicle/unmanned/proc/reload_turret(obj/item/ammo_magazine/reload_ammo, mob/user)
	if(!ispath(reload_ammo.type, initial(turret_path.magazine_type)))
		to_chat(user, span_warning("This is not the right ammo!"))
		return
	if(max_rounds == current_rounds)
		to_chat(user, span_warning("The [src] ammo storage is already full!"))
		return
	user.visible_message(span_notice("[user] starts to reload [src] with [reload_ammo]."), span_notice("You start to reload [src] with [reload_ammo]."))
	if(!do_after(user, 3 SECONDS, NONE, src))
		return
	current_rounds = current_rounds + reload_ammo.current_rounds
	if(current_rounds > max_rounds)
		var/extra_rounds = current_rounds - max_rounds
		reload_ammo.current_rounds = extra_rounds
		current_rounds = max_rounds
	else
		qdel(reload_ammo)
	user.visible_message(span_notice("[user] reloads [src] with [reload_ammo]."), span_notice("You reload [src] with [reload_ammo]. It now has [current_rounds] shots left out of a maximum of [max_rounds]."))
	playsound(loc, 'sound/weapons/guns/interact/smartgun_unload.ogg', 25, 1)
	update_icon()
	hud_set_uav_ammo()

/// Try to equip a turret on the vehicle
/obj/vehicle/unmanned/proc/equip_turret(obj/item/I, mob/user)
	if(turret_path)
		to_chat(user, span_notice("There's already something attached!"))
		return
	if(istype(I, /obj/item/uav_turret))
		var/obj/item/uav_turret/turret = I
		if(turret_pattern != turret.turret_pattern)
			to_chat(user, span_notice("You can't attach that type of turret!"))
			return
	user.visible_message(span_notice("[user] starts to attach [I] to [src]."),
	span_notice("You start to attach [I] to [src]."))
	if(!do_after(user, 3 SECONDS, NONE, src, BUSY_ICON_GENERIC))
		return
	turret_path = I.type
	if(istype(I, /obj/item/uav_turret))
		var/obj/item/uav_turret/turret = I
		ammo = GLOB.ammo_list[turret.ammo_type]
		turret_type = turret.turret_type
		fire_delay = turret.fire_delay
		current_rounds = turret.current_rounds
		max_rounds = turret.max_rounds
		hud_set_uav_ammo()
	else
		turret_type = TURRET_TYPE_EXPLOSIVE
	user.visible_message(span_notice("[user] attaches [I] to [src]."),
	span_notice("You attach [I] to [src]."))
	update_icon()
	SEND_SIGNAL(src, COMSIG_UNMANNED_TURRET_UPDATED, turret_type)
	qdel(I)

/**
 * Called when the drone is linked from a remote control
 */
/obj/vehicle/unmanned/proc/on_link(atom/remote_controller)
	SHOULD_CALL_PARENT(TRUE)
	RegisterSignal(src, COMSIG_REMOTECONTROL_CHANGED, PROC_REF(on_remote_toggle))
	controlled = TRUE

/**
 * Called when the drone is unlinked to a remote control
 */
/obj/vehicle/unmanned/proc/on_unlink(atom/remote_controller)
	SHOULD_CALL_PARENT(TRUE)
	UnregisterSignal(src, COMSIG_REMOTECONTROL_CHANGED)
	controlled = FALSE

///Called when remote control is taken
/obj/vehicle/unmanned/proc/on_remote_toggle(datum/source, is_on, mob/user)
	SIGNAL_HANDLER
	if(unmanned_flags & HAS_HEADLIGHTS)
		set_light_on(is_on)
	if(unmanned_flags & GIVE_NIGHT_VISION)
		if(is_on)
			ADD_TRAIT(user, TRAIT_SEE_IN_DARK, UNMANNED_VEHICLE)
		else
			REMOVE_TRAIT(user, TRAIT_SEE_IN_DARK, UNMANNED_VEHICLE)

///Checks if we can or already have a bullet loaded that we can shoot
/obj/vehicle/unmanned/proc/load_into_chamber()
	if(in_chamber)
		return TRUE //Already set!
	if(current_rounds <= 0)
		return FALSE
	in_chamber = new /atom/movable/projectile(src) //New bullet!
	in_chamber.generate_bullet(ammo)
	return TRUE

///Check if we have/create a new bullet and fire it at an atom target
/obj/vehicle/unmanned/proc/fire_shot(atom/target, mob/user)
	if(!COOLDOWN_CHECK(src, fire_cooldown))
		return FALSE
	// Check if battery has enough power to fire
	if(unmanned_flags & NEED_BATTERY)
		if(!battery || !battery.use(power_per_shot))
			to_chat(user, span_warning("[src] is out of power!"))
			return FALSE
	if(load_into_chamber() && istype(in_chamber, /atom/movable/projectile))
		//Setup projectile
		in_chamber.original_target = target
		in_chamber.def_zone = pick("chest","chest","chest","head")
		//Shoot at the thing
		var/angle = Get_Angle(src, target)
		playsound(loc, gunnoise, 65, 1)
		in_chamber.fire_at(target, user, src, ammo.max_range, ammo.shell_speed)
		in_chamber = null
		COOLDOWN_START(src, fire_cooldown, fire_delay)
		current_rounds--
		flash.transform = null
		flash.transform = turn(flash.transform, angle)
		vis_contents += flash
		addtimer(CALLBACK(src, PROC_REF(delete_muzzle_flash)), 0.2 SECONDS)
		hud_set_uav_ammo()
	return TRUE

///Removes muzzle flash from unmanned vehicles
/obj/vehicle/unmanned/proc/delete_muzzle_flash()
	vis_contents -= flash

///Uses the claw to grab and pull objects or mobs
/obj/vehicle/unmanned/proc/use_claw(atom/target, mob/user)
	if(!COOLDOWN_CHECK(src, fire_cooldown))
		return FALSE
	// Check if battery has enough power to operate claw
	if(!battery || !battery.use(power_per_shot))
		to_chat(user, span_warning("[src] is out of power!"))
		return FALSE

	if(target == pulling)
		stop_pulling(target)
		COOLDOWN_START(src, fire_cooldown, fire_delay)
		return TRUE

	// Check if target is adjacent
	if(!Adjacent(target))
		to_chat(user, span_warning("Target is too far away!"))
		return FALSE

	// Handle pulling different types of targets
	if(ismob(target))
		var/mob/M = target
		if(M.pulledby)
			M.pulledby.stop_pulling()
		start_pulling(M)
		to_chat(user, span_notice("Claw grabs [M] and starts pulling \him."))
		log_attack("[key_name(user)] used claw to pull [key_name(M)] at [AREACOORD(src)]")
	else if(isobj(target))
		var/obj/O = target
		if(O.anchored)
			to_chat(user, span_warning("[O] is anchored and cannot be moved!"))
			return FALSE
		if(O.pulledby)
			O.pulledby.stop_pulling()
		start_pulling(O)
		to_chat(user, span_notice("Claw grabs [O] and starts pulling it."))
		log_attack("[key_name(user)] used claw to pull [O] at [AREACOORD(src)]")
	else
		to_chat(user, span_warning("Claw cannot grab that target!"))
		return FALSE

	COOLDOWN_START(src, fire_cooldown, fire_delay)
	playsound(loc, 'sound/machines/click.ogg', 50, 1)
	return TRUE

/obj/vehicle/unmanned/fire_act(burn_level, flame_color)
	take_damage(burn_level * 0.5, BURN, FIRE)

/obj/vehicle/unmanned/welder_act(mob/living/user, obj/item/I)
	return welder_repair_act(user, I, 35, 2 SECONDS, 0, SKILL_ENGINEER_ENGI, 1, 4 SECONDS)

/obj/vehicle/unmanned/pre_crush_act(mob/living/carbon/xenomorph/charger, datum/action/ability/xeno_action/ready_charge/charge_datum)
	return (CHARGE_SPEED(charge_datum) * 50)

/obj/vehicle/unmanned/medium
	name = "UV-M Gecko"
	icon_state = "medium_uv"
	move_delay = 3
	max_rounds = 200
	max_integrity = 180
	soft_armor = list(MELEE = 35, BULLET = 90, LASER = 90, ENERGY = 90, BOMB = 55, BIO = 100, FIRE = 25, ACID = 35)
	affected_by_sticky_weeds = FALSE
	power_per_move = 0.2

/obj/vehicle/unmanned/heavy
	name = "UV-H Komodo"
	icon_state = "heavy_uv"
	move_delay = 4
	max_rounds = 200
	max_integrity = 220
	soft_armor = list(MELEE = 50, BULLET = 95, LASER = 95, ENERGY = 95, BOMB = 60, BIO = 100, FIRE = 35, ACID = 50)
	affected_by_sticky_weeds = FALSE
	power_per_move = 0.3

/obj/structure/closet/crate/uav_crate
	name = "\improper UV-L Iguana Crate"
	desc = "A crate containing an unmanned vehicle with a controller."
	icon = 'icons/obj/structures/crates.dmi'
	icon_state = "closed_weapons"
	icon_opened = "open_weapons"
	icon_closed = "closed_weapons"
	/// For doing less copy-paste (and make it look prettier) further as we want to expand UAV variations
	var/vehicle_type = /obj/vehicle/unmanned

// UAVs

/obj/structure/closet/crate/uav_crate/PopulateContents()
	new vehicle_type(src)
	new /obj/item/unmanned_vehicle_remote(src)

/obj/structure/closet/crate/uav_crate/medium
    name = "\improper UV-M Gecko Crate"
    vehicle_type = /obj/vehicle/unmanned/medium

/obj/structure/closet/crate/uav_crate/heavy
    name = "\improper UV-H Komodo Crate"
    vehicle_type = /obj/vehicle/unmanned/heavy

// Weapons

/obj/structure/closet/crate/uav_weapons_crate/light/PopulateContents()
	new /obj/item/uav_turret(src)
	for(var/i in 1 to 3)
		new /obj/item/ammo_magazine/box11x35mm(src)

/obj/structure/closet/crate/uav_weapons_crate/heavy/PopulateContents()
	new /obj/item/uav_turret/heavy(src)
	for(var/i in 1 to 3)
		new /obj/item/ammo_magazine/box12x40mm(src)

/obj/structure/closet/crate/uav_weapons_crate/claw/PopulateContents()
	new /obj/item/uav_turret/claw(src)
