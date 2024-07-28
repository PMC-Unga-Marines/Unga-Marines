/obj/structure/xeno/core
	name = "Xeno mind core"
	icon = 'icons/Xeno/resin_silo.dmi' // поменять потом
	icon_state = "weed_silo"
	desc = "A slimy, oozy resin bed filled with foul-looking egg-like ...things."
	bound_width = 96
	bound_height = 96
	max_integrity = 1000
	resistance_flags = UNACIDABLE | DROPSHIP_IMMUNE | PLASMACUTTER_IMMUNE
	xeno_structure_flags = IGNORE_WEED_REMOVAL|CRITICAL_STRUCTURE

///Change minimap icon if silo is under attack or not
/obj/structure/xeno/core/proc/update_minimap_icon()
	SSminimaps.remove_marker(src)
	SSminimaps.add_marker(src, MINIMAP_FLAG_XENO, image('icons/UI_icons/map_blips.dmi', null, "silo_passive", VERY_HIGH_FLOAT_LAYER))

/obj/structure/xeno/core/Destroy()
	var/datum/game_mode/infestation/mode = SSticker.mode //make sure mode is points defence
	mode.round_stage = INFESTATION_MARIN_RUSH_MAJOR
	return ..()
