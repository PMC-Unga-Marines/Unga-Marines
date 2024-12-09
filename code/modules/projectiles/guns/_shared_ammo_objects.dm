// Used for objects created by ammo datums that tend to be more general and can be used in multiple ammo datum files.

/////////////////////////////
//          FIRE           //
/////////////////////////////
// Base type , meant to be overridden
/obj/fire
	name = "fire"
	desc = "Ouch!"
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'icons/effects/fire.dmi'
	icon_state = "red_2"
	layer = BELOW_OBJ_LAYER
	light_system = MOVABLE_LIGHT
	light_mask_type = /atom/movable/lighting_mask/flicker
	light_on = TRUE
	light_range = 3
	light_power = 3
	/// tracks for how many process ticks the fire will exist.Can be reduced by other sources
	var/burn_ticks = 10
	///The color the flames and associated particles appear
	var/flame_color = FLAME_COLOR_RED
	///Tracks how HOT the fire is. This is basically the heat level of the fire and determines the temperature
	var/burn_level = 20
	/// How many burn ticks we lose per process
	var/burn_decay = 1

/obj/fire/Initialize(mapload, new_burn_ticks = burn_ticks, new_burn_level = burn_level, f_color, fire_stacks = 0, fire_damage = 0)
	. = ..()
	START_PROCESSING(SSobj, src)

	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_cross),
	)
	AddElement(/datum/element/connect_loc, connections)
	set_fire(new_burn_ticks, new_burn_level, f_color, fire_stacks, fire_damage)

/obj/fire/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/fire/update_icon()
	. = ..()
	var/light_intensity = 3
	switch(burn_ticks)
		if(1 to 9)
			light_intensity = 2
		if(10 to 25)
			light_intensity = 4
		if(25 to INFINITY)
			light_intensity = 6
	set_light_range_power_color(light_intensity, light_power, light_color)

/obj/fire/update_icon_state()
	. = ..()
	switch(flame_color)
		if(FLAME_COLOR_RED)
			light_color = LIGHT_COLOR_FLAME
		if(FLAME_COLOR_BLUE)
			light_color = LIGHT_COLOR_BLUE_FLAME
		if(FLAME_COLOR_GREEN)
			light_color = LIGHT_COLOR_ELECTRIC_GREEN
		if(FLAME_COLOR_LIME)
			light_color = LIGHT_COLOR_ELECTRIC_GREEN
	switch(burn_ticks)
		if(1 to 9)
			icon_state = "[flame_color]_1"
		if(10 to 25)
			icon_state = "[flame_color]_2"
		if(25 to INFINITY)
			icon_state = "[flame_color]_3"

/obj/fire/process()
	if(!isturf(loc))
		qdel(src)
		return PROCESS_KILL

	burn_ticks -= burn_decay
	if(burn_ticks <= 0)
		qdel(src)
		return PROCESS_KILL

	affect_atom(loc)
	for(var/thing in loc)
		affect_atom(thing)

	update_appearance(UPDATE_ICON)

/obj/fire/effect_smoke(obj/effect/particle_effect/smoke/affecting_smoke)
	if(!CHECK_BITFIELD(affecting_smoke.smoke_traits, SMOKE_EXTINGUISH))
		return
	burn_ticks -= EXTINGUISH_AMOUNT
	if(burn_ticks <= 0)
		playsound(affecting_smoke, 'sound/effects/smoke_extinguish.ogg', 20)
		qdel(src)
		return
	update_appearance(UPDATE_ICON)

///Sets the fire_base object to the correct colour and fire_base values, and applies the initial effects to anything on the turf
/obj/fire/proc/set_fire(new_burn_ticks, new_burn_level, new_flame_color, fire_stacks = 0, fire_damage = 0)
	if(new_burn_ticks <= 0)
		qdel(src)
		return

	if(new_flame_color)
		flame_color = new_flame_color
	if(new_burn_ticks)
		burn_ticks = new_burn_ticks
	if(new_burn_level)
		burn_level = new_burn_level
	if(!GLOB.flamer_particles[flame_color])
		GLOB.flamer_particles[flame_color] = new /particles/flamer_fire(flame_color)

	particles = GLOB.flamer_particles[flame_color]
	update_appearance(UPDATE_ICON)

	if((fire_stacks + fire_damage) <= 0)
		return

	for(var/thing in get_turf(src))
		affect_atom(thing)

///Effects applied to anything that crosses a burning turf
/obj/fire/proc/on_cross(datum/source, atom/movable/crosser, oldloc, oldlocs)
	SIGNAL_HANDLER
	affect_atom(crosser)

///Applies effects to an atom
/obj/fire/proc/affect_atom(atom/affected)
	return

/////////////////////////////
//      FLAMER FIRE        //
/////////////////////////////

/obj/fire/flamer
	icon_state = "red_2"
	burn_ticks = 12

/obj/fire/flamer/affect_atom(atom/affected)
	affected.fire_act(burn_level, flame_color)

/obj/fire/flamer/process()
	. = ..()
	burn_level -= 2
	if(burn_level <= 0)
		qdel(src)
		return PROCESS_KILL
