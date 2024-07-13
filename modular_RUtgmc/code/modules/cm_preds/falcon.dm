/obj/item/clothing/falcon_drone
	name = "falcon drone"
	desc = "An agile drone used by Yautja to survey the hunting grounds."
	icon = 'modular_RUtgmc/icons/obj/hunter/pred_gear.dmi'
	icon_state = "falcon_drone"
	item_icons = list(
		slot_ear_str = 'modular_RUtgmc/icons/mob/hunter/pred_gear.dmi',
		slot_head_str = 'modular_RUtgmc/icons/mob/hunter/pred_gear.dmi',
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/hunter/items_lefthand.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/hunter/items_righthand.dmi'
	)
	flags_equip_slot = ITEM_SLOT_HEAD|ITEM_SLOT_EARS
	flags_item = ITEM_PREDATOR

/obj/item/clothing/falcon_drone/attack_self(mob/user)
	..()
	control_falcon_drone()

/obj/item/clothing/falcon_drone/verb/control_falcon_drone()
	set name = "Control Falcon Drone"
	set desc = "Activates your falcon drone."
	set category = "Yautja"
	set src in usr

	var/mob/living/mob = usr
	if(mob.stat || (mob.lying_angle && !mob.resting && !mob.IsSleeping()) || (mob.IsParalyzed() || mob.IsUnconscious()))
		return

	var/mob/living/carbon/human/H = usr
	if(!istype(H) || !HAS_TRAIT(usr, TRAIT_YAUTJA_TECH))
		to_chat(usr, span_warning("You do not know how to use this."))
		return

	if(!istype(H.gloves, /obj/item/clothing/gloves/yautja))
		to_chat(usr, span_warning("You need your bracers to control \the [src]!"))
		return

	var/mob/hologram/falcon/hologram = new /mob/hologram/falcon(usr.loc, usr, src, H.gloves)
	usr.transferItemToLoc(src, hologram)

/mob/hologram/falcon
	name = "falcon drone"
	icon = 'modular_RUtgmc/icons/obj/hunter/pred_gear.dmi'
	icon_state = "falcon_drone_active"
	hud_possible = list(HUNTER_HUD)
	pass_flags = HOVERING
	var/obj/item/clothing/falcon_drone/parent_drone
	var/obj/item/clothing/gloves/yautja/owned_bracers
	desc = "An agile drone used by Yautja to survey the hunting grounds."

/mob/hologram/falcon/Initialize(mapload, mob/M, obj/item/clothing/falcon_drone/drone, obj/item/clothing/gloves/yautja/bracers)
	. = ..()
	parent_drone = drone
	owned_bracers = bracers
	RegisterSignal(owned_bracers, COMSIG_ITEM_DROPPED, PROC_REF(handle_bracer_drop))
	if(M)
		M.client.eye = src
		M.client.perspective = EYE_PERSPECTIVE
	med_hud_set_status()
	add_to_all_mob_huds()

/mob/hologram/falcon/add_to_all_mob_huds()
	var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_HUNTER]
	hud.add_to_hud(src)

/mob/hologram/falcon/remove_from_all_mob_huds()
	var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_HUNTER]
	hud.remove_from_hud(src)

/mob/hologram/falcon/med_hud_set_status()
	if(!hud_list)
		return

	var/image/holder = hud_list[HUNTER_HUD]
	holder?.icon_state = "falcon_drone_active"

/mob/hologram/falcon/Destroy()
	if(parent_drone)
		if(!linked_mob.equip_to_slot_if_possible(parent_drone, slot_ear_str, TRUE, FALSE, TRUE, TRUE, FALSE))
			linked_mob.put_in_hands(parent_drone)
		linked_mob.client.eye = linked_mob
		linked_mob.client.perspective = MOB_PERSPECTIVE
		parent_drone = null
	if(owned_bracers)
		UnregisterSignal(owned_bracers, COMSIG_ITEM_DROPPED)
		owned_bracers = null

	remove_from_all_mob_huds()

	return ..()

/mob/hologram/falcon/ex_act()
	new /obj/item/trash/falcon_drone(loc)
	QDEL_NULL(parent_drone)
	qdel(src)

/mob/hologram/falcon/emp_act()
	new /obj/item/trash/falcon_drone/emp(loc)
	QDEL_NULL(parent_drone)
	qdel(src)

/mob/hologram/falcon/proc/handle_bracer_drop()
	SIGNAL_HANDLER

	qdel(src)

/obj/item/trash/falcon_drone
	name = "destroyed falcon drone"
	desc = "The wreckage of a Yautja drone."
	icon = 'modular_RUtgmc/icons/obj/hunter/pred_gear.dmi'
	icon_state = "falcon_drone_destroyed"
	flags_item = ITEM_PREDATOR

/obj/item/trash/falcon_drone/emp
	name = "disabled falcon drone"
	desc = "An intact Yautja drone. The internal electronics are completely fried."
	icon_state = "falcon_drone_emped"
