/obj/item/toy/plush/pig
	name = "pig toy"
	desc = "Captain Dementy! Bring the pigs! Marines demand pigs!."
	icon = 'modular_RUtgmc/icons/obj/items/toy.dmi'
	icon_state = "pig"
	item_state = "pig"
	attack_verb = list("oinks", "grunts")

/obj/item/toy/plush/pig/attack_self(mob/user)
	if(world.time > last_hug_time)
		user.visible_message(span_notice("[user] presses [src]! Oink! "), \
							span_notice("You press [src]. Oink! "))
		last_hug_time = world.time + 50 //5 second cooldown
		playsound(src, 'modular_RUtgmc/sound/items/khryu.ogg', 50)

/obj/item/toy/plush/pig/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, 'modular_RUtgmc/sound/items/khryu.ogg', 50)

/obj/structure/bed/namaz
	name = "Prayer rug"
	desc = "Very halal prayer rug."
	icon = 'modular_RUtgmc/icons/obj/items/priest.dmi'
	icon_state = "namaz"
	buckle_flags = CAN_BUCKLE|BUCKLE_PREVENTS_PULL
	buckle_lying = 0
	buckling_y = 6
	dir = NORTH
	foldabletype = /obj/item/namaz
	accepts_bodybag = FALSE
	base_bed_icon = "namaz"

/obj/item/namaz
	name = "Prayer rug"
	desc = "Very halal prayer rug."
	icon = 'modular_RUtgmc/icons/obj/items/priest.dmi'
	icon_state = "rolled_namaz"
	w_class = WEIGHT_CLASS_SMALL
	var/rollertype = /obj/structure/bed/namaz

/obj/item/namaz/attack_self(mob/user)
	deploy_roller(user, user.loc)

/obj/item/namaz/afterattack(obj/target, mob/user , proximity)
	if(!proximity)
		return
	if(isturf(target))
		var/turf/T = target
		if(!T.density)
			deploy_roller(user, target)

/obj/item/namaz/proc/deploy_roller(mob/user, atom/location)
	var/obj/structure/bed/namaz/R = new rollertype(location)
	user.temporarilyRemoveItemFromInventory(src)
	user.visible_message(span_notice(" [user] puts [R] down."), span_notice(" You put [R] down."))
	qdel(src)

/obj/item/storage/bible/koran
	name = "Koran"
	icon = 'modular_RUtgmc/icons/obj/items/priest.dmi'
	icon_state = "Koran"
	actions_types = list(/datum/action/item_action)
	max_w_class = 3
	storage_slots = 1
	can_hold = list(
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/explosive/grenade,
		/obj/item/explosive/mine,
    )

/obj/item/storage/bible/koran/attack_self(mob/living/carbon/human/activator)
	TIMER_COOLDOWN_START(activator, "KoranSpam", 5 SECONDS)
	if(TIMER_COOLDOWN_CHECK(activator, "Koran"))
		activator.balloon_alert(activator, "Allah has already helped you")
		if(TIMER_COOLDOWN_CHECK(activator, "KoranSpam"))
			activator.adjustBrainLoss(1, TRUE)
			return
		return
	if(!((activator.religion == "Islam (Shia)") || (activator.religion == "Islam (Sunni)")))
		activator.balloon_alert(activator, "Infidels cannot use this")
		return
	if(locate(/obj/structure/bed/namaz, activator.loc))
		activator.say("أَشْهَدُ أَنْ لَا إِلَٰهَ إِلَّا ٱللَّهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا رَسُولُ ٱللَّهِ")
		TIMER_COOLDOWN_START(activator, "Koran", 10 MINUTES)
		if(prob(10))
			explosion(activator, 1, 1, 1, 1, 1)
		if(prob(80))
			activator.heal_limb_damage(50, 50, TRUE)
			activator.adjustCloneLoss(-10)
			activator.playsound_local(loc, 'sound/hallucinations/im_here1.ogg', 50)
	else
		activator.balloon_alert(activator, "This place is not sacred")
