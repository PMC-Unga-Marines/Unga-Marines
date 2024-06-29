/obj/machinery/deployable/mounted/sentry/attack_ghost(mob/dead/observer/user)
	. = ..()
	ui_interact(user)
	update_static_data(user)
