/obj/item/clothing/mask/muzzle
	name = "muzzle"
	desc = "To stop that awful noise."
	icon_state = "muzzle"
	worn_icon_state = "muzzle"
	inventory_flags = COVERMOUTH
	armor_protection_flags = NONE
	w_class = WEIGHT_CLASS_SMALL
	gas_transfer_coefficient = 0.90

/obj/item/clothing/mask/surgical
	name = "sterile mask"
	desc = "A sterile mask designed to help prevent the spread of diseases."
	icon_state = "sterile"
	worn_icon_state = "sterile"
	w_class = WEIGHT_CLASS_SMALL
	inventory_flags = COVERMOUTH
	armor_protection_flags = NONE
	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.01
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 25, FIRE = 0, ACID = 0)

/obj/item/clothing/mask/fakemoustache
	name = "fake moustache"
	desc = "Warning: moustache is fake."
	icon_state = "fake-moustache"
	inv_hide_flags = HIDEFACE
	armor_protection_flags = NONE

/obj/item/clothing/mask/snorkel
	name = "Snorkel"
	desc = "For the Swimming Savant."
	icon_state = "snorkel"
	inv_hide_flags = HIDEFACE
	armor_protection_flags = NONE

/obj/item/clothing/mask/balaclava
	name = "balaclava"
	desc = "LOADSAMONEY"
	icon_state = "balaclava"
	worn_icon_state = "balaclava"
	inv_hide_flags = HIDEFACE|HIDEALLHAIR
	armor_protection_flags = FACE
	w_class = WEIGHT_CLASS_SMALL
	worn_icon_list = list(
		slot_wear_mask_str = 'icons/mob/clothing/mask.dmi')

/obj/item/clothing/mask/luchador
	name = "Luchador Mask"
	desc = "Worn by robust fighters, flying high to defeat their foes!"
	icon_state = "luchag"
	worn_icon_state = "luchag"
	inv_hide_flags = HIDEFACE|HIDEALLHAIR
	cold_protection_flags = HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	armor_protection_flags = HEAD|FACE
	inventory_flags = COVERMOUTH
	w_class = WEIGHT_CLASS_SMALL
	siemens_coefficient = 3

/obj/item/clothing/mask/luchador/tecnicos
	name = "Tecnicos Mask"
	desc = "Worn by robust fighters who uphold justice and fight honorably."
	icon_state = "luchador"
	worn_icon_state = "luchador"

/obj/item/clothing/mask/luchador/rudos
	name = "Rudos Mask"
	desc = "Worn by robust fighters who are willing to do anything to win."
	icon_state = "luchar"
	worn_icon_state = "luchar"
