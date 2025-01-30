SUBSYSTEM_DEF(machines)
	name = "Machines"
	init_order = INIT_ORDER_MACHINES
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_LOBBY|RUNLEVEL_SETUP|RUNLEVEL_GAME|RUNLEVEL_POSTGAME

	var/list/currentrun = list()
	var/list/processing = list()
	var/list/powernets = list()

/datum/controller/subsystem/machines/Initialize()
	makepowernets()
	fire()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/machines/proc/makepowernets()
	for(var/datum/powernet/power_network AS in powernets)
		qdel(power_network )
	powernets.Cut()

	for(var/obj/structure/cable/power_cable AS in GLOB.cable_list)
		if(power_cable.powernet)
			continue
		var/datum/powernet/new_powernet = new()
		new_powernet.add_cable(power_cable)
		propagate_network(power_cable, power_cable.powernet)

/datum/controller/subsystem/machines/stat_entry(msg)
	msg = "PM:[length(processing)]|PN:[length(powernets)]"
	return ..()

/datum/controller/subsystem/machines/fire(resumed = FALSE)
	if(!resumed)
		for(var/datum/powernet/powernet AS in powernets)
			powernet.reset() //reset the power state.
		src.currentrun = processing.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	var/seconds = wait * 0.1
	while(length(currentrun))
		var/obj/machinery/thing = currentrun[length(currentrun)]
		currentrun.len--
		if(!QDELETED(thing) && thing.process(seconds) != PROCESS_KILL)
			if(thing.use_power)
				thing.auto_use_power() //add back the power state
		else
			processing -= thing
			if(!QDELETED(thing))
				thing.datum_flags &= ~DF_ISPROCESSING
		if(MC_TICK_CHECK)
			return

/datum/controller/subsystem/machines/proc/setup_template_powernets(list/cables)
	for(var/A in cables)
		var/obj/structure/cable/PC = A
		if(PC.powernet)
			continue
		var/datum/powernet/NewPN = new()
		NewPN.add_cable(PC)
		propagate_network(PC, PC.powernet)

/datum/controller/subsystem/machines/Recover()
	if(istype(SSmachines.processing))
		processing = SSmachines.processing

	if(istype(SSmachines.powernets))
		powernets = SSmachines.powernets
