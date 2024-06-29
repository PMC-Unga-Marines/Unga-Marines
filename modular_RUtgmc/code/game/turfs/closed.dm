/turf/closed/get_explosion_resistance()
	return EXPLOSION_MAX_POWER
/turf/closed/shuttle/dropship1
	resistance_flags = NONE

/turf/closed/shuttle/dropship2
	resistance_flags = RESIST_ALL|PLASMACUTTER_IMMUNE

/turf/closed/shuttle/dropship2/interiorwindow
	icon_state = "shuttle_interior_inwards"
	allow_pass_flags = PASS_GLASS
	opacity = FALSE

/turf/closed/shuttle/dropship2/panel
	opacity = FALSE

/turf/closed/shuttle/dropship2/glassthree
	opacity = FALSE

/turf/closed/shuttle/dropship2/glassfour
	opacity = FALSE

/turf/closed/shuttle/dropship2/glassfive
	opacity = FALSE

/turf/closed/shuttle/dropship2/glasssix
	opacity = FALSE

/turf/closed/gm/ex_act(severity)
	if(severity >= EXPLODE_DEVASTATE)
		ChangeTurf(/turf/open/ground/grass)
