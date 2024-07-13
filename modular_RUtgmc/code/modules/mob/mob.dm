/mob
	///Slowdown from readying shields
	var/shield_slowdown = 0
	///Color matrices to be applied to the client window. Assoc. list.
	var/list/client_color_matrices

// Shows three different messages depending on who does it to who and how does it look like to outsiders
// message_mob: "You do something to X!"
// message_affected: "Y does something to you!"
// message_viewer: "X does something to Y!"
/mob/proc/affected_message(mob/affected, message_mob, message_affected, message_viewer)
	src.show_message(message_mob, EMOTE_VISIBLE)
	if(src != affected)
		affected.show_message(message_affected, EMOTE_VISIBLE)
	for(var/mob/V in viewers(7, src))
		if(V != src && V != affected)
			V.show_message(message_viewer, EMOTE_VISIBLE)

/obj/effect/temp_visual/block //color is white by default, set to whatever is needed
	name = "blocking glow"
	icon_state = "block"
	icon = 'modular_RUtgmc/icons/effects/effects.dmi'
	duration = 6.7

/obj/effect/temp_visual/block/Initialize(mapload, set_color)
	if(set_color)
		add_atom_colour(set_color, FIXED_COLOUR_PRIORITY)
	. = ..()
	pixel_x = rand(-12, 12)
	pixel_y = rand(-9, 0)
