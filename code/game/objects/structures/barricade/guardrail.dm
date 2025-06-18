/obj/structure/barricade/guardrail
	name = "guard rail"
	desc = "A short wall made of rails to prevent entry into dangerous areas."
	icon_state = "railing_0"
	coverage = 25
	max_integrity = 150
	soft_armor = list(MELEE = 0, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 15, BIO = 100, FIRE = 100, ACID = 10)
	stack_type = /obj/item/stack/rods
	destroyed_stack_amount = 3
	hit_sound = 'sound/effects/metalhit.ogg'
	barricade_type = "railing"
	can_wire = FALSE

/obj/structure/barricade/guardrail/update_icon()
	. = ..()
	if(dir == NORTH)
		pixel_y = 12
