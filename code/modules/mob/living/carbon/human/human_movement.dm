/mob/living/carbon/human/Move(atom/newloc, direction, glide_size_override)
	. = ..()
	if(!.)
		return
	if(interactee)// moving stops any kind of interaction
		unset_interaction()
	if(shoes && !buckled)
		var/obj/item/clothing/shoes/S = shoes
		S.step_action()
	ToTracks(direction)

/mob/living/carbon/human/proc/ToTracks(direction)
	if(lying_angle || buckled && istype(buckled, /obj/structure/bed/chair))
		return

	// Tracking blood
	var/bloodcolor = ""
	var/bloodamount = 0
	if(shoes?.track_blood && shoes?.blood_overlay)
		bloodcolor = shoes.blood_color
		bloodamount = shoes.track_blood
		shoes.track_blood--
	else if(track_blood && feet_blood_color)
		bloodcolor = feet_blood_color
		bloodamount = track_blood
		track_blood--
	if(bloodamount > 0)
		var/turf/turf = get_turf(src)
		turf.AddTracks(/obj/effect/decal/cleanable/blood/tracks/footprints, null, direction, 0, bloodcolor) // Coming
		var/turf/from = get_step(src, REVERSE_DIR(direction))
		from.AddTracks(/obj/effect/decal/cleanable/blood/tracks/footprints, null, 0, direction, bloodcolor) // Going

/mob/living/carbon/human/proc/Process_Cloaking_Router(mob/living/carbon/human/user)
	if(!user.cloaking)
		return
	if(istype(back, /obj/item/storage/backpack/marine/satchel/scout_cloak) )
		Process_Cloaking_Scout(user)
	else if(istype(back, /obj/item/storage/backpack/marine/satchel/scout_cloak/sniper) )
		Process_Cloaking_Sniper(user)

/mob/living/carbon/human/proc/Process_Cloaking_Scout(mob/living/carbon/human/user)
	var/obj/item/storage/backpack/marine/satchel/scout_cloak/S = back
	if(!S.camo_active)
		return
	if(S.camo_last_shimmer > world.time - SCOUT_CLOAK_STEALTH_DELAY) //Shimmer after taking aggressive actions
		alpha = SCOUT_CLOAK_RUN_ALPHA //50% invisible
		S.camo_adjust_energy(src, SCOUT_CLOAK_RUN_DRAIN)
	else if(S.camo_last_stealth > world.time - SCOUT_CLOAK_STEALTH_DELAY) //We have an initial reprieve at max invisibility allowing us to reposition, albeit at a high drain rate
		alpha = SCOUT_CLOAK_STILL_ALPHA //95% invisible
		S.camo_adjust_energy(src, SCOUT_CLOAK_RUN_DRAIN)
	//Walking stealth
	else if(m_intent == MOVE_INTENT_WALK)
		alpha = SCOUT_CLOAK_WALK_ALPHA //80% invisible
		S.camo_adjust_energy(src, SCOUT_CLOAK_WALK_DRAIN)
	//Running and post-attack stealth
	else
		alpha = SCOUT_CLOAK_RUN_ALPHA //50% invisible
		S.camo_adjust_energy(src, SCOUT_CLOAK_RUN_DRAIN)

/mob/living/carbon/human/proc/Process_Cloaking_Sniper(mob/living/carbon/human/user)
	var/obj/item/storage/backpack/marine/satchel/scout_cloak/sniper/S = back
	if(!S.camo_active)
		return
	alpha = initial(alpha) //Sniper variant has *no* mobility stealth, but no drain on movement either

/mob/living/carbon/human/Process_Spacemove()
	if(restrained())
		return FALSE

	return ..()


/mob/living/carbon/human/Process_Spaceslipping(prob_slip = 5)
	//If knocked out we might just hit it and stop.  This makes it possible to get dead bodies and such.

	if(stat)
		prob_slip = 0 // Changing this to zero to make it line up with the comment, and also, make more sense.

	//Do we have magboots or such on if so no slip
	if(istype(shoes, /obj/item/clothing/shoes/magboots) && (shoes.flags_inventory & NOSLIPPING))
		prob_slip = 0

	//Check hands and mod slip
	if(!l_hand)	prob_slip -= 2
	else if(l_hand.w_class <= 2)	prob_slip -= 1
	if (!r_hand)	prob_slip -= 2
	else if(r_hand.w_class <= 2)	prob_slip -= 1

	prob_slip = round(prob_slip)
	return(prob_slip)


/mob/living/carbon/human/Moved(atom/oldloc, direction)
	Process_Cloaking_Router(src)
	// Moving around increases germ_level faster
	if(germ_level < GERM_LEVEL_MOVE_CAP && prob(8))
		germ_level++
	return ..()

/mob/living/carbon/human/return_mob_swap_mode(mob/living/target)
	if(isxeno(target))
		return NO_SWAP
	// the puller can always swap with its victim if on grab intent
	if(target.pulledby == src && a_intent == INTENT_GRAB)
		return SWAPPING
	/* If we're moving diagonally, but the mob isn't on the diagonal destination turf and the destination turf is enterable we have no reason to shuffle/push them
	 * However we also do not want mobs of smaller move forces being able to pass us diagonally if our move resist is larger, unless they're the same faction as us */
	if(moving_diagonally && (get_dir(src, target) in GLOB.cardinals) && get_step(src, dir).Enter(src, loc) && (target.faction == faction || target.move_resist <= move_force))
		return PHASING
	// Restrained people act if they were on 'help' intent to prevent a person being pulled from being seperated from their puller
	else if(a_intent == INTENT_HELP || restrained())
		if(move_force > target.move_resist)
			return SWAPPING
		else if(target.a_intent == INTENT_HELP || target.restrained())
			return SWAPPING
	return NO_SWAP
