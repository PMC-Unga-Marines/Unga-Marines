/datum/buildmode_mode/basic
	key = "basic"


/datum/buildmode_mode/basic/show_help(client/c)
	to_chat(c, span_notice("***********************************************************"))
	to_chat(c, span_notice("Left Mouse Button = Construct / Upgrade"))
	to_chat(c, span_notice("Right Mouse Button = Deconstruct / Delete / Downgrade"))
	to_chat(c, span_notice("Left Mouse Button + ctrl = R-Window"))
	to_chat(c, span_notice("Left Mouse Button + alt = Airlock"))
	to_chat(c, "")
	to_chat(c, span_notice("Use the button in the upper left corner to"))
	to_chat(c, span_notice("change the direction of built objects."))
	to_chat(c, span_notice("***********************************************************"))


/datum/buildmode_mode/basic/handle_click(client/c, params, obj/object)
	var/list/pa = params2list(params)
	var/left_click = pa.Find("left")
	var/right_click = pa.Find("right")
	var/ctrl_click = pa.Find("ctrl")
	var/alt_click = pa.Find("alt")

	if(istype(object,/turf) && left_click && !alt_click && !ctrl_click)
		var/turf/T = object
		if(isspaceturf(object))
			T.place_on_top(/turf/open/floor/plating)
		else if(isfloorturf(object))
			T.place_on_top(/turf/closed/wall)
		else if(iswallturf(object))
			T.place_on_top(/turf/closed/wall/r_wall)
		log_admin("Build Mode: [key_name(c)] built [T] at [AREACOORD(T)]")
		to_chat(c, span_notice("Success."))
	else if(right_click)
		log_admin("Build Mode: [key_name(c)] deleted [object] at [AREACOORD(object)]")
		to_chat(c, span_notice("Success."))
		if(isturf(object))
			var/turf/T = object
			T.scrape_away()
		else if(isobj(object))
			qdel(object)
	else if(istype(object,/turf) && alt_click && left_click)
		log_admin("Build Mode: [key_name(c)] built an airlock at [AREACOORD(object)]")
		to_chat(c, span_notice("Success."))
		new /obj/machinery/door/airlock(get_turf(object))
	else if(istype(object,/turf) && ctrl_click && left_click)
		var/obj/structure/window/reinforced/window
		window = new /obj/structure/window/reinforced(get_turf(object))
		window.setDir(BM.build_dir)
		log_admin("Build Mode: [key_name(c)] built a window at [AREACOORD(object)]")
		to_chat(c, span_notice("Success."))
