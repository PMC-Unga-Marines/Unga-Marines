/obj/machinery/factory
	name = "generic root heater"
	desc = "You shouldnt be seeing this."
	icon = 'icons/obj/factory/factory_machines.dmi'
	icon_state = "heater_inactive"
	density = TRUE
	anchored = FALSE // start off unanchored so its easier to move
	resistance_flags = XENO_DAMAGEABLE
	flags_atom = PREVENT_CONTENTS_EXPLOSION
	///process type we will use to determine what step of the production process this machine will do
	var/process_type = FACTORY_MACHINE_HEATER
	///Time in ticks that this machine takes to process one item
	var/cooldown_time = 1 SECONDS
	///Curent item being processed
	var/obj/item/factory_part/held_item
	///Icon state displayed while something is being processed in the machine
	var/processiconstate = "heater"
	COOLDOWN_DECLARE(process_cooldown)

/obj/machinery/factory/Initialize(mapload)
	. = ..()
	add_overlay(image(icon, "direction_arrow"))

/obj/machinery/factory/Destroy()
	QDEL_NULL(held_item)
	return ..()

/obj/machinery/factory/examine(mob/user, distance, infix, suffix)
	. = ..()
	. += "It is currently facing [dir2text(dir)] and [anchored ? "" : "un"]secured."
	. += "Processes one package every [cooldown_time*10] seconds."

/obj/machinery/factory/wrench_act(mob/living/user, obj/item/I)
	anchored = !anchored
	balloon_alert(user, "[anchored ? "" : "un"]anchored")
	playsound(loc, 'sound/items/ratchet.ogg', 25, 1)

/obj/machinery/factory/screwdriver_act(mob/living/user, obj/item/I)
	setDir(turn(dir, 90))
	balloon_alert(user, "Facing [dir2text(dir)]")

/obj/machinery/factory/Bumped(atom/movable/bumper)
	. = ..()
	if(!isitem(bumper))
		return
	if(!(bumper.dir & dir))//need to be bumping into the back
		return
	if(!anchored)
		return
	if(!isfactorypart(bumper))
		bumper.forceMove(get_step(src, pick(GLOB.alldirs)))//just find a random tile and throw it there to stop it from clogging
		return
	if(!COOLDOWN_CHECK(src, process_cooldown))
		return
	bumper.forceMove(src)
	held_item = bumper
	COOLDOWN_START(src, process_cooldown, cooldown_time)
	if(processiconstate && icon_state != processiconstate)//avoid resetting the animation
		icon_state = processiconstate
	addtimer(CALLBACK(src, PROC_REF(finish_process)), cooldown_time)

///Once the timer for processing is over this resets the machine and spits out the new result
/obj/machinery/factory/proc/finish_process()
	var/turf/target = get_step(src, dir)
	held_item.forceMove(target)
	if(held_item.next_machine == process_type)
		held_item.advance_stage()
	if(!locate(held_item.type) in get_step(src, REVERSE_DIR(dir)))
		icon_state = initial(icon_state)

	held_item = null

/obj/machinery/factory/heater
	name = "Industrial heater"
	desc = "An industrial level heater"

/obj/machinery/factory/flatter
	name = "Industrial flatter"
	desc = "An industrial level flatter"
	icon_state = "flatter_inactive"
	processiconstate = "flatter"
	process_type = FACTORY_MACHINE_FLATTER

/obj/machinery/factory/cutter
	name = "Industrial cutter"
	desc = "An industrial level cutter"
	icon_state = "cutter_inactive"
	processiconstate = "cutter"
	process_type = FACTORY_MACHINE_CUTTER

/obj/machinery/factory/former
	name = "Industrial former"
	desc = "An industrial level former"
	icon_state = "former_inactive"
	processiconstate = "former"
	process_type = FACTORY_MACHINE_FORMER

/obj/machinery/factory/reconstructor
	name = "Atomic reconstructor"
	desc = "An industrial level former"
	icon_state = "reconstructor_inactive"
	processiconstate = "reconstructor"
	process_type = FACTORY_MACHINE_CONSTRUCTOR

/obj/machinery/factory/driller
	name = "Industrial driller"
	desc = "An industrial level driller"
	icon_state = "driller_inactive"
	processiconstate = "driller"
	process_type = FACTORY_MACHINE_DRILLER

/obj/machinery/factory/galvanizer
	name = "Industrial galvanizer"
	desc = "An industrial level galvanizer"
	icon_state = "galvanizer_inactive"
	processiconstate = "galvanizer"
	process_type = FACTORY_MACHINE_GALVANIZER

/obj/machinery/factory/compressor
	name = "Industrial compressor"
	desc = "An industrial level compressor"
	icon_state = "compressor_inactive"
	processiconstate = "compressor"
	process_type = FACTORY_MACHINE_COMPRESSOR

GLOBAL_LIST_INIT(assembler_icons, list("heater", "flatter", "cutter", "former", "galvanizer", "driller", "compressor"))

/obj/machinery/assembler
	name = "Assembler"
	desc = "You shouldnt be seeing this."
	icon = 'icons/obj/factory/factory_machines.dmi'
	density = TRUE
	anchored = FALSE // start off unanchored so its easier to move
	resistance_flags = XENO_DAMAGEABLE
	flags_atom = PREVENT_CONTENTS_EXPLOSION
	interaction_flags = INTERACT_MACHINE_TGUI
	///Curent items being processed
	var/list/held_items
	///Icon state displayed while something is being processed in the machine
	var/processiconstate
	///Current craft datum
	var/datum/assembly_craft/craft = null

	COOLDOWN_DECLARE(process_cooldown)

/obj/machinery/assembler/Initialize(mapload)
	. = ..()
	processiconstate = pick(GLOB.assembler_icons)
	icon_state = processiconstate + "_inactive"
	add_overlay(image(icon, "direction_arrow"))

/obj/machinery/assembler/Destroy()
	QDEL_LIST(held_items)
	return ..()

/obj/machinery/assembler/examine(mob/user, distance, infix, suffix)
	. = ..()
	. += "It is currently facing [dir2text(dir)] and [anchored ? "" : "un"]secured."

/obj/machinery/assembler/wrench_act(mob/living/user, obj/item/I)
	anchored = !anchored
	balloon_alert(user, "[anchored ? "" : "un"]anchored")
	playsound(loc, 'sound/items/ratchet.ogg', 25, 1)

/obj/machinery/assembler/screwdriver_act(mob/living/user, obj/item/I)
	setDir(turn(dir, 90))
	balloon_alert(user, "Facing [dir2text(dir)]")

/obj/machinery/assembler/Bumped(atom/movable/bumper)
	. = ..()
	if(!isitem(bumper))
		return
	if(!anchored)
		return
	if(!craft)
		return
	if(!COOLDOWN_CHECK(src, process_cooldown))
		return
	if(isitemstack(bumper))
		var/obj/item/stack/stack = bumper
		if(!type_in_list(stack.merge_type, craft.input))
			return
		if(held_items[stack.merge_type] < craft.input[stack.merge_type])
			var/ammount_to_transfer = min(stack.amount, craft.input[stack.merge_type] - held_items[stack.merge_type])
			stack.amount -= ammount_to_transfer
			held_items[stack.merge_type] += ammount_to_transfer
			if(stack.amount <= 0)
				qdel(bumper)
	else
		if(!is_type_in_list(bumper, craft.input))
			return
		if(held_items[bumper.type] < craft.input[bumper.type])
			held_items[bumper.type] = held_items[bumper.type] + 1
			qdel(bumper)

	for(var/type in craft.input)
		if(held_items[type] < craft.input[type])
			return

	COOLDOWN_START(src, process_cooldown, craft.craft_time)
	if(processiconstate && icon_state != processiconstate)//avoid resetting the animation
		icon_state = processiconstate
	addtimer(CALLBACK(src, PROC_REF(finish_process)), craft.craft_time)

///Once the timer for processing is over this resets the machine and spits out the new result
/obj/machinery/assembler/proc/finish_process()
	var/turf/target = get_step(src, dir)

	for(var/type in craft.output)
		var/count = craft.output[type]
		for(var/i in 1 to count)
			new type(target)

	for(var/type in craft.input)
		held_items[type] = 0

	icon_state = processiconstate + "_inactive"

/obj/machinery/assembler/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)

	if(!ui)
		ui = new(user, src, "Assembler", name)
		ui.open()

/obj/machinery/assembler/ui_static_data(mob/user)
	. = list()
	.["categories"] = GLOB.all_assembly_craft_groups
	.["supplypacks"] = SSpoints.assembly_crafts_ui
	.["supplypackscontents"] = SSpoints.assembly_crafts_contents

/obj/machinery/assembler/ui_data(mob/living/user)
	. = list()
	.["assemblercraft"] = craft ? craft.type : "no_craft"

/obj/machinery/assembler/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("select")
			craft = SSpoints.assembly_crafts[text2path(params["id"])]
			held_items = list()
			for(var/i in craft.input)
				held_items[i] = 0
			. = TRUE

/obj/machinery/fabricator
	name = "Metal fabricator"
	desc = "Сreates metal from... air. I think so"
	icon = 'icons/obj/factory/factory_machines.dmi'
	icon_state = "reconstructor_inactive"
	density = TRUE
	anchored = FALSE // start off unanchored so its easier to move
	resistance_flags = XENO_DAMAGEABLE
	flags_atom = PREVENT_CONTENTS_EXPLOSION
	///Curent items being processed
	var/item_to_fabricate = /obj/item/stack/sheet/metal/large_stack
	///Icon state displayed while something is being processed in the machine
	var/processiconstate = "reconstructor"
	//points generation
	var/spawn_ticks = 24 //tick every 5 seconds
	///Last time points balance was checked
	var/ticks = 0

/obj/machinery/fabricator/Initialize(mapload)
	. = ..()
	add_overlay(image(icon, "direction_arrow"))

/obj/machinery/fabricator/examine(mob/user, distance, infix, suffix)
	. = ..()
	. += "It is currently facing [dir2text(dir)] and [anchored ? "" : "un"]secured."

/obj/machinery/fabricator/wrench_act(mob/living/user, obj/item/I)
	anchored = !anchored
	if(anchored)
		icon_state = processiconstate
		START_PROCESSING(SSslowprocess, src)
	else
		icon_state = initial(icon_state)
		STOP_PROCESSING(SSslowprocess, src)
	balloon_alert(user, "[anchored ? "" : "un"]anchored")
	playsound(loc, 'sound/items/ratchet.ogg', 25, 1)

/obj/machinery/fabricator/screwdriver_act(mob/living/user, obj/item/I)
	setDir(turn(dir, 90))
	balloon_alert(user, "Facing [dir2text(dir)]")

/obj/machinery/fabricator/process()
	ticks++
	if(ticks >= spawn_ticks)
		var/turf/target = get_step(src, dir)
		new item_to_fabricate(target)
		ticks = 0

/obj/machinery/fabricator/gunpowder
	name = "Gunpowder fabricator"
	desc = "Сreates gunpowder from... air. I think so"
	item_to_fabricate = /obj/item/stack/gun_powder/large_stack
