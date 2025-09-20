/obj/machinery/landinglight
	name = "landing light"
	icon = 'icons/obj/landinglights.dmi'
	icon_state = "landingstripe"
	desc = "A landing light, if it's flashing stay clear!"
	anchored = TRUE
	density = FALSE
	layer = LOWER_RUNE_LAYER
	plane = FLOOR_PLANE
	use_power = ACTIVE_POWER_USE
	idle_power_usage = 2
	active_power_usage = 20
	resistance_flags = RESIST_ALL|DROPSHIP_IMMUNE
	///ID of dropship
	var/id
	///port its linked to
	var/obj/docking_port/stationary/marine_dropship/linked_port = null

/obj/machinery/landinglight/Initialize(mapload)
	. = ..()
	GLOB.landing_lights += src

/obj/machinery/landinglight/Destroy()
	GLOB.landing_lights -= src
	return ..()

/obj/machinery/landinglight/proc/turn_on()
	icon_state = "landingstripe_1"
	set_light(2, 2, LIGHT_COLOR_RED)

/obj/machinery/landinglight/proc/turn_off()
	icon_state = "landingstripe"
	set_light(0)

/obj/machinery/landinglight/alamo
	id = SHUTTLE_NORMANDY //bruh

/obj/machinery/landinglight/lz1
	id = "lz1"

/obj/machinery/landinglight/lz2
	id = "lz2"

/obj/machinery/landinglight/cas
	id = SHUTTLE_CAS_DOCK

/obj/machinery/landinglight/tadpole
	id = SHUTTLE_TADPOLE
