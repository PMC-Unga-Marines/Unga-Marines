/obj/structure/girder/ex_act(severity, direction)
	take_damage(severity, BRUTE, BOMB, attack_dir = direction)

/obj/structure/girder/on_explosion_destruction(severity, direction)
	create_shrapnel(get_turf(src), rand(2, 5), direction, 45, /datum/ammo/bullet/shrapnel/light)
