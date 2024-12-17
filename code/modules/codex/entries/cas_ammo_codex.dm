/obj/structure/ship_ammo/get_antag_info()
	var/list/entries = SScodex.retrieve_entries_for_string(name)
	var/datum/codex_entry/general_entry = LAZYACCESS(entries, 1)
	if(general_entry?.antag_text)
		return general_entry.antag_text

/obj/structure/ship_ammo/get_lore_info()
	var/list/entries = SScodex.retrieve_entries_for_string(name)
	var/datum/codex_entry/general_entry = LAZYACCESS(entries, 1)
	if(general_entry?.lore_text)
		return general_entry.lore_text

/obj/structure/ship_ammo/get_mechanics_info()
	var/list/structure_strings = list()

	var/list/entries = SScodex.retrieve_entries_for_string(name)
	var/datum/codex_entry/general_entry = LAZYACCESS(entries, 1)
	if(general_entry?.mechanics_text)
		structure_strings += general_entry.mechanics_text + "<br>"

	if(climbable)
		structure_strings += "You can climb ontop of this structure."

	if(buckle_flags & CAN_BUCKLE)
		structure_strings += "You can buckle someone or yourself to this structure. <br>Click the structure or press 'resist' to unbuckle."

	if(CHECK_BITFIELD(resistance_flags, UNACIDABLE))
		structure_strings += "Acid does not stick to or affect this structure at all."
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		structure_strings += "You cannot destroy this structure."
	else
		structure_strings += "You can destroy this structure."
	if(CHECK_BITFIELD(resistance_flags, XENO_DAMAGEABLE))
		structure_strings += "Xenos can damage this structure."

	if(anchored)
		structure_strings += "It is anchored in place."

	// for (var/i in typesof(/obj/structure/ship_ammo))
	// 	if(travelling_time)
	// 		structure_strings += "Time to drop = [travelling_time]"
	// 	if(explosion_power)
	// 		structure_strings += "The force of the explosion [explosion_power]"

	structure_strings += "<br>--------------COMBAT INFORMATION-------------------------"

	if(travelling_time)
		var/timetohit = travelling_time / 10
		structure_strings += "Time to drop = [timetohit] seconds."

	if(explosion_power)
		structure_strings += "The force of the explosion = [explosion_power]."

	if(explosion_falloff)
		structure_strings += "Explosion will lose power per turf = [explosion_falloff]."

	var/prediction_type_string
	switch(prediction_type)
		if(CAS_AMMO_EXPLOSIVE)
			prediction_type_string = "Explosive"
			structure_strings += "Ammo type = [prediction_type_string] rocket."
		if(CAS_AMMO_INCENDIARY)
			prediction_type_string= "Incendiary"
			structure_strings += "Ammo type = [prediction_type_string] rocket."
			structure_strings += "Radius of fire  = [fire_range] tiles."

	. += jointext(structure_strings, "<br>")
