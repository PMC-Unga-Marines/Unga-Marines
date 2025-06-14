/obj/item/tool/kitchen
	icon = 'icons/obj/items/kitchen_tools.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/kitchen_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/kitchen_right.dmi',
	)

/*
* Utensils
*/
/obj/item/tool/kitchen/utensil
	force = 5
	w_class = WEIGHT_CLASS_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	atom_flags = CONDUCT
	attack_verb = list("attacks", "stabs", "pokes")
	sharp = 0
	/// Is there something on this utensil?
	var/image/loaded

/obj/item/tool/kitchen/utensil/Initialize(mapload)
	. = ..()
	pixel_y = rand(0, 4)

	create_reagents(5)

/obj/item/tool/kitchen/utensil/Destroy()
	QDEL_NULL(loaded)
	return ..()

/obj/item/tool/kitchen/utensil/update_overlays()
	. = ..()
	if(!loaded)
		return
	. += loaded

/obj/item/tool/kitchen/utensil/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M))
		return ..()

	if(user.a_intent != INTENT_HELP)
		return ..()

	if(reagents.total_volume > 0)
		reagents.reaction(M, INGEST)
		reagents.trans_to(M, reagents.total_volume, transfer_to_stomach = TRUE)
		if(M == user)
			visible_message(span_notice("[user] eats some [loaded] from \the [src]."))
			M.reagents.add_reagent(/datum/reagent/consumable/nutriment, 1)
		else
			visible_message(span_notice("[user] feeds [M] some [loaded] from \the [src]"))
			M.reagents.add_reagent(/datum/reagent/consumable/nutriment, 1)
		playsound(M.loc,'sound/items/eatfood.ogg', 15, 1)
		QDEL_NULL(loaded)
		update_appearance(UPDATE_OVERLAYS)
		return
	return ..()

/obj/item/tool/kitchen/utensil/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(!CONFIG_GET(flag/fun_allowed))
		return FALSE
	attack_hand(xeno_attacker)

/obj/item/tool/kitchen/utensil/fork
	name = "fork"
	desc = "It's a fork. Sure is pointy."
	icon_state = "fork"

/obj/item/tool/kitchen/utensil/pfork
	name = "plastic fork"
	desc = "Yay, no washing up to do."
	icon_state = "pfork"

/obj/item/tool/kitchen/utensil/spoon
	name = "spoon"
	desc = "It's a spoon. You can see your own upside-down face in the reflection."
	icon_state = "spoon"
	attack_verb = list("attacks", "pokes")

/obj/item/tool/kitchen/utensil/pspoon
	name = "plastic spoon"
	desc = "It's a plastic spoon. How dull."
	icon_state = "pspoon"
	attack_verb = list("attacks", "pokes")

/*
* Knives
*/
/obj/item/tool/kitchen/utensil/knife
	name = "knife"
	desc = "Can cut through any food."
	icon_state = "knife"
	force = 10
	throwforce = 10
	sharp = IS_SHARP_ITEM_ACCURATE
	edge = 1

/obj/item/tool/kitchen/utensil/knife/attack(target as mob, mob/living/user as mob)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 25, 1, 5)
	return ..()

/obj/item/tool/kitchen/utensil/pknife
	name = "plastic knife"
	desc = "The bluntest of blades."
	icon_state = "pknife"
	force = 10
	throwforce = 10

/*
* Kitchen knives
*/
/obj/item/tool/kitchen/knife
	name = "kitchen knife"
	icon_state = "knife"
	desc = "A general purpose Chef's Knife made by SpaceCook Incorporated. Guaranteed to stay sharp for years to come."
	atom_flags = CONDUCT
	sharp = IS_SHARP_ITEM_ACCURATE
	edge = 1
	force = 10
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 6
	throw_speed = 3
	throw_range = 6
	attack_verb = list("slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")

/obj/item/tool/kitchen/knife/ritual
	name = "ritual knife"
	desc = "The unearthly energies that once powered this blade are now dormant."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "render"

/*
* Bucher's cleaver
*/
/obj/item/tool/kitchen/knife/butcher
	name = "butcher's cleaver"
	icon_state = "butch"
	desc = "A huge thing used for chopping and chopping up meat. This includes clowns and clown-by-products."
	atom_flags = CONDUCT
	force = 35
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 25
	throw_speed = 3
	throw_range = 6
	attack_verb = list("cleaves", "slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")
	sharp = IS_SHARP_ITEM_ACCURATE
	edge = 1
	hitsound = 'sound/weapons/bladeslice.ogg'

/*
* Rolling Pins
*/

/obj/item/tool/kitchen/rollingpin
	name = "rolling pin"
	desc = "Used to knock out the Bartender."
	icon_state = "rolling_pin"
	force = 8
	throwforce = 10
	throw_speed = 2
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("bashes", "batters", "bludgeons", "thrashes", "whacks")

/*
* Trays - Agouri
*/
/obj/item/tool/kitchen/tray
	name = "tray"
	icon = 'icons/obj/items/kitchen_tools.dmi'
	icon_state = "tray"
	desc = "A metal tray to lay food on."
	throwforce = 12
	throwforce = 10
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	atom_flags = CONDUCT
	/// List of things on the tray. - Doohl
	var/list/carrying = list()
	/// WEIGHT_CLASS_TINY == 1, WEIGHT_CLASS_SMALL == 3, WEIGHT_CLASS_NORMAL == 5
	var/max_carry = 10

/obj/item/tool/kitchen/tray/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	// Drop all the things. All of them.
	overlays.Cut()
	for(var/obj/item/I in carrying)
		I.loc = M.loc
		carrying.Remove(I)
		if(isturf(I.loc))
			drop_tray_contents(I)

	var/mob/living/carbon/human/H = M      ///////////////////////////////////// /Let's have this ready for later.

	if(!(user.zone_selected == ("eyes" || "head"))) //////////////hitting anything else other than the eyes
		if(prob(33))
			src.add_mob_blood(H)
			var/turf/location = H.loc
			if (istype(location, /turf))
				location.add_mob_blood(H)     ///Plik plik, the sound of blood

		log_combat(user, M, "attacked", src)

		if(prob(15))
			M.Paralyze(6 SECONDS)
			M.take_limb_damage(3)
		else
			M.take_limb_damage(5)
		if(prob(50))
			playsound(M, 'sound/items/trayhit1.ogg', 25, 1)
			visible_message(span_danger("[user] slams [M] with the tray!"))
			return
		playsound(M, 'sound/items/trayhit2.ogg', 25, 1)  //we applied the damage, we played the sound, we showed the appropriate messages. Time to return and stop the proc
		visible_message(span_danger("[user] slams [M] with the tray!"))

	if(ishuman(M) && ((H.head && (H.head.inventory_flags & COVEREYES) ) || (H.wear_mask && (H.wear_mask.inventory_flags & COVEREYES) ) || (H.glasses && (H.glasses.inventory_flags & COVEREYES) )))
		to_chat(M, span_warning("You get slammed in the face with the tray, against your mask!"))
		if(prob(33))
			add_mob_blood(H)
			if(H.wear_mask)
				H.wear_mask.add_mob_blood(H)
			if(H.head)
				H.head.add_mob_blood(H)
			if(H.glasses && prob(33))
				H.glasses.add_mob_blood(H)
			var/turf/location = H.loc
			if(istype(location, /turf))     //Addin' blood! At least on the floor and item :v
				location.add_mob_blood(H)

		if(prob(50))
			playsound(M, 'sound/items/trayhit1.ogg', 25, 1)
			visible_message(span_danger("[user] slams [M] with the tray!"))
		else
			playsound(M, 'sound/items/trayhit2.ogg', 25, 1)  //sound playin'
			visible_message(span_danger("[user] slams [M] with the tray!"))
		if(prob(10))
			M.Stun(rand(2 SECONDS, 6 SECONDS))
			M.take_limb_damage(3)
			return
		else
			M.take_limb_damage(5)
			return

	else //No eye or head protection, tough luck!
		to_chat(M, span_warning("You get slammed in the face with the tray!"))
		if(prob(33))
			add_mob_blood(M)
			var/turf/location = H.loc
			if (istype(location, /turf))
				location.add_mob_blood(H)

		if(prob(50))
			playsound(M, 'sound/items/trayhit1.ogg', 25, 1)
			visible_message(span_danger("[user] slams [M] in the face with the tray!"))
		else
			playsound(M, 'sound/items/trayhit2.ogg', 25, 1)  //sound playin' again
			visible_message(span_danger("[user] slams [M] in the face with the tray!"))
		if(prob(30))
			M.Stun(rand(4 SECONDS, 8 SECONDS))
			M.take_limb_damage(4)
			return
		else
			M.take_limb_damage(8)
			if(prob(30))
				M.Paralyze(4 SECONDS)

/obj/item/tool/kitchen/tray/var/cooldown = 0	//shield bash cooldown. based on world.time

/obj/item/tool/kitchen/tray/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/tool/kitchen/rollingpin))
		if(cooldown < world.time - 25)
			user.visible_message(span_warning("[user] bashes [src] with [I]!"))
			playsound(user.loc, 'sound/effects/shieldbash.ogg', 25, 1)
			cooldown = world.time

/*
===============~~~~~================================~~~~~====================
=																			=
=  Code for trays carrying things. By Doohl for Doohl erryday Doohl Doohl~  =
=																			=
===============~~~~~================================~~~~~====================
*/

/obj/item/tool/kitchen/tray/proc/calc_carry()
	// calculate the weight of the items on the tray
	var/val = 0 // value to return

	for(var/obj/item/I in carrying)
		if(I.w_class == 1.0)
			val ++
		else if(I.w_class == 2.0)
			val += 3
		else
			val += 5

	return val

/obj/item/tool/kitchen/tray/pickup(mob/user)
	if(!isturf(loc))
		return

	for(var/obj/item/I in loc)
		if( I != src && !I.anchored && !istype(I, /obj/item/clothing/under) && !istype(I, /obj/item/clothing/suit))
			var/add = 0
			if(I.w_class == 1.0)
				add = 1
			else if(I.w_class == 2.0)
				add = 3
			else
				add = 5
			if(calc_carry() + add >= max_carry)
				break

			I.loc = src
			carrying.Add(I)
			overlays += image("icon" = I.icon, "icon_state" = I.icon_state, "layer" = 30 + I.layer)

/obj/item/tool/kitchen/tray/dropped(mob/user)
	. = ..()
	var/mob/living/M
	for(M in src.loc) //to handle hand switching
		return

	var/foundtable = 0
	for(var/obj/structure/table/T in loc)
		foundtable = 1
		break

	overlays.Cut()

	for(var/obj/item/I in carrying)
		I.loc = loc
		carrying.Remove(I)
		if(!foundtable && isturf(loc))
			// if no table, presume that the person just shittily dropped the tray on the ground and made a mess everywhere!
			INVOKE_ASYNC(src, PROC_REF(drop_tray_contents), I)

/obj/item/tool/kitchen/tray/proc/drop_tray_contents(obj/item/our_item)
	for(var/i = 1, i <= rand(1, 2), i++)
		if(!our_item)
			break
		step(our_item, pick(GLOB.cardinals))
		sleep(rand(2,4))
