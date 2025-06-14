//Jaeger Mk.II

//Medium
/obj/item/clothing/suit/modular/jaeger
	name = "\improper Jaeger Infantry medium exoskeleton"
	desc = "A Infantry-pattern Jaeger combat exoskeleton made to work with modular attachments for the ability to function in many enviroments. This one seems to have a moderate amount of armor plating. Alt-Click to remove attached items. Use it to toggle the built-in flashlight."

	icon_state = "chest"
	worn_icon_state = "chest"
	soft_armor = MARINE_ARMOR_MEDIUM
	slowdown = SLOWDOWN_ARMOR_MEDIUM

	item_map_variant_flags = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT

	greyscale_config = /datum/greyscale_config/armor_mk2/infantry
	colorable_allowed = PRESET_COLORS_ALLOWED
	colorable_colors = ARMOR_PALETTES_LIST
	greyscale_colors = ARMOR_PALETTE_DRAB

	allowed_uniform_type = /obj/item/clothing/under

/obj/item/clothing/suit/modular/jaeger/generate_attachments_allowed()
	attachments_allowed = general_list_of_marine_modules.Copy()

/obj/item/clothing/suit/modular/jaeger/eva
	name = "\improper Jaeger EVA medium exoskeleton"
	desc = "A EVA-pattern Jaeger combat exoskeleton made to work with modular attachments for the ability to function in many enviroments. This one seems to have a moderate amount of armor plating. Alt-Click to remove attached items. Use it to toggle the built-in flashlight."
	greyscale_config = /datum/greyscale_config/armor_mk2/eva

/obj/item/clothing/suit/modular/jaeger/helljumper
	name = "\improper Jaeger Hell Jumper medium exoskeleton"
	desc = "A Hell-Jumper-pattern Jaeger combat exoskeleton made to work with modular attachments for the ability to function in many enviroments. This one seems to have a moderate amount of armor plating. Alt-Click to remove attached items. Use it to toggle the built-in flashlight."
	greyscale_config = /datum/greyscale_config/armor_mk2/helljumper

/obj/item/clothing/suit/modular/jaeger/ranger
	name = "\improper Jaeger Ranger medium exoskeleton"
	desc = "A Ranger-pattern Jaeger combat exoskeleton made to work with modular attachments for the ability to function in many enviroments. This one seems to have a moderate amount of armor plating. Alt-Click to remove attached items. Use it to toggle the built-in flashlight."
	greyscale_config = /datum/greyscale_config/armor_mk2/ranger

/obj/item/clothing/suit/modular/jaeger/hotaru
	name = "\improper Style Pattern Hotaru medium exoskeleton"
	desc = "A Ranger-pattern Hotaru combat exoskeleton made to work with modular attachments for the ability to function in many enviroments. This one seems to have a moderate amount of armor plating. Alt-Click to remove attached items. Use it to toggle the built-in flashlight."
	greyscale_config = /datum/greyscale_config/armor_mk2/hotaru

// Light

/obj/item/clothing/suit/modular/jaeger/light
	name = "\improper Jaeger Scout light exoskeleton"
	desc = "A Scout-pattern Jaeger combat exoskeleton made to work with modular attachments for the ability to function in many enviroments. This one seems to have a light amount of armor plating. Alt-Click to remove attached items. Use it to toggle the built-in flashlight."
	soft_armor = MARINE_ARMOR_LIGHT
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	greyscale_config = /datum/greyscale_config/armor_mk2/scout

/obj/item/clothing/suit/modular/jaeger/light/skirmisher
	name = "\improper Jaeger Skirmisher light exoskeleton"
	desc = "A Skirmisher-pattern Jaeger combat exoskeleton made to work with modular attachments for the ability to function in many enviroments. This one seems to have a light amount of armor plating. Alt-Click to remove attached items. Use it to toggle the built-in flashlight."
	greyscale_config = /datum/greyscale_config/armor_mk2/skirmisher

/obj/item/clothing/suit/modular/jaeger/light/trooper
	name = "\improper Jaeger Trooper light exoskeleton"
	desc = "A Trooper-pattern Jaeger combat exoskeleton made to work with modular attachments for the ability to function in many enviroments. This one seems to have a light amount of armor plating. Alt-Click to remove attached items. Use it to toggle the built-in flashlight."
	greyscale_config = /datum/greyscale_config/armor_mk2/trooper

// Heavy
/obj/item/clothing/suit/modular/jaeger/heavy
	name = "\improper Jaeger Gungnir heavy exoskeleton"
	desc = "A Gungnir-pattern Jaeger combat exoskeleton made to work with modular attachments for the ability to function in many enviroments. This one seems to have a high amount of armor plating. Alt-Click to remove attached items. Use it to toggle the built-in flashlight."
	soft_armor = MARINE_ARMOR_HEAVY
	slowdown = SLOWDOWN_ARMOR_HEAVY
	greyscale_config = /datum/greyscale_config/armor_mk2/gugnir

/obj/item/clothing/suit/modular/jaeger/heavy/assault
	name = "\improper Jaeger Assault heavy exoskeleton"
	desc = "A Assault-pattern Jaeger combat exoskeleton made to work with modular attachments for the ability to function in many enviroments. This one seems to have a high amount of armor plating. Alt-Click to remove attached items. Use it to toggle the built-in flashlight."
	greyscale_config = /datum/greyscale_config/armor_mk2

/obj/item/clothing/suit/modular/jaeger/heavy/eod
	name = "\improper Jaeger EOD heavy exoskeleton"
	desc = "A EOD-pattern Jaeger combat exoskeleton made to work with modular attachments for the ability to function in many enviroments. This one seems to have a high amount of armor plating. Alt-Click to remove attached items. Use it to toggle the built-in flashlight."
	greyscale_config = /datum/greyscale_config/armor_mk2/eod

//jaeger hats
/obj/item/clothing/head/modular/marine
	name = "Jaeger Pattern Infantry Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Infantry markings."
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	icon_state = "helmet"
	worn_icon_state = "helmet"
	icon_override = null
	soft_armor = MARINE_ARMOR_MEDIUM
	greyscale_colors = ARMOR_PALETTE_DRAB
	colorable_allowed = PRESET_COLORS_ALLOWED|HAIR_CONCEALING_CHANGE_ALLOWED
	colorable_colors = ARMOR_PALETTES_LIST
	greyscale_config = /datum/greyscale_config/armor_mk2/infantry

	starting_attachments = list(/obj/item/armor_module/armor/visor/marine, /obj/item/armor_module/storage/helmet)

	item_map_variant_flags = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT

/obj/item/clothing/head/modular/marine/eva
	name = "Jaeger Pattern EVA Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has EVA markings."
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/eva, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/eva

/obj/item/clothing/head/modular/marine/eva/skull
	name = "Jaeger Pattern EVA 'Skull' Helmet"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/eva/skull, /obj/item/armor_module/storage/helmet)

/obj/item/clothing/head/modular/marine/skirmisher
	name = "Jaeger Pattern Skirmisher Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Skirmisher markings."
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/skirmisher, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/skirmisher

/obj/item/clothing/head/modular/marine/scout
	name = "Jaeger Pattern Scout Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Scout markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/scout, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/scout

/obj/item/clothing/head/modular/marine/gungnir
	name = "Jaeger Pattern Gungnir Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Gungnir markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/gungnir, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/gugnir

/obj/item/clothing/head/modular/marine/assault
	name = "Jaeger Pattern Assault Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Assault markings."
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/assault, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2

/obj/item/clothing/head/modular/marine/eod
	name = "Jaeger Pattern EOD Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has EOD markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/eod, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/eod

/obj/item/clothing/head/modular/marine/helljumper
	name = "Jaeger Pattern Helljumper Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Helljumper markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/helljumper, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/helljumper
	visorless_offset_y = 0

/obj/item/clothing/head/modular/marine/ranger
	name = "Jaeger Pattern Ranger Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Ranger markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/ranger, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/ranger

/obj/item/clothing/head/modular/marine/traditional
	name = "Jaeger Pattern Traditional Ranger Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has traditional Ranger markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/traditional, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/traditional

/obj/item/clothing/head/modular/marine/trooper
	name = "Jaeger Pattern Trooper Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Trooper markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/trooper, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/trooper

/obj/item/clothing/head/modular/marine/kabuto
	name = "Style Pattern Kabuto Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Kabuto markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/kabuto, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/kabuto

/obj/item/clothing/head/modular/marine/hotaru
	name = "Style Pattern Hotaru Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Hotaru markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/hotaru, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/hotaru

/obj/item/clothing/head/modular/marine/dashe
	name = "Style Pattern Dashe Helmet"
	desc = "Usually paired with the Jaeger Combat Exoskeleton. Can mount utility functions on the helmet hard points. Has Dashe markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/dashe, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/dashe

// Hardsuit Helmets

/obj/item/clothing/head/modular/marine/hardsuit_helm
	name = "FleckTex Base Hardsuit Helmet"
	desc = "Usually paired with the FleckTex WY-01 modular exoskeleton. Can mount utility functions on the helmet hard points. Has Base markings"
	greyscale_config = /datum/greyscale_config/hardsuit_variant
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine, /obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/secondary_color/helm)
	attachments_by_slot = list(
		ATTACHMENT_SLOT_VISOR,
		ATTACHMENT_SLOT_STORAGE,
		ATTACHMENT_SLOT_HEAD_MODULE,
		ATTACHMENT_SLOT_BADGE,
		ATTACHMENT_SLOT_HELM_SECONDARY_COLOR,
	)

/obj/item/clothing/head/modular/marine/hardsuit_helm/markfive
	name = "FleckTex Mark V Breacher Helmet"
	desc = "Usually paired with the FleckTex WY-01 modular exoskeleton. Can mount utility functions on the helmet hard points. Has Breacher markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/fourvisor, /obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/secondary_color/helm)
	greyscale_config = /datum/greyscale_config/hardsuit_variant/syndicate_markfive

/obj/item/clothing/head/modular/marine/hardsuit_helm/markthree
	name = "FleckTex Mark III Marauder Helmet"
	desc = "Usually paired with the FleckTex WY-01 modular exoskeleton. Can mount utility functions on the helmet hard points. Has Marauder markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/foureyevisor, /obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/secondary_color/helm)
	greyscale_config = /datum/greyscale_config/hardsuit_variant/syndicate_markthree

/obj/item/clothing/head/modular/marine/hardsuit_helm/markone
	name = "FleckTex Mark I Raider Helmet"
	desc = "Usually paired with the FleckTex WY-01 modular exoskeleton. Can mount utility functions on the helmet hard points. Has Raider markings"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/markonevisor, /obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/secondary_color/helm)
	greyscale_config = /datum/greyscale_config/hardsuit_variant


