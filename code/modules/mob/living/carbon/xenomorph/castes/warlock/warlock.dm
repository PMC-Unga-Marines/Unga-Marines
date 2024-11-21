/mob/living/carbon/xenomorph/warlock
	caste_base_type = /datum/xeno_caste/warlock
	name = "Warlock"
	desc = "A large, physically frail creature. It hovers in the air and seems to buzz with psychic power."
	icon = 'icons/Xeno/castes/warlock/basic.dmi'
	icon_state = "Warlock Walking"
	effects_icon = 'icons/Xeno/castes/warlock/effects.dmi'
	rouny_icon = 'icons/Xeno/castes/warlock/rouny.dmi'
	bubble_icon = "alienroyal"
	skins = list(
		/datum/xenomorph_skin/warlock/arabian,
		/datum/xenomorph_skin/warlock,
	)
	attacktext = "slashes"
	attack_sound = null
	friendly = "nuzzles"
	wall_smash = FALSE
	health = 320
	maxHealth = 320
	plasma_stored = 1400
	pixel_x = -16
	old_x = -16
	drag_delay = 3
	tier = XENO_TIER_THREE
	upgrade = XENO_UPGRADE_NORMAL
	pass_flags = PASS_LOW_STRUCTURE

	can_walk_zoomed = TRUE

	extract_rewards = list(
		/obj/item/psy_core,
		/obj/item/psy_core,
		/obj/item/psy_core,
	)

/mob/living/carbon/xenomorph/warlock/Initialize(mapload)
	. = ..()
	ammo = GLOB.ammo_list[/datum/ammo/energy/xeno/psy_blast]
	ADD_TRAIT(src, TRAIT_SILENT_FOOTSTEPS, XENO_TRAIT)

/mob/living/carbon/xenomorph/warlock/get_liquid_slowdown()
	return WARLOCK_WATER_SLOWDOWN

/obj/item/psy_core
	name = "\improper warlock materialization core"
	desc = "An operating table able to be transported and deployed for medical procedures."
	icon_state = "warlock_core"
	max_integrity = 300
	flags_item = IS_DEPLOYABLE
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = UNACIDABLE
	var/deployable_item = /obj/structure/barricade/metal/warloc

/obj/item/psy_core/Initialize()
	. = ..()
	AddComponent(/datum/component/deployable_item, deployable_item, 0.5 SECONDS, 0.5 SECONDS)

/obj/structure/barricade/metal/warloc
	icon_state = "warlock"
	max_integrity = 500
	coverage = 100
	barricade_type = "warlock"
	stack_type = null //no material
	can_wire = FALSE
	can_change_dmg_state = FALSE
	resistance_flags = UNACIDABLE|XENO_DAMAGEABLE
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 100, BOMB = 0, BIO = 100, FIRE = 100, ACID = 0)
	///What it deploys into. typecast version of internal_item
	var/obj/structure/barricade/metal/warloc/internal_shield

/obj/structure/barricade/metal/warloc/Initialize(mapload, _internal_item, deployer)
	. = ..()
	if(!_internal_item && !internal_shield)
		return INITIALIZE_HINT_QDEL

	internal_shield = _internal_item

	name = internal_shield.name
	desc = internal_shield.desc

/obj/structure/barricade/metal/warloc/get_internal_item()
	return internal_shield

/obj/structure/barricade/metal/warloc/clear_internal_item()
	internal_shield = null

/obj/structure/barricade/metal/warloc/Destroy()
	if(internal_shield)
		QDEL_NULL(internal_shield)
	var/obj/core = new /obj/item/psy_core
	core.forceMove(get_turf(src))
	return ..()

/obj/structure/barricade/metal/warloc/attempt_barricade_upgrade()
	return //not upgradable

/obj/structure/barricade/metal/warloc/pre_crush_act(mob/living/carbon/xenomorph/charger, datum/action/ability/xeno_action/ready_charge/charge_datum)
	var/fling_dir = REVERSE_DIR(charger.dir)
	var/fling_dist = min(round(CHARGE_SPEED(charge_datum)) * 3)
	var/turf/destination = loc
	var/turf/temp
	for(var/i in 1 to fling_dist)
		temp = get_step(destination, fling_dir)
		if(!temp)
			break
		destination = temp
	if(destination != loc)
		charger.throw_at(destination, fling_dist, 2, src, TRUE)
	playsound(loc, 'sound/effects/meteorimpact.ogg', 80, 1)
	return PRECRUSH_STOPPED
