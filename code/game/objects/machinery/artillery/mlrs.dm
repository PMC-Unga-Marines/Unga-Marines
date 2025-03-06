/obj/item/mortar_kit/mlrs
	name = "\improper TA-40L multiple rocket launcher system"
	desc = "A manual, crew-operated and towable multiple rocket launcher system piece used by the TerraGov Marine Corps, it is meant to saturate an area with munitions to total up to large amounts of firepower, it thus has high scatter when firing to accomplish such a task. Fires in only bursts of up to 16 rockets, it can hold 32 rockets in total. Uses 60mm Rockets."
	icon_state = "mlrs"
	icon = 'icons/obj/artillery/mlrs.dmi'
	max_integrity = 400
	item_flags = IS_DEPLOYABLE|TWOHANDED|DEPLOYED_NO_PICKUP|DEPLOY_ON_INITIALIZE
	w_class = WEIGHT_CLASS_HUGE
	deployable_item = /obj/machinery/deployable/mortar/howitzer/mlrs

/obj/machinery/deployable/mortar/howitzer/mlrs/perform_firing_visuals()
	return

/obj/machinery/deployable/mortar/howitzer/mlrs //TODO why in the seven hells is this a howitzer child??????
	pixel_x = 0
	anchored = FALSE // You can move this.
	fire_sound = 'sound/weapons/guns/fire/rocket_arty.ogg'
	reload_sound = 'sound/weapons/guns/interact/tat36_reload.ogg'
	fall_sound = 'sound/weapons/guns/misc/rocket_whistle.ogg'
	minimum_range = 20
	allowed_shells = list(
		/obj/item/mortal_shell/rocket/mlrs,
		/obj/item/mortal_shell/rocket/mlrs/gas,
		/obj/item/mortal_shell/rocket/mlrs/tangle,
	)
	cool_off_time = 60 SECONDS
	fire_delay = 0.15 SECONDS
	fire_amount = 16
	reload_time = 0.25 SECONDS
	max_rounds = 32
	offset_per_turfs = 25
	spread = 3.5
	max_spread = 6.5

//this checks for box of rockets, otherwise will go to normal attackby for mortars
/obj/machinery/deployable/mortar/howitzer/mlrs/attackby(obj/item/I, mob/user, params)
	if(firing)
		user.balloon_alert(user, "The barrel is steaming hot. Wait till it cools off")
		return

	if(!istype(I, /obj/item/storage/box/mlrs_rockets) && !istype(I, /obj/item/storage/box/mlrs_rockets_gas) && !istype(I, /obj/item/storage/box/mlrs_rockets_tangle))
		return ..()

	var/obj/item/storage/box/rocket_box = I

	//prompt user and ask how many rockets to load
	var/numrockets = tgui_input_number(user, "How many rockets do you wish to load?)", "Quantity to Load", 0, 16, 0)
	if(numrockets < 1 || !can_interact(user))
		return

	//loop that continues loading until a invalid condition is met
	var/rocketsloaded = 0
	while(rocketsloaded < numrockets)
		//verify it has rockets
		if(!istype(rocket_box.contents[1], /obj/item/mortal_shell/rocket/mlrs))
			user.balloon_alert(user, "Out of rockets")
			return
		var/obj/item/mortal_shell/mortar_shell = rocket_box.contents[1]

		if(length(chamber_items) >= max_rounds)
			user.balloon_alert(user, "You cannot fit more")
			return

		if(!(mortar_shell.type in allowed_shells))
			user.balloon_alert(user, "This shell doesn't fit")
			return

		if(busy)
			user.balloon_alert(user, "Someone else is using this")
			return

		user.visible_message(span_notice("[user] starts loading \a [mortar_shell.name] into [src]."),
		span_notice("You start loading \a [mortar_shell.name] into [src]."))
		playsound(loc, reload_sound, 50, 1)
		busy = TRUE
		if(!do_after(user, reload_time, NONE, src, BUSY_ICON_HOSTILE))
			busy = FALSE
			return

		busy = FALSE

		user.visible_message(span_notice("[user] loads \a [mortar_shell.name] into [src]."),
		span_notice("You load \a [mortar_shell.name] into [src]."))
		chamber_items += mortar_shell

		rocket_box.storage_datum.remove_from_storage(mortar_shell, null, user)
		rocketsloaded++
	user.balloon_alert(user, "Right click to fire")

/obj/machinery/deployable/mortar/howitzer/mlrs/record_shell_fired()
	GLOB.round_statistics.rocket_shells_fired++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "rocket_shells_fired")
