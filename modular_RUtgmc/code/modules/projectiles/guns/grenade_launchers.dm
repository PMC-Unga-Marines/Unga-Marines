/obj/item/weapon/gun/grenade_launcher/multinade_launcher
	wield_delay = 1.2 SECONDS
	fire_delay = 1.3 SECONDS

/obj/item/weapon/gun/grenade_launcher/single_shot
	wield_delay = 0.8 SECONDS
	flags_gun_features = GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES|GUN_WIELDED_STABLE_FIRING_ONLY

/obj/item/weapon/gun/grenade_launcher/single_shot/flare
	wield_delay = 0.4 SECONDS

/obj/item/weapon/gun/grenade_launcher/underslung
	max_shells = 1 //codex
	max_chamber_items = 0

/obj/item/weapon/gun/grenade_launcher/underslung/elite
	default_ammo_type = /obj/item/explosive/grenade/impact

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
	if(istype(new_magazine.loc, /obj/item/storage))
		var/obj/item/storage/S = new_magazine.loc
		S.remove_from_storage(new_magazine, get_turf(user), user)
	if(!CHECK_BITFIELD(get_flags_magazine_features(new_magazine), MAGAZINE_WORN))
		user.put_in_any_hand_if_possible(new_magazine)
	reload(new_magazine, user)
