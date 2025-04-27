/obj/item/light_bulb
	icon = 'icons/obj/lighting.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/lights_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/lights_right.dmi',
	)
	force = 2
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	/// LIGHT_OK, LIGHT_BURNED or LIGHT_BROKEN
	var/status = 0
	/// Number of times switched
	var/switchcount = 0
	/// True if rigged to explode
	var/rigged = 0
	/// How much light it gives off
	var/brightness = 2

/obj/item/light_bulb/Initialize(mapload)
	. = ..()
	update()

/obj/item/light_bulb/throw_impact(atom/hit_atom)
	. = ..()
	if(!.)
		return
	shatter()

/obj/item/light_bulb/bulb/attack_turf(turf/T, mob/living/user)
	var/turf/open/floor/light/light_tile = T
	if(!istype(light_tile))
		return
	if(status != LIGHT_OK)
		to_chat(user, span_notice("The replacement bulb is broken."))
		return
	var/obj/item/stack/tile/light/existing_bulb = light_tile.floor_tile
	if(existing_bulb.state == LIGHT_TILE_OK)
		to_chat(user, span_notice("The lightbulb seems fine, no need to replace it."))
		return

	user.drop_held_item(src)
	qdel(src)
	existing_bulb.state = 0
	light_tile.update_icon()
	to_chat(user, span_notice("You replace the light bulb."))

/obj/item/light_bulb/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/reagent_containers/syringe))
		var/obj/item/reagent_containers/syringe/S = I

		to_chat(user, "You inject the solution into the [src].")

		if(S.reagents.has_reagent(/datum/reagent/toxin/phoron, 5))
			rigged = TRUE

		S.reagents.clear_reagents()

/obj/item/light_bulb/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(istype(target, /obj/machinery/light))
		return
	if(user.a_intent != INTENT_HARM)
		return
	shatter()

/// Update the icon state and description of the light
/obj/item/light_bulb/proc/update()
	switch(status)
		if(LIGHT_OK)
			icon_state = base_icon_state
			desc = "A replacement [name]."
		if(LIGHT_BURNED)
			icon_state = "[base_icon_state]_burned"
			desc = "A burnt-out [name]."
		if(LIGHT_BROKEN)
			icon_state = "[base_icon_state]_broken"
			desc = "A broken [name]."

/obj/item/light_bulb/proc/shatter()
	if(status == LIGHT_EMPTY || status == LIGHT_BROKEN)
		return
	visible_message(span_warning("[name] shatters."), span_warning("You hear a small glass object shatter."))
	status = LIGHT_BROKEN
	force = 5
	sharp = IS_SHARP_ITEM_SIMPLE
	playsound(loc, 'sound/effects/Glasshit.ogg', 25, 1)
	update()

/obj/item/light_bulb/tube
	name = "light tube"
	desc = "A replacement light tube."
	icon_state = "ltube"
	base_icon_state = "ltube"
	worn_icon_state = "c_tube"
	brightness = 8

/obj/item/light_bulb/tube/large
	w_class = WEIGHT_CLASS_SMALL
	name = "large light tube"
	brightness = 15

/obj/item/light_bulb/bulb
	name = "light bulb"
	desc = "A replacement light bulb."
	icon_state = "lbulb"
	base_icon_state = "lbulb"
	brightness = 5
