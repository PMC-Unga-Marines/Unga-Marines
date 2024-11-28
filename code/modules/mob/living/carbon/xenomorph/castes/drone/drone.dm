/mob/living/carbon/xenomorph/drone
	caste_base_type = /datum/xeno_caste/drone
	name = "Drone"
	desc = "An Alien Drone"
	icon = 'icons/Xeno/castes/drone/basic.dmi'
	icon_state = "Drone Walking"
	effects_icon = 'icons/Xeno/castes/drone/effects.dmi'
	rouny_icon = 'icons/Xeno/castes/drone/rouny.dmi'
	bubble_icon = "alien"
	skins = list(
		/datum/xenomorph_skin/drone/king,
		/datum/xenomorph_skin/drone/cyborg,
		/datum/xenomorph_skin/drone,
	)
	health = 120
	maxHealth = 120
	plasma_stored = 350
	tier = XENO_TIER_ONE
	upgrade = XENO_UPGRADE_NORMAL
	pixel_x = -12
	old_x = -12
	pull_speed = -2
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)
	extract_rewards = list(
		/obj/item/stack/sheet/resin/big_stack,
	)

/obj/item/stack/sheet/resin
	name = "resin"
	desc = "Sheets made out of xeno resin."
	singular_name = "resin sheet"
	icon_state = "sheet-resin"
	item_state = "sheet-resin"
	flags_item = NOBLUDGEON
	throwforce = 14
	flags_atom = CONDUCT
	merge_type = /obj/item/stack/sheet/resin
	number_of_extra_variants = 3

/obj/item/stack/sheet/resin/big_stack
	amount = 50

/obj/item/stack/sheet/resin/attack_self(mob/user)
	. = ..()
	create_object(user, new/datum/stack_recipe("resin barricade", /obj/structure/barricade/metal/resin, 5, time = 8 SECONDS, max_per_turf = STACK_RECIPE_ONE_DIRECTIONAL_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_METAL), 1)

/obj/structure/barricade/metal/resin
	name = "resin barricade"
	desc = "Barricade made out of xeno resin."
	icon_state = "resin_0"
	barricade_type = "resin"
	max_integrity = 600
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 100, BOMB = 100, BIO = 100, FIRE = 100, ACID = 100)
	resistance_flags = UNACIDABLE
	can_upgrade = FALSE
