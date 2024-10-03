/obj/item/stack
	icon = 'icons/obj/stack_objects.dmi'
	gender = PLURAL
	var/list/datum/stack_recipe/recipes
	var/singular_name
	var/stack_name = "stack"
	var/amount = 1
	///Also see stack recipes initialisation, param "max_res_amount" must be equal to this max_amount
	var/max_amount = 50
	///This path and its children should merge with this stack, defaults to src.type
	var/merge_type
	///Determines whether the item should update it's sprites based on amount.
	var/number_of_extra_variants = 0

/obj/item/stack/Initialize(mapload, new_amount)
	. = ..()
	if(new_amount)
		amount = new_amount
	while(amount > max_amount)
		amount -= max_amount
		new type(loc, max_amount)
	if(!merge_type)
		merge_type = type
	update_weight()
	update_icon()
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_cross),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/item/stack/proc/update_weight()
	var/percent = round((amount * 100) / max_amount)
	var/full_w_class = initial(w_class)
	var/new_w_class
	switch(percent) //Currently 3 steps as defined by STACK_WEIGHT_STEPS
		if(0 to 33)
			new_w_class = clamp(full_w_class-2, WEIGHT_CLASS_TINY, full_w_class)
		if(34 to 66)
			new_w_class = clamp(full_w_class-1, WEIGHT_CLASS_TINY, full_w_class)
		if(67 to 100)
			new_w_class = full_w_class
		else
			stack_trace("[src] tried to update_weight() with [amount] amount and [max_amount] max_amount.")
	if(new_w_class != w_class)
		w_class = new_w_class
		loc?.recalculate_storage_space() //No need to do icon updates if there are no changes.

/obj/item/stack/update_icon_state()
	. = ..()
	if(!number_of_extra_variants)
		return
	var/ratio = round((amount * (number_of_extra_variants + 1)) / max_amount)
	if(ratio < 1)
		icon_state = initial(icon_state)
		return
	ratio = min(ratio + 1, number_of_extra_variants + 1)
	icon_state = "[initial(icon_state)]_[ratio]"

/obj/item/stack/update_overlays()
	. = ..()
	if(isturf(loc))
		return
	var/mutable_appearance/number = mutable_appearance()
	number.maptext = MAPTEXT(amount)
	. += number

/obj/item/stack/Destroy()
	if(usr && usr.interactee == src)
		usr << browse(null, "window=stack")
	return ..()

/obj/item/stack/examine(mob/user)
	. = ..()
	if(amount > 1)
		. += EXAMINE_SECTION_BREAK
		. += "There are [amount] [singular_name]\s in the [stack_name]."

/obj/item/stack/equipped(mob/user, slot)
	. = ..()
	update_icon()

/obj/item/stack/removed_from_inventory(mob/user)
	. = ..()
	update_icon()

/obj/item/stack/interact(mob/user, recipes_sublist)
	. = ..()

	//We need to open the menu only if radial stacks are disabled, or if select_radial tells us to by returning TRUE
	if(!(!(user.client.prefs.toggles_gameplay & RADIAL_STACKS) || select_radial(user)))
		return

	if(.)
		return

	if(!recipes)
		return

	if(QDELETED(src) || get_amount() <= 0)
		DIRECT_OUTPUT(user, browse(null, "window=stack"))

	var/list/recipe_list = recipes
	if(recipes_sublist && recipe_list[recipes_sublist] && istype(recipe_list[recipes_sublist], /datum/stack_recipe_list))
		var/datum/stack_recipe_list/srl = recipe_list[recipes_sublist]
		recipe_list = srl.recipes
	var/t1 = "Amount Left: [get_amount()]<br>"
	for(var/i in 1 to length(recipe_list))
		var/E = recipe_list[i]
		if(isnull(E))
			t1 += "<hr>"
			continue
		if(i > 1 && !isnull(recipe_list[i-1]))
			t1+="<br>"

		if(istype(E, /datum/stack_recipe_list))
			var/datum/stack_recipe_list/srl = E
			t1 += "<a href='?src=[REF(src)];sublist=[i]'>[srl.title]</a>"

		if(istype(E, /datum/stack_recipe))
			var/datum/stack_recipe/recipe = E
			var/max_multiplier = round(get_amount() / recipe.req_amount)
			var/title
			var/can_build = TRUE
			can_build = can_build && (max_multiplier > 0)

			if(recipe.res_amount > 1)
				title += "[recipe.res_amount]x [recipe.title]\s"
			else
				title += "[recipe.title]"
			title += " ([recipe.req_amount] [singular_name]\s)"
			if(can_build)
				t1 += "<A href='?src=[REF(src)];sublist=[recipes_sublist];make=[i];multiplier=1'>[title]</A>  "
			else
				t1 += "[title]"
				continue
			if(recipe.max_res_amount > 1 && max_multiplier > 1)
				max_multiplier = min(max_multiplier, round(recipe.max_res_amount / recipe.res_amount))
				t1 += " |"
				var/list/multipliers = list(5,10,25)
				for(var/n in multipliers)
					if(max_multiplier >= n)
						t1 += " <A href='?src=[REF(src)];make=[i];multiplier=[n]'>[n * recipe.res_amount]x</A>"
				if(!(max_multiplier in multipliers))
					t1 += " <A href='?src=[REF(src)];make=[i];multiplier=[max_multiplier]'>[max_multiplier * recipe.res_amount]x</A>"

	var/datum/browser/popup = new(user, "stack", name, 400, 400)
	popup.set_content(t1)
	popup.open()

/obj/item/stack/Topic(href, href_list)
	. = ..()
	if(.)
		return
	if(usr.get_active_held_item() != src)
		return
	if(href_list["sublist"] && !href_list["make"])
		interact(usr, text2num(href_list["sublist"]))
	if(href_list["make"])
		if(zero_amount())
			return
		var/list/recipes_list = recipes
		if(href_list["sublist"])
			var/datum/stack_recipe_list/srl = recipes_list[text2num(href_list["sublist"])]
			recipes_list = srl.recipes
		var/datum/stack_recipe/recipe = recipes_list[text2num(href_list["make"])]
		var/multiplier = text2num(href_list["multiplier"])
		var/max_multiplier = round(max_amount / recipe.req_amount)
		if(multiplier <= 0 || multiplier > max_multiplier) //href protection
			log_admin_private("[key_name(usr)] attempted to create a ([src]) stack ([recipe]) recipe with multiplier [multiplier] at [AREACOORD(usr.loc)].")
			message_admins("[ADMIN_TPMONTY(usr)] attempted to create a ([src]) stack ([recipe]) recipe with multiplier [multiplier]. Possible HREF exploit.")
			return

		create_object(usr, recipe, multiplier)

/// Creates multiplier amount of objects based off oт stack recipe. Most creation variables are changed through stack recipe datum's variables
/obj/item/stack/proc/create_object(mob/user, datum/stack_recipe/recipe, multiplier)
	if(user.get_active_held_item() != src)
		return
	if(!can_interact(user))
		return TRUE
	if(!building_checks(user, recipe, multiplier))
		return
	if(user.do_actions)
		return
	var/building_time = recipe.time
	if(recipe.skill_req && user.skills.getRating(SKILL_CONSTRUCTION) < recipe.skill_req)
		building_time += recipe.time * (recipe.skill_req - user.skills.getRating(SKILL_CONSTRUCTION)) * 0.5 // +50% time each skill point lacking.
	if(recipe.skill_req && user.skills.getRating(SKILL_CONSTRUCTION) > recipe.skill_req)
		building_time -= clamp(recipe.time * (user.skills.getRating(SKILL_CONSTRUCTION) - recipe.skill_req) * 0.40, 0 , 0.85 * building_time) // -40% time each extra skill point
	if(building_time)
		balloon_alert_to_viewers("building [recipe.title]")
		if(!do_after(user, building_time, NONE, src, (building_time > recipe.time ? BUSY_ICON_UNSKILLED : BUSY_ICON_BUILD)))
			return
		if(!building_checks(user, recipe, multiplier))
			return

	var/obj/object
	if(recipe.max_res_amount > 1) //Is it a stack?
		object = new recipe.result_type(get_turf(user), recipe.res_amount * multiplier)
	else if(ispath(recipe.result_type, /turf))
		var/turf/our_turf = get_turf(user)
		if(!isturf(our_turf))
			return
		our_turf.PlaceOnTop(recipe.result_type)
	else
		object = new recipe.result_type(get_turf(user))
	if(object)
		object.setDir(user.dir)
		object.color = color
	use(recipe.req_amount * multiplier)

	if(QDELETED(object))
		return //It's a stack and has already been merged

	if(isitem(object))
		if(isitemstack(object))
			var/obj/item/stack/merged_item = object
			var/obj/item/stack/stacked_item = user.is_holding_item_of_type(merged_item.merge_type)
			if(stacked_item && merged_item.merge(stacked_item))
				return
		user.put_in_hands(object)

	if(istype(object, /obj/item/storage))
		for(var/obj/item/I in object)
			qdel(I)

	if(istype(object, /obj/structure))
		user.record_structures_built()

/obj/item/stack/proc/building_checks(mob/user, datum/stack_recipe/recipe, multiplier)
	if(get_amount() < recipe.req_amount*multiplier)
		if(recipe.req_amount*multiplier>1)
			to_chat(user, span_warning("You haven't got enough [src] to build \the [recipe.req_amount*multiplier] [recipe.title]\s!"))
		else
			to_chat(user, span_warning("You haven't got enough [src] to build \the [recipe.title]!"))
		return FALSE
	var/turf/T = get_turf(user)

	switch(recipe.max_per_turf)
		if(STACK_RECIPE_ONE_PER_TILE)
			if(locate(recipe.result_type) in T)
				to_chat(user, span_warning("There is another [recipe.title] here!"))
				return FALSE
		if(STACK_RECIPE_ONE_DIRECTIONAL_PER_TILE)
			for(var/obj/thing in T)
				if(!istype(thing, recipe.result_type))
					continue
				if(thing.dir != user.dir)
					continue
				to_chat(user, span_warning("You can't build \the [recipe.title] on top of another!"))
				return FALSE
	if(recipe.on_floor)
		if(!isfloorturf(T) && !isbasalt(T) && !islavacatwalk(T) && !isopengroundturf(T))
			to_chat(user, span_warning("\The [recipe.title] must be constructed on the floor!"))
			return FALSE
		for(var/obj/AM in T)
			if(istype(AM,/obj/structure/grille))
				continue
			if(istype(AM,/obj/structure/table))
				continue
			if(!AM.density)
				continue
			if(AM.flags_atom & ON_BORDER && AM.dir != user.dir)
				if(istype(AM, /obj/structure/window))
					var/obj/structure/window/W = AM
					if(!W.is_full_window())
						continue
				else
					continue
			to_chat(user, span_warning("There is a [AM.name] right where you want to place \the [recipe.title], blocking the construction."))
			return FALSE
	return TRUE

/obj/item/stack/use(used)
	if(used > amount) //If it's larger than what we have, no go.
		return FALSE
	amount -= used
	if(zero_amount())
		return TRUE
	update_icon()
	update_weight()
	return TRUE

/obj/item/stack/proc/zero_amount()
	if(amount < 1)
		qdel(src)
		return TRUE
	return FALSE

/obj/item/stack/proc/add(extra)
	if(amount + extra > max_amount)
		return FALSE
	amount += extra
	update_icon()
	update_weight()
	return TRUE

/obj/item/stack/proc/get_amount()
	return amount

/obj/item/stack/proc/add_to_stacks(mob/user)
	for(var/obj/item/stack/S in get_turf(user))
		if(S.merge_type != merge_type)
			continue
		merge(S)
		if(QDELETED(src))
			return

/obj/item/stack/proc/merge(obj/item/stack/stackable) //Merge src into S, as much as possible
	if(QDELETED(stackable) || QDELETED(src) || stackable == src) //amusingly this can cause a stack to consume itself, let's not allow that.
		return
	if(amount == max_amount) // don't do useless swapping
		return
	var/max_transfer = loc.max_stack_merging(stackable) //We don't want to bypass the max size the container allows.
	var/transfer = min(get_amount(), (max_transfer ? max_transfer : stackable.max_amount) - stackable.amount)
	stackable.add(transfer)
	use(transfer)
	return transfer

/obj/item/stack/proc/on_cross(datum/source, obj/item/stack/S, oldloc, oldlocs)
	SIGNAL_HANDLER
	if(istype(S, merge_type) && !S.throwing)
		merge(S)

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/stack/attack_hand(mob/living/user)
	if(user.get_inactive_held_item() == src)
		return change_stack(user, 1)
	return ..()

/obj/item/stack/AltClick(mob/user)
	if(isxeno(user))
		return ..()
	if(!can_interact(user))
		return ..() //Alt click on turf if not human or too far away.
	var/stackmaterial = tgui_input_number(user, "How many sheets do you wish to take out of this stack ?)", max_value = get_amount())
	stackmaterial = min(get_amount(), stackmaterial) //The amount could have changed since the input started.
	if(stackmaterial < 1 || !can_interact(user)) //In case we were transformed or moved away since the input started.
		return
	change_stack(user, stackmaterial)
	to_chat(user, span_notice("You take [stackmaterial] sheets out of the stack"))

/obj/item/stack/proc/change_stack(mob/user, new_amount)
	if(amount < 1 || amount < new_amount)
		stack_trace("[src] tried to change_stack() by [new_amount] amount for [user] user, while having [amount] amount itself.")
		return
	var/obj/item/stack/S = new type(user, new_amount)
	use(new_amount)
	user.put_in_hands(S)

/obj/item/stack/attackby(obj/item/I, mob/user)
	if(istype(I, merge_type))
		var/obj/item/stack/S = I
		if(merge(S))
			to_chat(user, span_notice("Your [S.name] stack now contains [S.get_amount()] [S.singular_name]\s."))
		return
	return ..()

/// Proc for special actions and radial menus on subtypes. Returning FALSE cancels the recipe menu for a stack.
/obj/item/stack/proc/select_radial(mob/user)
	return TRUE

/obj/item/stack/dropped(mob/user)
	add_to_stacks(user)
	return ..()

/*
* Recipe datum
*/
/datum/stack_recipe
	var/title = "ERROR"
	var/result_type
	var/req_amount = 1
	var/res_amount = 1
	var/max_res_amount = 1
	var/time = 0
	var/max_per_turf = STACK_RECIPE_INFINITE_PER_TILE
	var/on_floor = FALSE
	var/skill_req = FALSE //whether only people with sufficient construction skill can build this.


/datum/stack_recipe/New(title, result_type, req_amount = 1, res_amount = 1, max_res_amount = 1, time = 0, max_per_turf = STACK_RECIPE_INFINITE_PER_TILE, on_floor = FALSE, skill_req = FALSE)
	src.title = title
	src.result_type = result_type
	src.req_amount = req_amount
	src.res_amount = res_amount
	src.max_res_amount = max_res_amount
	src.time = time
	src.max_per_turf = max_per_turf
	src.on_floor = on_floor
	src.skill_req = skill_req

/*
* Recipe list datum
*/
/datum/stack_recipe_list
	var/title = "ERROR"
	var/list/recipes
	var/req_amount = 1

/datum/stack_recipe_list/New(title, recipes, req_amount = 1)
	src.title = title
	src.recipes = recipes
	src.req_amount = req_amount
