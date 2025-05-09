/datum/map_template
	var/name = "Default Template Name"
	var/width = 0
	var/height = 0
	var/mappath = null
	/// Times loaded this round
	var/loaded = 0
	var/datum/parsed_map/cached_map
	var/keep_cached_map = FALSE
	///Default area associated with the map template
	var/default_area

	///if true, turfs loaded from this template are placed on top of the turfs already there, defaults to TRUE
	var/should_place_on_top = TRUE

	///if true, creates a list of all atoms created by this template loading, defaults to FALSE
	var/returns_created_atoms = FALSE

	///the list of atoms created by this template being loaded, only populated if returns_created_atoms is TRUE
	var/list/created_atoms = list()
	//make sure this list is accounted for/cleared if you request it from ssatoms!

/datum/map_template/New(path = null, rename = null, cache = FALSE)
	if(path)
		mappath = path
	if(mappath)
		preload_size(mappath, cache)
	if(rename)
		name = rename

/datum/map_template/proc/preload_size(path, cache = FALSE)
	var/datum/parsed_map/parsed = new(file(path))
	var/bounds = parsed?.bounds
	if(bounds)
		width = bounds[MAP_MAXX] // Assumes all templates are rectangular, have a single Z level, and begin at 1,1,1
		height = bounds[MAP_MAXY]
		if(cache)
			cached_map = parsed
	return bounds

/datum/map_template/proc/initTemplateBounds(list/bounds)
	if(!bounds) //something went wrong
		stack_trace("[name] template failed to initialize correctly!")
		return

	var/list/turfs = block(
		locate(
			bounds[MAP_MINX],
			bounds[MAP_MINY],
			bounds[MAP_MINZ]
			),
		locate(
			bounds[MAP_MAXX],
			bounds[MAP_MAXY],
			bounds[MAP_MAXZ]
			)
		)
	var/list/atom/movable/movables = list()
	var/list/obj/structure/cable/cables = list()
	var/list/obj/docking_port/stationary/ports = list()
	var/list/area/areas = list()

	for(var/turf/current_turf as anything in turfs)
		var/area/current_turfs_area = current_turf.loc
		areas |= current_turfs_area
		if(!SSatoms.initialized)
			continue

		for(var/movable_in_turf in current_turf)
			if(istype(movable_in_turf, /obj/docking_port/mobile))
				continue // mobile docking ports need to be initialized after their template has finished loading, to ensure that their bounds are setup
			movables += movable_in_turf
			if(istype(movable_in_turf, /obj/structure/cable))
				cables += movable_in_turf
				continue
			if(istype(movable_in_turf, /obj/docking_port/stationary))
				ports += movable_in_turf

	// Not sure if there is some importance here to make sure the area is in z
	// first or not.  Its defined In Initialize yet its run first in templates
	// BEFORE so... hummm

	SSmapping.reg_in_areas_in_z(areas)
	if(!SSatoms.initialized)
		return

	SSatoms.InitializeAtoms(areas + turfs + movables, returns_created_atoms ? created_atoms : null)

	// Sadly we still need this, so the shuttles like Canterbury properly make powernets
	SSmachines.setup_template_powernets(cables)

/datum/map_template/proc/load_new_z(minimap = TRUE, list/traits = list(ZTRAIT_AWAY = TRUE))
	var/x = round((world.maxx - width) * 0.5) + 1
	var/y = round((world.maxy - height) * 0.5) + 1

	var/datum/space_level/level = SSmapping.add_new_zlevel(name, list(), contain_turfs = FALSE)
	var/datum/parsed_map/parsed = load_map(
		file(mappath),
		x,
		y,
		level.z_value,
		no_changeturf = (SSatoms.initialized == INITIALIZATION_INSSATOMS),
		place_on_top = should_place_on_top,
		new_z = TRUE,
	)
	var/list/bounds = parsed.bounds
	if(!bounds)
		return FALSE
	repopulate_sorted_areas()
	//initialize things that are normally initialized after map load
	initTemplateBounds(bounds)
	SSmodularmapping.load_modular_maps() //must be run after initTemplateBounds so markers have an actual loc
	SSweather.load_late_z(level.z_value)
	SSair.setup_atmos_machinery()
	SSair.setup_pipenets()
	smooth_zlevel(level.z_value)
	if(minimap)
		SSminimaps.load_new_z(null, level)
	log_game("Z-level [name] loaded at [x], [y], [world.maxz]")

	return level

/datum/map_template/proc/load(turf/T, centered = FALSE, delete = FALSE)
	if(centered)
		T = locate(T.x - round(width * 0.5), T.y - round(height * 0.5), T.z)
	if(!T)
		return
	if((T.x + width) - 1 > world.maxx)
		return
	if((T.y + height) - 1> world.maxy)
		return

	// Accept cached maps, but don't save them automatically - we don't want
	// ruins clogging up memory for the whole round.
	var/datum/parsed_map/parsed = cached_map || new(file(mappath))
	cached_map = keep_cached_map ? parsed : null

	var/list/turf_blacklist = list()
	update_blacklist(T, turf_blacklist)

	UNSETEMPTY(turf_blacklist)
	parsed.turf_blacklist = turf_blacklist
	if(!parsed.load(
		T.x,
		T.y,
		T.z,
		crop_map = TRUE,
		no_changeturf = (SSatoms.initialized == INITIALIZATION_INSSATOMS),
		place_on_top = should_place_on_top,
	))
		return

	var/list/bounds = parsed.bounds
	if(!bounds)
		return

	repopulate_sorted_areas()
	//initialize things that are normally initialized after map load
	initTemplateBounds(bounds)

	log_game("[name] loaded at [T.x], [T.y], [T.z]")
	return bounds

///Whatever special stuff you want
/datum/map_template/proc/post_load()
	return

/datum/map_template/proc/update_blacklist(turf/T, list/input_blacklist)
	return

/datum/map_template/proc/get_affected_turfs(turf/T, centered = FALSE)
	var/turf/placement = T
	if(centered)
		var/turf/corner = locate(placement.x - round(width * 0.5), placement.y - round(height * 0.5), placement.z)
		if(corner)
			placement = corner
	return block(placement, locate(placement.x+width-1, placement.y+height-1, placement.z))

//for your ever biggening badminnery kevinz000
//❤ - Cyberboss
/proc/load_new_z_level(file, name, minimap = TRUE, list/traits = list())
	var/datum/map_template/template = new(file, name)
	return template.load_new_z(minimap, traits)
