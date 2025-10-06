/obj/item/weapon/gun/grenade_launcher
	icon = 'icons/obj/items/gun/special.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/special_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/special_righthand_1.dmi',
	)
	w_class = WEIGHT_CLASS_BULKY
	gun_skill_category = SKILL_FIREARMS
	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	reciever_flags = NONE
	throw_speed = 2
	throw_range = 10
	force = 5
	wield_delay = 0.4 SECONDS
	caliber = CALIBER_40MM //codex
	load_method = SINGLE_CASING //codex
	fire_sound = 'sound/weapons/guns/fire/grenadelauncher.ogg'
	fire_rattle = 'sound/weapons/guns/fire/grenadelauncher.ogg'
	cocked_sound = 'sound/weapons/guns/interact/m92_cocked.ogg'
	general_codex_key = "explosive weapons"
	default_ammo_type = /obj/item/explosive/grenade

	allowed_ammo_types = list(
		/obj/item/explosive/grenade,
		/obj/item/explosive/grenade/training,
		/obj/item/explosive/grenade/pmc,
		/obj/item/explosive/grenade/m15,
		/obj/item/explosive/grenade/stick,
		/obj/item/explosive/grenade/upp,
		/obj/item/explosive/grenade/som,
		/obj/item/explosive/grenade/sectoid,
		/obj/item/explosive/grenade/creampie,
		/obj/item/explosive/grenade/incendiary,
		/obj/item/explosive/grenade/incendiary/som,
		/obj/item/explosive/grenade/incendiary/molotov,
		/obj/item/explosive/grenade/smokebomb,
		/obj/item/explosive/grenade/smokebomb/som,
		/obj/item/explosive/grenade/smokebomb/cloak,
		/obj/item/explosive/grenade/smokebomb/drain,
		/obj/item/explosive/grenade/smokebomb/antigas,
		/obj/item/explosive/grenade/smokebomb/neuro,
		/obj/item/explosive/grenade/smokebomb/acid,
		/obj/item/explosive/grenade/smokebomb/satrapine,
		/obj/item/explosive/grenade/phosphorus,
		/obj/item/explosive/grenade/phosphorus/upp,
		/obj/item/explosive/grenade/impact,
		/obj/item/explosive/grenade/sticky,
		/obj/item/explosive/grenade/sticky/trailblazer,
		/obj/item/explosive/grenade/sticky/trailblazer/phosphorus, // RUTGMC ADDITION
		/obj/item/explosive/grenade/flare,
		/obj/item/explosive/grenade/flare/cas,
		/obj/item/explosive/grenade/chem_grenade,
		/obj/item/explosive/grenade/chem_grenade/large,
		/obj/item/explosive/grenade/chem_grenade/metalfoam,
		/obj/item/explosive/grenade/chem_grenade/razorburn_small,
		/obj/item/explosive/grenade/chem_grenade/razorburn_large,
		/obj/item/explosive/grenade/chem_grenade/incendiary,
		/obj/item/explosive/grenade/chem_grenade/teargas,
		/obj/item/explosive/grenade/flashbang/stun,
		/obj/item/explosive/grenade/bullet/laser,
		/obj/item/explosive/grenade/bullet/hefa,
		/obj/item/explosive/grenade/emp,
	)
	reciever_flags = NONE
	actions_types = list(/datum/action/item_action/overhead_grenade_launcher)

	///the maximum range the launcher can fling the grenade, by default 15 tiles
	var/max_range = 15
	///if the grenade launcher over mode is active
	var/overhead_launch_mode = FALSE

/obj/item/weapon/gun/grenade_launcher/able_to_fire(mob/user)
	. = ..()
	if(!.)
		return FALSE
	if(get_dist(target, gun_user) <= 2)
		to_chat(gun_user, span_warning("[src] beeps a warning noise. You are too close!"))
		return FALSE


/obj/item/weapon/gun/grenade_launcher/do_fire(obj/object_to_fire)
	if(!istype(object_to_fire, /obj/item/explosive/grenade))
		return FALSE
	var/obj/item/explosive/grenade/grenade_to_launch = object_to_fire
	var/turf/user_turf = get_turf(src)
	grenade_to_launch.forceMove(user_turf)
	gun_user?.visible_message(span_danger("[gun_user] fires a grenade from [gun_user?.p_their()] [src.name]!"), span_warning("You fire [src]!"))
	log_bomber(gun_user, "fired a grenade ([grenade_to_launch]) from", src, "at [AREACOORD(user_turf)]")
	play_fire_sound(loc)
	grenade_to_launch.launched_det_time()
	grenade_to_launch.launched = TRUE
	grenade_to_launch.activate(gun_user)
	if(!overhead_launch_mode)
		grenade_to_launch.throwforce += grenade_to_launch.launchforce
		grenade_to_launch.throw_at(target, max_range, 3, (gun_user ? gun_user : loc))
	else
		var/offset_x = overhead_launch_mode ? rand(-1, 1) : 0
		var/offset_y = overhead_launch_mode ? rand(-1, 1) : 0
		var/turf/target_turf = get_turf(target)
		var/turf/randomized_target = locate(target_turf.x + offset_x, target_turf.y + offset_y, target_turf.z)
		grenade_to_launch.throw_at(randomized_target, max_range, 3, (gun_user ? gun_user : loc), flying = TRUE)
	if(fire_animation)
		flick("[fire_animation]", src)
	if(CHECK_BITFIELD(gun_features_flags, GUN_SMOKE_PARTICLES))
		var/firing_angle = Get_Angle(user_turf, target)
		var/x_component = sin(firing_angle) * 40
		var/y_component = cos(firing_angle) * 40
		var/obj/effect/abstract/particle_holder/gun_smoke = new(get_turf(src), /particles/firing_smoke)
		gun_smoke.particles.velocity = list(x_component, y_component)
		addtimer(VARSET_CALLBACK(gun_smoke.particles, count, 0), 5)
		addtimer(VARSET_CALLBACK(gun_smoke.particles, drift, 0), 3)
		QDEL_IN(gun_smoke, 0.6 SECONDS)
	return TRUE

/obj/item/weapon/gun/grenade_launcher/get_ammo_list()
	if(!in_chamber)
		return ..()
	var/obj/item/explosive/grenade/grenade = in_chamber
	return list(grenade.hud_state, grenade.hud_state_empty)

/obj/item/weapon/gun/grenade_launcher/proc/toggle_overhead_launcher(mob/living/carbon/human/user)
	if(!overhead_launch_mode)
		balloon_alert(user, "You have activated overhead launcher mode.")
		overhead_launch_mode = TRUE
		windup_delay += 0.5 SECONDS
	else
		balloon_alert(user, "You have deactivated overhead launcher mode.")
		overhead_launch_mode = FALSE
		windup_delay -= 0.5 SECONDS

//-------------------------------------------------------
//GL-70 Grenade Launcher.

/obj/item/weapon/gun/grenade_launcher/multinade_launcher
	name = "\improper GL-70 grenade launcher"
	desc = "The GL-70 is the standard grenade launcher used by the TerraGov Marine Corps for area denial and big explosions."
	icon = 'icons/obj/items/gun/special64.dmi'
	icon_state = "t70"
	worn_icon_state = "t70"
	fire_animation = "t70_fire"
	equip_slot_flags = ITEM_SLOT_BACK
	max_shells = 6 //codex
	wield_delay = 1.2 SECONDS
	fire_sound = 'sound/weapons/guns/fire/underbarrel_grenadelauncher.ogg'
	fire_rattle = 'sound/weapons/guns/fire/underbarrel_grenadelauncher.ogg'
	aim_slowdown = 1.2
	attachable_allowed = list(
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/stock/t70stock,
	)
	starting_attachment_types = list(/obj/item/attachable/stock/t70stock)
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 14, "rail_y" = 22, "under_x" = 19, "under_y" = 14, "stock_x" = 11, "stock_y" = 12)
	fire_delay = 1.3 SECONDS
	max_chamber_items = 5

/obj/item/weapon/gun/grenade_launcher/multinade_launcher/beginner
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness)

/obj/item/weapon/gun/grenade_launcher/multinade_launcher/unloaded
	default_ammo_type = null

/obj/item/weapon/gun/grenade_launcher/multinade_launcher/erp
	name = "\improper PL-70 assault pie launcher"
	icon_state = "t70_erp"
	worn_icon_state = "t70_erp"
	fire_animation = "t70_erp_fire"
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness)
	default_ammo_type = /obj/item/explosive/grenade/creampie

/obj/item/weapon/gun/grenade_launcher/underslung
	name = "underslung grenade launcher"
	desc = "A weapon-mounted, reloadable, two-shot grenade launcher."
	icon = 'icons/obj/items/attachments/attachments.dmi'
	icon_state = "grenade"

	worn_icon_list = list( // for whatever fucking reason we can't set it null
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)

	max_shells = 2 //codex
	max_chamber_items = 1
	fire_delay = 1 SECONDS
	fire_sound = 'sound/weapons/guns/fire/underbarrel_grenadelauncher.ogg'
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 14, "rail_y" = 22, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)
	attachable_allowed = list()
	max_range = 7

	slot = ATTACHMENT_SLOT_UNDER
	attach_delay = 3 SECONDS
	detach_delay = 3 SECONDS
	gun_features_flags = GUN_AMMO_COUNTER|GUN_IS_ATTACHMENT|GUN_ATTACHMENT_FIRE_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	pixel_shift_x = 14
	pixel_shift_y = 18
	allowed_ammo_types = list(
		/obj/item/explosive/grenade,
		/obj/item/explosive/grenade/training,
		/obj/item/explosive/grenade/stick,
		/obj/item/explosive/grenade/upp,
		/obj/item/explosive/grenade/som,
		/obj/item/explosive/grenade/incendiary,
		/obj/item/explosive/grenade/incendiary/som,
		/obj/item/explosive/grenade/incendiary/molotov,
		/obj/item/explosive/grenade/smokebomb,
		/obj/item/explosive/grenade/smokebomb/som,
		/obj/item/explosive/grenade/smokebomb/cloak,
		/obj/item/explosive/grenade/smokebomb/drain,
		/obj/item/explosive/grenade/smokebomb/antigas,
		/obj/item/explosive/grenade/smokebomb/neuro,
		/obj/item/explosive/grenade/smokebomb/acid,
		/obj/item/explosive/grenade/smokebomb/satrapine,
		/obj/item/explosive/grenade/phosphorus,
		/obj/item/explosive/grenade/phosphorus/upp,
		/obj/item/explosive/grenade/flare,
		/obj/item/explosive/grenade/flare/cas,
		/obj/item/explosive/grenade/impact,
		/obj/item/explosive/grenade/sticky,
		/obj/item/explosive/grenade/flashbang/stun,
		/obj/item/explosive/grenade/m15,
		/obj/item/explosive/grenade/sticky/trailblazer,
		/obj/item/explosive/grenade/sticky/trailblazer/phosphorus,
		/obj/item/explosive/grenade/sticky/cloaker,
		/obj/item/explosive/grenade/mirage,
		/obj/item/explosive/grenade/bullet/laser,
		/obj/item/explosive/grenade/bullet/hefa,
		/obj/item/explosive/grenade/emp,
	)

	wield_delay_mod = 0.2 SECONDS

/obj/item/weapon/gun/grenade_launcher/underslung/elite
	default_ammo_type = /obj/item/explosive/grenade/impact

/obj/item/weapon/gun/grenade_launcher/underslung/invisible
	attach_features_flags = NONE

/obj/item/weapon/gun/grenade_launcher/underslung/br64
	name = "\improper BR-64 underslung grenade launcher"
	desc = "A weapon-mounted, reloadable, two-shot grenade launcher designed to fit the BR-64."
	icon = 'icons/obj/items/attachments/attachments.dmi'

	worn_icon_list = list( // for whatever fucking reason we can't set it null
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)

	icon_state = "t64_grenade"
	pixel_shift_x = 21
	pixel_shift_y = 15

/obj/item/weapon/gun/grenade_launcher/underslung/mpi
	icon_state = "grenade_mpi"
	attach_features_flags = NONE
	default_ammo_type = /obj/item/explosive/grenade/som

/obj/item/weapon/gun/grenade_launcher/underslung/mpi/removeable
	attach_features_flags = ATTACH_REMOVABLE

/obj/item/weapon/gun/grenade_launcher/single_shot
	name = "\improper GL-81 grenade launcher"
	desc = "A lightweight, single-shot grenade launcher used by the TerraGov Marine Corps for area denial and big explosions."
	icon_state = "m81"
	worn_icon_state = "m81"
	w_class = WEIGHT_CLASS_NORMAL
	max_shells = 1 //codex
	equip_slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	wield_delay = 0.8 SECONDS
	aim_slowdown = 1
	gun_features_flags = GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	attachable_allowed = list()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 14, "rail_y" = 22, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)
	fire_delay = 1.05 SECONDS
	max_chamber_items = 0
	max_range = 10

///This performs a tactical reload with src using new_magazine to load the gun.
/obj/item/weapon/gun/grenade_launcher/single_shot/tactical_reload(obj/item/new_magazine, mob/living/carbon/human/user)
	if(!istype(user) || user.incapacitated(TRUE) || user.do_actions)
		return
	if(!(new_magazine.type in allowed_ammo_types))
		if(active_attachable)
			active_attachable.tactical_reload(new_magazine, user)
			return
		to_chat(user, span_warning("[new_magazine] cannot fit into [src]!"))
		return
	if(src != user.r_hand && src != user.l_hand && (!master_gun || (master_gun != user.r_hand && master_gun != user.l_hand)))
		to_chat(user, span_warning("[src] must be in your hand to do that."))
		return
	//no tactical reload for the untrained.
	if(user.skills.getRating(SKILL_FIREARMS) < SKILL_FIREARMS_DEFAULT)
		to_chat(user, span_warning("You don't know how to do tactical reloads."))
		return
	to_chat(user, span_notice("You start a tactical reload."))
	var/tac_reload_time = max(0.25 SECONDS, 0.75 SECONDS - user.skills.getRating(SKILL_FIREARMS) * 5)
	if(length(chamber_items))
		if(!do_after(user, tac_reload_time, IGNORE_USER_LOC_CHANGE, new_magazine) && loc == user)
			return
		unload(user)
	if(!do_after(user, tac_reload_time, IGNORE_USER_LOC_CHANGE, new_magazine) && loc == user)
		return
	if(new_magazine.item_flags & IN_STORAGE)
		var/obj/item/storage/S = new_magazine.loc
		S.storage_datum.remove_from_storage(new_magazine, get_turf(user), user)
	if(!CHECK_BITFIELD(get_magazine_features_flags(new_magazine), MAGAZINE_WORN))
		user.put_in_any_hand_if_possible(new_magazine)
	reload(new_magazine, user)

/obj/item/weapon/gun/grenade_launcher/single_shot/riot
	name = "\improper GL-81 riot grenade launcher"
	desc = "A lightweight, single-shot grenade launcher to launch tear gas grenades. Used by Nanotrasen security during riots."
	default_ammo_type = null
	allowed_ammo_types = list(/obj/item/explosive/grenade/chem_grenade)
	req_access = list(ACCESS_MARINE_BRIG)

/obj/item/weapon/gun/grenade_launcher/single_shot/flare
	name = "flare gun"
	desc = "A gun that fires flares. Replace with flares. Simple! Equipped with long range irons."
	icon_state = "flaregun"
	worn_icon_state = "gun"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	fire_sound = 'sound/weapons/guns/fire/flare.ogg'
	w_class = WEIGHT_CLASS_SMALL
	gun_features_flags = NONE
	gun_skill_category = SKILL_PISTOLS
	fire_delay = 0.5 SECONDS
	wield_delay = 0.4 SECONDS
	default_ammo_type = /obj/item/explosive/grenade/flare
	allowed_ammo_types = list(/obj/item/explosive/grenade/flare, /obj/item/explosive/grenade/flare/cas)
	attachable_allowed = list(/obj/item/attachable/scope/unremovable/flaregun)
	starting_attachment_types = list(/obj/item/attachable/scope/unremovable/flaregun)

/obj/item/weapon/gun/grenade_launcher/single_shot/flare/marine
	name = "M30E2 flare gun"
	desc = "A very tiny flaregun that fires flares equipped with long range irons, the mass amounts of markings on the back and barrel denote it as owned by the TGMC."
	icon_state = "marine_flaregun"
