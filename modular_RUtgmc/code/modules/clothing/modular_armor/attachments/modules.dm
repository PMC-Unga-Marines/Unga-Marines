/obj/item/armor_module/module/style/light_armor
	soft_armor = list(MELEE = 35, BULLET = 55, LASER = 55, ENERGY = 50, BOMB = 40, BIO = 45, FIRE = 45, ACID = 45)
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT

/obj/item/armor_module/module/style/medium_armor
	soft_armor = list(MELEE = 45, BULLET = 65, LASER = 65, ENERGY = 55, BOMB = 45, BIO = 50, FIRE = 50, ACID = 50)

/obj/item/armor_module/module/style/heavy_armor
	soft_armor = list(MELEE = 55, BULLET = 70, LASER = 70, ENERGY = 60, BOMB = 50, BIO = 50, FIRE = 50, ACID = 60)
	slowdown = SLOWDOWN_ARMOR_VERY_HEAVY

/obj/item/armor_module/module/motion_detector
	name = "Tactical sensor helmet module"
	desc = "Help you to detect the xeno in the darkness."
	icon = 'modular_RUtgmc/icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_head_scanner"
	item_state = "mod_head_scanner_a"
	flags_attach_features = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_APPLY_ON_MOB
	slot = ATTACHMENT_SLOT_HEAD_MODULE
	prefered_slot = SLOT_HEAD

	/// Who's using this item
	var/mob/living/carbon/human/operator
	///The range of this motion detector
	var/range = 16
	//таймер для работы модуля
	var/motion_timer = null
	//время через которое будет срабатывать модуль
	var/scan_time = 2 SECONDS
	///The list of all the blips
	var/list/obj/effect/blip/blips_list = list()

/obj/item/armor_module/module/motion_detector/Destroy()
	stop_and_clean()
	return ..()

/obj/item/armor_module/module/motion_detector/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	RegisterSignal(parent, COMSIG_ITEM_UNEQUIPPED, PROC_REF(stop_and_clean))

/obj/item/armor_module/module/motion_detector/on_detach(obj/item/detaching_from, mob/user)
	UnregisterSignal(parent, COMSIG_ITEM_UNEQUIPPED, PROC_REF(stop_and_clean))
	stop_and_clean()
	return ..()

//убираем графическую хуйню и останавливает сканирование.
/obj/item/armor_module/module/motion_detector/proc/stop_and_clean()
	SIGNAL_HANDLER

	active = FALSE
	clean_blips()
	operator = null
	if(motion_timer)
		deltimer(motion_timer)
		motion_timer = null

//вкл-выкл модуль
/obj/item/armor_module/module/motion_detector/activate(mob/living/user)
	active = !active
	to_chat(user, span_notice("You toggle \the [src] [active ? "enabling" : "disabling"] it."))
	if(active)
		operator = user
		if(!motion_timer)
			motion_timer = addtimer(CALLBACK(src, PROC_REF(do_scan)), scan_time, TIMER_LOOP|TIMER_STOPPABLE)
	else
		stop_and_clean()

/obj/item/armor_module/module/motion_detector/proc/do_scan()
	if(!operator?.client || operator?.stat != CONSCIOUS)
		stop_and_clean()
		return
	var/hostile_detected = FALSE
	for(var/mob/living/carbon/human/nearby_human AS in cheap_get_humans_near(operator, range))
		if(nearby_human == operator)
			continue
		if(HAS_TRAIT(nearby_human, TRAIT_LIGHT_STEP))
			continue
		if(!hostile_detected && (!operator.wear_id || !nearby_human.wear_id || nearby_human.wear_id.iff_signal != operator.wear_id.iff_signal))
			hostile_detected = TRUE
		prepare_blip(nearby_human, nearby_human.wear_id?.iff_signal & operator.wear_id?.iff_signal ? MOTION_DETECTOR_FRIENDLY : MOTION_DETECTOR_HOSTILE)
	for(var/mob/living/carbon/xenomorph/nearby_xeno AS in cheap_get_xenos_near(operator, range))
		if(!hostile_detected)
			hostile_detected = TRUE
		prepare_blip(nearby_xeno, MOTION_DETECTOR_HOSTILE)
	if(hostile_detected)
		playsound(loc, 'sound/items/tick.ogg', 100, 0, 1)
	addtimer(CALLBACK(src, PROC_REF(clean_blips)), scan_time / 2)

///Clean all blips from operator screen
/obj/item/armor_module/module/motion_detector/proc/clean_blips()
	if(!operator)//We already cleaned
		return
	for(var/obj/effect/blip/blip AS in blips_list)
		blip.remove_blip(operator)
	blips_list.Cut()

///Prepare the blip to be print on the operator screen
/obj/item/armor_module/module/motion_detector/proc/prepare_blip(mob/target, status)
	if(!operator || !operator.client)
		return
	if(!target)
		return

	var/list/actualview = getviewsize(operator.client.view)
	var/viewX = actualview[1]
	var/viewY = actualview[2]
	var/turf/center_view = get_view_center(operator)
	var/screen_pos_y = target.y - center_view.y + round(viewY * 0.5) + 1
	var/dir
	if(screen_pos_y < 1)
		dir = SOUTH
		screen_pos_y = 1
	else if (screen_pos_y > viewY)
		dir = NORTH
		screen_pos_y = viewY
	var/screen_pos_x = target.x - center_view.x + round(viewX * 0.5) + 1
	if(screen_pos_x < 1)
		dir = (dir ? dir == SOUTH ? SOUTHWEST : NORTHWEST : WEST)
		screen_pos_x = 1
	else if (screen_pos_x > viewX)
		dir = (dir ? dir == SOUTH ? SOUTHEAST : NORTHEAST : EAST)
		screen_pos_x = viewX
	if(dir)
		blips_list += new /obj/effect/blip/edge_blip(null, status, operator, screen_pos_x, screen_pos_y, dir)
		return
	blips_list += new /obj/effect/blip/close_blip(get_turf(target), status, operator)

/obj/item/armor_module/module/fire_proof
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 100, ACID = 0)
	hard_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 100, ACID = 0)

/obj/item/armor_module/module/fire_proof_helmet
	icon = 'modular_RUtgmc/icons/mob/modular/modular_armor_modules.dmi'
	variants_by_parent_type = list(/obj/item/clothing/head/modular/m10x = "mod_fire_head_xn")
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 100, ACID = 0)
	hard_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 100, ACID = 0)

/**
 * Mini autodoc module
 */
/obj/item/armor_module/module/valkyrie_autodoc
	slowdown = 0

/**
 * Environment protection module
*/
/obj/item/armor_module/module/mimir_environment_protection/mimir_helmet //gas protection
	desc = "Designed for mounting on a modular helmet. Provides great resistance to xeno gas clouds"
	icon = 'modular_RUtgmc/icons/mob/modular/modular_armor_modules.dmi'
	variants_by_parent_type = list(/obj/item/clothing/head/modular/m10x = "mimir_head_xn")
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 15, FIRE = 0, ACID = 0)
	slowdown = 0

/obj/item/armor_module/module/mimir_environment_protection/mimir_helmet/mark1
	name = "Mimir Environmental Helmet System"
	desc = "Designed for mounting on a modular helmet. Provides good resistance to xeno gas clouds"
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 15, FIRE = 0, ACID = 0)

/**
 * Extra armor module
*/
/obj/item/armor_module/module/tyr_extra_armor
	soft_armor = list(MELEE = 15, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 5, BIO = 10, FIRE = 15, ACID = 10)
	slowdown = 0

/obj/item/armor_module/module/tyr_head
	icon = 'modular_RUtgmc/icons/mob/modular/modular_armor_modules.dmi'
	variants_by_parent_type = list(/obj/item/clothing/head/modular/m10x = "tyr_head_xn")

/obj/item/armor_module/module/eshield
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	damaged_shield_cooldown = 15 SECONDS

/obj/item/armor_module/module/artemis
	icon = 'modular_RUtgmc/icons/mob/modular/modular_armor_modules.dmi'
	variants_by_parent_type = list(/obj/item/clothing/head/modular/m10x = "artemis_head_xn")

/obj/item/armor_module/module/binoculars
	icon = 'modular_RUtgmc/icons/mob/modular/modular_armor_modules.dmi'

/obj/item/armor_module/module/binoculars/artemis_mark_two
	var/eye_protection_mod = 1
	icon = 'modular_RUtgmc/icons/mob/modular/modular_armor_modules.dmi'
	variants_by_parent_type = list(/obj/item/clothing/head/modular/m10x = "artemis_head_mk2_xn")

/obj/item/armor_module/module/binoculars/artemis_mark_two/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	parent.eye_protection += eye_protection_mod
	parent.AddComponent(/datum/component/blur_protection)

/obj/item/armor_module/module/binoculars/artemis_mark_two/on_detach(obj/item/detaching_from, mob/user)
	parent.eye_protection -= eye_protection_mod
	var/datum/component/blur_protection/blur_p = parent?.GetComponent(/datum/component/blur_protection)
	blur_p?.RemoveComponent()
	return ..()

/obj/item/armor_module/module/hod_head
	icon = 'modular_RUtgmc/icons/mob/modular/modular_armor_modules.dmi'

/obj/item/armor_module/module/welding
	icon = 'modular_RUtgmc/icons/mob/modular/modular_armor_modules.dmi'

/obj/item/armor_module/module/welding/superior
	icon = 'modular_RUtgmc/icons/mob/modular/modular_armor_modules.dmi'

/obj/item/armor_module/module/antenna
	icon = 'modular_RUtgmc/icons/mob/modular/modular_armor_modules.dmi'

/obj/item/armor_module/module/fire_proof/som
	icon = 'modular_RUtgmc/icons/mob/modular/som_armor_modules.dmi'

/obj/item/armor_module/module/tyr_extra_armor/som
	icon = 'modular_RUtgmc/icons/mob/modular/modular_armor_modules.dmi'

/obj/item/armor_module/module/mimir_environment_protection/som
	icon = 'modular_RUtgmc/icons/mob/modular/modular_armor_modules.dmi'

/obj/item/armor_module/module/valkyrie_autodoc/som
	icon = 'modular_RUtgmc/icons/mob/modular/modular_armor_modules.dmi'
/obj/item/armor_module/storage/engineering/som
	icon = 'modular_RUtgmc/icons/mob/modular/som_armor_modules.dmi'

/obj/item/armor_module/storage/general/som
	icon = 'modular_RUtgmc/icons/mob/modular/som_armor_modules.dmi'

/obj/item/armor_module/storage/medical/som
	icon = 'modular_RUtgmc/icons/mob/modular/som_armor_modules.dmi'

/obj/item/armor_module/module/antenna/activate(mob/living/user)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(update_beacon_location)), 5 SECONDS)

/obj/item/armor_module/module/antenna/proc/update_beacon_location()
	if(beacon_datum)
		beacon_datum.drop_location = get_turf(src)
		addtimer(CALLBACK(src, PROC_REF(update_beacon_location), beacon_datum), 5 SECONDS)
