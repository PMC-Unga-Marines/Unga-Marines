/obj/item/toy
	icon = 'icons/obj/items/toy.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/toys_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/toys_right.dmi',
	)
	throw_speed = 4
	throw_range = 20
	force = 0

/obj/item/toy/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(!CONFIG_GET(flag/fun_allowed))
		return FALSE
	attack_hand(xeno_attacker)

/*
* Balloons
*/
/obj/item/toy/balloon
	name = "water balloon"
	desc = "A translucent balloon. There's nothing in it."
	icon_state = "waterballoon-e"
	worn_icon_state = "balloon-empty"

/obj/item/toy/balloon/Initialize(mapload)
	. = ..()
	var/datum/reagents/R = new/datum/reagents(10)
	reagents = R
	R.my_atom = WEAKREF(src)

/obj/item/toy/balloon/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	return

/obj/item/toy/balloon/afterattack(atom/A as mob|obj, mob/user as mob, proximity)
	if(!proximity)
		return
	if (istype(A, /obj/structure/reagent_dispensers/watertank) && get_dist(src,A) <= 1)
		A.reagents.trans_to(src, 10)
		to_chat(user, span_notice("You fill the balloon with the contents of [A]."))
		desc = "A translucent balloon with some form of liquid sloshing around in it."
		update_icon()

/obj/item/toy/balloon/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/reagent_containers/glass))
		if(!I.reagents)
			return

		if(I.reagents.total_volume < 1)
			to_chat(user, "The [I] is empty.")
			return

		if(I.reagents.has_reagent(/datum/reagent/toxin/acid/polyacid, 1))
			to_chat(user, "The acid chews through the balloon!")
			I.reagents.reaction(user, TOUCH)
			qdel(src)
			return

		desc = "A translucent balloon with some form of liquid sloshing around in it."
		to_chat(user, span_notice("You fill the balloon with the contents of [I]."))
		I.reagents.trans_to(src, 10)
	update_icon()

/obj/item/toy/balloon/throw_impact(atom/hit_atom)
	. = ..()
	if(!.)
		return
	if(src.reagents.total_volume >= 1)
		src.visible_message(span_warning(" The [src] bursts!"),"You hear a pop and a splash.")
		src.reagents.reaction(get_turf(hit_atom), TOUCH)
		for(var/atom/A in get_turf(hit_atom))
			src.reagents.reaction(A, TOUCH)
		src.icon_state = "burst"
		QDEL_IN(src, 5)

/obj/item/toy/balloon/update_icon_state()
	. = ..()
	if(reagents.total_volume)
		icon_state = "waterballoon"
		worn_icon_state = "balloon"
	else
		icon_state = "waterballoon-e"
		worn_icon_state = "balloon-empty"

/obj/item/toy/syndicateballoon
	name = "syndicate balloon"
	desc = "There is a tag on the back that reads \"FUK NT!11!\"."
	throw_speed = 4
	throw_range = 20
	force = 0
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "syndballoon"
	worn_icon_state = "syndballoon"
	w_class = WEIGHT_CLASS_BULKY

/*
* Fake telebeacon
*/
/obj/item/toy/blink
	name = "electronic blink toy game"
	desc = "Blink.  Blink.  Blink. Ages 8 and up."
	icon = 'icons/obj/items/radio.dmi'
	icon_state = "beacon"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/tools_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/tools_right.dmi',
	)
	worn_icon_state = "signaler"

/*
* Fake singularity
*/
/obj/item/toy/spinningtoy
	name = "Gravitational Singularity"
	desc = "\"Singulo\" brand spinning toy."
	icon = 'icons/obj/singularity.dmi'
	icon_state = "singularity_s1"

/*
* Crayons
*/
/obj/item/toy/crayon
	name = "crayon"
	desc = "A colourful crayon. Please refrain from eating it or putting it in your nose."
	icon = 'icons/obj/items/crayons.dmi'
	icon_state = "crayonred"
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("attacks", "colours")
	///RGB
	var/colour = "#FF0000"
	///RGB
	var/shadeColour = "#220000"
	///0 for unlimited uses
	var/uses = 30
	var/instant = 0
	///for updateIcon purposes
	var/colourName = "red"

/*
* Snap pops
*/
/obj/item/toy/snappop
	name = "snap pop"
	desc = "Wow!"
	icon_state = "snappop"
	w_class = WEIGHT_CLASS_TINY

/obj/item/toy/snappop/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_cross),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/item/toy/snappop/throw_impact(atom/hit_atom)
	. = ..()
	if(!.)
		return
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	new /obj/effect/decal/cleanable/ash(src.loc)
	src.visible_message(span_warning(" The [src.name] explodes!"),span_warning(" You hear a snap!"))
	playsound(src, 'sound/effects/snap.ogg', 25, 1)
	qdel(src)

/obj/item/toy/snappop/proc/on_cross(datum/source, atom/movable/H, oldloc, oldlocs)
	SIGNAL_HANDLER
	if(!ishuman(H)) //i guess carp and shit shouldn't set them off
		return
	var/mob/living/carbon/M = H
	if(M.m_intent != MOVE_INTENT_RUN)
		return
	to_chat(M, span_warning("You step on the snap pop!"))

	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(2, 0, src)
	s.start()
	new /obj/effect/decal/cleanable/ash(src.loc)
	visible_message(span_warning(" The [src.name] explodes!"),span_warning(" You hear a snap!"))
	playsound(src, 'sound/effects/snap.ogg', 25, 1)
	qdel(src)

/*
* Water flower
*/
/obj/item/toy/waterflower
	name = "Water Flower"
	desc = "A seemingly innocent sunflower...with a twist."
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "sunflower"
	worn_icon_state = "sunflower"
	var/empty = 0
	flags

/obj/item/toy/waterflower/Initialize(mapload)
	. = ..()
	var/datum/reagents/R = new/datum/reagents(10)
	reagents = R
	R.my_atom = WEAKREF(src)
	R.add_reagent(/datum/reagent/water, 10)

/obj/item/toy/waterflower/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	return

/obj/item/toy/waterflower/afterattack(atom/A as mob|obj, mob/user as mob)

	if (istype(A, /obj/item/storage/backpack ))
		return

	else if (locate (/obj/structure/table, loc))
		return

	else if (istype(A, /obj/structure/reagent_dispensers/watertank) && get_dist(src,A) <= 1)
		A.reagents.trans_to(src, 10)
		to_chat(user, span_notice("You refill your flower!"))
		return

	else if (src.reagents.total_volume < 1)
		empty = 1
		to_chat(user, span_notice("Your flower has run dry!"))
		return

	else
		empty = 0

		var/obj/effect/decal/D = new/obj/effect/decal/(get_turf(src))
		D.name = "water"
		D.icon = 'icons/obj/items/chemistry.dmi'
		D.icon_state = "chempuff"
		D.create_reagents(5)
		reagents.trans_to(D, 1)
		playsound(loc, 'sound/effects/spray3.ogg', 15, 1, 3)

		INVOKE_ASYNC(src, PROC_REF(spray_water), A, D, user)
		return

/obj/item/toy/waterflower/proc/spray_water(atom/our_atom, obj/effect/decal/our_decal, mob/user)
	for(var/i = 0, i < 1, i++)
		step_towards(our_decal, our_atom)
		our_decal.reagents.reaction(get_turf(our_decal))
		for(var/atom/T in get_turf(our_decal))
			our_decal.reagents.reaction(T)
			if(ismob(T) && T:client)
				to_chat(T:client, span_warning("[user] has sprayed you with water!"))
		sleep(0.4 SECONDS)
	qdel(our_decal)

/obj/item/toy/waterflower/examine(mob/user)
	. = ..()
	. += "[reagents.total_volume] units of water left!"

/*
* Mech prizes
*/
/obj/item/toy/prize
	icon_state = "ripleytoy"
	var/cooldown = 0

//all credit to skasi for toy mech fun ideas
/obj/item/toy/prize/attack_self(mob/user as mob)
	if(cooldown < world.time - 8)
		to_chat(user, span_notice("You play with [src]."))
		playsound(user, 'sound/mecha/mechstep.ogg', 15, 1)
		cooldown = world.time

/obj/item/toy/prize/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(loc == user)
		if(cooldown < world.time - 8)
			to_chat(user, span_notice("You play with [src]."))
			playsound(user, 'sound/mecha/mechturn.ogg', 15, 1)
			cooldown = world.time
			return

/obj/item/toy/prize/ripley
	name = "toy ripley"
	desc = "Mini-Mecha action figure! Collect them all! 1/11."

/obj/item/toy/prize/fireripley
	name = "toy firefighting ripley"
	desc = "Mini-Mecha action figure! Collect them all! 2/11."
	icon_state = "fireripleytoy"

/obj/item/toy/prize/deathripley
	name = "toy deathsquad ripley"
	desc = "Mini-Mecha action figure! Collect them all! 3/11."
	icon_state = "deathripleytoy"

/obj/item/toy/prize/gygax
	name = "toy gygax"
	desc = "Mini-Mecha action figure! Collect them all! 4/11."
	icon_state = "gygaxtoy"

/obj/item/toy/prize/durand
	name = "toy durand"
	desc = "Mini-Mecha action figure! Collect them all! 5/11."
	icon_state = "durandprize"

/obj/item/toy/prize/honk
	name = "toy H.O.N.K."
	desc = "Mini-Mecha action figure! Collect them all! 6/11."
	icon_state = "honkprize"

/obj/item/toy/prize/marauder
	name = "toy marauder"
	desc = "Mini-Mecha action figure! Collect them all! 7/11."
	icon_state = "marauderprize"

/obj/item/toy/prize/seraph
	name = "toy seraph"
	desc = "Mini-Mecha action figure! Collect them all! 8/11."
	icon_state = "seraphprize"

/obj/item/toy/prize/mauler
	name = "toy mauler"
	desc = "Mini-Mecha action figure! Collect them all! 9/11."
	icon_state = "maulerprize"

/obj/item/toy/prize/odysseus
	name = "toy odysseus"
	desc = "Mini-Mecha action figure! Collect them all! 10/11."
	icon_state = "odysseusprize"

/obj/item/toy/prize/phazon
	name = "toy phazon"
	desc = "Mini-Mecha action figure! Collect them all! 11/11."
	icon_state = "phazonprize"

/obj/item/toy/inflatable_duck
	name = "inflatable duck"
	desc = "No bother to sink or swim when you can just float!"
	icon_state = "inflatable"
	worn_icon_state = "inflatable"
	icon = 'icons/obj/clothing/belts.dmi'
	equip_slot_flags = ITEM_SLOT_BELT

/obj/item/toy/beach_ball
	name = "beach ball"
	icon_state = "beachball"
	worn_icon_state = "beachball"
	density = FALSE
	anchored = FALSE
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 1
	throw_range = 20

/obj/item/toy/beach_ball/afterattack(atom/target, mob/user)
	user.drop_held_item()
	throw_at(target, throw_range, throw_speed, user)

/obj/item/toy/dice
	name = "d6"
	desc = "A dice with six sides."
	icon = 'icons/obj/items/dice.dmi'
	icon_state = "d66"
	w_class = WEIGHT_CLASS_TINY
	var/sides = 6
	attack_verb = list("dices")

/obj/item/toy/dice/Initialize(mapload)
	. = ..()
	icon_state = "[name][rand(sides)]"

/obj/item/toy/dice/d20
	name = "d20"
	desc = "A dice with twenty sides."
	icon_state = "d2020"
	sides = 20

/obj/item/toy/dice/attack_self(mob/user as mob)
	var/result = rand(1, sides)
	var/comment = ""
	if(sides == 20 && result == 20)
		comment = "Nat 20!"
	else if(sides == 20 && result == 1)
		comment = "Ouch, bad luck."
	icon_state = "[name][result]"
	user.visible_message(span_notice("[user] throws [src]. It lands on [result]. [comment]"), \
						span_notice("You throw [src]. It lands on a [result]. [comment]"), \
						span_notice("You hear [src] landing on a [result]. [comment]"))

/obj/item/toy/bikehorn
	name = "bike horn"
	desc = "A horn off of a bicycle."
	icon = 'icons/obj/items/items.dmi'
	icon_state = "bike_horn"
	worn_icon_state = "bike_horn"
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 15
	attack_verb = list("HONKS")

/obj/item/toy/bikehorn/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, 'sound/items/bikehorn.ogg', 50)

/obj/item/toy/plush
	name = "generic doll"
	desc = "An odd looking doll, it has a tag that reads: 'if found please return to coder.'"
	w_class = WEIGHT_CLASS_TINY
	icon_state = "debug"
	attack_verb = list("thumps", "whomps", "bumps")
	/// What was the last time we touch it?
	var/last_hug_time
	/// What sound should we play as squeak?
	var/squeak_sound = 'sound/items/dollsqueak.ogg'
	/// How loud is the squeak?
	var/squeak_volume = 50

/obj/item/toy/plush/attack_self(mob/user)
	if(world.time > last_hug_time)
		user.visible_message(span_notice("[user] hugs [src]! How cute!"), \
			span_notice("You hug [src]. Dawwww..."))
		last_hug_time = world.time + 5 SECONDS
		playsound(src, squeak_sound, 50)

/obj/item/toy/plush/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, squeak_sound, squeak_volume)

/obj/item/toy/plush/farwa
	name = "Farwa plush doll"
	desc = "A Farwa plush doll. It's soft and comforting!"
	w_class = WEIGHT_CLASS_TINY
	icon_state = "farwaplush"

/obj/item/toy/plush/therapy_red
	name = "red therapy doll"
	desc = "A toy for therapeutic and recreational purposes. This one is red."
	icon_state = "therapyred"
	w_class = WEIGHT_CLASS_TINY

/obj/item/toy/plush/therapy_purple
	name = "purple therapy doll"
	desc = "A toy for therapeutic and recreational purposes. This one is purple."
	icon_state = "therapypurple"
	w_class = WEIGHT_CLASS_TINY

/obj/item/toy/plush/therapy_blue
	name = "blue therapy doll"
	desc = "A toy for therapeutic and recreational purposes. This one is blue."
	icon_state = "therapyblue"
	w_class = WEIGHT_CLASS_TINY

/obj/item/toy/plush/therapy_yellow
	name = "yellow therapy doll"
	desc = "A toy for therapeutic and recreational purposes. This one is yellow."
	icon_state = "therapyyellow"
	w_class = WEIGHT_CLASS_TINY

/obj/item/toy/plush/therapy_orange
	name = "orange therapy doll"
	desc = "A toy for therapeutic and recreational purposes. This one is orange."
	icon_state = "therapyorange"
	w_class = WEIGHT_CLASS_TINY

/obj/item/toy/plush/therapy_green
	name = "green therapy doll"
	desc = "A toy for therapeutic and recreational purposes. This one is green."
	icon_state = "therapygreen"
	w_class = WEIGHT_CLASS_TINY

/obj/item/toy/plush/carp
	name = "carp plushie"
	desc = "An adorable stuffed toy that resembles a carp."
	icon_state = "carpplush"
	worn_icon_state = "carp_plushie"
	attack_verb = list("bites", "eats", "fin slaps")

/obj/item/toy/plush/lizard
	name = "lizard plushie"
	desc = "An adorable stuffed toy that resembles a lizard."
	icon_state = "lizplush"
	worn_icon_state = "lizplush"
	attack_verb = list("claws", "hisses", "tail slaps")

/obj/item/toy/plush/snake
	name = "snake plushie"
	desc = "An adorable stuffed toy that resembles a snake. Not to be mistaken for the real thing."
	icon_state = "snakeplush"
	worn_icon_state = "snakeplush"
	attack_verb = list("bites", "hisses", "tail slaps")

/obj/item/toy/plush/slime
	name = "slime plushie"
	desc = "An adorable stuffed toy that resembles a slime. It is practically just a hacky sack."
	icon_state = "slimeplush"
	worn_icon_state = "slimeplush"
	attack_verb = list("blorbles", "slimes", "absorbs")

/obj/item/toy/plush/moth
	name = "moth plushie"
	desc = "A plushie depicting an adorable mothperson. It's a huggable bug!"
	icon_state = "moffplush"
	worn_icon_state = "moffplush"
	attack_verb = list("flutters", "flaps")

/obj/item/toy/plush/rouny
	name = "rouny plushie"
	desc = "A plushie depicting a rouny, made to commemorate the centenary of the battle of LV-426. Much cuddlier and soft than the real thing."
	icon_state = "rounyplush"
	worn_icon_state = "rounyplush"
	attack_verb = list("slashes", "bites", "pounces")

/obj/item/toy/plush/witch
	name = "witch plushie"
	desc = "A plushie depicting an adorable witch. It likes to steal books."
	icon_state = "marisa"
	worn_icon_state = "marisa"

/obj/item/toy/plush/fairy
	name = "fairy plushie"
	desc = "A plushie depicting an adorable fairy. It's cold to the touch."
	icon_state = "cirno"
	worn_icon_state = "cirno"

/obj/item/toy/plush/royalqueen
	name = "royal queen plushie"
	desc = "A plushie depicting a royal xenomorph queen. Smells faintly of stardust and baguettes, with a tag that has Wee! written on it."
	icon_state = "queenplushie"
	worn_icon_state = "queenplushie"
	attack_verb = list("nuzzles", "bops", "pats")
	squeak_sound = 'sound/items/wee.ogg'
	squeak_volume = 20

/obj/item/toy/plush/gnome
	name = "gnome"
	desc = "A mythological creature that guarded Terra's garden. You wonder why it is here."
	icon_state = "gnome"
	worn_icon_state = "gnome"
	attack_verb = list("kickes", "punches", "pounces")
	squeak_sound = 'sound/items/gnome.ogg'

/obj/item/toy/plush/pig
	name = "pig toy"
	desc = "Captain Dementy! Bring the pigs! Marines demand pigs!."
	icon_state = "pig"
	worn_icon_state = "pig"
	attack_verb = list("oinks", "grunts")
	squeak_sound = 'sound/items/khryu.ogg'

/obj/item/toy/plush/pig/attack_self(mob/user)
	if(world.time > last_hug_time)
		user.visible_message(span_notice("[user] presses [src]! Oink!"), \
			span_notice("You press [src]. Oink!")) // should be a way to decrease copypaste, but no idea how
		last_hug_time = world.time + 5 SECONDS
		playsound(src, squeak_sound, 50)

/obj/item/toy/beach_ball/basketball
	name = "basketball"
	icon_state = "basketball"
	worn_icon_state = "basketball"
	desc = "Here's your chance, do your dance at the Space Jam."
	w_class = WEIGHT_CLASS_BULKY

/obj/structure/hoop
	name = "basketball hoop"
	desc = "Boom, Shakalaka!"
	icon = 'icons/obj/structures/misc.dmi'
	icon_state = "hoop"
	anchored = TRUE
	density = TRUE
	resistance_flags = XENO_DAMAGEABLE
	var/side = ""
	var/id = ""

/obj/structure/hoop/grab_interact(obj/item/grab/grab, mob/user, base_damage = BASE_OBJ_SLAM_DAMAGE, is_sharp = FALSE)
	. = ..()
	if(.)
		return
	if(!isliving(grab.grabbed_thing))
		return
	if(user.a_intent == INTENT_HARM)
		return
	var/mob/living/grabbed_mob = grab.grabbed_thing
	if(user.grab_state <= GRAB_AGGRESSIVE)
		to_chat(user, span_warning("You need a better grip to do that!"))
		return
	grabbed_mob.forceMove(loc)
	grabbed_mob.Paralyze(4 SECONDS)
	for(var/obj/machinery/scoreboard/X in GLOB.machines)
		if(X.id == id)
			X.score(side, 3)// 3 points for dunking a mob
	visible_message(span_danger("[user] dunks [grabbed_mob] into the [src]!"))

/obj/structure/hoop/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(get_dist(src, user) < 2)
		user.transferItemToLoc(I, loc)
		for(var/obj/machinery/scoreboard/X in GLOB.machines)
			if(X.id == id)
				X.score(side)
		visible_message(span_notice("[user] dunks [I] into the [src]!"))

/obj/structure/hoop/CanAllowThrough(atom/movable/mover, turf/target)
	if(istype(mover,/obj/item) && mover.throwing)
		var/obj/item/I = mover
		if(prob(50))
			I.forceMove(loc)
			for(var/obj/machinery/scoreboard/X in GLOB.machines)
				if(X.id == id)
					X.score(side)
					// no break, to update multiple scoreboards
			visible_message(span_notice("Swish! \the [I] lands in \the [src]."), 3)
			return TRUE
		visible_message(span_warning("\the [I] bounces off of \the [src]'s rim!"), 3)
		return FALSE
	return ..()
