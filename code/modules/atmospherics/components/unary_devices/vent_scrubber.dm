#define SIPHONING 0
#define SCRUBBING 1

/obj/machinery/atmospherics/components/unary/vent_scrubber
	name = "air scrubber"
	desc = "Has a valve and pump attached to it."
	icon_state = "scrub_map-2"
	base_icon_state = "scrub"
	use_power = IDLE_POWER_USE
	idle_power_usage = 10
	active_power_usage = 60
	can_unwrench = FALSE
	welded = FALSE
	level = 1
	layer = GAS_SCRUBBER_LAYER
	atom_flags = SHUTTLE_IMMUNE
	vent_movement = VENTCRAWL_ALLOWED | VENTCRAWL_CAN_SEE | VENTCRAWL_ENTRANCE_ALLOWED
	var/scrubbing = SCRUBBING //0 = siphoning, 1 = scrubbing
	var/filter_types = list()///datum/gas/carbon_dioxide)
	var/volume_rate = 200
	var/widenet = 0 //is this scrubber acting on the 3x3 area around it.
	var/list/turf/adjacent_turfs = list()

	pipe_state = "scrubber"

/obj/machinery/atmospherics/components/unary/vent_scrubber/auto_use_power()
	if(!on || welded || !is_operational() || !powered(power_channel))
		return FALSE

	var/amount = idle_power_usage

	if(scrubbing & SCRUBBING)
		amount += idle_power_usage * length(filter_types)
	else //scrubbing == SIPHONING
		amount = active_power_usage

	if(widenet)
		amount += amount * (length(adjacent_turfs) * (length(adjacent_turfs) * 0.5))
	use_power(amount, power_channel)
	return TRUE

/obj/machinery/atmospherics/components/unary/vent_scrubber/update_icon_nopipes()
	cut_overlays()
	if(showpipe)
		var/image/cap = get_pipe_image(icon, "scrub_cap", initialize_directions, piping_layer = piping_layer)
		add_overlay(cap)

	if(welded)
		icon_state = "[base_icon_state]_welded"
		return

	if(!nodes[1] || !on || !is_operational())
		icon_state = "[base_icon_state]_off"
		return

	if(scrubbing & SCRUBBING)
		if(widenet)
			icon_state = "scrub_wide"
		else
			icon_state = "[base_icon_state]_on"
	else //scrubbing == SIPHONING
		icon_state = "scrub_purge"

/obj/machinery/atmospherics/components/unary/vent_scrubber/power_change()
	..()
	update_icon_nopipes()

/obj/machinery/atmospherics/components/unary/vent_scrubber/plasmacutter_act(mob/living/user, obj/item/tool/pickaxe/plasmacutter/I)
	if(!welded)
		to_chat(user, span_warning("\The [I] can only cut open welds!"))
		return FALSE
	if(!(I.start_cut(user, src.name, src, PLASMACUTTER_BASE_COST * PLASMACUTTER_VLOW_MOD)))
		return FALSE
	if(!do_after(user, I.calc_delay(user) * PLASMACUTTER_VLOW_MOD, NONE, src, BUSY_ICON_BUILD))
		return FALSE
	I.cut_apart(user, src.name, src, PLASMACUTTER_BASE_COST * PLASMACUTTER_VLOW_MOD) //Vents require much less charge
	welded = FALSE
	update_icon()
	return TRUE

/obj/machinery/atmospherics/components/unary/vent_scrubber/welder_act(mob/living/user, obj/item/W)
	if(iswelder(W))
		var/obj/item/tool/weldingtool/WT = W
		if(WT.isOn())
			user.visible_message(span_notice("[user] starts welding [src] with [WT]."), \
			span_notice("You start welding [src] with [WT]."))
			if(WT.use_tool(src, user, 5 SECONDS, 1, 25, null, BUSY_ICON_BUILD))
				if(!welded)
					user.visible_message(span_notice("[user] welds [src] shut."), \
					span_notice("You weld [src] shut."))
					welded = TRUE
				else
					user.visible_message(span_notice("[user] welds [src] open."), \
					span_notice("You weld [src] open."))
					welded = FALSE
				update_icon()
				pipe_vision_img = image(src, loc, dir = dir)
				SET_PLANE_EXPLICIT(pipe_vision_img, ABOVE_HUD_PLANE, src)
				return TRUE
		else
			to_chat(user, span_warning("[WT] needs to be on to start this task."))
	return FALSE

/obj/machinery/atmospherics/components/unary/vent_scrubber/can_unwrench(mob/user)
	. = ..()
	if(. && on && is_operational())
		to_chat(user, span_warning("You cannot unwrench [src], turn it off first!"))
		return FALSE

/obj/machinery/atmospherics/components/unary/vent_scrubber/attack_facehugger(mob/living/carbon/xenomorph/facehugger/F, damage_amount = F.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(F.status_flags & INCORPOREAL)
		return
	if(!welded || !(do_after(F, 3 SECONDS, IGNORE_HELD_ITEM, src, BUSY_ICON_HOSTILE)))
		return
	F.visible_message("[F] furiously claws at [src]!", "We manage to clear away the stuff blocking the scrubber.", "You hear loud scraping noises.")
	welded = FALSE
	update_icon()
	pipe_vision_img = image(src, loc, dir = dir)
	SET_PLANE_EXPLICIT(pipe_vision_img, ABOVE_HUD_PLANE, src)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 100, 1)

/obj/machinery/atmospherics/components/unary/vent_scrubber/examine(mob/user)
	. = ..()
	if(welded)
		. += span_notice("It seems welded shut.")

/obj/machinery/atmospherics/components/unary/vent_scrubber/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(xeno_attacker.status_flags & INCORPOREAL)
		return
	if(!welded || !(do_after(xeno_attacker, 2 SECONDS, IGNORE_HELD_ITEM, src, BUSY_ICON_HOSTILE)))
		return
	xeno_attacker.visible_message("[xeno_attacker] furiously claws at [src]!", "We manage to clear away the stuff blocking the scrubber.", "You hear loud scraping noises.")
	welded = FALSE
	update_icon()
	pipe_vision_img = image(src, loc, dir = dir)
	SET_PLANE_EXPLICIT(pipe_vision_img, ABOVE_HUD_PLANE, src)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 100, 1)

/obj/machinery/atmospherics/components/unary/vent_scrubber/AltClick(mob/user)
	if(!isliving(user))
		return
	if(isxeno(user))
		var/mob/living/carbon/xenomorph/xeno_user = user
		xeno_user.handle_ventcrawl(src, xeno_user.xeno_caste.vent_enter_speed, xeno_user.xeno_caste.silent_vent_crawl)
		return
	var/mob/living/living_user = user
	living_user.handle_ventcrawl(src)

/obj/machinery/atmospherics/components/unary/vent_scrubber/on
	on = TRUE
	icon_state = "scrub_map_on-2"

/obj/machinery/atmospherics/components/unary/vent_scrubber/on/Initialize(mapload)
	. = ..()
	GLOB.atmospumps += src

/obj/machinery/atmospherics/components/unary/vent_scrubber/on/Destroy()
	. = ..()
	GLOB.atmospumps -= src

/obj/machinery/atmospherics/components/unary/vent_scrubber/on/alt
	icon = 'icons/obj/atmospherics/components/unary_devices.dmi'
	icon_state = "alt_scrub_map_on-2"
	base_icon_state = "alt_scrub"
	piping_layer = 3

#undef SIPHONING
#undef SCRUBBING
