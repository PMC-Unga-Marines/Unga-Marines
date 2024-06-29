/turf/open/floor/mainship/terragov
	icon = 'modular_RUtgmc/icons/turf/mainship.dmi'

/turf/open/floor/corsat
	icon = 'modular_RUtgmc/icons/turf/corsat.dmi'
	icon_state = "squareswood"
	base_icon_state = "squareswood"

/turf/open/floor/strata //Instance me!
	icon = 'modular_RUtgmc/icons/turf/strata_floor.dmi'
	base_icon_state = "floor"
	icon_state = "floor"

/turf/open/floor/strata/multi_tiles
	icon_state = "multi_tiles"
	color = "#5e5d5d"

/turf/open/floor/sandstone
	name = "sandstone floor"
	icon = 'modular_RUtgmc/icons/turf/sandstone.dmi'
	base_icon_state = "whiteyellowfull"
	icon_state = "whiteyellowfull"

/turf/open/floor/sandstone/runed
	name = "sandstone temple floor"
	base_icon_state = "runedsandstone"
	icon_state = "runedsandstone"

/turf/open/floor/carpet/ex_act(severity)
	if(hull_floor)
		return ..()
	if(prob(severity / 2))
		make_plating()
	return ..()
