/obj/structure/barricade/sandbags
	name = "sandbag barricade"
	desc = "A bunch of bags filled with sand, stacked into a small wall. Surprisingly sturdy, albeit labour intensive to set up. Trusted to do the job since 1914."
	icon_state = "sandbag_0"
	icon = 'icons/obj/structures/barricades/sandbag.dmi'
	max_integrity = 300
	soft_armor = list(MELEE = 0, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 0, BIO = 100, FIRE = 80, ACID = 40)
	coverage = 128
	stack_type = /obj/item/stack/sandbags
	hit_sound = 'sound/weapons/genhit.ogg'
	barricade_type = "sandbag"
	can_wire = TRUE

/obj/structure/barricade/sandbags/update_icon()
	. = ..()
	if(dir == SOUTH)
		pixel_y = -7
	else if(dir == NORTH)
		pixel_y = 7
	else
		pixel_y = 0

/obj/structure/barricade/sandbags/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/tool/shovel) && user.a_intent != INTENT_HARM)
		var/obj/item/tool/shovel/ET = I
		if(ET.folded)
			return TRUE
		balloon_alert_to_viewers("disassembling...")
		if(!do_after(user, ET.shovelspeed, NONE, src, BUSY_ICON_BUILD))
			return TRUE
		user.visible_message(span_notice("[user] disassembles [src]."),
		span_notice("You disassemble [src]."))
		deconstruct(!get_self_acid())
		return TRUE

	if(istype(I, /obj/item/stack/sandbags))
		if(obj_integrity == max_integrity)
			balloon_alert(user, "Already repaired")
			return
		var/obj/item/stack/sandbags/D = I
		if(D.get_amount() < 1)
			balloon_alert(user, "Not enough sandbags")
			return
		balloon_alert_to_viewers("Replacing sandbags...")

		if(LAZYACCESS(user.do_actions, src))
			return

		if(!do_after(user, 3 SECONDS, NONE, src, BUSY_ICON_BUILD) || obj_integrity >= max_integrity)
			return

		if(get_self_acid())
			balloon_alert(user, "It's melting!")
			return

		if(!D.use(1))
			return

		repair_damage(max_integrity * 0.2, user) //Each sandbag restores 20% of max health as 5 sandbags = 1 sandbag barricade.
		balloon_alert_to_viewers("Repaired")
		update_icon()
