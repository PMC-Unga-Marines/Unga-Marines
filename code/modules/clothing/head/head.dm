/obj/item/clothing/head
	name = "head"
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/clothing/hats_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/clothing/hats_right.dmi',
	)
	flags_armor_protection = HEAD
	flags_equip_slot = ITEM_SLOT_HEAD
	w_class = WEIGHT_CLASS_SMALL
	blood_sprite_state = "helmetblood"
	attachments_by_slot = list(ATTACHMENT_SLOT_BADGE)
	attachments_allowed = list(/obj/item/armor_module/armor/badge)
	var/anti_hug = 0

/obj/item/clothing/head/update_clothing_icon()
	if (ismob(loc))
		var/mob/M = loc
		M.update_inv_head()

/obj/item/clothing/head/update_greyscale(list/colors, update)
	. = ..()
	if(!greyscale_config)
		return
	item_icons = list(slot_head_str = icon)

/obj/item/clothing/head/MouseDrop(over_object, src_location, over_location)
	if(!attachments_by_slot[ATTACHMENT_SLOT_STORAGE])
		return ..()
	if(!istype(attachments_by_slot[ATTACHMENT_SLOT_STORAGE], /obj/item/armor_module/storage))
		return ..()
	var/obj/item/armor_module/storage/armor_storage = attachments_by_slot[ATTACHMENT_SLOT_STORAGE]
	if(armor_storage.storage.handle_mousedrop(usr, over_object))
		return ..()

/obj/item/clothing/head/examine(mob/user)
	. = ..()
	if(colorable_allowed & HAIR_CONCEALING_CHANGE_ALLOWED)
		. += span_notice("You can change the way it conceals the hair by using <b>facepaint</b> on it.")

/obj/item/clothing/head/beanie
	name = "\improper TGMC beanie"
	desc = "A standard military beanie, often worn by non-combat military personnel and support crews, though the occasional one finds its way to the front line. Popular due to being comfortable and snug."
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',)
	icon_state = "beanie_cargo"
	flags_inv_hide = HIDETOPHAIR
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 15, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 10, BIO = 5, FIRE = 5, ACID = 5)

/obj/item/clothing/head/tgmcberet
	name = "\improper Dark gray beret"
	desc = "A hat typically worn by the field-officers of the TGMC. Occasionally they find their way down the ranks into the hands of squad-leaders and decorated grunts."
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',)
	icon_state = "beret"
	soft_armor = list(MELEE = 15, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 10, BIO = 5, FIRE = 5, ACID = 5)
	flags_item_map_variant = NONE
	flags_armor_features = ARMOR_NO_DECAP

/obj/item/clothing/head/tgmcberet/tan
	name = "\improper Tan beret"
	icon_state = "berettan"
	flags_item_map_variant = (ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT)

/obj/item/clothing/head/tgmcberet/red
	name = "\improper Red badged beret"
	icon_state = "beretred"
	flags_item_map_variant = NONE

/obj/item/clothing/head/tgmcberet/red2
	name = "\improper Red beret"
	icon_state = "beretred2"
	flags_item_map_variant = NONE

/obj/item/clothing/head/tgmcberet/bloodred
	name = "\improper Blood red beret"
	icon_state = "bloodred_beret"
	flags_item_map_variant = NONE

/obj/item/clothing/head/tgmcberet/blueberet
	name = "\improper Blue beret"
	icon_state = "blue_beret"
	flags_item_map_variant = NONE

/obj/item/clothing/head/tgmcberet/darkgreen
	name = "\improper Dark green beret"
	icon_state = "darkgreen_beret"
	flags_item_map_variant = NONE

/obj/item/clothing/head/tgmcberet/green
	name = "\improper Green beret"
	icon_state = "beretgreen"
	flags_item_map_variant = NONE

/obj/item/clothing/head/tgmcberet/snow
	name = "\improper White beret"
	icon_state = "beretsnow"
	flags_item_map_variant = NONE

/obj/item/clothing/head/tgmcberet/wo
	name = "\improper Command Master at Arms beret"
	desc = "A beret with the lieutenant insignia emblazoned on it. It shines with the glow of corrupt authority and a smudge of doughnut."
	icon_state = "beretwo"
	soft_armor = list(MELEE = 15, BULLET = 50, LASER = 50, ENERGY = 15, BOMB = 50, BIO = 5, FIRE = 50, ACID = 5)
	flags_item_map_variant = NONE

/obj/item/clothing/head/tgmcberet/fc
	name = "\improper Field Commander beret"
	desc = "A beret with the field commander insignia emblazoned on it. It commands loyalty and bravery in all who gaze upon it."
	icon_state = "beretfc"
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 10, BIO = 5, FIRE = 50, ACID = 50)
	flags_item_map_variant = NONE

/obj/item/clothing/head/tgmccap
	name = "\improper TGMC cap"
	desc = "A casual cap occasionally worn by Squad-leaders and Combat-Engineers. While it has limited combat functionality, some prefer to wear it instead of the standard issue helmet."
	icon_state = "cap"
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',)
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 15, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 10, BIO = 5, FIRE = 5, ACID = 5)
	var/flipped_cap = FALSE
	var/base_cap_icon
	flags_item_map_variant = (ITEM_ICE_VARIANT)

/obj/item/clothing/head/tgmccap/verb/fliphat()
	set name = "Flip hat"
	set category = "Object.Clothing"
	set src in usr
	if(!isliving(usr))
		return
	if(usr.incapacitated())
		return

	flipped_cap = !flipped_cap
	if(flipped_cap)
		to_chat(usr, "You spin the hat backwards! You look like a tool.")
		icon_state = base_cap_icon + "_b"
	else
		to_chat(usr, "You spin the hat back forwards. That's better.")
		icon_state = base_cap_icon

	update_clothing_icon()

/obj/item/clothing/head/tgmccap/ro
	name = "\improper TGMC officer cap"
	desc = "A hat usually worn by officers in the TGMC. While it has limited combat functionality, some prefer to wear it instead of the standard issue helmet."
	icon_state = "rocap"

/obj/item/clothing/head/tgmccap/ro/navy
	name = "\improper TGMC navy officer cap"
	desc = "A hat usually worn by officers in the TGMC. This time in a nice shade of navy blue."
	icon_state = "navycap"

/obj/item/clothing/head/tgmccap/req
	name = "\improper TGMC requisition cap"
	desc = "It's a fancy hat for a not-so-fancy military supply clerk."
	icon_state = "cargocap"
	flags_item_map_variant = null

/obj/item/clothing/head/boonie
	name = "Boonie Hat"
	desc = "The pinnacle of tacticool technology."
	icon_state = "booniehat"
	item_state = "booniehat"
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 15, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 10, BIO = 5, FIRE = 5, ACID = 5)

/obj/item/clothing/head/ornamented_cap
	name = "\improper ornamented cap"
	desc = "An ornamented cap with a visor. This one seems to be torn at the back."
	icon_state = "ornamented_cap"
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',)
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 15, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 10, BIO = 5, FIRE = 5, ACID = 5)
	flags_armor_features = ARMOR_NO_DECAP

/obj/item/clothing/head/slouch
	name = "\improper TGMC slouch hat"
	desc = "A nice slouch hat worn by some TGMC troopers while on planets with hot weather, or just for style. While it has limited combat functionality, some prefer to wear it instead of the standard issue helmet."
	icon_state = "slouch_hat"
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',
	)
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 15, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 10, BIO = 5, FIRE = 5, ACID = 5)

/obj/item/clothing/head/headband
	name = "\improper Cyan headband"
	desc = "A rag typically worn by the less-orthodox weapons operators in the TGMC. While it offers no protection, it is certainly comfortable to wear compared to the standard helmet. Comes in two stylish colors."
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',)
	icon_state = "headband"
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 15, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 10, BIO = 5, FIRE = 5, ACID = 5)
	flags_armor_features = ARMOR_NO_DECAP

/obj/item/clothing/head/headband/red
	name = "\improper Red headband"
	icon_state = "headbandred"

/obj/item/clothing/head/headband/rambo
	name = "\improper Vivid red headband"
	desc = "It flutters in the face of the wind, defiant and unrestrained, like the man who wears it."
	icon_state = "headband_rambo"

/obj/item/clothing/head/headband/snake
	name = "\improper Black headband"
	desc = "A replica of the headband of a legendary soldier. Sadly it doesn't offer infinite ammo. Yet."
	icon_state = "headband_snake"

/obj/item/clothing/head/headset
	name = "\improper TGMC headset"
	desc = "A headset typically found in use by radio-operators and officers. This one appears to be malfunctioning."
	icon_state = "headset"
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',)
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/cmo
	name = "\improper Chief Medical hat"
	desc = "A somewhat fancy hat, typically worn by those who wish to command medical respect."
	icon_state = "cmohat"
	species_exception = list(/datum/species/robot)

/*============================BERETS=================================*/
//Berets have armor, so they have their own category. PMC caps are helmets, so they're in helmets.dm.

/obj/item/clothing/head/beret/marine
	name = "marine officer beret"
	desc = "A beret with the TGMC insignia emblazoned on it. It radiates respect and authority."
	icon_state = "hosberet"
	soft_armor = list(MELEE = 15, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 10, BIO = 5, FIRE = 5, ACID = 5)
	flags_inventory = BLOCKSHARPOBJ

/obj/item/clothing/head/beret/marine/captain
	name = "captain's beret"
	desc = "A beret with the captain insignia emblazoned on it. Wearer may suffer the heavy weight of responsibility upon his head and shoulders."
	icon_state = "centcomcaptain"

/obj/item/clothing/head/beret/marine/techofficer
	name = "technical officer beret"
	desc = "A beret with the lieutenant insignia emblazoned on it. There's something inexplicably efficient about it..."
	icon_state = "e_beret_badge"

/obj/item/clothing/head/beret/marine/logisticsofficer
	name = "logistics officer beret"
	desc = "A beret with the lieutenant insignia emblazoned on it. It inspires a feeling of respect."
	icon_state = "hosberet"

/*=========================PROTECTIVE===============================
=======================================================================*/

/obj/item/clothing/head/ushanka
	name = "ushanka"
	desc = "Perfect for winter in Siberia, da?"
	icon_state = "ushankadown"
	item_state = "ushankadown"
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 35, BULLET = 35, LASER = 20, ENERGY = 10, BOMB = 10, BIO = 0, FIRE = 10, ACID = 10)
	flags_cold_protection = HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDETOPHAIR
	anti_hug = 1

/obj/item/clothing/head/ushanka/attack_self(mob/user as mob)
	. = ..()
	if(icon_state == "ushankadown")
		icon_state = "ushankaup"
		item_state = "ushankaup"
		to_chat(user, "You raise the ear flaps on the ushanka.")
	else
		icon_state = "ushankadown"
		item_state = "ushankadown"
		to_chat(user, "You lower the ear flaps on the ushanka.")

/obj/item/clothing/head/bearpelt
	name = "bear pelt hat"
	desc = "Fuzzy."
	icon_state = "bearpelt"
	siemens_coefficient = 2
	anti_hug = 4
	flags_armor_protection = HEAD|CHEST|ARMS
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 90, BULLET = 70, LASER = 45, ENERGY = 55, BOMB = 45, BIO = 10, FIRE = 55, ACID = 55)
	flags_cold_protection = HEAD|CHEST|ARMS
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDETOPHAIR

/obj/item/clothing/head/uppcap
	name = "\improper armored USL cap"
	desc = "Standard USL head gear for covert operations and low-ranking pirates alike."
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	icon_state = "upp_cap"
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',)
	siemens_coefficient = 2
	//anti_hug = 2
	flags_armor_protection = HEAD
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 55, BOMB = 50, BIO = 50, FIRE = 55, ACID = 55)
	flags_cold_protection = HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS
	flags_armor_features = ARMOR_NO_DECAP

/obj/item/clothing/head/uppcap/beret
	name = "\improper armored USL beret"
	icon_state = "upp_beret"

/obj/item/clothing/head/frelancer
	name = "\improper armored Freelancer helmet"
	desc = "A sturdy freelancer's helmet."
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',)
	icon_state = "freelancer_helmet"
	siemens_coefficient = 2
	flags_armor_protection = HEAD
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 55, BOMB = 50, BIO = 50, FIRE = 55, ACID = 55)
	flags_cold_protection = HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS
	flags_armor_features = ARMOR_NO_DECAP
	attachments_by_slot = list(
		ATTACHMENT_SLOT_STORAGE,
		ATTACHMENT_SLOT_HEAD_MODULE,
	)
	attachments_allowed = list(
		/obj/item/armor_module/module/binoculars,
		/obj/item/armor_module/storage/helmet,
	)
	starting_attachments = list(
		/obj/item/armor_module/module/binoculars,
		/obj/item/armor_module/storage/helmet,
	)

/obj/item/clothing/head/frelancer/beret
	name = "\improper armored Freelancer beret"
	icon_state = "freelancer_beret"
	attachments_allowed = list(
		/obj/item/armor_module/storage/helmet,
	)
	starting_attachments = list(
		/obj/item/armor_module/storage/helmet,
	)

/obj/item/clothing/head/militia
	name = "\improper armored militia cowl"
	desc = "A large hood in service with some militias, meant for obscurity on the frontier. Offers some head protection due to the study fibers utilized in production."
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',)
	icon_state = "rebel_hood"
	siemens_coefficient = 2
	flags_armor_protection = HEAD|CHEST
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 50, FIRE = 50, ACID = 50)
	flags_cold_protection = HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	flags_inventory = BLOCKSHARPOBJ
	flags_inv_hide = HIDEEARS|HIDETOPHAIR
	flags_armor_features = ARMOR_NO_DECAP

/obj/item/clothing/head/commissar
	name = "\improper commissar cap"
	desc = "A cap worn by commissars of the Imperial Army. This one seems to radiate authority."
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',)
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	icon_state = "commissar_cap"
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 15, BIO = 10, FIRE = 20, ACID = 20)
	flags_armor_features = ARMOR_NO_DECAP

/obj/item/clothing/head/strawhat
	name = "\improper straw hat"
	desc = "A hat lined with durathread on the outside, has the usual iconic look of a straw hat. A common hat across the bubble."
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_1.dmi',)
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	icon_state = "straw_hat"
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 15, BIO = 10, FIRE = 20, ACID = 20)

/obj/item/clothing/head/squad_headband
	name = "\improper Squad headband"
	desc = "Headband made from ultra-thin special cloth. Cloth thickness provides more than just a stylish fluttering of headband. You can tie around headband onto a helmet. This squad version of a headband has secret unique features created by the cloth coloring component. "
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi')
	icon_state = ""
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	slowdown = -0.1
	w_class = WEIGHT_CLASS_TINY
	species_exception = list(/datum/species/robot, /datum/species/synthetic, /datum/species/human, /datum/species/early_synthetic, /datum/species/zombie)

/obj/item/clothing/head/squad_headband/alpha
	name = "\improper Alpha Squad headband"
	icon_state = "as_headband"

/obj/item/clothing/head/squad_headband/bravo
	name = "\improper Bravo Squad headband"
	icon_state = "bs_headband"

/obj/item/clothing/head/squad_headband/charlie
	name = "\improper Charlie Squad headband"
	icon_state = "cs_headband"

/obj/item/clothing/head/squad_headband/delta
	name = "\improper Delta Squad headband"
	icon_state = "ds_headband"

/obj/item/clothing/head/squad_headband/foreign
	name = "\improper Foreign Legion headband"
	icon_state = "fl_headband"

/obj/item/clothing/head/tgmcberet
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/tgmcberet/squad
	name = "\improper squad beret"
	icon_state = ""
	desc = "Military beret with TGMC marine squad insignia."
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/tgmcberet/squad/alpha
	name = "\improper Alpha Squad beret"
	desc = "Military beret with TGMC marine squad insignia. This one belongs to the Alpha Squad."
	icon_state = "as_beret"

/obj/item/clothing/head/tgmcberet/squad/alpha/black
	name = "\improper Alpha Squad black beret"
	icon_state = "as_black_beret"
	desc = "Black stylish beret with TGMC marine squad insignia. This one belongs to the Alpha Squad."

/obj/item/clothing/head/tgmcberet/squad/bravo
	name = "\improper Bravo Squad beret"
	desc = "Military beret with TGMC marine squad insignia. This one belongs to the Bravo Squad."
	icon_state = "bs_beret"

/obj/item/clothing/head/tgmcberet/squad/bravo/black
	name = "\improper Bravo Squad black beret"
	icon_state = "bs_black_beret"
	desc = "Black stylish beret with TGMC marine squad insignia. This one belongs to the Bravo Squad."

/obj/item/clothing/head/tgmcberet/squad/charlie
	name = "\improper Charlie Squad beret"
	icon_state = "cs_beret"
	desc = "Military beret with TGMC marine squad insignia. This one belongs to the Charlie Squad."

/obj/item/clothing/head/tgmcberet/squad/charlie/black
	name = "\improper Charlie Squad black beret"
	icon_state = "cs_black_beret"
	desc = "Black stylish beret with TGMC marine squad insignia. This one belongs to the Charlie Squad."

/obj/item/clothing/head/tgmcberet/squad/delta
	name = "\improper Delta Squad beret"
	desc = "Military beret with TGMC marine squad insignia. This one belongs to the Delta Squad."
	icon_state = "ds_beret"

/obj/item/clothing/head/tgmcberet/squad/delta/black
	name = "\improper Delta Squad black beret"
	icon_state = "ds_black_beret"
	desc = "Black stylish beret with TGMC marine squad insignia. This one belongs to the Delta Squad."

/obj/item/clothing/head/tgmcberet/squad/foreign
	name = "\improper Foreign Legion beret"
	desc = "Military beret with TGMC marine squad insignia. This one belongs to the Foreign Legion."
	icon_state = "fl_beret"

/obj/item/clothing/head/tgmcberet/squad/foreign/black
	name = "\improper Foreign Legion black beret"
	icon_state = "fl_black_beret"
	desc = "Black stylish beret with TGMC marine squad insignia. This one belongs to the Foreign Legion."

/obj/item/clothing/head/tgmcberet/commando
	name = "\improper Marines Commando beret"
	desc = "Dark Green beret with an old TGMC insignia on it."
	icon_state = "marcommandoberet"
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/tgmcberet/vdv
	name = "\improper Airborne beret"
	desc = "Blue badged beret that smells like ethanol and fountain water for some reason."
	icon_state = "russobluecamohat"
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/tgmcberet/medical
	name = "\improper Medical beret"
	desc = "A white beret with a green cross finely threaded into it. It has that sterile smell about it."
	icon_state = "medberet"
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/hachimaki
	name = "\improper Ancient pilot headband and scarf kit"
	desc = "Ancient pilot kit of scarf that protects neck from cold wind and headband that protects face from sweat"
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/head_0.dmi')
	icon_state = "Banzai"
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	w_class = WEIGHT_CLASS_SMALL

	actions_types = list(/datum/action/item_action)
	flags_armor_features = ARMOR_LAMP_OVERLAY|ARMOR_NO_DECAP
	flags_item = SYNTH_RESTRICTED
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/hachimaki/item_action_slot_check(mob/user, slot)
	if(slot != SLOT_HEAD)
		return FALSE
	return TRUE

/obj/item/clothing/head/hachimaki/attack_self(mob/user)
	var/mob/living/carbon/human/activator = user
	if(TIMER_COOLDOWN_CHECK(user, "Banzai"))
		user.balloon_alert(user, "You used that emote too recently")
		return
	TIMER_COOLDOWN_START(user, "Banzai", 60 SECONDS)
	if(user.gender == FEMALE)
		user.balloon_alert(user, "Women can't use that!")
	else
		activator.say("Tenno Heika Banzai!!")
		playsound(get_turf(user), 'sound/voice/banzai1.ogg', 30)

/obj/item/clothing/head/tgmcberet/squad/black
	name = "\improper Alpha squad black beret"
	icon_state = "alpha_black_beret"
	desc = "Black stylish beret with TGMC marine squad insignia. This one belongs to the Alpha Squad."
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/tgmcberet/squad/black/bravo
	name = "\improper Bravo squad black beret"
	icon_state = "bravo_black_beret"
	desc = "Black stylish beret with TGMC marine squad insignia. This one belongs to the Bravo Squad."

/obj/item/clothing/head/tgmcberet/squad/black/delta
	name = "\improper Delta squad black beret"
	icon_state = "delta_black_beret"
	desc = "Black stylish beret with TGMC marine squad insignia. This one belongs to the Delta Squad."

/obj/item/clothing/head/tgmcberet/squad/black/charlie
	name = "\improper Charlie squad black beret"
	icon_state = "charlie_black_beret"
	desc = "Black stylish beret with TGMC marine squad insignia. This one belongs to the Charlie Squad."

/obj/item/clothing/head/beret/marine
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/beret/sec/warden
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/beret/sec
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/beret/eng
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/beret/marine/captain
	icon = 'icons/obj/clothing/headwear/hats.dmi'

/obj/item/clothing/head/beret/marine/captain/black
	icon_state = "black_captain"

/obj/item/clothing/head/beret/marine/staff
	name = "staff officer's beret"
	desc = "A beret with the silver insignia emblazoned on it. Wearer may suffer being heavily misunderstood by marines."
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	icon_state = "so_beret"

//Peaked caps
/obj/item/clothing/head/highcap
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi')
	icon_state = "cap_black"
	soft_armor = list(MELEE = 15, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 10, BIO = 5, FIRE = 5, ACID = 5)
	flags_inventory = BLOCKSHARPOBJ
	flags_armor_features = ARMOR_NO_DECAP
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/highcap/staff
	name = "staff officer's peaked cap"
	desc = "A somewhat fancy hat, typically worn by those who wish to conduct military operations."
	icon_state = "so_alt"

/obj/item/clothing/head/highcap/captain
	name = "captain's peaked cap"
	desc = "A somewhat fancy hat, typically worn by those who wish to have total control."
	icon_state = "capitan_alt"

/obj/item/clothing/head/highcap/captain/black
	icon_state = "captain_alt_black"
