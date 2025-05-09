//Claim gear, same as the Hunter's get.
/obj/item/clothing/gloves/yautja/thrall/buy_gear(mob/living/carbon/human/wearer)
	if(wearer.gloves != src)
		to_chat(wearer, span_warning("You need to be wearing your thrall bracers to do this."))
		return

	if(wearer.hunter_data.claimed_equipment)
		to_chat(wearer, span_warning("You've already claimed your equipment."))
		return

	if(wearer.stat || (wearer.lying_angle && !wearer.resting && !wearer.has_status_effect(STATUS_EFFECT_SLEEPING)) || (wearer.has_status_effect(STATUS_EFFECT_PARALYZED) || wearer.has_status_effect(STATUS_EFFECT_UNCONSCIOUS)) || wearer.lying_angle || wearer.buckled)
		to_chat(wearer, span_warning("You're not able to do that right now."))
		return

	if(!istype(get_area(wearer), /area/yautja))
		to_chat(wearer, span_warning("Not here. Only on the ship."))
		return

	var/sure = alert("An array of powerful weapons are displayed to you. Pick your gear carefully. If you cancel at any point, you will not claim your equipment.","Sure?","Begin the Hunt","No, not now")
	if(sure == "Begin the Hunt")
		var/list/hmelee = list(YAUTJA_THRALL_GEAR_MACHETE = image(icon = 'icons/obj/items/weapons.dmi', icon_state = "machete"), YAUTJA_THRALL_GEAR_RAPIER = image(icon = 'icons/obj/items/weapons.dmi', icon_state = "officer_sword"), YAUTJA_THRALL_GEAR_CLAYMORE = image(icon = 'icons/obj/items/weapons.dmi', icon_state = "mercsword"), YAUTJA_THRALL_GEAR_FIREAXE = image(icon = 'icons/obj/items/weapons.dmi', icon_state = "fireaxe"))
		var/list/ymelee = list(YAUTJA_GEAR_GLAIVE = image(icon = 'icons/obj/hunter/pred_gear.dmi', icon_state = "glaive"), YAUTJA_GEAR_WHIP = image(icon = 'icons/obj/hunter/pred_gear.dmi', icon_state = "whip"), YAUTJA_GEAR_SWORD = image(icon = 'icons/obj/hunter/pred_gear.dmi', icon_state = "clansword"), YAUTJA_GEAR_SCYTHE = image(icon = 'icons/obj/hunter/pred_gear.dmi', icon_state = "predscythe"), YAUTJA_GEAR_STICK = image(icon = 'icons/obj/hunter/pred_gear.dmi', icon_state = "combistick"), YAUTJA_GEAR_SPEAR = image(icon = 'icons/obj/hunter/pred_gear.dmi', icon_state = "spearhunter"))

		var/main_weapon
		var/type = alert("Do you plan on embracing alien weaponry, or sticking to your human roots?", "Human or Alien?", "Once Human, Always Human", "Let's try Alien")
		if(type == "Once Human, Always Human")
			main_weapon = show_radial_menu(wearer, wearer, hmelee)
		else
			main_weapon = show_radial_menu(wearer, wearer, ymelee)
		if(!main_weapon)
			return //We don't want them to cancel out then get nothing.

		if(wearer.gloves != src)
			to_chat(wearer, span_warning("You need to be wearing your thrall bracers to do this."))
			return

		if(wearer.hunter_data.claimed_equipment)
			to_chat(src, span_warning("You've already claimed your equipment."))
			return

		var/obj/item/spawned_weapon
		switch(main_weapon)
			if(YAUTJA_GEAR_GLAIVE)
				spawned_weapon = new /obj/item/weapon/twohanded/yautja/glaive(wearer.loc)
			if(YAUTJA_GEAR_SPEAR)
				spawned_weapon = new /obj/item/weapon/twohanded/yautja/spear(wearer.loc)
			if(YAUTJA_GEAR_WHIP)
				spawned_weapon = new /obj/item/weapon/yautja/chain(wearer.loc)
			if(YAUTJA_GEAR_SWORD)
				spawned_weapon = new /obj/item/weapon/yautja/sword(wearer.loc)
			if(YAUTJA_GEAR_SCYTHE)
				spawned_weapon = new /obj/item/weapon/yautja/scythe(wearer.loc)
			if(YAUTJA_GEAR_STICK)
				spawned_weapon = new /obj/item/weapon/yautja/combistick(wearer.loc)
			if(YAUTJA_THRALL_GEAR_MACHETE)
				spawned_weapon = new /obj/item/weapon/sword/machete(wearer.loc)
			if(YAUTJA_THRALL_GEAR_RAPIER)
				spawned_weapon = new /obj/item/weapon/sword/ceremonial(wearer.loc)
			if(YAUTJA_THRALL_GEAR_CLAYMORE)
				spawned_weapon = new /obj/item/weapon/sword(wearer.loc)
			if(YAUTJA_THRALL_GEAR_FIREAXE)
				spawned_weapon = new /obj/item/weapon/twohanded/fireaxe(wearer.loc)

		if(istype(spawned_weapon, /obj/item/weapon/yautja))
			var/obj/item/weapon/yautja/yautja_melee = spawned_weapon
			yautja_melee.human_adapted = TRUE
		else if(istype(spawned_weapon, /obj/item/weapon/twohanded/yautja))
			var/obj/item/weapon/twohanded/yautja/yautja_melee = spawned_weapon
			yautja_melee.human_adapted = TRUE
		spawned_weapon.desc += " It looks like this one has been modified for human use."

		wearer.hunter_data.claimed_equipment = TRUE

		claim_equipment.remove_action(wearer)
		new /obj/item/clothing/suit/armor/yautja/thrall(wearer.loc)
		new /obj/item/clothing/shoes/marine/yautja/thrall(wearer.loc)
		new /obj/item/clothing/under/chainshirt/thrall(wearer.loc)
		new /obj/item/clothing/mask/gas/yautja/thrall(wearer.loc)


//Link to thrall bracer, enabling most of it's abilities
/obj/item/clothing/gloves/yautja/hunter/verb/link_bracer()
	set name = "Link Thrall Bracer"
	set desc = "Link your bracer to that of your thrall."
	set category = "Yautja"
	set src in usr

	var/mob/living/carbon/human/user = usr
	if(!istype(user))
		return
	if(!user.hunter_data)
		to_chat(user, span_warning("ERROR: No hunter_data detected."))
		return

	if(linked_bracer)
		to_chat(user, span_yautjabold("[icon2html(src)] \The <b>[src]</b> beeps: Link is already established!"))
		return

	if(user.gloves != src)
		to_chat(user, span_warning("You are not wearing your bracer!"))
		return
	else if(!owner || user != owner)
		to_chat(user, span_yautjabold("[icon2html(src)] \The <b>[src]</b> beeps: Wrong user detected!"))
		return

	var/mob/living/carbon/human/T = user.hunter_data.thrall
	if(!T)
		to_chat(user, span_warning("You do not have a thrall to link to!"))
		return
	else if(!istype(T.gloves, /obj/item/clothing/gloves/yautja/thrall))
		to_chat(user, span_yautjabold("[icon2html(src)] \The <b>[src]</b> beeps: Your thrall is not wearing a bracer!"))
		return
	else
		var/obj/item/clothing/gloves/yautja/thrall/thrall_gloves = T.gloves

		linked_bracer = thrall_gloves
		thrall_gloves.linked_bracer = src
		thrall_gloves.owner = T
		if(!T.hunter_data.claimed_equipment)
			thrall_gloves.claim_equipment.give_action(T)

		to_chat(user, span_yautjabold("[icon2html(src)] \The <b>[src]</b> beeps: Your bracer is now linked to your thrall."))
		if(notification_sound)
			playsound(loc, 'sound/items/pred_bracer.ogg', 75, 1)

		to_chat(T, span_warning("\The [thrall_gloves] locks around your wrist with a sharp click."))
		to_chat(T, span_yautjabold("[icon2html(thrall_gloves)] \The <b>[thrall_gloves]</b> beeps: Your master has linked their bracer to yours."))
		if(thrall_gloves.notification_sound)
			playsound(thrall_gloves.loc, 'sound/items/pred_bracer.ogg', 75, 1)

// Message thrall or master
/obj/item/clothing/gloves/yautja/verb/bracer_message()
	set name = "Transmit Message"
	set desc = "For direct communication between thrall and master."
	set src in usr

	var/mob/living/carbon/human/messenger = usr
	if(!istype(messenger))
		return

	var/mob/living/carbon/human/receiver
	var/messenger_title = "thrall"
	var/receiver_title = "master"
	if(messenger.hunter_data.thralled)
		receiver = messenger.hunter_data.thralled_set
	else
		receiver = messenger.hunter_data.thrall
		messenger_title = "master"
		receiver_title = "thrall"

	if(!istype(receiver))
		to_chat(messenger, span_warning("You have no one to message!"))
		return
	if(!istype(receiver.gloves, /obj/item/clothing/gloves/yautja))
		to_chat(messenger, span_warning("Your [receiver_title] isn't wearing their bracer!"))
		return

	var/message = sanitize(input(messenger, "Enter the message you want to send:", "Send Message") as null|text)
	if(!message)
		return

	if(!istype(receiver))
		to_chat(messenger, span_warning("You have no one to message!"))
		return
	var/obj/item/clothing/gloves/yautja/receiver_gloves = receiver.gloves
	if(!istype(receiver_gloves))
		to_chat(messenger, span_warning("Your [receiver_title] isn't wearing their bracer!"))
		return

	to_chat(receiver, span_yautjabold("\The <b>[receiver_gloves]</b> beeps with a message from your [messenger_title]: [message]"))
	to_chat(messenger, span_yautjabold("\The <b>[src]</b> beeps: You have sent '[message]' to your [receiver_title]."))

	if(notification_sound)
		playsound(loc, 'sound/items/pred_bracer.ogg', 75, 1)
	if(receiver_gloves.notification_sound)
		playsound(receiver_gloves.loc, 'sound/items/pred_bracer.ogg', 75, 1)

	log_game("HUNTER: [key_name(messenger)] has sent [key_name(receiver)] the message '[message]' via bracer")

/obj/item/clothing/gloves/yautja/hunter/bracer_message()
	set category = "Yautja"
	. = ..()

/obj/item/clothing/gloves/yautja/thrall/bracer_message()
	set category = "Thrall"
	. = ..()
