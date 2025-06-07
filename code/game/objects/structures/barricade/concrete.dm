/obj/structure/barricade/concrete
	name = "concrete barricade"
	desc = "A short wall made of reinforced concrete. It looks like it can take a lot of punishment."
	icon_state = "concrete_0"
	icon = 'icons/obj/structures/barricades/concrete.dmi'
	coverage = 100
	max_integrity = 500
	soft_armor = list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 60, BOMB = 40, BIO = 100, FIRE = 100, ACID = 20)
	stack_type = null
	destroyed_stack_amount = 0
	hit_sound = 'sound/effects/metalhit.ogg'
	barricade_type = "concrete"
	can_wire = FALSE

/obj/structure/barricade/concrete/update_overlays()
	. = ..()
	var/image/new_overlay = image(icon, src, "[icon_state]_overlay", dir == SOUTH ? BELOW_OBJ_LAYER : ABOVE_MOB_LAYER, dir)
	new_overlay.pixel_y = (dir == SOUTH ? -32 : 32)
	. += new_overlay
