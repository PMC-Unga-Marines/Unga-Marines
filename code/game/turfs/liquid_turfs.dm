///The alpha mask used on mobs submerged in liquid turfs
#define MOB_LIQUID_TURF_MASK "mob_liquid_turf_mask"
///The height of the mask itself in the icon state. Changes to the icon requires a change to this define
#define MOB_LIQUID_TURF_MASK_HEIGHT 32

/turf/open/liquid //Basic liquid turf parent
	name = "liquid"
	icon = 'icons/turf/ground_map.dmi'
	can_bloody = FALSE
	///Multiplier on any slowdown applied to a mob moving through this turf
	var/slowdown_multiplier = 1
	///How high up on the mob water overlays sit
	var/mob_liquid_height = 11
	///How far down the mob visually drops down when in water
	var/mob_liquid_depth = -5

/turf/open/liquid/AfterChange()
	. = ..()
	baseturfs = type

/turf/open/liquid/is_weedable()
	return FALSE

/turf/open/liquid/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(SEND_SIGNAL(src, COMSIG_TURF_CHECK_COVERED))
		return FALSE
	. = TRUE

	if(!ismob(arrived))
		return

	if(length(canSmoothWith) && !CHECK_MULTIPLE_BITFIELDS(smoothing_junction, (SOUTH_JUNCTION|EAST_JUNCTION|WEST_JUNCTION)))
		return

	var/mob/arrived_mob = arrived
	var/icon/mob_icon = icon(arrived_mob.icon)
	var/height_to_use = (64 - mob_icon.Height()) * 0.5 //gives us the right height based on carbon's icon height relative to the 64 high alpha mask

	if(arrived_mob.get_filter(MOB_LIQUID_TURF_MASK))
		var/turf/open/liquid/old_turf = old_loc
		if(!istype(old_turf))
			CRASH("orphaned liquid alpha mask")
		if(mob_liquid_height != old_turf.mob_liquid_height)
			animate(arrived_mob.get_filter(MOB_LIQUID_TURF_MASK), y = ((64 - mob_icon.Height()) * 0.5) - (MOB_LIQUID_TURF_MASK_HEIGHT - mob_liquid_height), time = arrived_mob.cached_multiplicative_slowdown + arrived_mob.next_move_slowdown)
		if(mob_liquid_depth != old_turf.mob_liquid_depth)
			animate(arrived_mob, pixel_y = arrived_mob.pixel_y + mob_liquid_depth - old_turf.mob_liquid_depth, time = arrived_mob.cached_multiplicative_slowdown + arrived_mob.next_move_slowdown, flags = ANIMATION_PARALLEL)
	else
		//The mask is spawned below the mob, then the animate() raises it up, giving the illusion of dropping into water, combining with the animate to actual drop the pixel_y into the water
		arrived_mob.add_filter(MOB_LIQUID_TURF_MASK, 1, alpha_mask_filter(0, height_to_use - MOB_LIQUID_TURF_MASK_HEIGHT, icon('icons/turf/alpha_64.dmi', "liquid_alpha"), null, MASK_INVERSE))

		animate(arrived_mob.get_filter(MOB_LIQUID_TURF_MASK), y = height_to_use - (MOB_LIQUID_TURF_MASK_HEIGHT - mob_liquid_height), time = arrived_mob.cached_multiplicative_slowdown + arrived_mob.next_move_slowdown)
		animate(arrived_mob, pixel_y = arrived_mob.pixel_y + mob_liquid_depth, time = arrived_mob.cached_multiplicative_slowdown + arrived_mob.next_move_slowdown, flags = ANIMATION_PARALLEL)

	if(!arrived_mob.throwing)
		arrived_mob.next_move_slowdown += (arrived_mob.get_liquid_slowdown() * slowdown_multiplier)

/turf/open/liquid/Exited(atom/movable/leaver, direction)
	. = ..()
	if(!ismob(leaver))
		return
	var/mob/mob_leaver = leaver
	if(!mob_leaver.get_filter(MOB_LIQUID_TURF_MASK))
		return

	var/turf/open/liquid/new_turf = mob_leaver.loc
	if(istype(new_turf))
		if(length(new_turf.canSmoothWith))
			if(!SEND_SIGNAL(new_turf, COMSIG_TURF_CHECK_COVERED) && CHECK_MULTIPLE_BITFIELDS(new_turf.smoothing_junction, (SOUTH_JUNCTION|EAST_JUNCTION|WEST_JUNCTION)))
				return
		else if(!SEND_SIGNAL(new_turf, COMSIG_TURF_CHECK_COVERED))
			return

	var/icon/mob_icon = icon(mob_leaver.icon)
	animate(mob_leaver.get_filter(MOB_LIQUID_TURF_MASK), y = ((64 - mob_icon.Height()) * 0.5) - MOB_LIQUID_TURF_MASK_HEIGHT, time = mob_leaver.cached_multiplicative_slowdown + mob_leaver.next_move_slowdown)
	animate(mob_leaver, pixel_y = mob_leaver.pixel_y - mob_liquid_depth, time = mob_leaver.cached_multiplicative_slowdown + mob_leaver.next_move_slowdown, flags = ANIMATION_PARALLEL)
	addtimer(CALLBACK(mob_leaver, TYPE_PROC_REF(/atom, remove_filter), MOB_LIQUID_TURF_MASK), clamp(mob_leaver.cached_multiplicative_slowdown + mob_leaver.next_move_slowdown, 0.1, 5))

/turf/open/liquid/water
	name = "river"
	icon_state = "seashallow"
	shoefootstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	mediumxenofootstep = FOOTSTEP_WATER
	heavyxenofootstep = FOOTSTEP_WATER
	minimap_color = MINIMAP_WATER

/turf/open/liquid/water/Initialize(mapload)
	. = ..()
	if(mob_liquid_height > 15)
		shoefootstep = FOOTSTEP_SWIM
		barefootstep = FOOTSTEP_SWIM
		mediumxenofootstep = FOOTSTEP_SWIM
		heavyxenofootstep = FOOTSTEP_SWIM

/turf/open/liquid/water/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(!.)
		return

	if(!iscarbon(arrived))
		return

	var/mob/living/carbon/carbon_mob = arrived
	carbon_mob.clean_mob()

	if(carbon_mob.on_fire)
		carbon_mob.ExtinguishMob()

/turf/open/liquid/water/sea
	name = "water"
	icon_state = "seadeep"

/turf/open/liquid/water/river
	name = "river"
	smoothing_groups = list(
		SMOOTH_GROUP_RIVER,
	)

/turf/open/liquid/water/river/deep
	icon_state = "seashallow_deep"
	mob_liquid_height = 18
	mob_liquid_depth = -8

/turf/open/liquid/water/river/deep/Initialize(mapload)
	. = ..()
	icon_state = "seashallow"

/turf/open/liquid/water/river/autosmooth
	icon = 'icons/turf/floors/river.dmi'
	icon_state = "river-icon"
	base_icon_state = "river"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_RIVER)
	canSmoothWith = list(
		SMOOTH_GROUP_RIVER,
		SMOOTH_GROUP_SURVIVAL_TITANIUM_WALLS,
		SMOOTH_GROUP_LATTICE,
		SMOOTH_GROUP_GRILLE,
		SMOOTH_GROUP_MINERAL_STRUCTURES,
	)

/turf/open/liquid/water/river/autosmooth/desert
	icon = 'icons/turf/floors/river_desert.dmi'

/turf/open/liquid/water/river/autosmooth/desert/deep
	icon_state = "river_deep-icon"
	mob_liquid_height = 18
	mob_liquid_depth = -8
	slowdown_multiplier = 1.5

/turf/open/liquid/water/river/autosmooth/deep
	icon_state = "river_deep-icon"
	mob_liquid_height = 18
	mob_liquid_depth = -8
	slowdown_multiplier = 1.5

//Desert River
/turf/open/liquid/water/river/desertdam
	name = "river"
	icon = 'icons/turf/desertdam_map.dmi'

//shallow water
/turf/open/liquid/water/river/desertdam/clean/shallow
	icon_state = "shallow_water_clean"

/turf/open/liquid/water/river/desertdam/clean/shallow/dirty
	icon_state = "shallow_water_dirty"

//shallow water transition to deep
/turf/open/liquid/water/river/desertdam/clean/shallow_edge
	icon_state = "shallow_to_deep_clean_water"

/turf/open/liquid/water/river/desertdam/clean/shallow_edge/corner
	icon_state = "shallowcorner1"

/turf/open/liquid/water/river/desertdam/clean/shallow_edge/corner2
	icon_state = "shallowcorner2"

/turf/open/liquid/water/river/desertdam/clean/shallow_edge/alt
	icon_state = "shallow_to_deep_clean_water1"

//deep water
/turf/open/liquid/water/river/desertdam/clean/deep_water_clean
	icon_state = "deep_water_clean"

//shallow water coast
/turf/open/liquid/water/river/desertdam/clean/shallow_water_desert_coast
	icon_state = "shallow_water_desert_coast"

/turf/open/liquid/water/river/desertdam/clean/shallow_water_desert_coast/edge
	icon_state = "shallow_water_desert_coast_edge"

//desert floor waterway
/turf/open/liquid/water/river/desertdam/clean/shallow_water_desert_waterway
	icon_state = "desert_waterway"

/turf/open/liquid/water/river/desertdam/clean/shallow_water_desert_waterway/edge
	icon_state = "desert_waterway_edge"

//shallow water cave coast
/turf/open/liquid/water/river/desertdam/clean/shallow_water_cave_coast
	icon_state = "shallow_water_cave_coast"

//cave floor waterway
/turf/open/liquid/water/river/desertdam/clean/shallow_water_cave_waterway
	icon_state = "shallow_water_cave_waterway"

/turf/open/liquid/water/river/desertdam/clean/shallow_water_cave_waterway/edge
	icon_state = "shallow_water_cave_waterway_edge"

// LAVA
/turf/open/liquid/lava
	name = "lava"
	icon = 'icons/turf/lava.dmi'
	icon_state = "full"
	light_system = STATIC_LIGHT //theres a lot of lava, dont change this
	light_range = 2
	light_power = 1.4
	light_color = LIGHT_COLOR_LAVA
	minimap_color = MINIMAP_LAVA
	slowdown_multiplier = 1.5

/turf/open/liquid/lava/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(SEND_SIGNAL(src, COMSIG_TURF_CHECK_COVERED))
		return
	if(burn_stuff(arrived))
		START_PROCESSING(SSobj, src)

/turf/open/liquid/lava/Exited(atom/movable/leaver, direction)
	. = ..()
	if(isliving(leaver))
		var/mob/living/L = leaver
		if(!islava(get_step(src, direction)) && !L.on_fire)
			L.update_fire()

/turf/open/liquid/lava/process()
	if(!burn_stuff())
		STOP_PROCESSING(SSobj, src)

///Handles burning turf contents or an entering AM. Returns true to keep processing
/turf/open/liquid/lava/proc/burn_stuff(AM)
	var/thing_to_check = AM ? list(AM) : src
	for(var/atom/thing AS in thing_to_check)
		if(thing.lava_act())
			. = TRUE

/turf/open/liquid/lava/corner
	icon_state = "corner"

/turf/open/liquid/lava/side
	icon_state = "side"

/turf/open/liquid/lava/lpiece
	icon_state = "lpiece"

/turf/open/liquid/lava/single/
	icon_state = "single"

/turf/open/liquid/lava/single/intersection
	icon_state = "single_intersection"

/turf/open/liquid/lava/single_intersection/direction
	icon_state = "single_intersection_direction"

/turf/open/liquid/lava/single/middle
	icon_state = "single_middle"

/turf/open/liquid/lava/single/end
	icon_state = "single_end"

/turf/open/liquid/lava/single/corners
	icon_state = "single_corners"

/turf/open/liquid/lava/autosmoothing
	icon = 'icons/turf/floors/lava.dmi'
	icon_state = "lava-icon"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_FLOOR_LAVA)
	canSmoothWith = list(SMOOTH_GROUP_FLOOR_LAVA, SMOOTH_GROUP_SURVIVAL_TITANIUM_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE)
	base_icon_state = "lava"

//Mapping helpers
/turf/open/liquid/lava/catwalk
	icon_state = "lavacatwalk"

/turf/open/liquid/lava/catwalk/Initialize(mapload)
	. = ..()
	icon_state = "full"
	new /obj/structure/catwalk(src)

/turf/open/liquid/lava/autosmoothing/catwalk
	icon_state = "lavacatwalk"

/turf/open/liquid/lava/autosmoothing/catwalk/Initialize(mapload)
	. = ..()
	new /obj/structure/catwalk(src)
