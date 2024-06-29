/obj/item/clothing/head/examine(mob/user)
	. = ..()
	if(colorable_allowed & HAIR_CONCEALING_CHANGE_ALLOWED)
		. += span_notice("You can change the way it conceals the hair by using <b>facepaint</b> on it.")

/obj/item/clothing/head/squad_headband
	name = "\improper Squad headband"
	desc = "Headband made from ultra-thin special cloth. Cloth thickness provides more than just a stylish fluttering of headband. You can tie around headband onto a helmet. This squad version of a headband has secret unique features created by the cloth coloring component. "
	icon = 'modular_RUtgmc/icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'modular_RUtgmc/icons/mob/clothing/headwear/marine_hats.dmi')
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
	icon = 'modular_RUtgmc/icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'modular_RUtgmc/icons/mob/clothing/headwear/marine_hats.dmi')

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
	icon = 'modular_RUtgmc/icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'modular_RUtgmc/icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/tgmcberet/vdv
	name = "\improper Airborne beret"
	desc = "Blue badged beret that smells like ethanol and fountain water for some reason."
	icon_state = "russobluecamohat"
	icon = 'modular_RUtgmc/icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'modular_RUtgmc/icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/tgmcberet/medical
	name = "\improper Medical beret"
	desc = "A white beret with a green cross finely threaded into it. It has that sterile smell about it."
	icon_state = "medberet"
	icon = 'modular_RUtgmc/icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'modular_RUtgmc/icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/tgmcberet/hijab
	name = "\improper Black hijab"
	desc = "Encompassing cloth headwear worn by some human cultures and religions."
	icon = 'modular_RUtgmc/icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'modular_RUtgmc/icons/mob/clothing/headwear/marine_hats.dmi')
	icon_state = "hijab_black"
	flags_inv_hide = HIDEEARS|HIDETOPHAIR

/obj/item/clothing/head/tgmcberet/hijab/grey
	name = "\improper Grey hijab"
	icon_state = "hijab_grey"

/obj/item/clothing/head/tgmcberet/hijab/red
	name = "\improper Red hijab"
	icon_state = "hijab_red"

/obj/item/clothing/head/tgmcberet/hijab/blue
	name = "\improper Blue hijab"
	icon_state = "hijab_blue"

/obj/item/clothing/head/tgmcberet/hijab/brown
	name = "\improper Brown hijab"
	icon_state = "hijab_brown"

/obj/item/clothing/head/tgmcberet/hijab/white
	name = "\improper White hijab"
	icon_state = "hijab_white"

/obj/item/clothing/head/tgmcberet/hijab/turban
	name = "\improper White turban"
	desc = "A sturdy cloth, worn around the head."
	icon_state = "turban_black"

/obj/item/clothing/head/tgmcberet/hijab/turban/white
	name = "\improper White turban"
	icon_state = "turban_white"

/obj/item/clothing/head/tgmcberet/hijab/turban/red
	name = "\improper Red turban"
	icon_state = "turban_red"

/obj/item/clothing/head/tgmcberet/hijab/turban/blue
	name = "\improper Blue turban"
	icon_state = "turban_blue"

/obj/item/clothing/head/hachimaki
	name = "\improper Ancient pilot headband and scarf kit"
	desc = "Ancient pilot kit of scarf that protects neck from cold wind and headband that protects face from sweat"
	icon = 'modular_RUtgmc/icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'modular_RUtgmc/icons/mob/clothing/headwear/head_0.dmi')
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
		playsound(get_turf(user), 'modular_RUtgmc/sound/voice/banzai1.ogg', 30)

/obj/item/clothing/head/tgmcberet/squad/black
	name = "\improper Alpha squad black beret"
	icon_state = "alpha_black_beret"
	desc = "Black stylish beret with TGMC marine squad insignia. This one belongs to the Alpha Squad."
	icon = 'modular_RUtgmc/icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'modular_RUtgmc/icons/mob/clothing/headwear/marine_hats.dmi')

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
		slot_head_str = 'modular_RUtgmc/icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/beret/sec/warden
	item_icons = list(
		slot_head_str = 'modular_RUtgmc/icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/beret/sec
	item_icons = list(
		slot_head_str = 'modular_RUtgmc/icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/beret/eng
	item_icons = list(
		slot_head_str = 'modular_RUtgmc/icons/mob/clothing/headwear/marine_hats.dmi')

/obj/item/clothing/head/beret/marine/captain
	icon = 'modular_RUtgmc/icons/obj/clothing/headwear/hats.dmi'

/obj/item/clothing/head/beret/marine/captain/black
	icon_state = "black_captain"

/obj/item/clothing/head/beret/marine/staff
	name = "staff officer's beret"
	desc = "A beret with the silver insignia emblazoned on it. Wearer may suffer being heavily misunderstood by marines."
	icon = 'modular_RUtgmc/icons/obj/clothing/headwear/hats.dmi'
	icon_state = "so_beret"

//Peaked caps
/obj/item/clothing/head/highcap
	icon = 'modular_RUtgmc/icons/obj/clothing/headwear/hats.dmi'
	item_icons = list(
		slot_head_str = 'modular_RUtgmc/icons/mob/clothing/headwear/marine_hats.dmi')
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

/obj/item/clothing/head/slouch
	icon_state = "slouch_hat"
	item_icons = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',)
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/headband
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/beanie
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/tgmccap
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/boonie
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/ornamented_cap
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/headset
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/cmo
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/ushanka
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/bearpelt
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/uppcap
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/frelancer
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/militia
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/admiral
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/commissar
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/strawhat
	species_exception = list(/datum/species/robot)



