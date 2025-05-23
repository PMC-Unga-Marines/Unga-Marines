/***************** MECHA ACTIONS *****************/

/obj/vehicle/sealed/mecha/generate_action_type()
	. = ..()
	if(istype(., /datum/action/vehicle/sealed/mecha))
		var/datum/action/vehicle/sealed/mecha/mecha = .
		mecha.chassis = src

/datum/action/vehicle/sealed/mecha
	action_icon = 'icons/mob/actions/actions_mecha.dmi'
	///mech owner of this action
	var/obj/vehicle/sealed/mecha/chassis

/datum/action/vehicle/sealed/mecha/Destroy()
	chassis = null
	return ..()

/datum/action/vehicle/sealed/mecha/mech_eject
	name = "Eject From Mech"
	action_icon_state = "mech_eject"

/datum/action/vehicle/sealed/mecha/mech_eject/action_activate(trigger_flags)
	if(!owner)
		return
	if(!chassis || !(owner in chassis.occupants))
		return
	chassis.resisted_against(owner)

/datum/action/vehicle/sealed/mecha/mech_toggle_lights
	name = "Toggle Lights"
	action_icon_state = "mech_lights_off"

/datum/action/vehicle/sealed/mecha/mech_toggle_lights/action_activate(trigger_flags)
	if(!owner || !chassis || !(owner in chassis.occupants))
		return

	chassis.lights_on = !chassis.lights_on
	if(chassis.lights_on)
		action_icon_state = "mech_lights_on"
	else
		action_icon_state = "mech_lights_off"
	chassis.set_light_on(chassis.lights_on)
	chassis.balloon_alert(owner, "toggled lights [chassis.lights_on ? "on" : "off"]")
	playsound(chassis,'sound/mecha/brass_skewer.ogg', 40, TRUE)
	chassis.log_message("Toggled lights [chassis.lights_on ? "on" : "off"].", LOG_MECHA)
	update_button_icon()

/datum/action/vehicle/sealed/mecha/mech_view_stats
	name = "View Stats"
	action_icon_state = "mech_view_stats"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_MECHABILITY_VIEW_STATS,
	)

/datum/action/vehicle/sealed/mecha/mech_view_stats/action_activate(trigger_flags)
	if(!owner || !chassis || !(owner in chassis.occupants))
		return

	chassis.ui_interact(owner)

/datum/action/vehicle/sealed/mecha/strafe
	name = "Toggle Strafing. Disabled when Alt is held."
	action_icon_state = "strafe"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_MECHABILITY_TOGGLE_STRAFE,
	)
/datum/action/vehicle/sealed/mecha/strafe/action_activate(trigger_flags)
	if(!owner || !chassis || !(owner in chassis.occupants))
		return

	chassis.toggle_strafe()

/obj/vehicle/sealed/mecha/AltClick(mob/living/user)
	if(!(user in occupants))
		return
	if(!(user in return_controllers_with_flag(VEHICLE_CONTROL_DRIVE)))
		to_chat(user, span_warning("You're in the wrong seat to control movement."))
		return

	toggle_strafe()

/obj/vehicle/sealed/mecha/proc/toggle_strafe()
	strafe = !strafe
	for(var/occupant in occupants)
		balloon_alert(occupant, "Strafing mode [strafe?"on":"off"].")
		var/datum/action/action = LAZYACCESSASSOC(occupant_actions, occupant, /datum/action/vehicle/sealed/mecha/strafe)
		action?.update_button_icon()

///swap seats, for two person mecha
/datum/action/vehicle/sealed/mecha/swap_seat
	name = "Switch Seats"
	action_icon_state = "mech_seat_swap"

/datum/action/vehicle/sealed/mecha/swap_seat/action_activate(trigger_flags)
	if(!owner || !chassis || !(owner in chassis.occupants))
		return

	if(length(chassis.occupants) == chassis.max_occupants)
		chassis.balloon_alert(owner, "other seat occupied!")
		return
	var/list/drivers = chassis.return_drivers()
	chassis.balloon_alert(owner, "moving to other seat...")
	chassis.is_currently_ejecting = TRUE
	if(!do_after(owner, chassis.exit_delay, target = chassis))
		chassis.balloon_alert(owner, "interrupted!")
		chassis.is_currently_ejecting = FALSE
		return
	chassis.is_currently_ejecting = FALSE
	if(owner in drivers)
		chassis.balloon_alert(owner, "controlling gunner seat")
		chassis.remove_control_flags(owner, VEHICLE_CONTROL_DRIVE|VEHICLE_CONTROL_SETTINGS)
		chassis.add_control_flags(owner, VEHICLE_CONTROL_MELEE|VEHICLE_CONTROL_EQUIPMENT)
	else
		chassis.balloon_alert(owner, "controlling pilot seat")
		chassis.remove_control_flags(owner, VEHICLE_CONTROL_MELEE|VEHICLE_CONTROL_EQUIPMENT)
		chassis.add_control_flags(owner, VEHICLE_CONTROL_DRIVE|VEHICLE_CONTROL_SETTINGS)
	chassis.update_appearance()

/datum/action/vehicle/sealed/mecha/mech_overload_mode
	name = "Toggle leg actuators overload"
	action_icon_state = "mech_overload_off"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_MECHABILITY_TOGGLE_ACTUATORS,
	)

/datum/action/vehicle/sealed/mecha/mech_overload_mode/action_activate(trigger_flags, forced_state = null)
	if(!owner || !chassis || !(owner in chassis.occupants))
		return
	if(!isnull(forced_state))
		chassis.leg_overload_mode = forced_state
	else
		chassis.leg_overload_mode = !chassis.leg_overload_mode
	action_icon_state = "mech_overload_[chassis.leg_overload_mode ? "on" : "off"]"
	chassis.log_message("Toggled leg actuators overload.", LOG_MECHA)
	//tgmc add
	var/obj/item/mecha_parts/mecha_equipment/ability/dash/ability = locate() in chassis.equip_by_category[MECHA_UTILITY]
	if(ability)
		chassis.cut_overlay(ability.overlay)
		var/state = chassis.leg_overload_mode ? (initial(ability.icon_state) + "_active") : initial(ability.icon_state)
		ability.overlay = image('icons/mecha/mecha_ability_overlays.dmi', icon_state = state, layer=chassis.layer+0.001)
		chassis.add_overlay(ability.overlay)
		if(chassis.leg_overload_mode)
			ability.sound_loop.start(chassis)
		else
			ability.sound_loop.stop(chassis)
	//tgmc end
	if(chassis.leg_overload_mode)
		chassis.speed_mod = min(chassis.move_delay-1, round(chassis.move_delay * 0.5))
		chassis.move_delay -= chassis.speed_mod
		chassis.step_energy_drain = max(chassis.overload_step_energy_drain_min,chassis.step_energy_drain*chassis.leg_overload_coeff)
		chassis.balloon_alert(owner,"leg actuators overloaded")
	else
		chassis.move_delay += chassis.speed_mod
		chassis.step_energy_drain = chassis.normal_step_energy_drain
		chassis.balloon_alert(owner, "you disable the overload")
	update_button_icon()

/datum/action/vehicle/sealed/mecha/mech_smoke
	name = "Smoke"
	action_icon_state = "mech_smoke"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_MECHABILITY_SMOKE,
	)
/datum/action/vehicle/sealed/mecha/mech_smoke/action_activate(trigger_flags)
	if(!owner || !chassis || !(owner in chassis.occupants))
		return
	if(!TIMER_COOLDOWN_CHECK(src, COOLDOWN_MECHA_SMOKE) && chassis.smoke_charges>0)
		chassis.smoke_system.start()
		chassis.smoke_charges--
		TIMER_COOLDOWN_START(src, COOLDOWN_MECHA_SMOKE, chassis.smoke_cooldown)

/datum/action/vehicle/sealed/mecha/mech_zoom
	name = "Zoom"
	action_icon_state = "mech_zoom_off"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_MECHABILITY_TOGGLE_ZOOM,
	)
/datum/action/vehicle/sealed/mecha/mech_zoom/action_activate(trigger_flags)
	if(!owner?.client || !chassis || !(owner in chassis.occupants))
		return
	chassis.zoom_mode = !chassis.zoom_mode
	action_icon_state = "mech_zoom_[chassis.zoom_mode ? "on" : "off"]"
	chassis.log_message("Toggled zoom mode.", LOG_MECHA)
	to_chat(owner, "[icon2html(chassis, owner)]<font color='[chassis.zoom_mode?"blue":"red"]'>Zoom mode [chassis.zoom_mode?"en":"dis"]abled.</font>")
	if(chassis.zoom_mode)
		owner.client.view_size.set_view_radius_to(4.5)
		SEND_SOUND(owner, sound('sound/mecha/imag_enh.ogg', volume=50))
	else
		owner.client.view_size.reset_to_default()
	update_button_icon()
/datum/action/vehicle/sealed/mecha/reload
	name = "Reload equipped weapons"
	action_icon_state = "reload"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_MECHABILITY_RELOAD,
	)

/datum/action/vehicle/sealed/mecha/reload/action_activate(trigger_flags)
	if(!owner || !chassis || !(owner in chassis.occupants))
		return

	for(var/i in chassis.equip_by_category)
		if(!istype(chassis.equip_by_category[i], /obj/item/mecha_parts/mecha_equipment))
			continue
		INVOKE_ASYNC(chassis.equip_by_category[i], TYPE_PROC_REF(/obj/item/mecha_parts/mecha_equipment, attempt_rearm), owner)
