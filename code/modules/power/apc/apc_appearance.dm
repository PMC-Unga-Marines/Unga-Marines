/obj/machinery/power/apc/update_appearance(updates=check_updates())
	icon_update_needed = FALSE
	if(!updates)
		return
	. = ..()
	// And now, separately for cleanness, the lighting changing
	if(!update_state)
		switch(charging)
			if(APC_NOT_CHARGING)
				set_light_color(LIGHT_COLOR_RED)
			if(APC_CHARGING)
				set_light_color(LIGHT_COLOR_BLUE)
			if(APC_FULLY_CHARGED)
				set_light_color(LIGHT_COLOR_GREEN)
		set_light(initial(light_range))
		return
	set_light(0)

/obj/machinery/power/apc/update_icon_state()
	. = ..()

	var/broken = CHECK_BITFIELD(update_state, UPSTATE_BROKE) ? "_broken" : ""
	var/status = (CHECK_BITFIELD(update_state, UPSTATE_WIREEXP) && !CHECK_BITFIELD(update_state, UPSTATE_OPENED1)) ? "_wires" : broken
	var/apc_opened
	switch(opened)
		if(APC_COVER_CLOSED)
			apc_opened = "closed"
		if(APC_COVER_OPENED)
			apc_opened = "opened"
		if(APC_COVER_REMOVED)
			apc_opened = "removed"
	icon_state = "apc_[apc_opened][status]"

/obj/machinery/power/apc/update_overlays()
	. = ..()

	if(opened && cell)
		. += "apc_overlay_cell"

	if((machine_stat & (BROKEN|MAINT)) || update_state)
		return

	var/apc_locked = locked ? "locked" : "unlocked"
	. += emissive_appearance(icon, "apc_overlay_[apc_locked]")
	. += mutable_appearance(icon, "apc_overlay_[apc_locked]")

	var/apc_charging = ""
	switch(charging)
		if(APC_NOT_CHARGING)
			apc_charging = "off"
		if(APC_CHARGING)
			apc_charging = "on"
		if(APC_FULLY_CHARGED)
			apc_charging = "full"
	. += emissive_appearance(icon, "apc_charging_[apc_charging]")
	. += mutable_appearance(icon, "apc_charging_[apc_charging]")

	if(!operating)
		return

	var/apc_equipment = ""
	switch(equipment)
		if(APC_CHANNEL_OFF)
			apc_equipment = "off"
		if(APC_CHANNEL_AUTO_OFF)
			apc_equipment = "auto_off"
		if(APC_CHANNEL_ON)
			apc_equipment = "on"
		if(APC_CHANNEL_AUTO_ON)
			apc_equipment = "auto_on"
	. += emissive_appearance(icon, "apc_equipment_[apc_equipment]")
	. += mutable_appearance(icon, "apc_equipment_[apc_equipment]")

	var/apc_lighting = ""
	switch(lighting)
		if(APC_CHANNEL_OFF)
			apc_lighting = "off"
		if(APC_CHANNEL_AUTO_OFF)
			apc_lighting = "auto_off"
		if(APC_CHANNEL_ON)
			apc_lighting = "on"
		if(APC_CHANNEL_AUTO_ON)
			apc_lighting = "auto_on"
	. += emissive_appearance(icon, "apc_lighting_[apc_lighting]")
	. += mutable_appearance(icon, "apc_lighting_[apc_lighting]")

	var/apc_environ = ""
	switch(environ)
		if(APC_CHANNEL_OFF)
			apc_environ = "off"
		if(APC_CHANNEL_AUTO_OFF)
			apc_environ = "auto_off"
		if(APC_CHANNEL_ON)
			apc_environ = "on"
		if(APC_CHANNEL_AUTO_ON)
			apc_environ = "auto_on"
	. += emissive_appearance(icon, "apc_environ_[apc_environ]")
	. += mutable_appearance(icon, "apc_environ_[apc_environ]")

/// Checks for what icon updates we will need to handle
/obj/machinery/power/apc/proc/check_updates()
	SIGNAL_HANDLER
	. = NONE

	// Handle icon status:
	var/new_update_state = NONE
	if(machine_stat & BROKEN)
		new_update_state |= UPSTATE_BROKE
	if(machine_stat & MAINT)
		new_update_state |= UPSTATE_MAINT

	if(opened)
		new_update_state |= (opened << UPSTATE_COVER_SHIFT)

	else if(CHECK_BITFIELD(machine_stat, PANEL_OPEN))
		new_update_state |= UPSTATE_WIREEXP

	if(new_update_state != update_state)
		update_state = new_update_state
		. |= UPDATE_ICON_STATE

	// Handle overlay status:
	var/new_update_overlay = NONE
	if(operating)
		new_update_overlay |= UPOVERLAY_OPERATING

	if(!update_state)
		if(locked)
			new_update_overlay |= UPOVERLAY_LOCKED

		new_update_overlay |= (charging << UPOVERLAY_CHARGING_SHIFT)
		new_update_overlay |= (equipment << UPOVERLAY_EQUIPMENT_SHIFT)
		new_update_overlay |= (lighting << UPOVERLAY_LIGHTING_SHIFT)
		new_update_overlay |= (environ << UPOVERLAY_ENVIRON_SHIFT)

	if(new_update_overlay != update_overlay)
		update_overlay = new_update_overlay
		. |= UPDATE_OVERLAYS

/obj/machinery/power/apc/proc/queue_icon_update()
	icon_update_needed = TRUE
