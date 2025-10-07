/obj/machinery/floor_warn_light
	name = "alarm light"
	desc = "If this is on you should probably be running!"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "rotating_alarm"
	light_system = MOVABLE_LIGHT
	light_color = LIGHT_COLOR_RED
	plane = FLOOR_PLANE
	layer = LOWER_RUNE_LAYER
	light_mask_type = /atom/movable/lighting_mask/rotating_conical
	light_power = 6
	light_range = 4

/obj/machinery/floor_warn_light/self_destruct
	name = "self destruct alarm light"
	icon_state = "rotating_alarm_off"
	light_power = 0
	light_range = 0

/obj/machinery/floor_warn_light/self_destruct/Initialize(mapload)
	. = ..()
	SSevacuation.alarm_lights += src

/obj/machinery/floor_warn_light/self_destruct/Destroy()
	. = ..()
	SSevacuation.alarm_lights -= src

///Enables the alarm lights and makes them start flashing
/obj/machinery/floor_warn_light/self_destruct/proc/enable()
	icon_state = "rotating_alarm"
	set_light(4,6)

///Disables the alarm lights and makes them stop flashing
/obj/machinery/floor_warn_light/self_destruct/proc/disable()
	icon_state = initial(icon_state)
	set_light(0,0)
