#define CLOSET_INSERT_END -1
#define CLOSET_INSERT_FAIL 0
#define CLOSET_INSERT_SUCCESS 1

/obj/structure/closet
	name = "closet"
	desc = "It's a basic storage unit."
	icon = 'icons/obj/structures/closet.dmi'
	icon_state = "closed"
	density = TRUE
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	hit_sound = 'sound/effects/metalhit.ogg'
	blocks_emissive = EMISSIVE_BLOCK_GENERIC
	max_integrity = 200
	coverage = 40
	soft_armor = list(MELEE = 20, BULLET = 10, LASER = 10, ENERGY = 0, BOMB = 10, BIO = 0, FIRE = 70, ACID = 60)
	resistance_flags = XENO_DAMAGEABLE
	interaction_flags = INTERACT_OBJ_DEFAULT|INTERACT_POWERLOADER_PICKUP_ALLOWED

	/// The material dropped on destruction
	var/drop_material = /obj/item/stack/sheet/metal
	/// Used for determining the closed overlay
	var/icon_closed = "closed"
	/// Used for determining the open overlay
	var/icon_opened = "open"
	/// Used for determining the welded overlay
	var/overlay_welded = "welded"
	/// Is the closet open?
	var/opened = FALSE
	/// Is the closet welded?
	var/welded = FALSE
	/// Is the closet locked?
	var/locked = FALSE
	/// Is the closet mounted to a wall?
	var/wall_mounted = FALSE //never solid (You can always pass over it)
	/// How much time it takes to resist out of a closet
	var/breakout_time = 2 MINUTES
	/// The cooldown for the "bang bang" of breaking out of the closet
	var/lastbang = FALSE
	/// The flags of closets, used for various flags, see code\__DEFINES\objects.dm
	var/closet_flags = NONE
	/// The maximum size of the mob we can put in
	var/max_mob_size = MOB_SIZE_HUMAN
	/// How many max_mob_size'd mob/living can fit together inside a closet.
	var/mob_storage_capacity = 1
	/// The amount of things in general we can have in a closet
	var/storage_capacity = 50 //This is so that someone can't pack hundreds of items in a locker/crate
							//then open it in a populated area to crash clients.
	/// How many mobs are currently inside
	var/mob_size_counter = 0
	/// How many items are currently inside
	var/item_size_counter = 0
	/// The sound the closet makes when opened
	var/open_sound = 'sound/machines/click.ogg'
	/// The sound the closet makes when closed
	var/close_sound = 'sound/machines/click.ogg'
	/// The delay between stuns getting out of the closet causes
	var/closet_stun_delay = 2 SECONDS
	//var to prevent welding stasis bags and tarps
	var/can_be_welded = TRUE
	//the amount of material you drop
	var/drop_material_amount = 1

/obj/structure/closet/ex_act(severity)
	take_damage(severity, BRUTE, BOMB)
	if(!locked || prob(severity * 0.3))
		break_open()
		contents_explosion(severity)

/obj/structure/closet/Initialize(mapload, ...)
	. = ..()

	if(mapload && !opened) // if closed, any item at the crate's loc is put in the contents
		. = INITIALIZE_HINT_LATELOAD

	RegisterSignal(src, COMSIG_MOVABLE_SHUTTLE_CRUSH, PROC_REF(shuttle_crush))
	PopulateContents()
	update_icon()

/obj/structure/closet/LateInitialize()
	. = ..()

	take_contents()

/obj/structure/closet/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(ispath(drop_material) && drop_material_amount)
		new drop_material(loc, drop_material_amount)
	dump_contents()
	return ..()

///USE THIS TO FILL CONTENTS OF OBJECTS, NOT INITIALIZE OR NEW
/obj/structure/closet/proc/PopulateContents()
	return

/obj/structure/closet/proc/shuttle_crush()
	SIGNAL_HANDLER
	for(var/mob/living/L in contents)
		L.gib()
	for(var/atom/movable/AM in contents)
		qdel(AM)

/obj/structure/closet/open
	icon_state = "open"
	density = FALSE
	opened = TRUE

/obj/structure/closet/CanAllowThrough(atom/movable/mover, turf/target)
	if(wall_mounted)
		return TRUE
	return ..()

/obj/structure/closet/proc/can_open(mob/living/user)
	if(welded || locked)
		if(user)
			balloon_alert(user, "Won't budge")
		return FALSE
	return TRUE

/obj/structure/closet/proc/can_close(mob/living/user)
	for(var/obj/structure/closet/blocking_closet in loc)
		if(blocking_closet != src && !blocking_closet.wall_mounted && !blocking_closet.opened)
			if(user)
				balloon_alert(user, "Can't close, too cramped")
			return FALSE
	for(var/mob/living/mob_to_stuff in loc)
		if(mob_to_stuff.anchored || mob_to_stuff.mob_size > max_mob_size)
			if(user)
				balloon_alert(user, "Can't close, [mob_to_stuff] in the way")
			return FALSE
	return TRUE

/obj/structure/closet/proc/dump_contents()
	var/atom/drop_loc = drop_location()
	for(var/thing in src)
		var/atom/movable/stuffed_thing = thing
		if(isliving(stuffed_thing))
			var/mob/living/stuffed_mob = stuffed_thing
			stuffed_mob.on_closet_dump(src)
		stuffed_thing.forceMove(drop_loc)
		if(throwing) // you keep some momentum when getting out of a thrown closet
			step(stuffed_thing, dir)
	mob_size_counter = 0
	item_size_counter = 0

/obj/structure/closet/proc/take_contents()
	for(var/mapped_thing in drop_location())
		if(mapped_thing == src)
			continue
		if(insert(mapped_thing) == CLOSET_INSERT_END) // limit reached
			break

/obj/structure/closet/proc/open(mob/living/user)
	SIGNAL_HANDLER
	if(user)
		UnregisterSignal(user, COMSIG_ATOM_EXITED)
	if(opened || !can_open(user))
		return FALSE
	opened = TRUE
	density = FALSE
	dump_contents()
	update_icon()
	playsound(loc, open_sound, 15, 1)
	return TRUE

/obj/structure/closet/proc/insert(atom/movable/thing_to_insert)
	if(length(contents) >= storage_capacity)
		return CLOSET_INSERT_END
	if(!thing_to_insert.closet_insertion_allowed(src))
		return CLOSET_INSERT_FAIL
	thing_to_insert.forceMove(src)
	return CLOSET_INSERT_SUCCESS

/obj/structure/closet/proc/close(mob/living/user)
	if(!opened || !can_close(user))
		return FALSE
	take_contents()
	playsound(loc, close_sound, 15, 1)
	opened = FALSE
	density = TRUE
	update_icon()
	return TRUE

/obj/structure/closet/proc/toggle(mob/living/user)
	return opened ? close(user) : open(user)

/obj/structure/closet/attack_animal(mob/living/user)
	if(user.wall_smash)
		balloon_alert_to_viewers("[user] destroys the [src]")
		dump_contents()
		qdel(src)

/obj/structure/closet/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	. = ..()
	if(!.)
		return
	if(xeno_attacker.a_intent == INTENT_HARM && !opened && prob(70))
		break_open()

/obj/structure/closet/attackby(obj/item/I, mob/user, params)
	if(user in src)
		return FALSE
	if(I.item_flags & ITEM_ABSTRACT)
		return FALSE
	. = ..()
	if(opened)
		if(.)
			return TRUE
		return user.transferItemToLoc(I, drop_location())

	if(user.get_idcard())
		if(!togglelock(user, TRUE))
			toggle(user)

/obj/structure/closet/attack_powerloader(mob/living/user, obj/item/powerloader_clamp/attached_clamp)
	. = ..()
	if(.)
		return

	if(!attached_clamp.loaded && mob_size_counter)
		balloon_alert(user, "Can't, creature is inside")
		return

/obj/structure/closet/welder_act(mob/living/user, obj/item/tool/weldingtool/welder)
	if(!can_be_welded)
		return FALSE
	if(!welder.isOn())
		return FALSE

	if(opened)
		if(!welder.use_tool(src, user, 2 SECONDS, 1, 50))
			balloon_alert(user, "Need more welding fuel")
			return TRUE
		balloon_alert_to_viewers("\The [src] is cut apart by [user]!")
		deconstruct()
		return TRUE

	if(!welder.use_tool(src, user, 2 SECONDS, 1, 50))
		balloon_alert(user, "Need more welding fuel")
		return TRUE
	welded = !welded
	update_icon()
	balloon_alert_to_viewers("[src] has been [welded ? "welded shut" : "unwelded"]")
	return TRUE

/obj/structure/closet/wrench_act(mob/living/user, obj/item/tool/wrench/wrenchy_tool)
	if(opened)
		return FALSE
	if(isspaceturf(loc) && !anchored)
		balloon_alert(user, "Need firmer floor")
		return TRUE
	setAnchored(!anchored)
	wrenchy_tool.play_tool_sound(src, 75)
	balloon_alert_to_viewers("[user] [anchored ? "anchors" : "unanchors"] the [src]")
	return TRUE

/obj/structure/closet/relaymove(mob/user, direct)
	if(!isturf(loc))
		return
	if(user.incapacitated(TRUE))
		return
	if(!direct)
		return

	user.changeNext_move(5)

	if(open())
		return

	balloon_alert(user, "Won't budge")
	if(!lastbang)
		lastbang = TRUE
		for(var/mob/M in hearers(src, null))
			to_chat(M, "<FONT size=[max(0, 5 - get_dist(src, M))]>BANG, bang!</FONT>")
		addtimer(VARSET_CALLBACK(src, lastbang, FALSE), 3 SECONDS)

/obj/structure/closet/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(user.get_idcard() && locked)
		togglelock(user, TRUE)
	else
		toggle(user)

/obj/structure/closet/attack_hand_alternate(mob/user)
	. = ..()
	if(.)
		return
	if(opened)
		toggle(user)
	else if(user.get_idcard())
		togglelock(user, TRUE)

/obj/structure/closet/update_icon_state()//Putting the welded stuff in updateicon() so it's easy to overwrite for special cases (Fridges, cabinets, and whatnot)
	. = ..()
	if(!opened)
		icon_state = icon_closed
	else
		icon_state = icon_opened

/obj/structure/closet/update_overlays()
	. = ..()
	if(!opened && welded)
		. += image(icon, overlay_welded)

/obj/structure/closet/resisted_against(datum/source)
	container_resist(source)

/obj/structure/closet/proc/container_resist(mob/living/user)
	if(opened)
		return FALSE
	if(!welded && !locked)
		open()
		return FALSE
	if(user.do_actions) //Already resisting or doing something like it.
		return FALSE
	if(TIMER_COOLDOWN_CHECK(user, COOLDOWN_RESIST))
		return FALSE
	//okay, so the closet is either welded or locked... resist!!!
	user.changeNext_move(CLICK_CD_BREAKOUT)
	TIMER_COOLDOWN_START(user, COOLDOWN_RESIST, CLICK_CD_BREAKOUT)
	balloon_alert_to_viewers("Begins to shake violently", ignored_mobs = user)
	balloon_alert(user, "You push on the door... [DisplayTimeText(breakout_time)] until escape")
	if(!do_after(user, breakout_time, target = src))
		if(!opened) //Didn't get opened in the meatime.
			balloon_alert(user, "You fail to break out of [src]")
		return FALSE
	if(opened || (!locked && !welded) ) //Did get opened in the meatime.
		return TRUE
	balloon_alert_to_viewers("breaks out")
	return bust_open()

/obj/structure/closet/proc/bust_open()
	welded = FALSE //applies to all lockers
	locked = FALSE //applies to critter crates and secure lockers only
	broken = TRUE //applies to secure lockers only
	open()

/obj/structure/closet/proc/break_open()
	if(!opened)
		dump_contents()
		opened = TRUE
		playsound(loc, open_sound, 15, 1) //Could use a more telltale sound for "being smashed open"
		density = FALSE
		welded = FALSE
		update_icon()

/obj/structure/closet/proc/togglelock(mob/living/user, silent)
	if(!CHECK_BITFIELD(closet_flags, CLOSET_IS_SECURE))
		return FALSE
	if(!user.dextrous)
		if(!silent)
			balloon_alert(user, "Not enough dexterity")
		return
	if(opened)
		if(!silent)
			balloon_alert(user, "Close \the [src] first.")
		return
	if(broken)
		if(!silent)
			balloon_alert(user, "Cannot, [src] is broken")
		return FALSE

	if(!allowed(user))
		if(!silent)
			balloon_alert(user, "Access Denied")
		return FALSE

	locked = !locked
	balloon_alert_to_viewers("[locked ? "" : "un"]locked")
	update_icon()
	return TRUE

/obj/structure/closet/contents_explosion(severity)
	. = ..()
	for(var/i in contents)
		var/atom/movable/closet_contents = i
		closet_contents.ex_act(severity)

/obj/structure/closet/proc/closet_special_handling(mob/living/mob_to_stuff)
	return TRUE //We are permisive by default.

//Redefined procs for closets

/atom/movable/proc/closet_insertion_allowed(obj/structure/closet/destination)
	return FALSE

/mob/living/closet_insertion_allowed(obj/structure/closet/destination)
	if(anchored || buckled)
		return FALSE
	if(mob_size + destination.mob_size_counter > destination.mob_storage_capacity * destination.max_mob_size)
		return FALSE
	if(!destination.closet_special_handling(src))
		return FALSE
	destination.mob_size_counter += mob_size
	stop_pulling()
	smokecloak_off()
	destination.RegisterSignal(destination, COMSIG_ATOM_EXITED, TYPE_PROC_REF(/obj/structure/closet, open))
	return TRUE

/obj/closet_insertion_allowed(obj/structure/closet/destination)
	if(!CHECK_BITFIELD(destination.closet_flags, CLOSET_ALLOW_OBJS))
		return FALSE
	if(anchored)
		return FALSE
	if(!CHECK_BITFIELD(destination.closet_flags, CLOSET_ALLOW_DENSE_OBJ) && density)
		return FALSE
	if(move_resist == INFINITY)
		return FALSE
	return TRUE

/obj/structure/closet_insertion_allowed(obj/structure/closet/destination)
	return FALSE

/obj/item/closet_insertion_allowed(obj/structure/closet/destination)
	if(anchored)
		return FALSE
	if(!CHECK_BITFIELD(destination.closet_flags, CLOSET_ALLOW_DENSE_OBJ) && density)
		return FALSE
	if(CHECK_BITFIELD(item_flags, DELONDROP))
		return FALSE
	var/item_size = CEILING(w_class * 0.5, 1)
	if(item_size + destination.item_size_counter > destination.storage_capacity)
		return FALSE
	destination.item_size_counter += item_size
	return TRUE

/mob/living/proc/on_closet_dump(obj/structure/closet/origin)
	SetStun(origin.closet_stun_delay)
	if(!lying_angle && has_status_effect(STATUS_EFFECT_STUN))
		balloon_alert_to_viewers("Gets out of [origin]", ignored_mobs = src)
		balloon_alert(src, "You struggle to get your bearings")

/obj/structure/closet/pred
	icon = 'icons/obj/machines/yautja_machines.dmi'
	icon_state = "closed"

/obj/structure/closet/marine
	name = "marine's locker"
	icon = 'icons/obj/structures/closet.dmi'
	icon_state = "marine_closed"
	icon_closed = "marine_closed"
	icon_opened = "marine_open"
	var/squad // to which squad this closet belongs to

/obj/structure/closet/marine/Initialize()
	. = ..()
	if(squad)
		icon_state = "[squad]_closed"
		icon_closed = "[squad]_closed"
		icon_opened = "[squad]_open"

/obj/structure/closet/marine/PopulateContents()
	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new /obj/item/clothing/mask/rebreather/scarf(src)

/obj/structure/closet/marine/alpha
	name = "alpha equipment locker"
	squad = "alpha"

/obj/structure/closet/marine/alpha/PopulateContents()
	. = ..()
	new /obj/item/radio/headset/mainship/marine/alpha(src)
	new /obj/item/clothing/head/tgmcberet/squad/alpha(src)
	new /obj/item/clothing/head/tgmcberet/squad/alpha/black(src)
	new /obj/item/clothing/mask/bandanna/alpha(src)
	new /obj/item/clothing/head/squad_headband/alpha(src)
	new /obj/item/clothing/under/marine/squad/neck/alpha(src)
	new /obj/effect/spawner/random/misc/plushie/fiftyfifty(src)

/obj/structure/closet/marine/bravo
	name = "bravo equipment locker"
	squad = "bravo"

/obj/structure/closet/marine/bravo/PopulateContents()
	. = ..()
	new /obj/item/radio/headset/mainship/marine/bravo(src)
	new /obj/item/clothing/head/tgmcberet/squad/bravo(src)
	new /obj/item/clothing/head/tgmcberet/squad/bravo/black(src)
	new /obj/item/clothing/mask/bandanna/bravo(src)
	new /obj/item/clothing/head/squad_headband/bravo(src)
	new /obj/item/clothing/under/marine/squad/neck/bravo(src)
	new /obj/effect/spawner/random/misc/plushie/fiftyfifty(src)

/obj/structure/closet/marine/charlie
	name = "charlie equipment locker"
	squad = "charlie"

/obj/structure/closet/marine/charlie/PopulateContents()
	. = ..()
	new /obj/item/radio/headset/mainship/marine/charlie(src)
	new /obj/item/clothing/head/tgmcberet/squad/charlie(src)
	new /obj/item/clothing/head/tgmcberet/squad/charlie/black(src)
	new /obj/item/clothing/mask/bandanna/charlie(src)
	new /obj/item/clothing/head/squad_headband/charlie(src)
	new /obj/item/clothing/under/marine/squad/neck/charile(src)
	new /obj/effect/spawner/random/misc/prizemecha(src)

/obj/structure/closet/marine/delta
	name = "delta equipment locker"
	squad = "delta"

/obj/structure/closet/marine/delta/PopulateContents()
	. = ..()
	new /obj/item/radio/headset/mainship/marine/delta(src)
	new /obj/item/clothing/head/tgmcberet/squad/delta(src)
	new /obj/item/clothing/head/tgmcberet/squad/delta/black(src)
	new /obj/item/clothing/mask/bandanna/delta(src)
	new /obj/item/clothing/head/squad_headband/delta(src)
	new /obj/item/clothing/under/marine/squad/neck/delta(src)
	new /obj/effect/spawner/random/misc/delta(src)

#undef CLOSET_INSERT_END
#undef CLOSET_INSERT_FAIL
#undef CLOSET_INSERT_SUCCESS
