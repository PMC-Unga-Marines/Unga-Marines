/obj/item/ex_act(severity, explosion_direction)
	explosion_throw(severity, explosion_direction)

	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return

	if(!prob(severity / 3))
		return

	var/msg = pick("is destroyed by the blast!", "is obliterated by the blast!", "shatters as the explosion engulfs it!", "disintegrates in the blast!", "perishes in the blast!", "is mangled into uselessness by the blast!")
	visible_message(span_danger("<u>\The [src] [msg]</u>"))
	deconstruct(FALSE)
