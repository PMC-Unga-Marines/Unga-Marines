
//chameleon projector
//cloaking device

/obj/item/chameleon
	name = "chameleon-projector"
	icon = 'icons/obj/device.dmi'
	icon_state = "shield0"
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/engineering_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/engineering_right.dmi',
	)
	worn_icon_state = "electronic"
	throwforce = 5
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	var/chameleon_on = FALSE
	var/datum/effect_system/spark_spread/spark_system
	var/chameleon_cooldown

/obj/item/chameleon/Initialize(mapload)
	. = ..()
	spark_system = new
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)

/obj/item/chameleon/Destroy()
	QDEL_NULL(spark_system)
	return ..()

/obj/item/chameleon/dropped(mob/user)
	. = ..()
	disrupt(user)

/obj/item/chameleon/equipped(mob/user, slot)
	. = ..()
	disrupt(user)

/obj/item/chameleon/attack_self(mob/user)
	toggle(user)

/obj/item/chameleon/proc/toggle(mob/user, forced = FALSE)
	if(chameleon_cooldown >= world.time)
		return
	if(!ishuman(user))
		return
	if(chameleon_on)
		if(HAS_TRAIT(user, TRAIT_STEALTH))
			to_chat(user, span_warning("You are already cloaked!"))
			return
		ADD_TRAIT(user, TRAIT_STEALTH, TRAIT_STEALTH)
		user.alpha = 25
		to_chat(user, span_notice("You activate the [src]."))
		spark_system.start()
	else
		REMOVE_TRAIT(user, TRAIT_STEALTH, TRAIT_STEALTH)
		user.alpha = initial(user.alpha)
		to_chat(user, span_notice("You deactivate the [src]."))
		spark_system.start()
	playsound(get_turf(src), 'sound/effects/pop.ogg', 25, 1, 3)
	chameleon_on = !chameleon_on
	if(forced)
		chameleon_cooldown = world.time + 50
		return
	chameleon_cooldown = world.time + 20

/obj/item/chameleon/proc/disrupt(mob/user)
	toggle(user, TRUE)
