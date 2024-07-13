///updates the boiler's glow, based on its base glow/color, and its ammo reserves. More green ammo = more green glow; more yellow = more yellow.
/mob/living/carbon/xenomorph/boiler/proc/update_boiler_glow()
	var/current_ammo = corrosive_ammo
	var/ammo_glow = BOILER_LUMINOSITY_AMMO * current_ammo
	var/glow = CEILING(BOILER_LUMINOSITY_BASE + ammo_glow, 1)
	var/color = BOILER_LUMINOSITY_BASE_COLOR
	if(current_ammo)
		var/ammo_color = BOILER_LUMINOSITY_AMMO_CORROSIVE_COLOR
		color = BlendRGB(color, ammo_color, (ammo_glow*2)/glow)
	if(!light_on && glow >= BOILER_LUMINOSITY_THRESHOLD)
		set_light_on(TRUE)
	else if(glow < BOILER_LUMINOSITY_THRESHOLD && !fire_luminosity)
		set_light_range_power_color(0, 0)
		set_light_on(FALSE)
	set_light_range_power_color(glow, 4, color)
