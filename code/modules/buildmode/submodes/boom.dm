/datum/buildmode_mode/boom
	key = "boom"
	var/power_choice
	var/falloff_choice
	var/falloff_shape_choice


/datum/buildmode_mode/boom/show_help(client/c)
	to_chat(c, span_notice("***********************************************************"))
	to_chat(c, span_notice("Mouse Button on obj = Kaboom"))
	to_chat(c, span_notice("NOTE: Using the \"Config/Launch Supplypod\" verb allows you to do this in an IC way (ie making a cruise missile come down from the sky and explode wherever you click!)"))
	to_chat(c, span_notice("***********************************************************"))

/datum/buildmode_mode/boom/change_settings(client/client)
	power_choice = tgui_input_number(client, "Explosion Power", "Choose explosion power", 250, 5000, 1)
	if(isnull(power_choice))
		return
	falloff_choice = tgui_input_number(client, "Explosion Falloff", "Choose explosion falloff", 50, 5000, 1)
	if(isnull(falloff_choice))
		return
	switch(tgui_alert(client, "Falloff Shape", "Choose falloff shape", list("Linear", "Exponential"), 0))
		if("Linear")
			falloff_shape_choice = EXPLOSION_FALLOFF_SHAPE_LINEAR
		if("Exponential")
			falloff_shape_choice = EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL

/datum/buildmode_mode/boom/handle_click(client/c, params, obj/object)
	var/list/pa = params2list(params)
	var/left_click = pa.Find("left")

	if(left_click)
		cell_explosion(object, power_choice, falloff_choice, falloff_shape_choice, silent = TRUE)
		to_chat(c, span_notice("Success."))
		log_admin("Build Mode: [key_name(c)] caused an explosion (power = [power_choice], falloff = [falloff_choice], falloff_shape = [falloff_shape_choice] at [AREACOORD(object)]")
