/obj/machinery/assembler
	name = "Assembler"
	desc = "You shouldnt be seeing this."
	icon = 'icons/obj/factory/factory_machines.dmi'
	density = TRUE
	anchored = FALSE // start off unanchored so its easier to move
	resistance_flags = XENO_DAMAGEABLE
	atom_flags = PREVENT_CONTENTS_EXPLOSION
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
	processiconstate = pick(list("heater", "flatter", "cutter", "former", "galvanizer", "driller", "compressor"))
	icon_state = processiconstate + "_inactive"
	add_overlay(image(icon, "direction_arrow"))

/obj/machinery/assembler/Destroy()
	QDEL_LIST(held_items)
	return ..()

/obj/machinery/assembler/examine(mob/user, distance, infix, suffix)
	. = ..()
	. += "It is currently facing [dir2text(dir)] and [anchored ? "" : "un"]secured."
	if(craft)
		. += "Current craft:"
		. += craft.name
		. += "Contains:"
		for(var/type in craft.input)
			var/atom/movable/path = type
			. += "[initial(path.name)] - [held_items[type] ? held_items[type] : 0]"

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
	var/current_dir = dir
	var/rotate = 90

	switch(length(craft.output))
		if(1)
			current_dir = dir
			rotate = 0
		if(2)
			current_dir = turn(dir, 90)
			rotate = 180
		if(3)
			current_dir = turn(dir, 90)
			rotate = -90

	for(var/type in craft.output)
		var/count = craft.output[type]
		for(var/i in 1 to count)
			var/obj/obj = new type(loc)
			obj.forceMove(get_step(src, current_dir))
		current_dir = turn(current_dir, rotate)

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
	.["supplypacks"] = SSreqtorio.assembly_crafts_ui
	.["supplypackscontents"] = SSreqtorio.assembly_crafts_contents

/obj/machinery/assembler/ui_data(mob/living/user)
	. = list()
	.["assemblercraft"] = craft ? craft.type : "no_craft"

/obj/machinery/assembler/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("select")
			if(!COOLDOWN_CHECK(src, process_cooldown))
				balloon_alert(usr, "assembly is still in progress")
				return
			craft = SSreqtorio.assembly_crafts[text2path(params["id"])]
			held_items = list()
			for(var/i in craft.input)
				held_items[i] = 0
			. = TRUE

/obj/machinery/fabricator
	name = "Metal fabricator"
	desc = "Spends requisition points to create metal."
	icon = 'icons/obj/factory/factory_machines.dmi'
	icon_state = "reconstructor_inactive"
	density = TRUE
	anchored = FALSE // start off unanchored so its easier to move
	resistance_flags = XENO_DAMAGEABLE
	atom_flags = PREVENT_CONTENTS_EXPLOSION
	faction = FACTION_TERRAGOV
	///Curent items being processed
	var/item_to_fabricate = /obj/item/stack/sheet/metal/large_stack
	///Icon state displayed while something is being processed in the machine
	var/processiconstate = "reconstructor"
	//points generation
	var/spawn_ticks = 32 //tick every 5 seconds
	//points generation
	var/ground_spawn_ticks = 24 //tick every 5 seconds
	///Last time points balance was checked
	var/ticks = 0
	var/points_per_tick = 2

/obj/machinery/fabricator/Initialize(mapload)
	. = ..()
	add_overlay(image(icon, "direction_arrow"))

/obj/machinery/fabricator/examine(mob/user, distance, infix, suffix)
	. = ..()
	. += "It is currently facing [dir2text(dir)] and [anchored ? "" : "un"]secured."
	. += "Works faster on the ground than on a ship"

/obj/machinery/fabricator/wrench_act(mob/living/user, obj/item/I)
	anchored = !anchored
	if(anchored)
		icon_state = processiconstate
		START_PROCESSING(SSslowprocess, src)
	else
		icon_state = initial(icon_state)
		STOP_PROCESSING(SSslowprocess, src)
	faction = user.faction
	balloon_alert(user, "[anchored ? "" : "un"]anchored")
	playsound(loc, 'sound/items/ratchet.ogg', 25, 1)

/obj/machinery/fabricator/screwdriver_act(mob/living/user, obj/item/I)
	setDir(turn(dir, 90))
	balloon_alert(user, "Facing [dir2text(dir)]")

/obj/machinery/fabricator/process()
	if(!is_ground_level(z) && points_per_tick < SSpoints.supply_points[faction])
		SSpoints.supply_points[faction] -= points_per_tick
	ticks++
	var/ticks_to_spawn = is_ground_level(z) ? ground_spawn_ticks : spawn_ticks
	if(ticks >= ticks_to_spawn)
		var/turf/target = get_step(src, dir)
		var/obj/obj = new item_to_fabricate(loc)
		obj.forceMove(target)
		ticks = 0

/obj/machinery/fabricator/gunpowder
	name = "Gunpowder fabricator"
	desc = "Spends requisition points to create gunpowder."
	item_to_fabricate = /obj/item/stack/gun_powder/large_stack

/obj/machinery/fabricator/gunpowder/Destroy()
	cell_explosion(loc, 300, 100)
	return ..()

/obj/machinery/fabricator/junk
	name = "Junk fabricator"
	desc = "Spends requisition points to create junk."
	item_to_fabricate = /obj/item/stack/sheet/mineral/junk/large_stack

/obj/machinery/fabricator/plasteel
	name = "Plasteel fabricator"
	desc = "Spends requisition points to create plasteel."
	item_to_fabricate = /obj/item/stack/sheet/plasteel/large_stack

/obj/machinery/splitter
	name = "Splitter"
	desc = "You shouldnt be seeing this."
	icon = 'icons/obj/factory/factory_machines.dmi'
	icon_state = "spitter_inactive"
	density = TRUE
	anchored = FALSE // start off unanchored so its easier to move
	resistance_flags = XENO_DAMAGEABLE
	atom_flags = PREVENT_CONTENTS_EXPLOSION
	///Icon state displayed while something is being processed in the machine
	var/processiconstate = "spitter"
	var/current_split_dir
	var/rotate = 180

/obj/machinery/splitter/Initialize(mapload)
	. = ..()
	current_split_dir = (turn(dir, 90))
	add_overlay(image(icon, "direction_arrow"))

/obj/machinery/splitter/examine(mob/user, distance, infix, suffix)
	. = ..()
	. += "It is currently facing [dir2text(dir)] and [anchored ? "" : "un"]secured."

/obj/machinery/splitter/wrench_act(mob/living/user, obj/item/I)
	anchored = !anchored
	icon_state = anchored ? processiconstate : initial(icon_state)
	balloon_alert(user, "[anchored ? "" : "un"]anchored")
	playsound(loc, 'sound/items/ratchet.ogg', 25, 1)

/obj/machinery/splitter/screwdriver_act(mob/living/user, obj/item/I)
	setDir(turn(dir, 90))
	current_split_dir = (turn(current_split_dir, 90))
	balloon_alert(user, "Facing [dir2text(dir)]")

/obj/machinery/splitter/Bumped(atom/movable/bumper)
	. = ..()
	if(!isitem(bumper))
		return
	if(!(bumper.dir & dir))//need to be bumping into the back
		return
	if(!anchored)
		return
	if(isitemstack(bumper))
		var/obj/item/stack/stack = bumper
		if(stack.amount <= 1)
			bumper.forceMove(get_step(src, current_split_dir))
			current_split_dir = turn(current_split_dir, rotate)
		else
			var/first_stack_ammount = round(stack.amount * 0.5, 1)
			var/second_stack_ammount = stack.amount - first_stack_ammount
			qdel(bumper)
			var/obj/stack_1 = new stack.merge_type(loc, first_stack_ammount)
			stack_1.forceMove(get_step(src, current_split_dir))
			current_split_dir = turn(current_split_dir, rotate)
			var/obj/stack_2 = new stack.merge_type(loc, second_stack_ammount)
			stack_2.forceMove(get_step(src, current_split_dir))
	else
		bumper.forceMove(get_step(src, current_split_dir))
		current_split_dir = turn(current_split_dir, rotate)
