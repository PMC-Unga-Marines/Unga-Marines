//Handles dismemberment
/datum/limb/droplimb(amputation, delete_limb = FALSE, silent = FALSE)
	if(limb_status & LIMB_DESTROYED)
		return FALSE

	if(body_part == CHEST)
		return FALSE

	if(amputation)
		set_limb_flags(LIMB_AMPUTATED|LIMB_DESTROYED)
	else
		set_limb_flags(LIMB_DESTROYED)

	if(owner.species.species_flags & ROBOTIC_LIMBS)
		limb_status |= LIMB_ROBOT

	for(var/i in implants)
		var/obj/item/embedded_thing = i
		embedded_thing.unembed_ourself(TRUE)

	germ_level = 0
	if(hidden)
		hidden.forceMove(owner.loc)
		hidden = null

	// If any organs are attached to this, destroy them
	for(var/c in children)
		var/datum/limb/appendage = c
		appendage.droplimb(amputation, delete_limb, silent)

	//Clear out any internal and external wounds, damage the parent limb
	QDEL_LIST(wounds)
	if(parent && !amputation)
		parent.createwound(CUT, max_damage * 0.25)
	brute_dam = 0
	burn_dam = 0
	limb_wound_status = NONE
	update_bleeding()

	//we reset the surgery related variables
	reset_limb_surgeries()

	var/obj/organ	//Dropped limb object
	switch(body_part)
		if(HEAD)
			if(issynth(owner)) //special head for synth to allow brainmob to talk without an MMI
				organ = new /obj/item/limb/head/synth(owner.loc, owner)
			else if(isrobot(owner))
				organ = new /obj/item/limb/head/robotic(owner.loc, owner)
			else
				organ = new /obj/item/limb/head(owner.loc, owner)
			owner.dropItemToGround(owner.glasses, force = TRUE)
			owner.dropItemToGround(owner.head, force = TRUE)
			owner.dropItemToGround(owner.wear_ear, force = TRUE)
			owner.dropItemToGround(owner.wear_mask, force = TRUE)
			owner.update_hair()
		if(ARM_RIGHT)
			if(limb_status & LIMB_ROBOT)
				organ = new /obj/item/robot_parts/r_arm(owner.loc)
			else
				organ = new /obj/item/limb/r_arm(owner.loc, owner)
		if(ARM_LEFT)
			if(limb_status & LIMB_ROBOT)
				organ = new /obj/item/robot_parts/l_arm(owner.loc)
			else
				organ = new /obj/item/limb/l_arm(owner.loc, owner)
		if(LEG_RIGHT)
			if(limb_status & LIMB_ROBOT)
				organ = new /obj/item/robot_parts/r_leg(owner.loc)
			else
				organ = new /obj/item/limb/r_leg(owner.loc, owner)
		if(LEG_LEFT)
			if(limb_status & LIMB_ROBOT)
				organ = new /obj/item/robot_parts/l_leg(owner.loc)
			else
				organ = new /obj/item/limb/l_leg(owner.loc, owner)
		if(HAND_RIGHT)
			if(!(limb_status & LIMB_ROBOT))
				organ= new /obj/item/limb/r_hand(owner.loc, owner)
			owner.dropItemToGround(owner.gloves, force = TRUE)
			owner.dropItemToGround(owner.r_hand, force = TRUE)
		if(HAND_LEFT)
			if(!(limb_status & LIMB_ROBOT))
				organ= new /obj/item/limb/l_hand(owner.loc, owner)
			owner.dropItemToGround(owner.gloves, force = TRUE)
			owner.dropItemToGround(owner.l_hand, force = TRUE)
		if(FOOT_RIGHT)
			if(!(limb_status & LIMB_ROBOT))
				organ= new /obj/item/limb/r_foot/(owner.loc, owner)
			owner.dropItemToGround(owner.shoes, force = TRUE)
		if(FOOT_LEFT)
			if(!(limb_status & LIMB_ROBOT))
				organ = new /obj/item/limb/l_foot(owner.loc, owner)
			owner.dropItemToGround(owner.shoes, force = TRUE)

	if(delete_limb)
		QDEL_NULL(organ)
	else if(!silent)
		owner.visible_message(span_warning("[owner.name]'s [display_name] flies off in an arc!"),
		span_highdanger("<b>Your [display_name] goes flying off!</b>"),
		span_warning("You hear a terrible sound of ripping tendons and flesh!"), 3)

	if(organ)
		//Throw organs around
		var/lol = pick(GLOB.cardinals)
		step(organ, lol)

	owner.update_body(1, 1)

	// OK so maybe your limb just flew off, but if it was attached to a pair of cuffs then hooray! Freedom!
	release_restraints()

	if(vital)
		owner.death()
	return TRUE

/datum/limb/head/droplimb(amputation, delete_limb = FALSE, silent = FALSE)
	. = ..()
	if(!.)
		return
	if(!(owner.species.species_flags & DETACHABLE_HEAD) && vital)
		owner.set_undefibbable()

/datum/limb/hand/l_hand/droplimb(amputation, delete_limb = FALSE, silent = FALSE)
	. = ..()
	if(!.)
		return
	owner.update_inv_gloves()
