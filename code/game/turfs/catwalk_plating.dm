/turf/open/floor/plating/plating_catwalk // TODO: repath it to just floor/catwalk_floor
	name = "catwalk"
	desc = "Cats really don't like these things."
	icon = 'icons/turf/catwalk_plating.dmi'
	icon_state = "catwalk_above"
	base_icon_state = "catwalk"
	shoefootstep = FOOTSTEP_CATWALK
	barefootstep = FOOTSTEP_CATWALK
	mediumxenofootstep = FOOTSTEP_CATWALK
	baseturfs = /turf/open/floor/plating/mainship
	/// Are we covered by the upper catwalk part?
	var/covered = TRUE

/turf/open/floor/plating/plating_catwalk/Initialize(mapload)
	. = ..()
	underlays += mutable_appearance(icon, "[base_icon_state]_under", LOW_FLOOR_LAYER, src, FLOOR_PLANE)
	update_overlays(UPDATE_OVERLAYS)

/turf/open/floor/plating/plating_catwalk/update_overlays()
	. = ..()
	if(!covered)
		return
	. += mutable_appearance(icon, "[base_icon_state]_above", CATWALK_LAYER, src, FLOOR_PLANE, appearance_flags = KEEP_APART)

/turf/open/floor/plating/plating_catwalk/attackby(obj/item/I, mob/user)
	. = ..()
	if(.)
		return
	if(!istype(I, /obj/item/stack/catwalk))
		return
	if(covered)
		return
	var/obj/item/stack/catwalk/E = I
	E.use(1)
	covered = TRUE
	icon_state = "[base_icon_state]_above"
	update_appearance(UPDATE_OVERLAYS)

/turf/open/floor/plating/plating_catwalk/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(!covered)
		return
	var/obj/item/stack/catwalk/R = new(user.loc)
	R.add_to_stacks(user)
	covered = FALSE
	icon_state = "[base_icon_state]_under"
	update_appearance(UPDATE_OVERLAYS)

/turf/open/floor/plating/plating_catwalk/make_plating()
	return scrape_away()

/turf/open/floor/plating/plating_catwalk/prison
	icon_state = "prison_above"
	base_icon_state = "prison"
	baseturfs = /turf/open/floor/plating

/turf/open/floor/plating/plating_catwalk/dark
	icon_state = "dark_above"
	base_icon_state = "dark"

/turf/open/floor/plating/plating_catwalk/light
	icon_state = "light_above"
	base_icon_state = "light"
