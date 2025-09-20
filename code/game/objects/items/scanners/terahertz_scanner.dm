/obj/item/t_scanner
	name = "\improper T-ray scanner"
	desc = "A terahertz-ray emitter and scanner used to detect underfloor objects such as cables and pipes."
	icon = 'icons/obj/device.dmi'
	icon_state = "t-ray0"
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/engineering_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/engineering_right.dmi',
	)
	worn_icon_state = "electronic"
	var/on = 0

/obj/item/t_scanner/attack_self(mob/user)

	on = !on
	icon_state = "t-ray[on]"

	if(on)
		START_PROCESSING(SSobj, src)

/obj/item/t_scanner/process()
	if(!on)
		STOP_PROCESSING(SSobj, src)
		return null

	for(var/turf/T AS in RANGE_TURFS(1, loc))
		if(!T.intact_tile)
			continue

		for(var/obj/O in T.contents)
			if(!HAS_TRAIT(O, TRAIT_T_RAY_VISIBLE))
				continue

			if(O.invisibility != INVISIBILITY_MAXIMUM)
				continue
			O.invisibility = 0
			O.alpha = 128
			addtimer(CALLBACK(src, PROC_REF(set_alpha_back), O), 1 SECONDS)

/obj/item/t_scanner/proc/set_alpha_back(obj/O)
	if(!O || O.gc_destroyed)
		return
	var/turf/U = O.loc
	if(U.intact_tile)
		O.invisibility = INVISIBILITY_MAXIMUM
		O.alpha = 255
