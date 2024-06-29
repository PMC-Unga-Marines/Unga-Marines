/obj/structure/window/ex_act(severity, direction)
	take_damage(severity *= EXPLOSION_DAMAGE_MULTIPLIER_WINDOW, BRUTE, BOMB, attack_dir = direction)

/obj/structure/window/on_explosion_destruction(severity, direction)
	if(severity < 2000)
		return

	playsound(src, "windowshatter", 50, 1)
	create_shrapnel(loc, rand(1, 5), direction, shrapnel_type = /datum/ammo/bullet/shrapnel/light/glass)

/obj/structure/window/get_explosion_resistance(direction)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return EXPLOSION_MAX_POWER

	if(flags_atom & ON_BORDER && (direction == turn(dir, 90) || direction == turn(dir, -90)))
		return 0
	return obj_integrity / EXPLOSION_DAMAGE_MULTIPLIER_WINDOW

/obj/structure/window/framed/mainship
	icon = 'modular_RUtgmc/icons/obj/smooth_objects/ship_window.dmi'

/obj/structure/window/framed/mainship/gray
	icon = 'modular_RUtgmc/icons/obj/smooth_objects/ship_gray_window.dmi'

/obj/structure/window/framed/colony
	icon = 'modular_RUtgmc/icons/obj/smooth_objects/col_window.dmi'

/obj/structure/window/framed/colony/reinforced
	icon = 'modular_RUtgmc/icons/obj/smooth_objects/col_rwindow.dmi'

/obj/structure/window/framed/colony/reinforced/hull/pred
	basestate = "pred_window"
	icon_state = "pred_window-0"
	icon = 'modular_RUtgmc/icons/obj/smooth_objects/pred_window.dmi'
	base_icon_state = "pred_window"

/obj/structure/window/phoronreinforced/pred
	icon_state = "phoronrwindow"
	resistance_flags = INDESTRUCTIBLE
