/obj/structure/ship_ammo/get_mechanics_info()
	. = ..()

	. += "<br>--------------COMBAT INFORMATION-------------------------"

	if(travelling_time)
		var/timetohit = travelling_time * 0.1
		. += "Time to drop = [timetohit] seconds.<br>"

	if(explosion_power)
		. += "The force of the explosion = [explosion_power].<br>"

	if(explosion_falloff)
		. += "Explosion will lose [explosion_falloff] power per turf.<br>"

	var/prediction_type_string
	switch(prediction_type)
		if(CAS_AMMO_EXPLOSIVE)
			prediction_type_string = "Explosive"
			. += "Ammo type = [prediction_type_string] rocket.<br>"
		if(CAS_AMMO_INCENDIARY)
			prediction_type_string = "Incendiary"
			. += "Ammo type = [prediction_type_string] rocket.<br>"
			. += "Radius of fire  = [fire_range] tiles.<br>"
		if(CAS_AMMO_HARMLESS)
			prediction_type_string = "Harmless"
			. += "Ammo type = [prediction_type_string] rocket. It doesn't deal any damage.<br>"
