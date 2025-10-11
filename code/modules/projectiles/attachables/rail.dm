/obj/item/attachable/reddot
	name = "red-dot sight"
	desc = "A red-dot sight for short to medium range. Does not have a zoom feature, but does increase weapon accuracy and fire rate while aiming by a good amount. \nNo drawbacks."
	icon_state = "reddot"
	slot = ATTACHMENT_SLOT_RAIL
	accuracy_mod = 0.15
	accuracy_unwielded_mod = 0.1
	aim_mode_delay_mod = -0.5
	variants_by_parent_type = list(/obj/item/weapon/gun/rifle/som = "", /obj/item/weapon/gun/shotgun/som = "")

/obj/item/attachable/b7_scope
	name = "B7 smart scope"
	desc = "A B7 smart scope. Does not have a zoom feature, but allows you to take aim and fire through allies. \nNo drawbacks."
	icon_state = "b7"
	slot = ATTACHMENT_SLOT_RAIL
	add_aim_mode = TRUE

/obj/item/attachable/m16sight
	name = "M16 iron sights"
	desc = "The iconic carry-handle iron sights for the m16. Usually removed once the user finds something worthwhile to attach to the rail."
	icon_state = "m16sight"
	slot = ATTACHMENT_SLOT_RAIL
	accuracy_mod = 0.1
	accuracy_unwielded_mod = 0.05
	movement_acc_penalty_mod = -0.1

/obj/item/attachable/flashlight
	name = "rail flashlight"
	desc = "A simple flashlight used for mounting on a firearm. \nHas no drawbacks, but isn't particuraly useful outside of providing a light source."
	icon_state = "flashlight"
	light_mod = 6
	light_system = MOVABLE_LIGHT
	slot = ATTACHMENT_SLOT_RAIL
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle
	activation_sound = 'sound/items/flashlight.ogg'

/obj/item/attachable/flashlight/activate(mob/living/user, turn_off)
	turn_light(user, turn_off ? !turn_off : !light_on)

/obj/item/attachable/flashlight/turn_light(mob/user, toggle_on, cooldown, sparks, forced, light_again)
	. = ..()

	if(. != CHECKS_PASSED)
		return

	if(ismob(master_gun.loc) && !user)
		user = master_gun.loc

	if(!toggle_on && light_on)
		icon_state = initial(icon_state)
		light_on = FALSE
		master_gun.set_light_range(master_gun.light_range - light_mod)
		master_gun.set_light_power(master_gun.light_power - (light_mod * 0.5))
		if(master_gun.light_range <= 0) //does the gun have another light source
			master_gun.set_light_on(FALSE)
			REMOVE_TRAIT(master_gun, TRAIT_GUN_FLASHLIGHT_ON, GUN_TRAIT)
	else if(toggle_on & !light_on)
		icon_state = initial(icon_state) +"_on"
		light_on = TRUE
		master_gun.set_light_range(master_gun.light_range + light_mod)
		master_gun.set_light_power(master_gun.light_power + (light_mod * 0.5))
		if(!HAS_TRAIT(master_gun, TRAIT_GUN_FLASHLIGHT_ON))
			master_gun.set_light_on(TRUE)
			ADD_TRAIT(master_gun, TRAIT_GUN_FLASHLIGHT_ON, GUN_TRAIT)
	else
		return

	update_icon()

/obj/item/attachable/flashlight/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	to_chat(user, span_notice("You modify the rail flashlight back into a normal flashlight."))
	if(loc == user)
		user.temporarilyRemoveItemFromInventory(src)
	var/obj/item/flashlight/F = new(user)
	user.put_in_hands(F) //This proc tries right, left, then drops it all-in-one.
	qdel(src) //Delete da old flashlight

/obj/item/attachable/flashlight/under
	name = "underbarreled flashlight"
	desc = "A simple flashlight used for mounting on a firearm. \nHas no drawbacks, but isn't particuraly useful outside of providing a light source."
	icon_state = "uflashlight"
	slot = ATTACHMENT_SLOT_UNDER
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_ACTIVATION

/obj/item/attachable/quickfire
	name = "quickfire adapter"
	desc = "An enhanced and upgraded autoloading mechanism to fire rounds more quickly. \nHowever, it also reduces accuracy and the number of bullets fired on burst."
	slot = ATTACHMENT_SLOT_RAIL
	icon_state = "autoloader"
	accuracy_mod = -0.10
	delay_mod = -0.125 SECONDS
	burst_mod = -1
	accuracy_unwielded_mod = -0.15

/obj/item/attachable/magnetic_harness
	name = "magnetic harness"
	desc = "A magnetically attached harness kit that attaches to the rail mount of a weapon. When dropped, the weapon will sling to a TGMC armor."
	icon_state = "magnetic"
	slot = ATTACHMENT_SLOT_RAIL
	size_mod = 1
	pixel_shift_x = 13
	///Handles the harness functionality, created when attached to a gun and removed on detach
	var/datum/component/reequip/reequip_component

/obj/item/attachable/magnetic_harness/on_attach(attaching_item, mob/user)
	. = ..()
	if(!master_gun)
		return
	reequip_component = master_gun.AddComponent(/datum/component/reequip, list(SLOT_S_STORE, SLOT_BELT, SLOT_BACK))

/obj/item/attachable/magnetic_harness/on_detach(attaching_item, mob/user)
	. = ..()
	if(master_gun)
		return
	QDEL_NULL(reequip_component)

/obj/item/attachable/buildasentry
	name = "\improper Build-A-Sentry attachment system"
	icon = 'icons/obj/sentry.dmi'
	icon_state = "build_a_sentry_attachment"
	desc = "The Build-A-Sentry is the latest design in cheap, automated, defense. Simply attach it to the rail of a gun and deploy. Its that easy!"
	slot = ATTACHMENT_SLOT_RAIL
	size_mod = 1
	pixel_shift_x = 10
	pixel_shift_y = 18
	///Deploy time for the build-a-sentry
	var/deploy_time = 2 SECONDS
	///Undeploy tim for the build-a-sentry
	var/undeploy_time = 2 SECONDS

/obj/item/attachable/buildasentry/can_attach(obj/item/attaching_to, mob/attacher)
	if(!isgun(attaching_to))
		return FALSE
	var/obj/item/weapon/gun/attaching_gun = attaching_to
	if(ispath(attaching_gun.deployable_item, /obj/machinery/deployable/mounted/sentry))
		to_chat(attacher, span_warning("[attaching_gun] is already a sentry!"))
		return FALSE
	return ..()

/obj/item/attachable/buildasentry/on_attach(attaching_item, mob/user)
	. = ..()
	ENABLE_BITFIELD(master_gun.deploy_flags, IS_DEPLOYABLE)
	ENABLE_BITFIELD(master_gun.item_flags, IS_SENTRY)
	master_gun.deployable_item = /obj/machinery/deployable/mounted/sentry/buildasentry
	master_gun.turret_flags |= TURRET_HAS_CAMERA|TURRET_SAFETY|TURRET_ALERTS
	master_gun.AddComponent(/datum/component/deployable_item, master_gun.deployable_item, deploy_time, undeploy_time)
	update_icon()

/obj/item/attachable/buildasentry/on_detach(detaching_item, mob/user)
	. = ..()
	var/obj/item/weapon/gun/detaching_gun = detaching_item
	DISABLE_BITFIELD(detaching_gun.deploy_flags, IS_DEPLOYABLE)
	DISABLE_BITFIELD(detaching_gun.item_flags, IS_SENTRY)
	qdel(detaching_gun.GetComponent(/datum/component/deployable_item))
	detaching_gun.deployable_item = null
	detaching_gun.turret_flags &= ~(TURRET_HAS_CAMERA|TURRET_SAFETY|TURRET_ALERTS)

/obj/item/attachable/shoulder_mount
	name = "experimental shoulder attachment point"
	desc = "A brand new advance in combat technology. This device, once attached to a firearm, will allow the firearm to be mounted onto any piece of modular armor. Once attached to the armor and activated, the gun will fire when the user chooses.\nOnce attached to the armor, <b>right clicking</b> the armor with an empty hand will select what click will fire the armor (middle, right, left). <b>Right clicking</b> with ammunition will reload the gun. Using the <b>Unique Action</b> keybind will perform the weapon's unique action only when the gun is active."
	icon = 'icons/mob/modular/shoulder_gun.dmi'
	icon_state = "shoulder_gun"
	slot = ATTACHMENT_SLOT_RAIL
	pixel_shift_x = 13
	///What click the gun will fire on.
	var/fire_mode = "right"
	///Blacklist of item types not allowed to be in the users hand to fire the gun.
	var/list/in_hand_items_blacklist = list(
		/obj/item/weapon/gun,
		/obj/item/weapon/shield,
	)

/obj/item/attachable/shoulder_mount/on_attach(attaching_item, mob/user)
	. = ..()
	var/obj/item/weapon/gun/attaching_gun = attaching_item
	ENABLE_BITFIELD(attach_features_flags, ATTACH_BYPASS_ALLOWED_LIST|ATTACH_APPLY_ON_MOB)
	attaching_gun.AddElement(/datum/element/attachment, ATTACHMENT_SLOT_MODULE, icon, null, null, null, null, 0, 0, attach_features_flags, attach_delay, detach_delay, attach_skill, attach_skill_upper_threshold, attach_sound, attachment_layer = COLLAR_LAYER)
	RegisterSignal(attaching_gun, COMSIG_ATTACHMENT_ATTACHED, PROC_REF(handle_armor_attach))
	RegisterSignal(attaching_gun, COMSIG_ATTACHMENT_DETACHED, PROC_REF(handle_armor_detach))

/obj/item/attachable/shoulder_mount/on_detach(detaching_item, mob/user)
	var/obj/item/weapon/gun/detaching_gun = detaching_item
	detaching_gun.RemoveElement(/datum/element/attachment, ATTACHMENT_SLOT_MODULE, icon, null, null, null, null, 0, 0, attach_features_flags, attach_delay, detach_delay, attach_skill, attach_skill_upper_threshold, attach_sound, attachment_layer = COLLAR_LAYER)
	DISABLE_BITFIELD(attach_features_flags, ATTACH_BYPASS_ALLOWED_LIST|ATTACH_APPLY_ON_MOB)
	UnregisterSignal(detaching_gun, list(COMSIG_ATTACHMENT_ATTACHED, COMSIG_ATTACHMENT_DETACHED))
	return ..()

/obj/item/attachable/shoulder_mount/ui_action_click(mob/living/user, datum/action/item_action/action, obj/item/weapon/gun/G)
	if(!istype(master_gun.loc, /obj/item/clothing/suit/modular) || master_gun.loc.loc != user)
		return
	return activate(user)

/obj/item/attachable/shoulder_mount/activate(mob/user, turn_off)
	. = ..()
	if(CHECK_BITFIELD(master_gun.deploy_flags, IS_DEPLOYED))
		DISABLE_BITFIELD(master_gun.deploy_flags, IS_DEPLOYED)
		UnregisterSignal(user, COMSIG_MOB_MOUSEDOWN)
		master_gun.set_gun_user(null)
		. = FALSE
	else if(!turn_off)
		ENABLE_BITFIELD(master_gun.deploy_flags, IS_DEPLOYED)
		update_icon()
		master_gun.set_gun_user(user)
		RegisterSignal(user, COMSIG_MOB_MOUSEDOWN, PROC_REF(handle_firing))
		master_gun.RegisterSignal(user, COMSIG_MOB_MOUSEDRAG, TYPE_PROC_REF(/obj/item/weapon/gun, change_target))
		. = TRUE
	for(var/datum/action/item_action/toggle/action_to_update AS in actions)
		action_to_update.set_toggle(.)

///Handles the gun attaching to the armor.
/obj/item/attachable/shoulder_mount/proc/handle_armor_attach(datum/source, attaching_item, mob/user)
	SIGNAL_HANDLER
	if(!istype(attaching_item, /obj/item/clothing/suit/modular))
		return
	master_gun.set_gun_user(null)
	RegisterSignal(attaching_item, COMSIG_ITEM_EQUIPPED, PROC_REF(handle_activations))
	RegisterSignal(attaching_item, COMSIG_ATOM_ATTACK_HAND_ALTERNATE, PROC_REF(switch_mode))
	RegisterSignal(attaching_item, COMSIG_ATOM_ATTACKBY_ALTERNATE, PROC_REF(reload_gun))
	RegisterSignal(master_gun, COMSIG_MOB_GUN_FIRED, PROC_REF(after_fire))
	master_gun.base_gun_icon = master_gun.placed_overlay_iconstate
	master_gun.update_icon()

///Handles the gun detaching from the armor.
/obj/item/attachable/shoulder_mount/proc/handle_armor_detach(datum/source, detaching_item, mob/user)
	SIGNAL_HANDLER
	if(!istype(detaching_item, /obj/item/clothing/suit/modular))
		return
	for(var/datum/action/action_to_delete AS in actions)
		if(action_to_delete.target != src)
			continue
		QDEL_NULL(action_to_delete)
		break
	update_icon()
	master_gun.base_gun_icon = initial(master_gun.icon_state)
	master_gun.update_icon()
	UnregisterSignal(detaching_item, list(COMSIG_ITEM_EQUIPPED, COMSIG_ATOM_ATTACK_HAND_ALTERNATE, COMSIG_ATOM_ATTACKBY_ALTERNATE))
	UnregisterSignal(master_gun, COMSIG_MOB_GUN_FIRED)
	UnregisterSignal(user, COMSIG_MOB_MOUSEDOWN)

///Sets up the action.
/obj/item/attachable/shoulder_mount/proc/handle_activations(datum/source, mob/equipper, slot)
	if(!isliving(equipper))
		return
	if(slot != SLOT_WEAR_SUIT)
		LAZYREMOVE(actions_types, /datum/action/item_action/toggle)
		var/datum/action/item_action/toggle/old_action = locate(/datum/action/item_action/toggle) in actions
		if(!old_action)
			return
		old_action.remove_action(equipper)
		actions = null
	else
		LAZYADD(actions_types, /datum/action/item_action/toggle)
		var/datum/action/item_action/toggle/new_action = new(src)
		new_action.give_action(equipper)

///Performs the firing.
/obj/item/attachable/shoulder_mount/proc/handle_firing(datum/source, atom/object, turf/location, control, params)
	SIGNAL_HANDLER
	var/list/modifiers = params2list(params)
	if(!modifiers[fire_mode])
		return
	if(!istype(master_gun.loc, /obj/item/clothing/suit/modular) || master_gun.loc.loc != source)
		return
	if(source.Adjacent(object))
		return
	var/mob/living/user = master_gun.gun_user
	if(user.incapacitated()  || user.lying_angle || LAZYACCESS(user.do_actions, src) || !user.dextrous || (!CHECK_BITFIELD(master_gun.gun_features_flags, GUN_ALLOW_SYNTHETIC) && !CONFIG_GET(flag/allow_synthetic_gun_use) && issynth(user)))
		return
	var/active_hand = user.get_active_held_item()
	var/inactive_hand = user.get_inactive_held_item()
	for(var/item_blacklisted in in_hand_items_blacklist)
		if(!istype(active_hand, item_blacklisted) && !istype(inactive_hand, item_blacklisted))
			continue
		to_chat(user, span_warning("[src] beeps. Guns or shields in your hands are interfering with its targetting. Aborting."))
		return
	master_gun.start_fire(source, object, location, control, null, TRUE)

///Switches click fire modes.
/obj/item/attachable/shoulder_mount/proc/switch_mode(datum/source, mob/living/user)
	SIGNAL_HANDLER
	switch(fire_mode)
		if("right")
			fire_mode = "middle"
			to_chat(user, span_notice("[master_gun] will now fire on a 'middle click'."))
		if("middle")
			fire_mode = "left"
			to_chat(user, span_notice("[master_gun] will now fire on a 'left click'."))
		if("left")
			fire_mode = "right"
			to_chat(user, span_notice("[master_gun] will now fire on a 'right click'."))

///Reloads the gun
/obj/item/attachable/shoulder_mount/proc/reload_gun(datum/source, obj/item/attacking_item, mob/living/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(master_gun, TYPE_PROC_REF(/obj/item/weapon/gun, reload), attacking_item, user)

///Performs the unique action after firing and checks to see if the user is still able to fire.
/obj/item/attachable/shoulder_mount/proc/after_fire(datum/source, atom/target, obj/item/weapon/gun/fired_gun)
	SIGNAL_HANDLER
	if(CHECK_BITFIELD(master_gun.reciever_flags, AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION))
		INVOKE_ASYNC(master_gun, TYPE_PROC_REF(/obj/item/weapon/gun, do_unique_action), master_gun.gun_user)
	var/mob/living/user = master_gun.gun_user
	var/active_hand = user.get_active_held_item()
	var/inactive_hand = user.get_inactive_held_item()
	for(var/item_blacklisted in in_hand_items_blacklist)
		if(!istype(active_hand, item_blacklisted) && !istype(inactive_hand, item_blacklisted))
			continue
		to_chat(user, span_warning("[src] beeps. Guns or shields in your hands are interfering with its targetting. Stopping fire."))
		master_gun.stop_fire()
		return
	if(!user.incapacitated() && !user.lying_angle && !LAZYACCESS(user.do_actions, src) && user.dextrous && (CHECK_BITFIELD(master_gun.gun_features_flags, GUN_ALLOW_SYNTHETIC) || CONFIG_GET(flag/allow_synthetic_gun_use) || !issynth(user)))
		return
	master_gun.stop_fire()
