SUBSYSTEM_DEF(reqtorio)
	name = "Reqtorio"

	priority = FIRE_PRIORITY_REQTORIO
	flags = SS_NO_FIRE

	var/list/assembly_crafts = list()
	var/list/assembly_crafts_ui = list()
	var/list/assembly_crafts_contents = list()

/datum/controller/subsystem/reqtorio/Recover()
	assembly_crafts = SSreqtorio.assembly_crafts
	assembly_crafts_ui = SSreqtorio.assembly_crafts_ui
	assembly_crafts_contents = SSreqtorio.assembly_crafts_contents

/datum/controller/subsystem/reqtorio/Initialize()
	return SS_INIT_SUCCESS

/// Prepare the global assembly_craft pack list at the gamemode start
/datum/controller/subsystem/reqtorio/proc/prepare_assembly_crafts_list()
	for(var/craft in subtypesof(/datum/assembly_craft))
		var/datum/assembly_craft/C = craft
		C = new craft()
		if(!C.input)
			continue
		if(!C.output)
			continue
		assembly_crafts[craft] = C
		LAZYADD(assembly_crafts_ui[C.group], craft)

		var/list/inputs = list()
		for(var/i in C.input)
			var/atom/movable/path = i
			var/count = C.input[i]
			if(!path)
				continue
			inputs[path] = list("name" = initial(path.name), "count" = count)

		var/list/outputs = list()
		for(var/i in C.output)
			var/atom/movable/path = i
			var/count = C.input[i]
			if(!path)
				continue
			outputs[path] = list("name" = initial(path.name), "count" = count)

		assembly_crafts_contents[craft] = list("name" = C.name, "inputs" = inputs, "outputs" = outputs)
