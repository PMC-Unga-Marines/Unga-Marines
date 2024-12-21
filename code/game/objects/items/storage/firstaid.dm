/* First aid storage
* Contains:
*		First Aid Kits
* 		Pill Bottles
*/

/*
* First Aid Kits
*/
/obj/item/storage/firstaid
	name = "first-aid kit"
	desc = "It's an emergency medical kit for those serious boo-boos."
	icon = 'icons/obj/items/storage/firstaid.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medkits_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medkits_right.dmi',
	)
	icon_state = "firstaid"
	base_icon_state = "firstaid"
	use_sound = 'sound/effects/toolbox.ogg'
	w_class = WEIGHT_CLASS_BULKY
	throw_speed = 2
	throw_range = 8
	cant_hold = list(
		/obj/item/ammo_magazine,
		/obj/item/explosive/grenade,
	)
	var/empty = FALSE //whether the kit starts empty

/obj/item/storage/firstaid/update_icon_state()
	. = ..()
	if(!length(contents))
		icon_state = icon_state += "_empty"
	else
		icon_state = base_icon_state

/obj/item/storage/firstaid/PopulateContents()
	if(empty)
		return
	new /obj/item/healthanalyzer(src)

/obj/item/storage/firstaid/fire
	name = "fire first-aid kit"
	desc = "It's an emergency medical kit for when the toxins lab <i>-spontaneously-</i> burns down."
	icon_state = "firefirstaid"
	base_icon_state = "firefirstaid"
	item_state = "firefirstaid"

/obj/item/storage/firstaid/fire/PopulateContents()
	. = ..()
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/storage/pill_bottle/packet/leporazine(src)
	new /obj/item/storage/syringe_case/burn(src)

/obj/item/storage/firstaid/regular
	icon_state = "firstaid"
	base_icon_state = "firstaid"
	item_state = "firstaid"

/obj/item/storage/firstaid/regular/PopulateContents()
	. = ..()
	new /obj/item/stack/medical/heal_pack/gauze(src)
	new /obj/item/stack/medical/heal_pack/ointment(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/combat(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/tricordrazine(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/tramadol(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/firstaid/toxin
	name = "toxin first aid"
	desc = "Used to treat when you have a high amount of toxins in your body."
	icon_state = "antitoxfirstaid"
	base_icon_state = "antitoxfirstaid"
	item_state = "antitoxfirstaid"

/obj/item/storage/firstaid/toxin/PopulateContents()
	. = ..()
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/hypervene(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/hypervene(src)
	new /obj/item/storage/syringe_case/tox(src)

/obj/item/storage/firstaid/o2
	name = "oxygen deprivation first aid"
	desc = "A box full of oxygen goodies."
	icon_state = "o2firstaid"
	base_icon_state = "o2firstaid"
	item_state = "o2firstaid"

/obj/item/storage/firstaid/o2/PopulateContents()
	. = ..()
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/dexalinplus(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/dexalinplus(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/dexalinplus(src)
	new /obj/item/storage/syringe_case/oxy(src)

/obj/item/storage/firstaid/adv
	name = "advanced first-aid kit"
	desc = "Contains advanced medical treatments."
	icon_state = "advfirstaid"
	base_icon_state = "advfirstaid"
	item_state = "advfirstaid"

/obj/item/storage/firstaid/adv/PopulateContents()
	. = ..()
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/firstaid/rad
	name = "radiation first-aid kit"
	desc = "Contains treatment for radiation exposure"
	icon_state = "purplefirstaid"
	base_icon_state = "purplefirstaid"
	item_state = "purplefirstaid"

/obj/item/storage/firstaid/rad/PopulateContents()
	. = ..()
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/combat(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/tricordrazine(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/tricordrazine(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/bicaridine(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/bicaridine(src)

/*
* Syringe Case
*/

/obj/item/storage/syringe_case
	name = "syringe case"
	desc = "It's a medical case for storing syringes and bottles."
	icon_state = "syringe_case"
	throw_speed = 2
	throw_range = 8
	storage_slots = 3
	w_class = WEIGHT_CLASS_SMALL
	can_hold = list(
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/syringe,
	)

/obj/item/storage/syringe_case/PopulateContents()
	new /obj/item/reagent_containers/syringe(src)

/obj/item/storage/syringe_case/empty/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/empty(src)
	new /obj/item/reagent_containers/glass/bottle/empty(src)

/obj/item/storage/syringe_case/regular
	name = "basic syringe case"
	desc = "It's a medical case for storing syringes and bottles. This one contains basic meds."

/obj/item/storage/syringe_case/regular/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/inaprovaline(src)
	new /obj/item/reagent_containers/glass/bottle/tricordrazine(src)

/obj/item/storage/syringe_case/burn
	name = "burn syringe case"
	desc = "It's a medical case for storing syringes and bottles. This one contains meds designed to treat burns."

/obj/item/storage/syringe_case/burn/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/kelotane(src)
	new /obj/item/reagent_containers/glass/bottle/oxycodone(src)

/obj/item/storage/syringe_case/tox
	name = "toxins syringe case"
	desc = "It's a medical case for storing syringes and bottles. This one contains meds designed to treat toxins."

/obj/item/storage/syringe_case/tox/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/dylovene(src)
	new /obj/item/reagent_containers/glass/bottle/hypervene(src)

/obj/item/storage/syringe_case/oxy
	name = "oxyloss syringe case"
	desc = "It's a medical case for storing syringes and bottles. This one contains meds designed to treat oxygen deprivation."

/obj/item/storage/syringe_case/oxy/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/inaprovaline(src)
	new /obj/item/reagent_containers/glass/bottle/dexalin(src)

/obj/item/storage/syringe_case/meralyne
	name = "syringe case (meralyne)"
	desc = "It's a medical case for storing syringes and bottles. This one contains Meralyne."

/obj/item/storage/syringe_case/meralyne/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/meralyne(src)
	new /obj/item/reagent_containers/glass/bottle/meralyne(src)

/obj/item/storage/syringe_case/dermaline
	name = "syringe case (dermaline)"
	desc = "It's a medical case for storing syringes and bottles. This one contains Dermaline."

/obj/item/storage/syringe_case/dermaline/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/dermaline(src)
	new /obj/item/reagent_containers/glass/bottle/dermaline(src)

/obj/item/storage/syringe_case/meraderm
	name = "syringe case (meraderm)"
	desc = "It's a medical case for storing syringes and bottles. This one contains Meraderm."

/obj/item/storage/syringe_case/meraderm/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/meraderm(src)
	new /obj/item/reagent_containers/glass/bottle/meraderm(src)

/obj/item/storage/syringe_case/nanoblood
	name = "syringe case (nanoblood)"
	desc = "It's a medical case for storing syringes and bottles. This one contains nanoblood."

/obj/item/storage/syringe_case/nanoblood/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/nanoblood(src)
	new /obj/item/reagent_containers/glass/bottle/nanoblood(src)

/obj/item/storage/syringe_case/tricordrazine
	name = "syringe case (tricordrazine)"
	desc = "It's a medical case for storing syringes and bottles. This one contains Tricordrazine."

/obj/item/storage/syringe_case/tricordrazine/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/tricordrazine(src)
	new /obj/item/reagent_containers/glass/bottle/tricordrazine(src)

/*
* Pill Bottles
*/

/obj/item/storage/pill_bottle
	name = "pill bottle"
	desc = "It's an airtight container for storing medication."
	icon_state = "pill_canister"
	icon = 'icons/obj/items/chemistry.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_right.dmi',
	)
	item_state = "contsolid"
	w_class = WEIGHT_CLASS_SMALL
	can_hold = list(
		/obj/item/reagent_containers/pill,
		/obj/item/toy/dice,
		/obj/item/paper,
	)
	allow_quick_gather = 1
	use_to_pickup = 1
	storage_slots = null
	use_sound = 'sound/items/pillbottle.ogg'
	max_storage_space = 16
	flags_storage = BYPASS_CRYO_CHECK
	greyscale_config = /datum/greyscale_config/pillbottle
	greyscale_colors = "#d9cd07#f2cdbb" //default colors
	refill_types = list(/obj/item/storage/pill_bottle)
	refill_sound = 'sound/items/pills.ogg'
	var/pill_type_to_fill //type of pill to use to fill in the bottle in New()
	/// Short description in overlay
	var/description_overlay = ""

/obj/item/storage/pill_bottle/PopulateContents()
	if(!pill_type_to_fill)
		return
	for(var/i in 1 to max_storage_space)
		new pill_type_to_fill(src)
	update_icon(UPDATE_OVERLAYS)

/obj/item/storage/pill_bottle/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/hypospray))
		var/obj/item/reagent_containers/hypospray/hypospray = I
		if(hypospray.reagents.total_volume >= hypospray.volume)
			balloon_alert(user, "Hypospray is full.")
			return FALSE //early returning if its full

		if(!length(contents))
			return FALSE//early returning if its empty
		var/obj/item/pill = contents[1]

		if((pill.reagents.total_volume + hypospray.reagents.total_volume) > hypospray.volume)
			balloon_alert(user, "Can't hold that much.")
			return FALSE// so it doesnt let people have hypos more filled than their volume
		pill.reagents.trans_to(I, pill.reagents.total_volume)

		to_chat(user, span_notice("You dissolve [pill] from [src] in [I]."))
		remove_from_storage(pill, null, user)
		qdel(pill)
		return TRUE

	return ..()

/obj/item/storage/pill_bottle/attack_self(mob/living/user)
	if(user.get_inactive_held_item())
		user.balloon_alert(user, "Need an empty hand")
		return
	if(length(contents))
		var/obj/item/I = contents[1]
		if(!remove_from_storage(I,user,user))
			return
		if(user.put_in_inactive_hand(I))
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.swap_hand()
		else
			user.dropItemToGround(I)
			to_chat(user, span_notice("You fumble around with \the [src] and drop a pill on the floor."))
		return

/obj/item/storage/pill_bottle/remove_from_storage(obj/item/item, atom/new_location, mob/user)
	. = ..()
	if(. && user)
		playsound(user, 'sound/items/pills.ogg', 15, 1)

/obj/item/storage/pill_bottle/update_overlays()
	. = ..()
	if(isturf(loc))
		return
	var/mutable_appearance/number = mutable_appearance()
	number.maptext = MAPTEXT(length(contents))
	. += number
	if(!description_overlay)
		return
	var/mutable_appearance/desc = mutable_appearance('icons/misc/12x12.dmi')
	desc.pixel_x = 16
	desc.maptext = MAPTEXT(description_overlay)
	desc.maptext_width = 16
	. += desc

/obj/item/storage/pill_bottle/equipped(mob/user, slot)
	. = ..()
	update_icon()

/obj/item/storage/pill_bottle/on_enter_storage(mob/user, slot)
	. = ..()
	update_icon()

/obj/item/storage/pill_bottle/removed_from_inventory()
	. = ..()
	update_icon()

/obj/item/storage/pill_bottle/kelotane
	name = "kelotane pill bottle"
	desc = "Contains pills that heal burns, but cause slight pain. Take two to heal faster, but have slightly more pain."
	pill_type_to_fill = /obj/item/reagent_containers/pill/kelotane
	greyscale_colors = "#CC9900#FFFFFF"
	description_overlay = "Ke"

/obj/item/storage/pill_bottle/dermaline
	name = "dermaline pill bottle"
	desc = "Contains pills that heal burns, but cause slight pain. Take two to heal faster, but have slightly more pain."
	pill_type_to_fill = /obj/item/reagent_containers/pill/dermaline
	greyscale_config = /datum/greyscale_config/pillbottleround
	greyscale_colors = "#ffef00#FFFFFF"
	description_overlay = "De"

/obj/item/storage/pill_bottle/dylovene
	name = "dylovene pill bottle"
	desc = "Contains pills that heal toxic damage and purge toxins and neurotoxins of all kinds."
	pill_type_to_fill = /obj/item/reagent_containers/pill/dylovene
	greyscale_colors = "#669900#ffffff"
	description_overlay = "Dy"

/obj/item/storage/pill_bottle/isotonic
	name = "isotonic pill bottle"
	desc = "Contains pills that stimulate the regeneration of lost blood."
	pill_type_to_fill = /obj/item/reagent_containers/pill/isotonic
	greyscale_colors = "#5c0e0e#ffffff"
	description_overlay = "Is"

/obj/item/storage/pill_bottle/inaprovaline
	name = "inaprovaline pill bottle"
	desc = "Contains pills that prevent wounds from getting worse on their own."
	pill_type_to_fill = /obj/item/reagent_containers/pill/inaprovaline
	greyscale_config = /datum/greyscale_config/pillbottlebox
	greyscale_colors = "#9966CC#ffffff"
	description_overlay = "In"

/obj/item/storage/pill_bottle/tramadol
	name = "tramadol pill bottle"
	desc = "Contains pills that numb pain. Take two for a stronger effect at the cost of a toxic effect."
	pill_type_to_fill = /obj/item/reagent_containers/pill/tramadol
	greyscale_colors = "#8a8686#ffffff"
	description_overlay = "Ta"

/obj/item/storage/pill_bottle/paracetamol
	name = "paracetamol pill bottle"
	desc = "Contains pills that mildly numb pain. Take two for a slightly stronger effect."
	pill_type_to_fill = /obj/item/reagent_containers/pill/paracetamol
	greyscale_colors = "#cac5c5#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottlebox
	greyscale_colors = "#f8f4f8#ffffff"
	description_overlay = "Pa"

/obj/item/storage/pill_bottle/spaceacillin
	name = "spaceacillin pill bottle"
	desc = "Contains pills that handle low-level viral and bacterial infections. Effect increases with dosage."
	pill_type_to_fill = /obj/item/reagent_containers/pill/spaceacillin
	greyscale_config = /datum/greyscale_config/pillbottlebox
	greyscale_colors = "#90F7DeF5#ffffff"
	description_overlay = "Sp"

/obj/item/storage/pill_bottle/bicaridine
	name = "bicaridine pill bottle"
	desc = "Contains pills that heal cuts and bruises, but cause slight pain. Take two to heal faster, but have slightly more pain."
	pill_type_to_fill = /obj/item/reagent_containers/pill/bicaridine
	greyscale_colors = "#DA0000#ffffff"
	description_overlay = "Bi"

/obj/item/storage/pill_bottle/meralyne
	name = "meralyne pill bottle"
	desc = "Contains pills that heal cuts and bruises, but cause slight pain. Take two to heal faster, but have slightly more pain."
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/meralyne
	greyscale_config = /datum/greyscale_config/pillbottleround
	greyscale_colors = "#FD5964#ffffff"
	description_overlay = "Me"

/obj/item/storage/pill_bottle/dexalin
	name = "dexalin pill bottle"
	desc = "Contains pills that heal oxygen damage. They can suppress bloodloss symptoms as well."
	pill_type_to_fill = /obj/item/reagent_containers/pill/dexalin
	greyscale_colors = "#5972FD#ffffff"
	description_overlay = "Dx"

/obj/item/storage/pill_bottle/alkysine
	name = "alkysine pill bottle"
	desc = "Contains pills that heal brain and ear damage."
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/alkysine
	greyscale_config = /datum/greyscale_config/pillbottlebubble
	greyscale_colors = "#0292AC#ffffff"
	description_overlay = "Al"

/obj/item/storage/pill_bottle/imidazoline
	name = "imidazoline pill bottle"
	desc = "Contains pills that heal eye damage."
	pill_type_to_fill = /obj/item/reagent_containers/pill/imidazoline
	greyscale_config = /datum/greyscale_config/pillbottlebubble
	greyscale_colors = "#F7A151#ffffff" //orange like carrots
	description_overlay = "Im"

/obj/item/storage/pill_bottle/russian_red
	name = "\improper Russian Red pill bottle"
	desc = "Contains pills that heal all damage rapidly at the cost of small amounts of unhealable damage."
	icon_state = "pill_canister"
	pill_type_to_fill = /obj/item/reagent_containers/pill/russian_red
	greyscale_colors = "#3d0000#ffffff"
	description_overlay = "Rr"

/obj/item/storage/pill_bottle/quickclot
	name = "quick-clot pill bottle"
	desc = "Contains pills that suppress internal bleeding while waiting for full treatment."
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/quickclot
	greyscale_config = /datum/greyscale_config/pillbottleround
	greyscale_colors = "#E07BAD#ffffff"
	description_overlay = "Qk"

/obj/item/storage/pill_bottle/peridaxon
	name = "peridaxon pill bottle"
	desc = "Contains pills that suppress internal organ damage."
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/peridaxon
	greyscale_config = /datum/greyscale_config/pillbottleround
	greyscale_colors = "#460750#ffffff"
	description_overlay = "Pe"

/obj/item/storage/pill_bottle/hypervene
	name = "hypervene pill bottle"
	desc = "A purge medication used to treat overdoses and rapidly remove toxins. Causes pain and vomiting."
	icon_state = "pill_canister"
	pill_type_to_fill = /obj/item/reagent_containers/pill/hypervene
	greyscale_config = /datum/greyscale_config/pillbottlebubble
	greyscale_colors = "#AC6D32#ffffff"
	description_overlay = "Hy"

/obj/item/storage/pill_bottle/tricordrazine
	name = "tricordrazine pill bottle"
	desc = "Contains pills capable of minorly healing all main types of damages."
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/tricordrazine
	greyscale_colors = "#f8f8f8#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottleround
	description_overlay = "Ti"

/obj/item/storage/pill_bottle/imialky
	name = "imialky pill bottle"
	desc = "Contains pills used to fix brain, ear and eye damage"
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/imialky
	greyscale_colors = "#E467B3#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottleround
	description_overlay = "IA"

/obj/item/storage/pill_bottle/combatmix
	name = "combatmix pill bottle"
	desc = "Contains BKTT pills. Combat mix"
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/combatmix
	greyscale_colors = "#FF2600#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottleround
	description_overlay = "Cm"

/obj/item/storage/pill_bottle/doctor_delight
	name = "doctor's delight pill bottle"
	desc = "Contains pills used to heal slowly."
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/doctor_delight
	greyscale_colors = "#A3295C#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottleround
	description_overlay = "Dd"

/obj/item/storage/pill_bottle/sugar
	name = "sugar pill bottle"
	desc = "Contains pills used to prevent hunger, yum!"
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/sugar
	greyscale_colors = "#ECFC00#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottleround
	description_overlay = "Su"

/obj/item/storage/pill_bottle/ifosfamide
	name = "ifosfamide pill bottle"
	desc = "Contains pills of cytostatic antitumor emergency use drug."
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/ifosfamide
	greyscale_colors = "#9ACD32#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottleround
	description_overlay = "If"

/obj/item/storage/pill_bottle/happy
	name = "happy pill bottle"
	desc = "Contains highly illegal drugs. When you want to see the rainbow."
	max_storage_space = 7
	pill_type_to_fill = /obj/item/reagent_containers/pill/happy
	greyscale_colors = "#6C52BF#ffffff"

/obj/item/storage/pill_bottle/zoom
	name = "zoom pill bottle"
	desc = "Containts highly illegal drugs. Trade heart for speed."
	max_storage_space = 7
	pill_type_to_fill = /obj/item/reagent_containers/pill/zoom
	greyscale_colors = "#ef3ad4#ffffff"

/obj/item/storage/pill_bottle/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(!istype(I, /obj/item/facepaint) || isnull(greyscale_config))
		return

	var/obj/item/facepaint/paint = I
	if(paint.uses < 1)
		to_chat(user, span_warning("\the [paint] is out of color!"))
		return
	var/bottle_color
	var/label_color
	bottle_color = input(user, "Pick a color", "Pick color") as null|color
	label_color = input(user, "Pick a color", "Pick color") as null|color

	if(!bottle_color || !label_color || !do_after(user, 1 SECONDS, NONE, src, BUSY_ICON_GENERIC))
		return


	set_greyscale_colors(list(bottle_color,label_color))
	paint.uses--
	update_icon()

//АИ-2

/obj/item/storage/ai2
	name = "\"АИ-2\" first aid kit"
	desc = "It's an individual medical kit with rare and useful reagents."
	icon = 'icons/obj/items/storage/firstaidkit.dmi'
	icon_state = "firstaidkit"
	storage_slots = 8
	w_class = WEIGHT_CLASS_NORMAL
	use_sound = 'sound/effects/toolbox.ogg'
	can_hold = list(
		/obj/item/storage/pill_bottle/penal,
		/obj/item/reagent_containers/hypospray/autoinjector/pen,
	)
	var/is_open = FALSE

/obj/item/storage/ai2/PopulateContents()
	new /obj/item/storage/pill_bottle/penal/meralyne(src)
	new /obj/item/storage/pill_bottle/penal/dermaline(src)
	new /obj/item/storage/pill_bottle/penal/hyronalin(src)
	new /obj/item/storage/pill_bottle/penal/dexalin(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/pen/tramadol(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/pen/neuraline(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/pen/inaprovaline(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/pen/hypervene(src)

/obj/item/storage/ai2/update_icon_state()
	cut_overlays()

	var/list/types_and_overlays = list(
		/obj/item/storage/pill_bottle/penal/meralyne = "firstaidkit_meralyne_open",
		/obj/item/storage/pill_bottle/penal/dermaline = "firstaidkit_dermaline_open",
		/obj/item/storage/pill_bottle/penal/hyronalin = "firstaidkit_hyronalin_open",
		/obj/item/storage/pill_bottle/penal/dexalin = "firstaidkit_dexalin_open",
		/obj/item/reagent_containers/hypospray/autoinjector/pen/tramadol = "firstaidkit_tramadol_open",
		/obj/item/reagent_containers/hypospray/autoinjector/pen/neuraline = "firstaidkit_neuraline_open",
		/obj/item/reagent_containers/hypospray/autoinjector/pen/inaprovaline = "firstaidkit_inaprovaline_open",
		/obj/item/reagent_containers/hypospray/autoinjector/pen/hypervene = "firstaidkit_hypervene_open",
	)

	if(is_open)
		for(var/obj/item/W in contents)
			if(types_and_overlays[W.type])
				add_overlay(types_and_overlays[W.type])
				types_and_overlays -= W.type

/obj/item/storage/ai2/open(mob/user)
	. = ..()
	icon_state = "firstaidkit_empty"
	is_open = TRUE
	update_icon()

/obj/item/storage/ai2/close(mob/user)
	. = ..()
	icon_state = "firstaidkit"
	is_open = FALSE
	update_icon()

/obj/item/storage/ai2/attackby(obj/item/I, mob/user, params)
	. = ..()
	update_icon()

/obj/item/storage/pill_bottle/penal
	icon = 'icons/obj/items/storage/firstaidkit.dmi'
	max_storage_space = 6
	w_class = WEIGHT_CLASS_TINY
	greyscale_config = null
	greyscale_colors = null

/obj/item/storage/pill_bottle/penal/meralyne
	name = "Meralyne \"Пенал\" case"
	desc = "Contains a few meralyne pills, old and fancy."
	icon_state = "meralyne_agent"
	pill_type_to_fill = /obj/item/reagent_containers/pill/meralyne

/obj/item/storage/pill_bottle/penal/dermaline
	name = "Dermaline \"Пенал\" case"
	desc = "Contains a few dermaline pills, old and fancy."
	icon_state = "dermaline_agent"
	pill_type_to_fill = /obj/item/reagent_containers/pill/dermaline

/obj/item/storage/pill_bottle/penal/hyronalin
	name = "Hyronalin \"Пенал\" case"
	desc = "Contains a few hyronalin pills, old and fancy."
	icon_state = "hyronalin_agent"
	pill_type_to_fill = /obj/item/reagent_containers/pill/hyronalin

/obj/item/storage/pill_bottle/penal/dexalin
	name = "Dexalin \"Пенал\" case"
	desc = "Contains a few dexalin pills, old and fancy."
	icon_state = "dexalin_agent"
	pill_type_to_fill = /obj/item/reagent_containers/pill/dexalin

/obj/item/reagent_containers/hypospray/autoinjector/pen
	icon = 'icons/obj/items/storage/firstaidkit.dmi'
	volume = 30
	init_reagent_flags = null

/obj/item/reagent_containers/hypospray/autoinjector/pen/tramadol
	name = "Tramadol pen"
	desc = "A pen loaded with 2 heavy doses of tramadol, use two times for better effect."
	icon_state = "tramadol_pen"
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/tramadol = 30)

/obj/item/reagent_containers/hypospray/autoinjector/pen/neuraline
	name = "Neuraline pen"
	desc = "A pen loaded with strong stimulant reagent. Causes serious intoxication!"
	icon_state = "neuraline_pen"
	amount_per_transfer_from_this = 4
	list_reagents = list(/datum/reagent/medicine/neuraline = 4)

/obj/item/reagent_containers/hypospray/autoinjector/pen/inaprovaline
	name = "Inaprovaline pen"
	desc = "A pen loaded with stimulant reagent. Use it for people in critical condition!"
	icon_state = "inaprovaline_pen"
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/inaprovaline = 30)

/obj/item/reagent_containers/hypospray/autoinjector/pen/hypervene
	name = "Hypervene pen"
	desc = "A pen loaded with purge reagent. Be careful, it causes severe pain and purges EVERYTHING."
	icon_state = "hypervene_pen"
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/hypervene = 30)

/obj/item/storage/pill_bottle/oxycodone
	name = "oxycodone pill bottle"
	desc = "Contains pills that numb severe pain."
	pill_type_to_fill = /obj/item/reagent_containers/pill/oxycodone
	greyscale_colors = "#360570#ffffff"
	description_overlay = "Ox"

/obj/item/storage/pill_bottle/meraderm
	name = "Meraderm pill bottle"
	desc = "Contains pills used to heal cuts and burns, yum!"
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/meraderm
	greyscale_colors = "#ECFC00#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottleround
	description_overlay = "MD"
