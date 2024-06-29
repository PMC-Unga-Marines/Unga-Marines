/obj/item
	///Current hair concealing option selected.
	var/current_hair_concealment

/obj/item/color_item(obj/item/facepaint/paint, mob/living/carbon/human/user)

	if(paint.uses < 1)
		balloon_alert(user, "\the [paint] is out of color!")
		return

	var/list/selection_list = list()
	if(colorable_allowed & COLOR_WHEEL_ALLOWED)
		selection_list += COLOR_WHEEL
	if(colorable_allowed & PRESET_COLORS_ALLOWED && length(colorable_colors)>1)
		selection_list += PRESET_COLORS
	if(colorable_allowed & ICON_STATE_VARIANTS_ALLOWED && (length(icon_state_variants)>1))
		selection_list += VARIANTS
	if(colorable_allowed & HAIR_CONCEALING_CHANGE_ALLOWED)
		selection_list += HAIR_CONCEALING_CHANGE

	var/selection
	if(length(selection_list) == 1)
		selection = selection_list[1]
	else
		selection = tgui_input_list(user, "Choose a setting", name, selection_list)

	var/new_color
	var/hair_concealing_variants = list(
		HAIR_NO_CONCEALING,
		TOP_HAIR_CONCEALING,
		HAIR_PARTIALLY_CONCEALING,
		HAIR_FULL_CONCEALING,
	)
	switch(selection)
		if(VARIANTS)
			var/variant = tgui_input_list(user, "Choose a variant", "Variant", icon_state_variants)

			if(!variant)
				return

			if(!do_after(user, 1 SECONDS, NONE, src, BUSY_ICON_GENERIC))
				return

			current_variant = variant
			update_icon()
			update_greyscale()
			SEND_SIGNAL(src, COMSIG_ITEM_VARIANT_CHANGE, user, variant)
			return
		if(PRESET_COLORS)
			var/color_selection = tgui_input_list(user, "Pick a color", "Pick color", colorable_colors)
			if(!color_selection)
				return
			if(islist(colorable_colors[color_selection]))
				var/old_list = colorable_colors[color_selection]
				color_selection = tgui_input_list(user, "Pick a color", "Pick color", old_list)
				if(!color_selection)
					return
				new_color = old_list[color_selection]
			else
				new_color = colorable_colors[color_selection]
		if(COLOR_WHEEL)
			new_color = input(user, "Pick a color", "Pick color") as null|color

		if(HAIR_CONCEALING_CHANGE)
			var/concealment_variant = tgui_input_list(user, "Choose how much hair you want to conceal?", "Hair Concealment", hair_concealing_variants)
			if(!concealment_variant || !do_after(user, 1 SECONDS, NONE, src, BUSY_ICON_GENERIC))
				return

			current_hair_concealment = concealment_variant
			switch_hair_concealment_flags(user)

	if(!new_color || !do_after(user, 1 SECONDS, NONE, src, BUSY_ICON_GENERIC))
		return

	set_greyscale_colors(new_color)
	update_icon()
	update_greyscale()

/obj/item/proc/switch_hair_concealment_flags(mob/living/carbon/human/user)
	switch(current_hair_concealment)
		if(HAIR_NO_CONCEALING) // if you apply it to something that has different inv hide flags it will break it, so just don't i guess?
			flags_inv_hide = HIDEEARS
		if(TOP_HAIR_CONCEALING)
			flags_inv_hide = HIDEEARS|HIDETOPHAIR
		if(HAIR_PARTIALLY_CONCEALING)
			flags_inv_hide = HIDEEARS|HIDE_EXCESS_HAIR
		if(HAIR_FULL_CONCEALING)
			flags_inv_hide = HIDEEARS|HIDEALLHAIR
	user.update_hair()
