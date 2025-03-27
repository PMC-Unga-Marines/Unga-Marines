//tried to make this a alpha mask that moved up and down over the bar but I failed so whatever
/image/heat_bar
	icon = 'icons/effects/overheat.dmi'
	icon_state = "status_bar"
	plane = ABOVE_HUD_PLANE
	appearance_flags = APPEARANCE_UI_IGNORE_ALPHA

///takes a 0-1 value and then animates to display that percentage on this bar
/image/heat_bar/proc/animate_change(new_percentage, animate_time)
	if(new_percentage != 0)
		animate(src, color = gradient(COLOR_GREEN, COLOR_RED, new_percentage), alpha = 175, easing = SINE_EASING, time = animate_time)
		return
	animate(src, color = gradient(COLOR_GREEN, COLOR_RED, new_percentage), alpha = 0, easing = SINE_EASING, time = animate_time)
