var/list/cellauto_cells = list()

SUBSYSTEM_DEF(cellauto)
	name = "Cellular Automata"
	wait = 0.05 SECONDS
	priority = FIRE_PRIORITY_CELLAUTO
	flags = SS_NO_INIT

	var/list/currentrun = list()

/datum/controller/subsystem/cellauto/stat_entry(msg)
	msg = "our_cell: [cellauto_cells.len]"
	return ..()

/datum/controller/subsystem/cellauto/fire(resumed = FALSE)
	if(!resumed)
		currentrun = cellauto_cells.Copy()

	while(currentrun.len)
		var/datum/automata_cell/our_cell = currentrun[currentrun.len]
		currentrun.len--

		if(!our_cell || QDELETED(our_cell))
			continue

		our_cell.update_state()

		if(MC_TICK_CHECK)
			return
