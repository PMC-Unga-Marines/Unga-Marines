/obj/structure/barricade/wood
	name = "wooden barricade"
	desc = "A wall made out of wooden planks nailed together. Not very sturdy, but can provide some concealment."
	icon_state = "wooden"
	max_integrity = 100
	layer = OBJ_LAYER
	stack_type = /obj/item/stack/sheet/wood
	stack_amount = 5
	destroyed_stack_amount = 3
	hit_sound = 'sound/effects/woodhit.ogg'
	can_change_dmg_state = FALSE
	barricade_type = "wooden"
	can_wire = FALSE

/obj/structure/barricade/wood/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_WOOD, -40, 5)

/obj/structure/barricade/wood/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(!istype(I, /obj/item/stack/sheet/wood))
		return
	var/obj/item/stack/sheet/wood/D = I
	if(obj_integrity >= max_integrity)
		return

	if(D.get_amount() < 1)
		balloon_alert(user, "You need more wood")
		return

	if(LAZYACCESS(user.do_actions, src))
		return

	balloon_alert_to_viewers("Repairing...")

	if(!do_after(user, 2 SECONDS, NONE, src, BUSY_ICON_FRIENDLY) || obj_integrity >= max_integrity)
		return

	if(get_self_acid())
		balloon_alert(user, "It's melting!")
		return TRUE

	if(!D.use(1))
		return

	repair_damage(max_integrity, user)
	balloon_alert_to_viewers("Repaired")
	update_icon()
