/obj/item/clothing/glasses/ru
	name = "ru glasses"
	desc = "ru glasses"
	icon = 'modular_RUtgmc/icons/obj/clothing/glasses.dmi'
	item_icons = list(
		slot_glasses_str = 'modular_RUtgmc/icons/mob/clothing/eyes.dmi')

/obj/item/clothing/glasses/ru/orange
	name = "orange glasses"
	desc = "A pair of orange glasses."
	icon_state = "orange"
	item_state = "orange"
	deactive_state = "orange"
	species_exception = list(/datum/species/robot)

/obj/item/clothing/glasses/ru/orange/attackby(obj/item/our_item, mob/user, params)
	. = ..()
	if(istype(our_item, /obj/item/clothing/glasses/hud/health))
		var/obj/item/clothing/glasses/hud/orange_glasses/our_glasses = new
		to_chat(user, span_notice("You fasten the medical hud projector to the inside of the glasses."))
		qdel(our_item)
		qdel(src)
		user.put_in_hands(our_glasses)
		update_icon(user)
	else if(istype(our_item, /obj/item/clothing/glasses/night/imager_goggles))
		var/obj/item/clothing/glasses/night/imager_goggles/orange_glasses/our_glasses = new
		to_chat(user, span_notice("You fasten the optical imager scaner to the inside of the glasses."))
		qdel(our_item)
		qdel(src)
		user.put_in_hands(our_glasses)
		update_icon(user)
	else if(istype(our_item, /obj/item/clothing/glasses/meson))
		var/obj/item/clothing/glasses/meson/orange_glasses/our_glasses = new
		to_chat(user, span_notice("You fasten the optical meson scaner to the inside of the glasses."))
		qdel(our_item)
		qdel(src)
		user.put_in_hands(our_glasses)
		update_icon(user)

/obj/item/clothing/glasses/eyepatch/attackby(obj/item/our_item, mob/user, params)
	. = ..()
	if(istype(our_item, /obj/item/clothing/glasses/night/imager_goggles))
		var/obj/item/clothing/glasses/night/imager_goggles/eyepatch/our_glasses = new
		to_chat(user, span_notice("You fasten the optical scanner to the inside of the eyepatch."))
		qdel(our_item)
		qdel(src)
		user.put_in_hands(our_glasses)
		update_icon(user)

/obj/item/clothing/glasses/mgoggles/attackby(obj/item/our_item, mob/user, params)
	. = ..()
	if(istype(our_item, /obj/item/clothing/glasses/night/imager_goggles))
		if(prescription)
			var/obj/item/clothing/glasses/night/optgoggles/prescription/our_glasses = new
			to_chat(user, span_notice("You fasten the optical imaging scanner to the inside of the goggles."))
			qdel(our_item)
			qdel(src)
			user.put_in_hands(our_glasses)
		else
			var/obj/item/clothing/glasses/night/optgoggles/our_glasses = new
			to_chat(user, span_notice("You fasten the optical imaging scanner to the inside of the goggles."))
			qdel(our_item)
			qdel(src)
			user.put_in_hands(our_glasses)
		update_icon(user)

/obj/item/clothing/glasses/sunglasses/fake/attackby(obj/item/our_item, mob/user, params)
	. = ..()
	if(istype(our_item, /obj/item/clothing/glasses/night/imager_goggles))
		var/obj/item/clothing/glasses/night/imager_goggles/sunglasses/our_glasses = new
		to_chat(user, span_notice("You fasten the optical imager scaner to the inside of the glasses."))
		qdel(our_item)
		qdel(src)
		user.put_in_hands(our_glasses)
		update_icon(user)

/obj/item/clothing/glasses/meson/orange_glasses
	name = "Orange glasses"
	desc = "A pair of orange glasses. This pair has been fitted with an optical meson scanner."
	icon = 'modular_RUtgmc/icons/obj/clothing/glasses.dmi'
	item_icons = list(
		slot_glasses_str = 'modular_RUtgmc/icons/mob/clothing/eyes.dmi')
	icon_state = "meson_orange"
	item_state = "meson_orange"
	deactive_state = "d_orange"
	prescription = TRUE

/obj/item/clothing/glasses/night/imager_goggles/orange_glasses
	name = "Orange glasses"
	desc = "A pair of orange glasses. This pair has been fitted with an internal optical imager scanner."
	icon = 'modular_RUtgmc/icons/obj/clothing/glasses.dmi'
	item_icons = list(
		slot_glasses_str = 'modular_RUtgmc/icons/mob/clothing/eyes.dmi')
	icon_state = "optical_orange"
	item_state = "optical_orange"
	deactive_state = "d_orange"
	prescription = TRUE

/obj/item/clothing/glasses/hud/orange_glasses
	name = "Orange glasses"
	desc = "A pair of orange glasses. This pair has been fitted with an internal HealthMate HUD projector."
	icon = 'modular_RUtgmc/icons/obj/clothing/glasses.dmi'
	item_icons = list(
		slot_glasses_str = 'modular_RUtgmc/icons/mob/clothing/eyes.dmi')
	icon_state = "med_orange"
	item_state = "med_orange"
	deactive_state = "d_orange"
	prescription = TRUE
	toggleable = TRUE
	hud_type = DATA_HUD_MEDICAL_ADVANCED
	actions_types = list(/datum/action/item_action/toggle)
