#define BARRICADE_METAL_LOOSE 0
#define BARRICADE_METAL_ANCHORED 1
#define BARRICADE_METAL_FIRM 2

#define CADE_UPGRADE_REQUIRED_SHEETS 1

/obj/structure/barricade/solid
	name = "metal barricade"
	desc = "A sturdy and easily assembled barricade made of metal plates, often used for quick fortifications. Use a blowtorch to repair."
	icon_state = "metal_0"
	icon = 'icons/obj/structures/barricades/metal.dmi'
	max_integrity = 200 //4 sheets
	soft_armor = list(MELEE = 10, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 20, BIO = 100, FIRE = 80, ACID = 40)
	coverage = 128
	stack_type = /obj/item/stack/sheet/metal
	stack_amount = 4
	destroyed_stack_amount = 2
	hit_sound = 'sound/effects/metalhit.ogg'
	barricade_type = "metal"
	can_wire = TRUE
	can_upgrade = TRUE
	///Build state of the barricade
	var/build_state = BARRICADE_METAL_FIRM
	///The type of upgrade and corresponding overlay we have attached
	var/barricade_upgrade_type

/obj/structure/barricade/solid/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_SPARKS, -40, 8, 1)

/obj/structure/barricade/solid/update_overlays()
	. = ..()
	if(!barricade_upgrade_type)
		return
	var/damage_state
	var/percentage = (obj_integrity / max_integrity) * 100
	switch(percentage)
		if(-INFINITY to 25)
			damage_state = 3
		if(25 to 50)
			damage_state = 2
		if(50 to 75)
			damage_state = 1
		if(75 to INFINITY)
			damage_state = 0
	switch(barricade_upgrade_type)
		if(CADE_TYPE_BOMB)
			. += image('icons/obj/structures/barricades/upgrades.dmi', icon_state = "+explosive_upgrade_[damage_state]")
		if(CADE_TYPE_MELEE)
			. += image('icons/obj/structures/barricades/upgrades.dmi', icon_state = "+brute_upgrade_[damage_state]")
		if(CADE_TYPE_ACID)
			. += image('icons/obj/structures/barricades/upgrades.dmi', icon_state = "+burn_upgrade_[damage_state]")

/obj/structure/barricade/solid/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/stack/sheet/metal) && obj_integrity >= max_integrity * 0.3)
		return attempt_barricade_upgrade(I, user, params)

	if(!istype(I, stack_type))
		return

	var/obj/item/stack/sheet/material_sheets = stack_type
	material_sheets = I

	if(obj_integrity >= max_integrity * 0.3)
		return

	if(material_sheets.get_amount() < 2)
		balloon_alert(user, "You need at least 2 [material_sheets.name] sheets")
		return FALSE

	if(LAZYACCESS(user.do_actions, src))
		return

	balloon_alert_to_viewers("Repairing base...")

	if(!do_after(user, 2 SECONDS, NONE, src, BUSY_ICON_FRIENDLY))
		return FALSE

	if(get_self_acid())
		balloon_alert(user, "It's melting!")
		return TRUE

	if(!material_sheets.use(2))
		return FALSE

	repair_damage(max_integrity * 0.3, user)
	balloon_alert_to_viewers("Base repaired")
	update_icon()

/obj/structure/barricade/solid/examine(mob/user)
	. = ..()
	switch(build_state)
		if(BARRICADE_METAL_FIRM)
			. += span_info("The protection panel is still tighly screwed in place.")
		if(BARRICADE_METAL_ANCHORED)
			. += span_info("The protection panel has been removed, you can see the anchor bolts.")
		if(BARRICADE_METAL_LOOSE)
			. += span_info("The protection panel has been removed and the anchor bolts loosened. It's ready to be taken apart.")

	. += span_info("It is [barricade_upgrade_type ? "upgraded with [barricade_upgrade_type]" : "not upgraded"].")

/obj/structure/barricade/solid/welder_act(mob/living/user, obj/item/I)
	. = welder_repair_act(user, I, 85, 2.5 SECONDS, 0.3, SKILL_ENGINEER_METAL, 1)
	if(. == BELOW_INTEGRITY_THRESHOLD)
		balloon_alert(user, "Too damaged. Use metal sheets.")

/obj/structure/barricade/solid/screwdriver_act(mob/living/user, obj/item/I)
	if(LAZYACCESS(user.do_actions, src))
		return FALSE
	switch(build_state)
		if(BARRICADE_METAL_ANCHORED) //Protection panel removed step. Screwdriver to put the panel back, wrench to unsecure the anchor bolts
			if(user.skills.getRating(SKILL_CONSTRUCTION) < SKILL_CONSTRUCTION_METAL)
				var/fumbling_time = 1 SECONDS * ( SKILL_CONSTRUCTION_METAL - user.skills.getRating(SKILL_CONSTRUCTION) )
				if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
					return TRUE

			playsound(loc, 'sound/items/screwdriver.ogg', 25, TRUE)
			if(!do_after(user, 1 SECONDS, NONE, src, BUSY_ICON_BUILD))
				return TRUE

			balloon_alert_to_viewers("bolt protection panel replaced")
			build_state = BARRICADE_METAL_FIRM
			return TRUE

		if(BARRICADE_METAL_FIRM) //Fully constructed step. Use screwdriver to remove the protection panels to reveal the bolts
			if(user.skills.getRating(SKILL_CONSTRUCTION) < SKILL_CONSTRUCTION_METAL)
				var/fumbling_time = 1 SECONDS * ( SKILL_CONSTRUCTION_METAL - user.skills.getRating(SKILL_CONSTRUCTION) )
				if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
					return TRUE

			playsound(loc, 'sound/items/screwdriver.ogg', 25, TRUE)

			if(!do_after(user, 1 SECONDS, NONE, src, BUSY_ICON_BUILD))
				return TRUE

			balloon_alert_to_viewers("bolt protection panel removed")
			build_state = BARRICADE_METAL_ANCHORED
			return TRUE

/obj/structure/barricade/solid/wrench_act(mob/living/user, obj/item/I)
	if(LAZYACCESS(user.do_actions, src))
		return FALSE
	switch(build_state)
		if(BARRICADE_METAL_ANCHORED) //Protection panel removed step. Screwdriver to put the panel back, wrench to unsecure the anchor bolts
			if(user.skills.getRating(SKILL_CONSTRUCTION) < SKILL_CONSTRUCTION_METAL)
				var/fumbling_time = 1 SECONDS * ( SKILL_CONSTRUCTION_METAL - user.skills.getRating(SKILL_CONSTRUCTION) )
				if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
					return TRUE

			playsound(loc, 'sound/items/ratchet.ogg', 25, TRUE)
			if(!do_after(user, 1 SECONDS, NONE, src, BUSY_ICON_BUILD))
				return TRUE

			balloon_alert_to_viewers("anchor bolts loosened")
			build_state = BARRICADE_METAL_LOOSE
			anchored = FALSE
			modify_max_integrity(initial(max_integrity) * 0.5)
			update_icon() //unanchored changes layer
			return TRUE

		if(BARRICADE_METAL_LOOSE) //Anchor bolts loosened step. Apply crowbar to unseat the panel and take apart the whole thing. Apply wrench to resecure anchor bolts

			var/turf/mystery_turf = get_turf(src)
			if(!isopenturf(mystery_turf))
				balloon_alert(user, "can't anchor here")
				return TRUE

			var/turf/open/T = mystery_turf
			if(!T.allow_construction) //We shouldn't be able to anchor in areas we're not supposed to build; loophole closed.
				balloon_alert(user, "can't anchor here")
				return TRUE

			if(user.skills.getRating(SKILL_CONSTRUCTION) < SKILL_CONSTRUCTION_METAL)
				var/fumbling_time = 1 SECONDS * ( SKILL_CONSTRUCTION_METAL - user.skills.getRating(SKILL_CONSTRUCTION) )
				if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
					return TRUE

			for(var/obj/structure/barricade/B in loc)
				if(B != src && B.dir == dir)
					balloon_alert(user, "already barricade here")
					return TRUE

			playsound(loc, 'sound/items/ratchet.ogg', 25, TRUE)
			if(!do_after(user, 1 SECONDS, NONE, src, BUSY_ICON_BUILD))
				return TRUE

			balloon_alert_to_viewers("anchor bolts secured")
			build_state = BARRICADE_METAL_ANCHORED
			anchored = TRUE
			modify_max_integrity(initial(max_integrity))
			update_icon() //unanchored changes layer
			return TRUE

/obj/structure/barricade/solid/crowbar_act(mob/living/user, obj/item/I)
	if(LAZYACCESS(user.do_actions, src))
		return FALSE
	switch(build_state)
		if(BARRICADE_METAL_LOOSE) //Anchor bolts loosened step. Apply crowbar to unseat the panel and take apart the whole thing. Apply wrench to resecure anchor bolts
			if(user.skills.getRating(SKILL_CONSTRUCTION) < SKILL_CONSTRUCTION_METAL)
				var/fumbling_time = 5 SECONDS * ( SKILL_CONSTRUCTION_METAL - user.skills.getRating(SKILL_CONSTRUCTION) )
				if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
					return TRUE

			balloon_alert_to_viewers("disassembling")

			playsound(loc, 'sound/items/crowbar.ogg', 25, 1)
			if(!do_after(user, 5 SECONDS, NONE, src, BUSY_ICON_BUILD))
				return TRUE

			user.visible_message(span_notice("[user] takes [src]'s panels apart."),
			span_notice("You take [src]'s panels apart."))
			playsound(loc, 'sound/items/deconstruct.ogg', 25, 1)
			deconstruct(!get_self_acid())
			return TRUE
		if(BARRICADE_METAL_FIRM)

			if(!barricade_upgrade_type) //Check to see if we actually have upgrades to remove.
				balloon_alert(user, "no upgrades to remove")
				return TRUE

			if(user.skills.getRating(SKILL_CONSTRUCTION) < SKILL_CONSTRUCTION_METAL)
				var/fumbling_time = 5 SECONDS * ( SKILL_CONSTRUCTION_METAL - user.skills.getRating(SKILL_CONSTRUCTION) )
				if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
					return TRUE

			balloon_alert_to_viewers("removing armor plates")

			playsound(loc, 'sound/items/crowbar.ogg', 25, 1)
			if(!do_after(user, 5 SECONDS, NONE, src, BUSY_ICON_BUILD))
				return TRUE

			balloon_alert_to_viewers("removed armor plates")
			playsound(loc, 'sound/items/deconstruct.ogg', 25, 1)

			switch(barricade_upgrade_type)
				if(CADE_TYPE_BOMB)
					soft_armor = soft_armor.modifyRating(bomb = -80)
				if(CADE_TYPE_MELEE)
					soft_armor = soft_armor.modifyRating(melee = -40, bullet = -50, laser = -50, energy = -50, acid = 10)
				if(CADE_TYPE_ACID)
					soft_armor = soft_armor.modifyRating(melee = 10, acid = -40)
					resistance_flags &= ~UNACIDABLE

			new /obj/item/stack/sheet/metal(loc, CADE_UPGRADE_REQUIRED_SHEETS)
			barricade_upgrade_type = null
			update_icon()
			return TRUE

/obj/structure/barricade/solid/proc/attempt_barricade_upgrade(obj/item/stack/sheet/metal/metal_sheets, mob/user, params)
	if(!can_upgrade)
		return FALSE
	if(barricade_upgrade_type)
		balloon_alert(user, "Already upgraded")
		return FALSE
	if(obj_integrity < max_integrity)
		balloon_alert(user, "It needs to be at full health")
		return FALSE

	if(metal_sheets.get_amount() < CADE_UPGRADE_REQUIRED_SHEETS)
		balloon_alert(user, "You need at least [CADE_UPGRADE_REQUIRED_SHEETS] metal to upgrade")
		return FALSE

	var/static/list/cade_types = list(
		CADE_TYPE_BOMB = image(icon = 'icons/obj/structures/barricades/upgrades.dmi',icon_state = "explosive_obj"),
		CADE_TYPE_MELEE = image(icon = 'icons/obj/structures/barricades/upgrades.dmi', icon_state = "brute_obj"),
		CADE_TYPE_ACID = image(icon = 'icons/obj/structures/barricades/upgrades.dmi', icon_state = "burn_obj")
	)
	var/choice = show_radial_menu(user, src, cade_types, require_near = TRUE, tooltips = TRUE)

	if(!choice)
		return

	if(user.skills.getRating(SKILL_CONSTRUCTION) < SKILL_CONSTRUCTION_METAL)
		balloon_alert_to_viewers("fumbles")
		var/fumbling_time = 2 SECONDS * ( SKILL_CONSTRUCTION_METAL - user.skills.getRating(SKILL_CONSTRUCTION) )
		if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
			return FALSE

	balloon_alert_to_viewers("attaching [choice]")
	if(!do_after(user, 2 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return FALSE

	if(!metal_sheets.use(CADE_UPGRADE_REQUIRED_SHEETS))
		return FALSE

	switch(choice)
		if(CADE_TYPE_BOMB)
			soft_armor = soft_armor.modifyRating(bomb = 80)
		if(CADE_TYPE_MELEE)
			soft_armor = soft_armor.modifyRating(melee = 40, bullet = 50, laser = 50, energy = 50, acid = -10)
		if(CADE_TYPE_ACID)
			soft_armor = soft_armor.modifyRating(melee = -10, acid = 40)
			resistance_flags |= UNACIDABLE

	barricade_upgrade_type = choice

	balloon_alert_to_viewers("[choice] attached")

	playsound(loc, 'sound/items/screwdriver.ogg', 25, TRUE)
	update_icon()

/obj/structure/barricade/solid/deployable
	icon_state = "folding_0"
	icon = 'icons/obj/structures/barricades/folding.dmi'
	max_integrity = 300
	coverage = 100
	barricade_type = "folding"
	can_wire = TRUE
	is_wired = FALSE
	soft_armor = list(MELEE = 35, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 25, BIO = 100, FIRE = 100, ACID = 30)
	can_upgrade = FALSE
	///Whether this item can be deployed or undeployed
	var/item_flags = IS_DEPLOYABLE
	///What it deploys into. typecast version of internal_item
	var/obj/item/weapon/shield/riot/marine/deployable/internal_shield

/obj/structure/barricade/solid/deployable/Initialize(mapload, _internal_item, deployer)
	. = ..()
	if(!_internal_item && !internal_shield)
		return INITIALIZE_HINT_QDEL

	internal_shield = _internal_item

	name = internal_shield.name
	desc = internal_shield.desc
	//if the shield is wired, it deploys wired
	if(internal_shield.is_wired)
		can_wire = FALSE
		is_wired = TRUE
		climbable = FALSE

/obj/structure/barricade/solid/deployable/get_internal_item()
	return internal_shield

/obj/structure/barricade/solid/deployable/clear_internal_item()
	internal_shield = null

/obj/structure/barricade/solid/deployable/Destroy()
	if(internal_shield)
		QDEL_NULL(internal_shield)
	return ..()

/obj/structure/barricade/solid/deployable/MouseDrop(over_object, src_location, over_location)
	if(!ishuman(usr))
		return
	var/mob/living/carbon/human/user = usr
	if(over_object != user || !in_range(src, user) || user.incapacitated() || user.lying_angle)
		return
	disassemble(user)

/obj/structure/barricade/solid/deployable/wire()
	. = ..()
	//makes the shield item wired as well
	internal_shield.is_wired = TRUE
	internal_shield.modify_max_integrity(max_integrity + 50)

/obj/structure/barricade/solid/plasteel
	name = "plasteel barricade"
	desc = "A sturdy and heavily assembled barricade made of plasteel plates. Use a blowtorch to repair."
	icon_state = "new_plasteel_0"
	icon = 'icons/obj/structures/barricades/new_plasteel.dmi'
	max_integrity = 550 //4 sheets
	soft_armor = list(MELEE = 0, BULLET = 45, LASER = 45, ENERGY = 45, BOMB = 35, BIO = 100, FIRE = 80, ACID = 55)
	stack_type = /obj/item/stack/sheet/plasteel
	stack_amount = 4
	destroyed_stack_amount = 2
	hit_sound = 'sound/effects/metalhit.ogg'
	barricade_type = "new_plasteel"
	can_wire = TRUE
	can_upgrade = FALSE
	resistance_flags = UNACIDABLE|XENO_DAMAGEABLE

/obj/structure/barricade/solid/handrail
	resistance_flags = INDESTRUCTIBLE
	icon_state = "handrail_strata"
	name = "handrail"
	barricade_type = "handrail"
	icon = 'icons/obj/structures/barricades/misc.dmi'

#undef BARRICADE_METAL_LOOSE
#undef BARRICADE_METAL_ANCHORED
#undef BARRICADE_METAL_FIRM

#undef CADE_UPGRADE_REQUIRED_SHEETS
