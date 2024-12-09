/obj/item/ammo_magazine
	name = "generic ammo"
	desc = "A box of ammo."
	icon = 'icons/obj/items/ammo/magazine.dmi'
	item_state = "ammo_mag" //PLACEHOLDER. This ensures the mag doesn't use the icon state instead.
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/ammo_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/ammo_right.dmi',
	)
	flags_atom = CONDUCT
	flags_equip_slot = ITEM_SLOT_BELT
	throwforce = 2
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 2
	throw_range = 6
	///Icon state to an overlay to add to the gun, for extended mags, box mags, and so on
	var/bonus_overlay = null
	///This is a typepath for the type of bullet the magazine holds, it is cast so that it can draw the variable handful_amount from default_ammo in create_handful()
	var/datum/ammo/bullet/default_ammo = /datum/ammo/bullet
	///Generally used for energy weapons
	var/datum/ammo/bullet/overcharge_ammo = /datum/ammo/bullet
	///This is used for matching handfuls to each other or whatever the mag is. The #Defines can be found in __DEFINES/calibers.dm
	var/caliber = null
	///Set this to something else for it not to start with different initial counts.
	var/current_rounds = -1
	///How many rounds it can hold.
	var/max_rounds = 7
	///Set a timer for reloading mags. Higher is slower.
	var/reload_delay = 0 SECONDS
	///Delay for filling this magazine with another one.
	var/fill_delay = 0 SECONDS
	///Just an easier way to track how many shells to eject later.
	var/used_casings = 0
	///flags specifically for magazines.
	var/flags_magazine = MAGAZINE_REFILLABLE
	///the default mag icon state.
	var/base_mag_icon

	//Stats to modify on the gun, just like the attachments do, only has used ones add more as you need.
	var/scatter_mod = 0
	///Increases or decreases scatter chance but for onehanded firing.
	var/scatter_unwielded_mod = 0
	///Changes the slowdown amount when wielding a weapon by this value.
	var/aim_speed_mod = 0
	///How long ADS takes (time before firing)
	var/wield_delay_mod = 0

	/// If this and ammo_band_icon aren't null, run update_ammo_band(). Is the color of the band, such as green on AP.
	var/ammo_band_color = null
	/// If this and ammo_band_color aren't null, run update_ammo_band() Is the greyscale icon used for the ammo band.
	var/ammo_band_icon = null

/obj/item/ammo_magazine/Initialize(mapload, spawn_empty)
	. = ..()
	base_mag_icon = icon_state
	current_rounds = spawn_empty ? 0 : max_rounds
	update_icon()
	update_ammo_band()

/obj/item/ammo_magazine/update_icon_state()
	. = ..()
	if(CHECK_BITFIELD(flags_magazine, MAGAZINE_HANDFUL))
		setDir(current_rounds + round(current_rounds/3))
		return
	if(current_rounds <= 0)
		icon_state = base_mag_icon + "_e"
		return
	icon_state = base_mag_icon

/obj/item/ammo_magazine/proc/update_ammo_band()
	overlays.Cut()
	if(ammo_band_color)
		var/image/ammo_band_image = image(icon, src, ammo_band_icon)
		ammo_band_image.color = ammo_band_color
		ammo_band_image.appearance_flags = RESET_COLOR|KEEP_APART
		overlays += ammo_band_image

/obj/item/ammo_magazine/examine(mob/user)
	. = ..()
	. += "[src] has <b>[current_rounds]</b> rounds out of <b>[max_rounds]</b>."

/obj/item/ammo_magazine/attack_hand(mob/living/user)
	if(user.get_inactive_held_item() != src || !CHECK_BITFIELD(flags_magazine, MAGAZINE_REFILLABLE))
		return ..()
	if(current_rounds <= 0)
		to_chat(user, span_notice("[src] is empty. There is nothing to grab."))
		return
	create_handful(user)

/obj/item/ammo_magazine/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(!istype(I, /obj/item/ammo_magazine))
		if(!CHECK_BITFIELD(flags_magazine, MAGAZINE_WORN) || !istype(I, /obj/item/weapon/gun) || loc != user)
			return ..()
		var/obj/item/weapon/gun/gun = I
		if(!CHECK_BITFIELD(gun.reciever_flags, AMMO_RECIEVER_MAGAZINES))
			return ..()
		gun.reload(src, user)
		return

	if(!CHECK_BITFIELD(flags_magazine, MAGAZINE_REFILLABLE)) //and a refillable magazine
		return

	if(src != user.get_inactive_held_item() && !CHECK_BITFIELD(flags_magazine, MAGAZINE_HANDFUL)) //It has to be held.
		to_chat(user, span_notice("Try holding [src] before you attempt to restock it."))
		return

	var/obj/item/ammo_magazine/mag = I
	var/amount_to_transfer = mag.current_rounds

	if(default_ammo != mag.default_ammo)
		if(current_rounds == 0)
			transfer_ammo(mag, user, amount_to_transfer, TRUE)
			return
		to_chat(user, span_notice("Those aren't the same rounds. Better not mix them up."))
		return

	transfer_ammo(mag, user, amount_to_transfer)

/obj/item/ammo_magazine/attackby_alternate(obj/item/I, mob/user, params)
	. = ..()
	if(!isgun(I))
		return
	var/obj/item/weapon/gun/gun = I
	if(!gun.active_attachable)
		return
	attackby(gun.active_attachable, user, params)

/obj/item/ammo_magazine/proc/on_inserted(obj/item/weapon/gun/master_gun)
	master_gun.scatter						+= scatter_mod
	master_gun.scatter_unwielded			+= scatter_unwielded_mod
	master_gun.aim_slowdown					+= aim_speed_mod
	master_gun.wield_delay					+= wield_delay_mod

/obj/item/ammo_magazine/proc/on_removed(obj/item/weapon/gun/master_gun)
	master_gun.scatter						-= scatter_mod
	master_gun.scatter_unwielded			-= scatter_unwielded_mod
	master_gun.aim_slowdown					-= aim_speed_mod
	master_gun.wield_delay					-= wield_delay_mod

///Сan the magazine be refilled, mainly used in transfer_ammo proc
/obj/item/ammo_magazine/proc/can_transfer_ammo(obj/item/ammo_magazine/source, mob/user, transfer_amount = 1, silent = FALSE)
	if(current_rounds >= max_rounds) //Does the mag actually need reloading?
		if(!silent)
			to_chat(user, span_notice("[src] is already full."))
		return FALSE

	if(source.caliber != caliber) //Are they the same caliber?
		if(!silent)
			to_chat(user, span_notice("The rounds don't match up. Better not mix them up."))
		return FALSE

	if(!source.current_rounds)
		if(!silent)
			to_chat(user, span_warning("\The [source] is empty."))
		return FALSE

	//using handfuls; and filling internal mags has no delay.
	if(fill_delay)
		if(!silent)
			to_chat(user, span_notice("You start refilling [src] with [source]."))
		if(!do_after(user, fill_delay, NONE, src, BUSY_ICON_GENERIC))
			return FALSE
	return TRUE

///Generic proc to transfer ammo between ammo mags. Can work for anything, mags, handfuls, etc.
/obj/item/ammo_magazine/proc/transfer_ammo(obj/item/ammo_magazine/source, mob/user, transfer_amount = 1, is_new_ammo_type = FALSE)
	if(!can_transfer_ammo(source, user, transfer_amount))
		return

	to_chat(user, span_notice("You refill [src] with [source]."))

	var/amount_difference = clamp(min(transfer_amount, max_rounds - current_rounds), 0, source.current_rounds)
	source.current_rounds -= amount_difference
	current_rounds += amount_difference

	if(is_new_ammo_type)
		default_ammo = source.default_ammo
		ammo_band_color = source.ammo_band_color
		update_ammo_band()

	if(source.current_rounds <= 0 && CHECK_BITFIELD(source.flags_magazine, MAGAZINE_HANDFUL)) //We want to delete it if it's a handful.
		user?.temporarilyRemoveItemFromInventory(source)
		QDEL_NULL(source) //Dangerous. Can mean future procs break if they reference the source. Have to account for this.
	else
		source.update_icon()

	update_icon()

///Called on a /ammo_magazine that wishes to be a handful. It generates all the data required for the handful.
/obj/item/ammo_magazine/proc/generate_handful(new_ammo, new_caliber, new_rounds, maximum_rounds)
	var/datum/ammo/ammo = ispath(new_ammo) ? GLOB.ammo_list[new_ammo] : new_ammo
	var/ammo_name = ammo.name

	///sets greyscale for the handful if it has been specified by the ammo datum
	if (ammo.handful_greyscale_config && ammo.handful_greyscale_colors)
		set_greyscale_config(ammo.handful_greyscale_config)
		set_greyscale_colors(ammo.handful_greyscale_colors)

	name = "handful of [ammo_name + " ([new_caliber])"]"
	icon_state = ammo.handful_icon_state

	default_ammo = new_ammo
	caliber = new_caliber
	if(maximum_rounds)
		max_rounds = maximum_rounds
	else
		max_rounds = ammo.handful_amount
	current_rounds = new_rounds
	update_icon()

///This will attempt to place the ammo in the user's hand if possible.
/obj/item/ammo_magazine/proc/create_handful(mob/user, transfer_amount)
	if(current_rounds <= 0)
		return
	var/obj/item/ammo_magazine/handful/new_handful = new /obj/item/ammo_magazine/handful()
	var/rounds = transfer_amount ? min(current_rounds, transfer_amount) : min(current_rounds, initial(default_ammo.handful_amount))
	new_handful.generate_handful(default_ammo, caliber, rounds)
	current_rounds -= rounds

	if(user)
		user.put_in_hands(new_handful)
		to_chat(user, span_notice("You grab <b>[rounds]</b> round\s from [src]."))
		update_icon() //Update the other one.
		if(current_rounds <= 0 && CHECK_BITFIELD(flags_magazine, MAGAZINE_HANDFUL))
			user.temporarilyRemoveItemFromInventory(src)
			qdel(src)
		return rounds //Give the number created.
	else
		update_icon()
		if(current_rounds <= 0 && CHECK_BITFIELD(flags_magazine, MAGAZINE_HANDFUL))
			qdel(src)
		return new_handful

//our magazine inherits ammo info from a source magazine
/obj/item/ammo_magazine/proc/match_ammo(obj/item/ammo_magazine/source)
	caliber = source.caliber
	default_ammo = source.default_ammo

/obj/item/ammo_magazine/fire_act(burn_level, flame_color)
	if(QDELETED(src))
		return
	if(!current_rounds)
		return
	var/turf/explosion_loc = loc // we keep it so we dn't runtime on src deletion
	var/power = 5
	for(var/obj/item/ammo_magazine/ammo in explosion_loc) // we unite all small explosions into 1 big, so we don't fucking crash the game
		if(!ammo.current_rounds)
			continue
		power++
		qdel(ammo)
	cell_explosion(explosion_loc, power, power)

//Helper proc, to allow us to see a percentage of how full the magazine is.
/obj/item/ammo_magazine/proc/get_ammo_percent()		// return % charge of cell
	return 100.0 * current_rounds / max_rounds
