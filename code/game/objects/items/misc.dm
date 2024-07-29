/obj/item/phone
	name = "red phone"
	desc = "Should anything ever go wrong..."
	icon = 'icons/obj/items/items.dmi'
	icon_state = "red_phone"
	force = 3
	throwforce = 2
	throw_speed = 1
	throw_range = 4
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("called", "rang")
	hitsound = 'sound/weapons/ring.ogg'

/obj/item/clock
	name = "digital clock"
	desc = "A battery powered clock, able to keep time within about 5 seconds... it was never that accurate."
	icon = 'icons/obj/device.dmi'
	icon_state = "digital_clock"
	force = 3
	throwforce = 2
	throw_speed = 1
	throw_range = 4
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clock/examine(mob/user, distance, infix, suffix)
	. = ..()
	. += "The [src] reads: [GLOB.current_date_string] - [stationTimestamp()]"

/obj/item/bananapeel
	name = "banana peel"
	desc = "A peel from a banana."
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "banana_peel"
	item_state = "banana_peel"
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 4
	throw_range = 20

/obj/item/bananapeel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, 0.4 SECONDS, 0.2 SECONDS)

/obj/item/gift
	name = "gift"
	desc = "A wrapped item."
	icon = 'icons/obj/items/items.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/items/containers_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/containers_right.dmi',
	)
	icon_state = "gift3"
	var/size = 3
	var/obj/item/gift = null
	item_state = "gift"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/staff
	name = "wizards staff"
	desc = "Apparently a staff used by the wizard."
	icon = 'icons/obj/wizard.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/items/toys_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/toys_right.dmi',
	)
	icon_state = "staff"
	force = 3
	throwforce = 5
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("bludgeoned", "whacked", "disciplined")

/obj/item/staff/broom
	name = "broom"
	desc = "Used for sweeping, and flying into the night while cackling. Black cat not included."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "broom"

/obj/item/skub
	desc = "It's skub."
	name = "skub"
	icon = 'icons/obj/items/items.dmi'
	icon_state = "skub"
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("skubbed")

/obj/item/ectoplasm
	name = "ectoplasm"
	desc = "spooky"
	gender = PLURAL
	icon = 'icons/obj/wizard.dmi'
	icon_state = "ectoplasm"

/obj/item/minerupgrade
	name = "miner upgrade"
	desc = "Subtype item, should not exist."
	icon = 'icons/obj/mining_drill.dmi'
	icon_state = "mining_drill_reinforceddisplay"
	w_class = WEIGHT_CLASS_NORMAL
	/// Used to determine the type of upgrade the miner is going to receive. Has to be a string which is defined in miner.dm or it won't work.
	var/uptype

/obj/item/minerupgrade/reinforcement
	name = "reinforced components box"
	desc = "A very folded box of reinforced components, meant to replace weak components used in normal mining wells."
	icon_state = "mining_drill_reinforceddisplay"
	uptype = "reinforced components"

/obj/item/minerupgrade/overclock
	name = "high-efficiency drill"
	desc = "A box with a few pumps and a big drill, meant to replace the standard drill used in normal mining wells for faster extraction."
	icon_state = "mining_drill_overclockeddisplay"
	uptype = "high-efficiency drill"

/obj/item/minerupgrade/automatic
	name = "mining computer"
	desc = "A small computer that can automate mining wells, reducing the need for oversight."
	icon_state = "mining_drill_automaticdisplay"
	uptype = "mining computer"

/obj/item/ai_target_beacon
	name = "AI linked remote targeter"
	desc = "A small set of servos and gears, coupled to a battery, antenna and circuitry. Attach it to a mortar to allow a shipborne AI to remotely target it."
	icon = 'icons/obj/items/items.dmi'
	icon_state = "modkit"

/obj/item/toy/plush/pig
	name = "pig toy"
	desc = "Captain Dementy! Bring the pigs! Marines demand pigs!."
	icon_state = "pig"
	item_state = "pig"
	attack_verb = list("oinks", "grunts")

/obj/item/toy/plush/pig/attack_self(mob/user)
	if(world.time > last_hug_time)
		user.visible_message(span_notice("[user] presses [src]! Oink! "), \
							span_notice("You press [src]. Oink! "))
		last_hug_time = world.time + 50 //5 second cooldown
		playsound(src, 'sound/items/khryu.ogg', 50)

/obj/item/toy/plush/pig/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, 'sound/items/khryu.ogg', 50)

/obj/structure/bed/namaz
	name = "Prayer rug"
	desc = "Very halal prayer rug."
	icon = 'icons/obj/items/priest.dmi'
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
	icon = 'icons/obj/items/priest.dmi'
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
	icon = 'icons/obj/items/priest.dmi'
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

