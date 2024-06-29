// Now that this has been replaced entirely by D.O.R.E.C, we just need something that translates old explosion calls into a D.O.R.E.C approximation
/proc/explosion(turf/epicenter, devastation_range, heavy_impact_range, light_impact_range, weak_impact_range, flash_range, flame_range = 0, flame_color = "red", throw_range, adminlog = TRUE, silent = FALSE, smoke = FALSE, color = LIGHT_COLOR_LAVA, direction)
	var/power = 0

	if(devastation_range)
		power += (50 * devastation_range)
	if(heavy_impact_range)
		power += (25 * heavy_impact_range)
	if(light_impact_range)
		power += (15 * light_impact_range)
	if(weak_impact_range)
		power += (5 * weak_impact_range)
	var/max_range = max(devastation_range, heavy_impact_range, light_impact_range, weak_impact_range, flash_range, flame_range)

	var/falloff = power / max_range
	cell_explosion(epicenter, power, falloff, EXPLOSION_FALLOFF_SHAPE_LINEAR, max_range, direction, color, silent, TRUE, adminlog)

	if(flame_range)
		flame_radius(flame_range, epicenter, colour = flame_color)
