/obj/item/card
	name = "card"
	desc = "Does card things."
	icon = 'icons/obj/items/card.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/id_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/id_right.dmi',
	)
	worn_icon_state = "card-id"
	worn_icon_state_worn = TRUE
	w_class = WEIGHT_CLASS_TINY
	var/associated_account_number = 0
	var/list/files = list(  )

/obj/item/card/emag_broken // left as decor for maps
	desc = "It's a card with a magnetic strip attached to some circuitry. It looks too busted to be used for anything but salvage."
	name = "broken cryptographic sequencer"
	icon_state = "emag"

/obj/item/card/id
	name = "identification card"
	desc = "A card used to provide ID and determine access to a large array of machinery."
	icon_state = "id"
	equip_slot_flags = ITEM_SLOT_ID
	///The access this id card has
	var/access = list()
	/// The name registered_name on the card
	var/registered_name = "Unknown"
	///Miscelaneous ID flags
	var/id_flags = CAN_BUY_LOADOUT
	///Blood type of the person that has it.
	var/blood_type = "\[UNSET\]"

	///How many points you can use to buy items
	var/marine_points = list()

	///What category of items can you buy - used for armor and pouches
	var/marine_buy_choices = list()

	//alt titles are handled a bit weirdly in order to unobtrusively integrate into existing ID system
	var/assignment = null	//can be alt title or the actual job
	///actual job
	var/rank = null
	/// Marine's paygrade
	var/paygrade = null
	///which fire team this ID belongs to, only used by squad marines.
	var/assigned_fireteam = ""
	/// Iff bitfield to determines hit and misses
	var/iff_signal = NONE

/obj/item/card/id/Initialize(mapload)
	. = ..()
	marine_buy_choices = GLOB.marine_selector_cats.Copy() //by default you can buy the whole list
	if(!ishuman(loc))
		return
	var/mob/living/carbon/human/H = loc
	blood_type = H.blood_type
	GLOB.id_card_list += src

/obj/item/card/id/Destroy()
	GLOB.id_card_list -= src
	return ..()

/obj/item/card/id/attack_self(mob/user as mob)
	user.visible_message("[user] shows you: [icon2html(src, viewers(user))] [name]: assignment: [assignment]")

/obj/item/card/id/vv_edit_var(var_name, var_value)
	. = ..()
	if(!.)
		return
	if(var_name == ("assignment" || "registered_name"))
		update_label()

/obj/item/card/id/proc/update_label(newname, newjob)
	if(newname || newjob)
		name = "[(!newname)	? "identification card"	: "[newname]'s ID Card"][(!newjob) ? "" : " ([newjob])"]"
		return

	name = "[(!paygrade) ? "" : "[get_paygrades(paygrade, TRUE, gender)]. "][(!registered_name)	? "identification card"	: "[registered_name]'s ID Card"][(!assignment) ? "" : " ([assignment])"]"
	if(isliving(loc))
		var/mob/living/L = loc
		L.name = L.get_visible_name()

/obj/item/card/id/proc/set_user_data(mob/living/carbon/human/human_user)
	if(!istype(human_user))
		return

	registered_name = human_user.real_name
	blood_type = human_user.blood_type

/obj/item/card/id/verb/read()
	set name = "Read ID Card"
	set category = "IC.Clothing"
	set src in usr

	to_chat(usr, "[icon2html(src, usr)] [name]: The current assignment on the card is [assignment].")
	to_chat(usr, "The blood type on the card is [blood_type].")

/obj/item/card/id/equipped(mob/living/carbon/human/H, slot)
	if(istype(H))
		H.update_inv_head() //updating marine helmet squad coloring
		H.update_inv_wear_suit()
	return ..()

/obj/item/card/id/dropped(mob/user)
	if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		H.update_inv_head() //Don't do a full update yet
		H.update_inv_wear_suit()
	return ..()

/obj/item/card/id/silver
	name = "identification card"
	desc = "A silver card which shows honour and dedication."
	icon_state = "silver"
	worn_icon_state = "silver_id"

/obj/item/card/id/gold
	name = "identification card"
	desc = "A golden card which shows power and might."
	icon_state = "gold"
	worn_icon_state = "gold_id"
	marine_points = list(CAT_SYNTH = SYNTH_TOTAL_BUY_POINTS)

/obj/item/card/id/syndicate
	name = "agent card"
	access = list(ACCESS_ILLEGAL_PIRATE)
	var/registered_user = null

/obj/item/card/id/syndicate/Initialize(mapload)
	. = ..()
	if(ismob(loc)) // Runtime prevention on laggy starts or where users log out because of lag at round start.
		var/mob/user = loc
		registered_name = ishuman(user) ? user.real_name : user.name
	else
		registered_name = "Agent Card"
	assignment = "Agent"
	name = "[registered_name]'s ID Card ([assignment])"

/obj/item/card/id/syndicate/attack_self(mob/user as mob)
	if(!src.registered_name)
		//Stop giving the players unsanitized unputs! You are giving ways for players to intentionally crash clients! -Nodrak
		var/newname = reject_bad_name(tgui_input_text(user, "What name would you like to put on this card?", "Agent card name", ishuman(user) ? user.real_name : user.name))
		if(!newname) //Same as mob/new_player/prefrences.dm
			alert("Invalid name.")
			return
		src.registered_name = newname

		var/newjob = stripped_input(user, "What occupation would you like to put on this card?\nNote: This will not grant any access levels other than Maintenance.", "Agent card job assignment", "Agent")
		if(!newjob)
			alert("Invalid assignment.")
			src.registered_name = ""
			return
		src.assignment = newjob
		src.name = "[src.registered_name]'s ID Card ([src.assignment])"
		to_chat(user, span_notice("You successfully forge the ID card."))
		registered_user = user
	else if(!registered_user || registered_user == user)

		if(!registered_user) registered_user = user  //

		switch(tgui_alert(user, "Would you like to display the ID, or retitle it?", "Choose.", list("Rename","Show")))
			if("Rename")
				var/newname = stripped_input(user, "What name would you like to put on this card?", "Agent card name", ishuman(user) ? user.real_name : user.name, max_length = 26)
				if(!newname || newname == "Unknown" || newname == "floor" || newname == "wall" || newname == "r-wall") //Same as mob/new_player/prefrences.dm
					alert("Invalid name.")
					return
				src.registered_name = newname

				var/newjob = stripped_input(user, "What occupation would you like to put on this card?\nNote: This will not grant any access levels other than Maintenance.", "Agent card job assignment", "Assistant")
				if(!newjob)
					alert("Invalid assignment.")
					return
				src.assignment = newjob
				src.name = "[src.registered_name]'s ID Card ([src.assignment])"
				to_chat(user, span_notice("You successfully forge the ID card."))
				return
			if("Show")
				return ..()
	else
		return ..()

/obj/item/card/id/syndicate_command
	name = "syndicate ID card"
	desc = "An ID straight from the Syndicate."
	registered_name = "Syndicate"
	assignment = "Syndicate Overlord"
	access = list(ACCESS_ILLEGAL_PIRATE)

/obj/item/card/id/captains_spare
	name = "captain's spare ID"
	desc = "The spare ID of the High Lord himself."
	icon_state = "gold"
	worn_icon_state = "gold_id"
	registered_name = CAPTAIN
	assignment = CAPTAIN
	access = ALL_MARINE_ACCESS

/obj/item/card/id/sec
	name = "identification card"
	desc = "A security card which shows law and order."
	icon_state = "sec"
	worn_icon_state = "silver_id"

/obj/item/card/id/dogtag
	name = "dog tag"
	desc = "A marine dog tag."
	icon_state = "dogtag"
	worn_icon_state = "dogtag"
	iff_signal = TGMC_LOYALIST_IFF
	marine_points = list(CAT_MARINE = MARINE_TOTAL_BUY_POINTS)

/obj/item/card/id/dogtag/examine(mob/user)
	. = ..()
	if(ishuman(user))
		. += span_notice("It reads: \"[registered_name] - [assignment] - [blood_type]\"")

/obj/item/card/id/dogtag/canStrip(mob/stripper, mob/owner)
	. = ..()
	if(!.)
		return
	if(stripper.faction == owner.faction && owner.stat != DEAD) // no grief please
		stripper.balloon_alert(stripper, "[owner.name] isn't dead yet")
		return FALSE

// Vendor points for job override
/obj/item/card/id/dogtag/smartgun
	marine_points = list(CAT_SGSUP = SMARTGUNNER_TOTAL_BUY_POINTS)

/obj/item/card/id/dogtag/robot
	marine_points = list(CAT_ROBOT = ROBOT_TOTAL_BUY_POINTS)

/obj/item/card/id/dogtag/engineer
	marine_points = list(CAT_ENGSUP = ENGINEER_TOTAL_BUY_POINTS)

/obj/item/card/id/dogtag/leader
	marine_points = list(CAT_LEDSUP = LEADER_TOTAL_BUY_POINTS)

/obj/item/card/id/dogtag/corpsman
	marine_points = list(CAT_MEDSUP = MEDIC_TOTAL_BUY_POINTS)

/obj/item/card/id/dogtag/fc
	marine_points = list(CAT_FCSUP = COMMANDER_TOTAL_BUY_POINTS)

/obj/item/card/id/dogtag/full
	marine_points = list(
		CAT_MARINE = MARINE_TOTAL_BUY_POINTS,
		CAT_SGSUP = SMARTGUNNER_TOTAL_BUY_POINTS,
		CAT_ENGSUP = ENGINEER_TOTAL_BUY_POINTS,
		CAT_LEDSUP = LEADER_TOTAL_BUY_POINTS,
		CAT_MEDSUP = MEDIC_TOTAL_BUY_POINTS,
		CAT_FCSUP = COMMANDER_TOTAL_BUY_POINTS,
		CAT_SYNTH = SYNTH_TOTAL_BUY_POINTS,
		CAT_ROBOT = ROBOT_TOTAL_BUY_POINTS, //necessary to correctly show max points
	)

/obj/item/card/id/dogtag/som
	name = "\improper Sons of Mars dogtag"
	desc = "Used by the Sons of Mars."
	icon_state = "dogtag_som"
	worn_icon_state = "dogtag_som"
	iff_signal = SOM_IFF
