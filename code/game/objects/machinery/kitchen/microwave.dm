
/obj/machinery/microwave
	name = "Microwave"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "mw"
	layer = ABOVE_TABLE_LAYER
	density = TRUE
	anchored = TRUE
	coverage = 10
	use_power = IDLE_POWER_USE
	idle_power_usage = 5
	active_power_usage = 500
	/// Is it on?
	var/operating = 0
	/// = {0..100} Does it need cleaning?
	var/dirty = 0
	/// ={0,1,2} How broken is it???
	var/broken = 0
	/// List of the recipes you can use
	var/global/list/datum/recipe/available_recipes
	/// List of the items you can put in
	var/global/list/acceptable_items
	/// List of the reagents you can put in
	var/global/list/acceptable_reagents
	var/global/max_n_of_items = 0

// see code/modules/food/recipes_microwave.dm for recipes

/*******************
*   Initialising
********************/

/obj/machinery/microwave/Initialize(mapload)
	. = ..()
	create_reagents(100, OPENCONTAINER)
	if(!available_recipes)
		available_recipes = new
		for(var/type in subtypesof(/datum/recipe))
			available_recipes += new type
		acceptable_items = new
		acceptable_reagents = new
		for(var/datum/recipe/recipe AS in available_recipes)
			for(var/item in recipe.items)
				acceptable_items |= item
			for(var/reagent in recipe.reagents)
				acceptable_reagents |= reagent
			if(recipe.items)
				max_n_of_items = max(max_n_of_items,length(recipe.items))

/*******************
*   Item Adding
********************/

/obj/machinery/microwave/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(broken > 2)
		balloon_alert(user, "Cannot, broken")
		return TRUE

	else if(dirty == 100)
		if(!istype(I, /obj/item/reagent_containers/spray/cleaner))
			balloon_alert(user, "Very dirty")
			return TRUE

		balloon_alert_to_viewers("starts cleaning [src]")

		if(!do_after(user, 20, NONE, src, BUSY_ICON_BUILD))
			return TRUE

		balloon_alert_to_viewers("cleans the [src]")
		dirty = 0
		broken = 0
		icon_state = "mw"
		ENABLE_BITFIELD(reagents.reagent_flags, OPENCONTAINER)

	else if(is_type_in_list(I, acceptable_items))
		if(length(contents) >= max_n_of_items)
			balloon_alert(user, "Cannot, it's full")
			return TRUE

		if(istype(I, /obj/item/stack) && I:get_amount() > 1) // This is bad, but I can't think of how to change it
			var/obj/item/stack/S = I
			new S.type(src)
			S.use(1)
			balloon_alert_to_viewers("[user] adds [I] to the [src]")

		else if(user.drop_held_item())
			I.forceMove(src)
			balloon_alert_to_viewers("[user] has added [I] to the [src]")

	else if(istype(I,/obj/item/reagent_containers/glass) || \
			istype(I,/obj/item/reagent_containers/food/drinks) || \
			istype(I,/obj/item/reagent_containers/food/condiment))

		if(!I.reagents)
			return TRUE

		for(var/i in I.reagents.reagent_list)
			var/datum/reagent/R = i
			if(!(R.type in acceptable_reagents))
				balloon_alert(user, "Cannot, incompatible material for cooking")
				return TRUE

		return FALSE
	else
		balloon_alert(user, "Can't cook anything with this")
	return TRUE

/obj/machinery/microwave/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(broken != 2)
		return
	balloon_alert_to_viewers("starts to fix the microwave")
	if(!do_after(user,20, NONE, src, BUSY_ICON_BUILD))
		return
	balloon_alert_to_viewers("fixes part of the microwave")
	broken = 1

/obj/machinery/microwave/wrench_act(mob/living/user, obj/item/I)
	. = ..()

	if(broken != 1)
		return
	balloon_alert_to_viewers("starts to fix part of the microwave")
	if(!do_after(user,20, NONE, src, BUSY_ICON_BUILD))
		return
	balloon_alert_to_viewers("fixes the microwave")
	icon_state = "mw"
	broken = 0
	dirty = 0
	ENABLE_BITFIELD(reagents.reagent_flags, OPENCONTAINER)

/obj/machinery/microwave/grab_interact(obj/item/grab/grab, mob/user, base_damage = BASE_OBJ_SLAM_DAMAGE, is_sharp = FALSE)
	if(!is_operational())
		return ..()
	if(isxeno(user))
		return
	if(user.do_actions)
		return
	if(!isliving(grab.grabbed_thing))
		return
	if(user.a_intent != INTENT_HARM)
		return
	if(user.grab_state <= GRAB_AGGRESSIVE)
		to_chat(user, span_warning("You need a better grip to do that!"))
		return
	var/mob/living/grabbed_mob = grab.grabbed_thing
	if(grabbed_mob.mob_size > MOB_SIZE_HUMAN)
		to_chat(user, span_warning("They're too big to fit!"))
		return
	user.visible_message(span_danger("[user] starts to force [grabbed_mob] into [src]!"), span_notice("You start to force [grabbed_mob] into [src]!"))
	if(!do_after(user, 3 SECONDS, NONE, src, BUSY_ICON_HOSTILE, extra_checks = CALLBACK(src, PROC_REF(microwave_victim), grabbed_mob)))
		playsound(src.loc, 'sound/machines/ding.ogg', 25, 1)
		return

	user.visible_message(span_danger("[user] microwaves [grabbed_mob]!"), span_notice("You microwave [grabbed_mob]!"), "You hear sizzling.")
	log_combat(user, grabbed_mob, "microwaved")
	playsound(src.loc, 'sound/machines/ding.ogg', 25, 1)
	return TRUE

/obj/machinery/microwave/proc/microwave_victim(mob/living/victim)
	victim.apply_damage(3, BURN, "head", ENERGY, updating_health = TRUE, penetration = 20)
	victim.jitter(5)
	if(prob(10))
		victim.emote("scream")
		victim.adjust_brain_loss(5)
	if(victim.stat != DEAD)
		return TRUE

/obj/machinery/microwave/nopower
	use_power = NO_POWER_USE

/*******************
*   Microwave Menu
********************/

/obj/machinery/microwave/interact(mob/user) // The microwave Menu
	. = ..()
	if(.)
		return

	var/dat = ""
	if(src.broken > 0)
		dat = {"<TT>Bzzzzttttt</TT>"}
	else if(src.operating)
		dat = {"<TT>Microwaving in progress!<BR>Please wait...!</TT>"}
	else if(src.dirty==100)
		dat = {"<TT>This microwave is dirty!<BR>Please clean it before use!</TT>"}
	else
		var/list/items_counts = new
		var/list/items_measures = new
		var/list/items_measures_p = new
		for(var/obj/O in contents)
			var/display_name = O.name
			if(istype(O,/obj/item/reagent_containers/food/snacks/egg))
				items_measures[display_name] = "egg"
				items_measures_p[display_name] = "eggs"
			if(istype(O,/obj/item/reagent_containers/food/snacks/tofu))
				items_measures[display_name] = "tofu chunk"
				items_measures_p[display_name] = "tofu chunks"
			if(istype(O,/obj/item/reagent_containers/food/snacks/meat)) //any meat
				items_measures[display_name] = "slab of meat"
				items_measures_p[display_name] = "slabs of meat"
			if(istype(O,/obj/item/reagent_containers/food/snacks/donkpocket))
				display_name = "Turnovers"
				items_measures[display_name] = "turnover"
				items_measures_p[display_name] = "turnovers"
			if(istype(O,/obj/item/reagent_containers/food/snacks/carpmeat))
				items_measures[display_name] = "fillet of meat"
				items_measures_p[display_name] = "fillets of meat"
			items_counts[display_name]++
		for(var/O in items_counts)
			var/N = items_counts[O]
			if (!(O in items_measures))
				dat += {"<B>[capitalize(O)]:</B> [N] [lowertext(O)]\s<BR>"}
			else
				if(N==1)
					dat += {"<B>[capitalize(O)]:</B> [N] [items_measures[O]]<BR>"}
				else
					dat += {"<B>[capitalize(O)]:</B> [N] [items_measures_p[O]]<BR>"}

		for(var/datum/reagent/R in reagents.reagent_list)
			var/display_name = R.name
			if(R.type == /datum/reagent/consumable/capsaicin)
				display_name = "Hotsauce"
			if(R.type == /datum/reagent/consumable/frostoil)
				display_name = "Coldsauce"
			dat += {"<B>[display_name]:</B> [R.volume] unit\s<BR>"}

		if (length(items_counts) == 0 && length(reagents.reagent_list) == 0)
			dat = {"<B>The microwave is empty</B><BR>"}
		else
			dat = {"<b>Ingredients:</b><br>[dat]"}
		dat += {"<HR><BR>
			<a href='byond://?src=[text_ref(src)];action=cook'>Turn on!</a><br>
			<a href='byond://?src=[text_ref(src)];action=dispose'>Eject ingredients!</a>
		"}

	var/datum/browser/popup = new(user, "microwave", "<div align='center'>Microwave Controls</div>")
	popup.set_content(dat)
	popup.open()

/***********************************
*   Microwave Menu Handling/Cooking
************************************/
/obj/machinery/microwave/proc/cook()
	if(machine_stat & (NOPOWER|BROKEN))
		return
	start()
	if(reagents.total_volume==0 && !(locate(/obj) in contents)) //dry run
		if(!wzhzhzh(10))
			abort()
			return
		stop()
		return

	var/datum/recipe/recipe = select_recipe(available_recipes,src)
	var/obj/cooked
	if(!recipe)
		dirty += 1
		if(prob(max(10, dirty * 5)))
			if(!wzhzhzh(4))
				abort()
				return
			muck_start()
			wzhzhzh(4)
			muck_finish()
			cooked = fail()
			cooked.loc = loc
			return
		else if(has_extra_item())
			if(!wzhzhzh(4))
				abort()
				return
			broke()
			cooked = fail()
			cooked.loc = loc
			return
		else
			if(!wzhzhzh(10))
				abort()
				return
			stop()
			cooked = fail()
			cooked.loc = loc
			return
	else
		var/halftime = round(recipe.time * 0.1 * 0.5)
		if(!wzhzhzh(halftime))
			abort()
			return
		if(!wzhzhzh(halftime))
			abort()
			cooked = fail()
			cooked.loc = loc
			return
		cooked = recipe.make_food(src)
		stop()
		if(cooked)
			cooked.loc = loc
		return

/obj/machinery/microwave/proc/wzhzhzh(seconds as num)
	for(var/i = 1 to seconds)
		if(machine_stat & (NOPOWER|BROKEN))
			return FALSE
		use_power(active_power_usage)
		sleep(1 SECONDS)
	return TRUE

/obj/machinery/microwave/proc/has_extra_item()
	for(var/obj/O in contents)
		if(!istype(O,/obj/item/reagent_containers/food) && !istype(O, /obj/item/grown))
			return TRUE
	return FALSE

/obj/machinery/microwave/proc/start()
	balloon_alert_to_viewers("Turns on")
	operating = 1
	icon_state = "mw1"
	updateUsrDialog()

/obj/machinery/microwave/proc/abort()
	balloon_alert_to_viewers("Turns off")
	operating = 0 // Turn it off again aferwards
	icon_state = "mw"
	updateUsrDialog()

/obj/machinery/microwave/proc/stop()
	balloon_alert_to_viewers("Turns off")
	playsound(loc, 'sound/machines/ding.ogg', 25, 1)
	operating = 0 // Turn it off again aferwards
	icon_state = "mw"
	updateUsrDialog()

/obj/machinery/microwave/proc/destroy_contents()
	for(var/obj/O in contents)
		O.loc = loc
	if(reagents.total_volume)
		dirty++
	reagents.clear_reagents()
	balloon_alert(src, "Dumps the microwave contents")
	updateUsrDialog()

/obj/machinery/microwave/proc/muck_start()
	playsound(loc, 'sound/effects/splat.ogg', 25, 1) // Play a splat sound
	icon_state = "mwbloody1" // Make it look dirty!!

/obj/machinery/microwave/proc/muck_finish()
	playsound(loc, 'sound/machines/ding.ogg', 25, 1)
	visible_message(span_warning(" The microwave gets covered in muck!"))
	dirty = 100 // Make it dirty so it can't be used util cleaned
	DISABLE_BITFIELD(reagents.reagent_flags, OPENCONTAINER) //So you can't add condiments
	icon_state = "mwbloody0" // Make it look dirty too
	operating = 0 // Turn it off again aferwards
	updateUsrDialog()

/obj/machinery/microwave/proc/broke()
	var/datum/effect_system/spark_spread/s = new
	s.set_up(2, 1, src)
	s.start()
	icon_state = "mwb" // Make it look all busted up and shit
	visible_message(span_warning(" The microwave breaks!")) //Let them know they're stupid
	broken = 2 // Make it broken so it can't be used util fixed
	DISABLE_BITFIELD(reagents.reagent_flags, OPENCONTAINER) //So you can't add condiments
	operating = 0 // Turn it off again aferwards
	updateUsrDialog()

/obj/machinery/microwave/proc/fail()
	var/obj/item/reagent_containers/food/snacks/badrecipe/ffuu = new(src)
	var/amount = 0
	for(var/obj/O in contents-ffuu)
		amount++
		if(O.reagents)
			var/id = O.reagents.get_master_reagent_id()
			if(id)
				amount+=O.reagents.get_reagent_amount(id)
		qdel(O)
	reagents.clear_reagents()
	ffuu.reagents.add_reagent(/datum/reagent/carbon, amount)
	ffuu.reagents.add_reagent(/datum/reagent/toxin, amount * 0.1)
	return ffuu

/obj/machinery/microwave/Topic(href, href_list)
	. = ..()
	if(.)
		return

	switch(href_list["action"])
		if("cook")
			cook()

		if("dispose")
			destroy_contents()

	updateUsrDialog()
