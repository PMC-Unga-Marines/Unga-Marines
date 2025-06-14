//Old jaeger for old grogs
/obj/item/clothing/head/modular/marine/old
	name = "Jaeger Mk.I Pattern Infantry Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Infantry markings."
	icon_state = "helmet"
	worn_icon_state = "helmet"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)

	greyscale_config = /datum/greyscale_config/armor_mk1/infantry
	greyscale_colors = ARMOR_PALETTE_DRAB
	colorable_allowed = PRESET_COLORS_ALLOWED|HAIR_CONCEALING_CHANGE_ALLOWED
	colorable_allowed = PRESET_COLORS_ALLOWED


	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/old, /obj/item/armor_module/storage/helmet)

/obj/item/clothing/head/modular/marine/old/open
	name = "Jaeger Mk.I Pattern Infantry Open Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points."
	starting_attachments = list(/obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/infantry/old
	visorless_offset_y = 0

/obj/item/clothing/head/modular/marine/old/eva
	name = "Jaeger Mk.I Pattern EVA Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has EVA markings."
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/old/eva, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/eva

/obj/item/clothing/head/modular/marine/old/eva/skull
	name = "Jaeger Mk.I Pattern EVA 'Skull' Helmet"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/old/eva/skull, /obj/item/armor_module/storage/helmet)

/obj/item/clothing/head/modular/marine/old/skirmisher
	name = "Jaeger Mk.I Pattern Skirmisher Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Skirmisher markings."
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/old/skirmisher, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/skirmisher

/obj/item/clothing/head/modular/marine/old/scout
	name = "Jaeger Mk.I Pattern Scout Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Scout markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/old/scout, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/scout

/obj/item/clothing/head/modular/marine/old/assault
	name = "Jaeger Mk.I Pattern Assault Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Assault markings."
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/old/assault, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1

/obj/item/clothing/head/modular/marine/old/eod
	name = "Jaeger Mk.I Pattern EOD Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has EOD markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/old/eod, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/eod
