/turf
	var/list/datum/automata_cell/autocells

/turf/proc/get_cell(type)
	for(var/datum/automata_cell/our_cell in autocells)
		if(istype(our_cell, type))
			return our_cell
	return null

/turf/ex_act()
	return
