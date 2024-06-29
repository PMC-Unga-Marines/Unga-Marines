/atom/movable/screen/minimap_locator
	icon = 'modular_RUTGMC/icons/UI_icons/map_blips.dmi'

/datum/controller/subsystem/minimaps/proc/add_zlevel(zlevel)
	minimaps_by_z["[zlevel]"] = new /datum/hud_displays
	var/icon/icon_gen = new('icons/UI_icons/minimap.dmi') //480x480 blank icon template for drawing on the map
	for(var/xval = 1 to world.maxx)
		for(var/yval = 1 to world.maxy) //Scan all the turfs and draw as needed
			var/turf/location = locate(xval,yval,zlevel)
			if(isspaceturf(location))
				continue
			if(location.density)
				icon_gen.DrawBox(location.minimap_color, xval, yval)
				continue
			var/atom/movable/alttarget = (locate(/obj/machinery/door) in location) || (locate(/obj/structure/fence) in location)
			if(alttarget)
				icon_gen.DrawBox(alttarget.minimap_color, xval, yval)
				continue
			var/area/turfloc = location.loc
			if(turfloc.minimap_color)
				icon_gen.DrawBox(BlendRGB(location.minimap_color, turfloc.minimap_color, 0.5), xval, yval)
				continue
			icon_gen.DrawBox(location.minimap_color, xval, yval)
	icon_gen.Scale(480*2,480*2) //scale it up x2 to make it easer to see
	icon_gen.Crop(1, 1, min(icon_gen.Width(), 480), min(icon_gen.Height(), 480)) //then cut all the empty pixels
	//generation is done, now we need to center the icon to someones view, this can be left out if you like it ugly and will halve SSinit time
	//calculate the offset of the icon
	var/largest_x = 0
	var/smallest_x = SCREEN_PIXEL_SIZE
	var/largest_y = 0
	var/smallest_y = SCREEN_PIXEL_SIZE
	for(var/xval=1 to SCREEN_PIXEL_SIZE step 2) //step 2 is twice as fast :)
		for(var/yval=1 to SCREEN_PIXEL_SIZE step 2) //keep in mind 1 wide giant straight lines will offset wierd but you shouldnt be mapping those anyway right???
			if(!icon_gen.GetPixel(xval, yval))
				continue
			if(xval > largest_x)
				largest_x = xval
			else if(xval < smallest_x)
				smallest_x = xval
			if(yval > largest_y)
				largest_y = yval
			else if(yval < smallest_y)
				smallest_y = yval

	minimaps_by_z["[zlevel]"].x_offset = FLOOR((SCREEN_PIXEL_SIZE-largest_x-smallest_x)/2, 1)
	minimaps_by_z["[zlevel]"].y_offset = FLOOR((SCREEN_PIXEL_SIZE-largest_y-smallest_y)/2, 1)

	icon_gen.Shift(EAST, minimaps_by_z["[zlevel]"].x_offset)
	icon_gen.Shift(NORTH, minimaps_by_z["[zlevel]"].y_offset)

	minimaps_by_z["[zlevel]"].hud_image = icon_gen //done making the image!

/datum/action/minimap/yautja
	minimap_flags = MINIMAP_FLAG_XENO|MINIMAP_FLAG_MARINE|MINIMAP_FLAG_MARINE_SOM|MINIMAP_FLAG_YAUTJA
	marker_flags = MINIMAP_FLAG_YAUTJA

/datum/action/minimap/observer
	minimap_flags = MINIMAP_FLAG_XENO|MINIMAP_FLAG_MARINE|MINIMAP_FLAG_MARINE_SOM|MINIMAP_FLAG_EXCAVATION_ZONE|MINIMAP_FLAG_YAUTJA
