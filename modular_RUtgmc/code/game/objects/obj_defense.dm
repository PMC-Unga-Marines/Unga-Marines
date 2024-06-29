/obj/ex_act(severity, direction)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return
	. = ..() //contents explosion
	if(QDELETED(src))
		return
	take_damage(severity, BRUTE, BOMB, FALSE, direction)

/obj/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", effects = TRUE, attack_dir, armour_penetration = 0)
	if(QDELETED(src))
		CRASH("[src] taking damage after deletion")
	if(!damage_amount)
		return
	if(effects)
		play_attack_sound(damage_amount, damage_type, damage_flag)
	if((resistance_flags & INDESTRUCTIBLE) || obj_integrity <= 0)
		return

	if(damage_flag)
		damage_amount = round(modify_by_armor(damage_amount, damage_flag, armour_penetration), DAMAGE_PRECISION)
	if(damage_amount < DAMAGE_PRECISION)
		return
	. = damage_amount
	obj_integrity = max(obj_integrity - damage_amount, 0)
	update_icon()

	//BREAKING FIRST
	if(integrity_failure && obj_integrity <= integrity_failure)
		obj_break(damage_flag)

	//DESTROYING SECOND
	if(obj_integrity <= 0)
		if(damage_flag == BOMB)
			on_explosion_destruction(damage_amount, attack_dir)
		obj_destruction(damage_amount, damage_type, damage_flag)

/obj/proc/on_explosion_destruction(severity, direction)
	return
