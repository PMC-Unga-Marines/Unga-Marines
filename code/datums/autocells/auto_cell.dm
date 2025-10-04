/*
	Each datum represents a single cellular automataton
	Cell death is just the cell being deleted.
	So if you want a cell to die, just qdel it.
*/
/datum/automata_cell
	// Which turf is the cell contained in
	var/turf/in_turf = null
	// What type of neighborhood do we use?
	// This affects what neighbors you'll get passed in update_state()
	var/neighbor_type = NEIGHBORS_CARDINAL

/datum/automata_cell/New(turf/our_turf)
	. = ..()

	if(!istype(our_turf))
		qdel(src)
		return

	// Attempt to merge the two cells if they end up in the same turf
	var/datum/automata_cell/our_cell = our_turf.get_cell(type)
	if(our_cell && merge(our_cell))
		qdel(src)
		return

	in_turf = our_turf
	LAZYADD(in_turf.autocells, src)
	SScellauto.cellauto_cells += src
	birth()

/datum/automata_cell/Destroy()
	. = ..()
	if(!QDELETED(in_turf))
		LAZYREMOVE(in_turf.autocells, src)
		in_turf = null
	SScellauto.cellauto_cells -= src
	death()

/// Called when the cell is created
/datum/automata_cell/proc/birth()
	return

/// Called when the cell is deleted/when it dies
/datum/automata_cell/proc/death()
	return

/// Transfer this automata cell to another turf
/datum/automata_cell/proc/transfer_turf(turf/new_turf)
	if(QDELETED(new_turf))
		return

	if(!QDELETED(in_turf))
		LAZYREMOVE(in_turf.autocells, src)
		in_turf = null

	in_turf = new_turf
	LAZYADD(in_turf.autocells, src)

/// Use this proc to merge this cell with another one if the other cell enters the same turf
/// Return TRUE if this cell should survive the merge (the other one will die/be qdeleted)
/// Return FALSE if this cell should die and be replaced by the other cell
/datum/automata_cell/proc/merge(datum/automata_cell/other_cell)
	return TRUE

/// Returns a list of neighboring cells
/// This is called by and results are passed to update_state by the cellauto subsystem
/datum/automata_cell/proc/get_neighbors()
	if(QDELETED(in_turf))
		return

	var/list/direction_list = GLOB.cardinals
	if(neighbor_type & NEIGHBORS_ORDINAL)
		direction_list = GLOB.diagonals

	var/list/neighbors = list()
	for(var/dir in direction_list)
		var/turf/our_turf = get_step(in_turf, dir)
		if(QDELETED(our_turf))
			continue
		for(var/datum/automata_cell/our_cell as anything in our_turf.autocells)
			if(!istype(our_cell, type))
				continue
			neighbors += our_cell
	return neighbors

/// Create a new cell in the given direction
/// Obviously override this if you want custom propagation,
/// but I figured this is pretty useful as a basic propagation function
/datum/automata_cell/proc/propagate(dir)
	if(!dir)
		return

	var/turf/our_turf = get_step(in_turf, dir)
	if(QDELETED(our_turf))
		return

	// Create the new cell
	var/datum/automata_cell/our_cell = new type(our_turf)
	return our_cell

/// Update the state of this cell
/datum/automata_cell/proc/update_state(list/turf/neighbors)
	// just fucking DIE
	qdel(src)
