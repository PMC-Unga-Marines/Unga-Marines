/obj/structure/closet/secure_closet
	name = "secure locker"
	desc = "It's an immobile card-locked storage unit."
	icon_state = "secure1"
	density = TRUE
	opened = FALSE
	locked = TRUE
	broken = FALSE
	closet_flags = CLOSET_IS_SECURE
	max_integrity = 100
	icon_closed = "secure"
	icon_opened = "secureopen"
	var/icon_locked = "secure1"
	var/icon_broken = "securebroken"
	var/icon_off = "secureoff"

/obj/structure/closet/secure_closet/close()
	if(..())
		if(broken)
			icon_state = icon_off
		return TRUE
	return FALSE

/obj/structure/closet/secure_closet/emp_act(severity)
	. = ..()
	for(var/obj/O in src)
		O.emp_act(severity)
	if(!broken)
		if(prob(50 / severity))
			locked = !locked
			update_icon()
		if(prob(20 / severity) && !opened)
			if(!locked)
				open()
			else
				req_access = list()
				req_access += pick(ALL_ACCESS)

/obj/structure/closet/secure_closet/update_icon_state()
	. = ..()
	if(opened)
		icon_state = icon_opened
	else
		icon_state = locked ? icon_locked : icon_closed

/obj/structure/closet/secure_closet/update_overlays()
	. = ..()
	if(welded)
		. += overlay_welded

/obj/structure/closet/secure_closet/break_open()
	broken = TRUE
	locked = FALSE
	return ..()
