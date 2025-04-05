/obj/machinery/practice/medical/surgery
	name = "Practice Button (Surgery)"
	desc = "A button used to simulate situations for training purposes."
	icon = 'icons/obj/machines/buttons.dmi'
	icon_state = "door"
	resistance_flags = RESIST_ALL
	var/mob/living/carbon/human/humanspawned = null

/obj/machinery/practice/medical/surgery/Initialize(mapload)
	. = ..()

	switch(dir)
		if(NORTH)
			pixel_y = -24
		if(SOUTH)
			pixel_y = 24
		if(EAST)
			pixel_x = -24
		if(WEST)
			pixel_x = 24

/obj/machinery/practice/medical/surgery/attack_hand(mob/living/user)
	if(user.a_intent == INTENT_HARM)
		to_chat(user, span_warning("You are unable to damage the button."))
		return
	var/choice = tgui_input_list(user, "What surgery would you like to simulate?", "Surgery Dummy", list("Basic dummy", "Larval host", "Broken bones", "Missing limbs", "Damaged organs"), "Basic dummy", 0)
	if(!choice)
		to_chat(user, span_notice("You must select a surgery to start the simulation."))
		return
	if(!isnull(humanspawned))
		QDEL_NULL(humanspawned)
		visible_message(span_notice("The dummy vanishes suddenly!"))
	switch(choice)
		if("Basic dummy")
			humanspawned = new /mob/living/carbon/human(get_turf(src))
		if("Larval host")
			humanspawned = new /mob/living/carbon/human(get_turf(src))
			new /obj/item/alien_embryo(humanspawned)
		if("Broken bones")
			humanspawned = new /mob/living/carbon/human(get_turf(src))
			var/datum/limb/L = pick(humanspawned.limbs)
			L.fracture()
		if("Missing limbs")
			humanspawned = new /mob/living/carbon/human(get_turf(src))
			humanspawned.remove_random_limb(TRUE)
		if("Damaged organs")
			humanspawned = new /mob/living/carbon/human(get_turf(src))
			var/datum/internal_organ/O = pick(humanspawned.internal_organs)
			O.take_damage(40)
