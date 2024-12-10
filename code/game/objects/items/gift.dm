/* Gifts and wrapping paper
 * Contains:
 * Gifts
 * Wrapping Paper
 */

/*
 * Gifts
 */

GLOBAL_LIST_EMPTY(possible_gifts)

///special grenade that looks like a present, santa spawn only
/obj/item/explosive/grenade/gift
	name = "gift"
	desc = "A wrapped bundle of joy, you'll have to get closer to see who it's addressed to."
	icon = 'icons/obj/items/items.dmi'
	icon_state = "gift0"
	hud_state = "gift0"

/obj/item/explosive/grenade/gift/Initialize(mapload)
	. = ..()
	icon_state = "gift[rand(0,10)]"
	item_state = icon_state
	hud_state = icon_state
	icon_state_mini = icon_state

/obj/item/explosive/grenade/gift/attack_self(mob/user)
	if(HAS_TRAIT(user, TRAIT_SANTA_CLAUS)) //santa uses the present as a grenade
		to_chat(user, span_warning("This present is now live, toss it at somebody naughty!"))
		. = ..()
	else //anyone else opening the present gets an explosion, yes this also affects elves
		flame_radius(1, user)
		qdel(src)

/obj/item/explosive/grenade/gift/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_SANTA_CLAUS))
		. += "This present is rigged to blow! Activate it yourself to throw it like a grenade, or give it to somebody on the naughty list and watch it blow up in their face."
	if(HAS_TRAIT(user, TRAIT_CHRISTMAS_ELF))
		. += "One of the boss' presents, this one is explosive and will go off if you open it."


/obj/item/a_gift
	name = "gift"
	desc = "A wrapped bundle of joy, you'll have to get closer to see who it's addressed to."
	icon = 'icons/obj/items/items.dmi'
	icon_state = "gift0"
	resistance_flags = RESIST_ALL
	///if true the present can be opened by anybody
	var/freepresent = FALSE
	///who is the present addressed to?
	var/mob/living/carbon/human/present_receiver = null
	///item contained in this gift
	var/obj/item/contains_type
	///real name of the present receiver
	var/present_receiver_name = null
	///is santa the giver of this present?
	var/is_santa_present = FALSE

/obj/item/a_gift/santa
	is_santa_present = TRUE

/obj/item/a_gift/Initialize(mapload)
	. = ..()
	pixel_x = rand(-10,10)
	pixel_y = rand(-10,10)
	icon_state = "gift[rand(0,10)]"

	contains_type = get_gift_type()

/obj/item/a_gift/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_SANTA_CLAUS)) //santa can reveal the owner of a present just by looking at it
		if(present_receiver == null && !freepresent)
			get_recipient()
	if(present_receiver)
		. += "This present is addressed to [present_receiver_name]."

/obj/item/a_gift/attack_self(mob/M)
	if(present_receiver == null && !freepresent && !HAS_TRAIT(M, TRAIT_SANTA_CLAUS))
		to_chat(M, span_warning("You start unwrapping the present, trying to locate any sign of who the present belongs to..."))
		if(!do_after(M, 4 SECONDS))
			return
		get_recipient() //generate owner of gift
	if(HAS_TRAIT(M, TRAIT_SANTA_CLAUS) || HAS_TRAIT(M, TRAIT_CHRISTMAS_ELF))
		if(present_receiver == null && !freepresent)
			get_recipient()
		to_chat(M, span_notice("This present is addressed to [present_receiver_name]."))
		to_chat(M, span_warning("You're supposed to deliver presents, not open them."))
		return
	if(!freepresent && present_receiver != M)
		switch(tgui_alert(M, "This present is addressed to [present_receiver_name]. Open it anyways?", "Continue?", list("Yes", "No")))
			if("Yes")
				if(!do_after(M, 1.5 SECONDS))
					to_chat(M, span_warning("You start unwrapping the present..."))
					return
				M.visible_message(span_warning("[M] tears into [present_receiver_name]'s gift with reckless abandon!"))
				M.balloon_alert_to_viewers("Open's [present_receiver_name]'s gift" ,ignored_mobs = M)
				log_game("[M] has opened a present that belonged to [present_receiver_name] at [AREACOORD(loc)]")
				if(prob(70) || HAS_TRAIT(M, TRAIT_CHRISTMAS_GRINCH))
					GLOB.round_statistics.presents_grinched += 1
					if(!HAS_TRAIT(M, TRAIT_CHRISTMAS_GRINCH))
						GLOB.round_statistics.number_of_grinches += 1
						ADD_TRAIT(M, TRAIT_CHRISTMAS_GRINCH, TRAIT_CHRISTMAS_GRINCH) //bad present openers are effectively cursed to receive nothing but coal for the rest of the round
						to_chat(M, span_boldannounce("Your heart feels three sizes smaller..."))
						M.color = COLOR_LIME
					spawnpresent(M) //they have the grinch trait, the presents will always spawn coal
				else
					spawnpresent(M, TRUE) //they got lucky, the present will open as normal but with a STOLEN label in the desc
				qdel(src)
			else
				return

	qdel(src)
	spawnpresent(M)

/obj/item/a_gift/proc/get_recipient(mob/M)
	var/list/z_levels = SSmapping.levels_by_any_trait(list(ZTRAIT_MARINE_MAIN_SHIP, ZTRAIT_GROUND, ZTRAIT_RESERVED))
	var/list/eligible_targets = list()
	for(var/z in z_levels)
		for(var/i in GLOB.alive_human_list)
			var/mob/living/carbon/human/potential_gift_receiver = i
			if(!istype(potential_gift_receiver) || !potential_gift_receiver.client)
				continue
			eligible_targets += potential_gift_receiver
	if(!length(eligible_targets))
		freepresent = TRUE //nobody alive, anybody can open it
	present_receiver = (pick(eligible_targets))
	present_receiver_name = present_receiver.real_name //assign real name for maximum readability on examine

/obj/item/a_gift/proc/spawnpresent(mob/M, stolen_gift)
	if(HAS_TRAIT(M, TRAIT_CHRISTMAS_GRINCH))
		var/obj/item/C = new /obj/item/ore/coal(get_turf(M))
		to_chat(M, span_boldannounce("You feel the icy tug of Santa's magic envelop the present before you can open it!"))
		M.put_in_hands(C)
		M.balloon_alert_to_viewers("Received a piece of [C]")
		return
	else
		var/obj/item/I = new contains_type(get_turf(M))
		log_game("[M] has opened a present that contained a [I] at [AREACOORD(loc)]")
		if(QDELETED(I)) //might contain something like metal rods that might merge with a stack on the ground
			M.balloon_alert_to_viewers("Nothing inside [M]'s gift" ,ignored_mobs = M)
			M.balloon_alert(M, "Nothing inside")
			return
		if(!freepresent)
			if(is_santa_present)
				GLOB.round_statistics.santa_presents_delivered += 1
			GLOB.round_statistics.presents_delivered += 1
		if(!stolen_gift)
			I.desc += " Property of [M.real_name]."
		else
			I.color = pick(COLOR_SOFT_RED, COLOR_GREEN, COLOR_LIME, COLOR_RED_LIGHT)
			I.desc += " The word 'STOLEN' is visible in bright red and green ink."
		M.balloon_alert_to_viewers("Found a [I]")
		M.put_in_hands(I)

/obj/item/a_gift/proc/get_gift_type()
	var/gift_type_list = list(
		/obj/item/weapon/claymore,
		/obj/item/toy/dice/d20,
		/obj/item/toy/plush/rouny,
		/obj/item/toy/spinningtoy,
		/obj/item/toy/syndicateballoon,
		/obj/item/megaphone,
		/obj/item/storage/box/snappops,
		/obj/item/storage/belt/champion,
		/obj/item/tool/soap/deluxe,
		/obj/item/explosive/grenade/smokebomb,
		list(/obj/item/clothing/head/boonie,
		/obj/item/clothing/head/beaverhat, /obj/item/clothing/head/cakehat, /obj/item/clothing/head/cardborg, /obj/item/clothing/head/chicken, /obj/item/clothing/head/powdered_wig),
		list(/obj/item/clothing/head/xenos, /obj/item/clothing/suit/xenos),
		/obj/item/clothing/mask/cigarette/pipe/cobpipe,
		/obj/item/book/manual/chef_recipes,
		/obj/item/toy/beach_ball,
		/obj/item/toy/beach_ball/holoball,
		/obj/item/weapon/banhammer,
		/obj/item/stack/barbed_wire/small_stack,
		/obj/item/storage/toolbox/syndicate,
		/obj/item/clothing/mask/facehugger/lamarr,
		/obj/item/clothing/tie/horrible,
		/obj/item/tweezers_advanced,
		/obj/item/tool/pickaxe/plasmacutter,
		/obj/item/pinpointer,
		/obj/item/a_gift/anything,
		/obj/item/toy/prize/durand,
		/obj/item/stack/sheet/mineral/phoron/small_stack,
		/obj/item/stack/sheet/metal/small_stack,
		/obj/item/jetpack_marine,
		/obj/item/phone,
		/obj/item/binoculars/tactical,
		/obj/item/clock,
		/obj/item/stack/sheet/plasteel/small_stack,
		/obj/item/ore/coal,
		/obj/item/clothing/suit/storage/marine/boomvest/ob_vest,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/burstfire_assembly,
		list(/obj/item/clothing/gloves/techpriest, /obj/item/clothing/head/techpriest, /obj/item/clothing/shoes/techpriest, /obj/item/clothing/suit/techpriest, /obj/item/clothing/under/techpriest,),
		/obj/item/paper/santacontract,
		)

	gift_type_list += subtypesof(/obj/item/loot_box)
	gift_type_list += subtypesof(/obj/item/clothing/head/collectable)
	gift_type_list += subtypesof(/obj/item/toy)
	gift_type_list += subtypesof(/obj/item/cell)
	gift_type_list += subtypesof(/obj/item/explosive/grenade)
	gift_type_list += subtypesof(/obj/item/clothing/mask) - /obj/item/clothing/mask/gas/swat/santa - /obj/item/clothing/mask/rebreather/scarf - /obj/item/clothing/mask/bandanna/skull - /obj/item/clothing/mask/bandanna/green - /obj/item/clothing/mask/bandanna/white - /obj/item/clothing/mask/bandanna/black - /obj/item/clothing/mask/bandanna - /obj/item/clothing/mask/bandanna/alpha - /obj/item/clothing/mask/bandanna/bravo - /obj/item/clothing/mask/bandanna/charlie - /obj/item/clothing/mask/bandanna/delta - /obj/item/clothing/mask/balaclava - /obj/item/clothing/mask/rebreather - /obj/item/clothing/mask/breath - /obj/item/clothing/mask/gas - /obj/item/clothing/mask/gas/tactical - /obj/item/clothing/mask/gas/tactical/coif
	gift_type_list += subtypesof(/obj/item/reagent_containers/food)
	gift_type_list += subtypesof(/obj/item/reagent_containers/spray)
	gift_type_list += subtypesof(/obj/item/reagent_containers/blood) - /obj/item/reagent_containers/blood/empty
	gift_type_list += subtypesof(/obj/item/tool) - /obj/item/tool/weedkiller - /obj/item/tool/weedkiller/D24 - /obj/item/tool/weedkiller/lindane - /obj/item/tool/weedkiller/triclopyr - /obj/item/tool/taperoll - /obj/item/tool/taperoll/engineering - /obj/item/tool/taperoll/police - /obj/item/tool/weldpack/marinestandard
	gift_type_list += subtypesof(/obj/item/research_resource)
	gift_type_list += subtypesof(/obj/item/research_product)
	gift_type_list += subtypesof(/obj/item/stack/sheet/animalhide)
	gift_type_list += subtypesof(/obj/item/stack/sheet/mineral)
	gift_type_list += subtypesof(/obj/item/storage/pill_bottle) - /obj/item/storage/pill_bottle/dice
	gift_type_list += subtypesof(/obj/item/storage/toolbox)
	gift_type_list += subtypesof(/obj/item/reagent_containers/glass)
	gift_type_list += subtypesof(/obj/item/reagent_containers/pill)
	gift_type_list += subtypesof(/obj/item/instrument) - /obj/item/instrument/violin - /obj/item/instrument/piano_synth - /obj/item/instrument/banjo - /obj/item/instrument/guitar - /obj/item/instrument/glockenspiel - /obj/item/instrument/accordion - /obj/item/instrument/trumpet - /obj/item/instrument/saxophone - /obj/item/instrument/trombone - /obj/item/instrument/recorder - /obj/item/instrument/harmonica
	gift_type_list += subtypesof(/obj/item/weapon/gun/flamer)
	gift_type_list += subtypesof(/obj/item/portable_vendor)
	gift_type_list += subtypesof(/obj/item/storage/fancy)
	gift_type_list += subtypesof(/obj/item/storage/syringe_case)
	gift_type_list += subtypesof(/obj/item/minerupgrade)
	gift_type_list += subtypesof(/obj/item/weapon/shield)
	gift_type_list += subtypesof(/obj/item/weapon/claymore)
	gift_type_list += subtypesof(/obj/item/bedsheet)
	gift_type_list += subtypesof(/obj/item/cell)
	gift_type_list += subtypesof(/obj/item/weapon/twohanded) - /obj/item/weapon/twohanded/offhand - /obj/item/weapon/twohanded/spear/tactical - /obj/item/weapon/twohanded/glaive/harvester
	gift_type_list += subtypesof(/obj/item/armor_module/module) - /obj/item/armor_module/module/welding - /obj/item/armor_module/module/binoculars - /obj/item/armor_module/module/artemis - /obj/item/armor_module/module/tyr_head - /obj/item/armor_module/module/antenna - /obj/item/armor_module/module/mimir_environment_protection/mark1 - /obj/item/armor_module/module/mimir_environment_protection/mimir_helmet/mark1 - /obj/item/armor_module/module/tyr_extra_armor/mark1 - /obj/item/armor_module/module/ballistic_armor - /obj/item/armor_module/module/hod_head - /obj/item/armor_module/module/better_shoulder_lamp - /obj/item/armor_module/module/chemsystem - /obj/item/armor_module/module/eshield - /obj/item/armor_module/module/motion_detector
	gift_type_list += subtypesof(/obj/item/armor_module/storage) - /obj/item/armor_module/storage/boot/som_knife - /obj/item/armor_module/storage/boot/full - /obj/item/armor_module/storage/boot - /obj/item/armor_module/storage/general - /obj/item/armor_module/storage/engineering - /obj/item/armor_module/storage/medical - /obj/item/armor_module/storage/injector - /obj/item/armor_module/storage/grenade
	gift_type_list += subtypesof(/obj/item/clothing/mask/cigarette/cigar)
	gift_type_list += subtypesof(/obj/item/clothing/mask/cigarette/pipe)
	gift_type_list += subtypesof(/obj/item/clothing/head/wizard)
	gift_type_list += subtypesof(/obj/item/clothing/head/hardhat)
	gift_type_list += subtypesof(/obj/item/clothing/head/soft)
	gift_type_list += subtypesof(/obj/item/clothing/head/helmet/space) - /obj/item/clothing/head/helmet/space/santahat/special - /obj/item/clothing/head/helmet/space/elf/special
	gift_type_list += subtypesof(/obj/item/clothing/head/collectable)
	gift_type_list += subtypesof(/obj/item/clothing/glasses/sunglasses) - /obj/item/clothing/glasses/sunglasses/sa - /obj/item/clothing/glasses/sunglasses/sa/nodrop - /obj/item/clothing/glasses/night/sectoid - /obj/item/clothing/glasses/welding/elf - /obj/item/clothing/glasses/regular - /obj/item/clothing/glasses/eyepatch - /obj/item/clothing/glasses/sunglasses/fake/big - /obj/item/clothing/glasses/sunglasses/fake/big/prescription - /obj/item/clothing/glasses/sunglasses/fake - /obj/item/clothing/glasses/sunglasses/fake/prescription - /obj/item/clothing/glasses/mgoggles - /obj/item/clothing/glasses/mgoggles/prescription
	gift_type_list += subtypesof(/obj/item/bodybag) - /obj/item/bodybag/cryobag
	gift_type_list += subtypesof(/obj/item/implanter) - /obj/item/implanter/chem - /obj/item/implanter/neurostim
	gift_type_list += subtypesof(/obj/item/mortal_shell)
	gift_type_list += subtypesof(/obj/item/storage/backpack) - /obj/item/storage/backpack/santabag - /obj/item/storage/backpack/marine/standard - /obj/item/storage/backpack/marine/satchel - /obj/item/storage/backpack/marine/satchel/green - /obj/item/storage/backpack/marine/standard/molle - /obj/item/storage/backpack/marine/satchel/molle
	gift_type_list += subtypesof(/obj/item/toy/plush)
	var/gift_type = pick(gift_type_list)

	return gift_type


/obj/item/a_gift/anything
	name = "christmas gift"
	desc = "It could be anything!"
	freepresent = TRUE

/obj/item/a_gift/anything/get_gift_type()
	if(!GLOB.possible_gifts.len)
		var/list/gift_types_list = subtypesof(/obj/item)
		GLOB.possible_gifts = gift_types_list
	var/gift_type = pick(GLOB.possible_gifts)

	return gift_type

/obj/item/a_gift/free
	freepresent = TRUE
