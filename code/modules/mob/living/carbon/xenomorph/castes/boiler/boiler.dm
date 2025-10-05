/mob/living/carbon/xenomorph/boiler
	caste_base_type = /datum/xeno_caste/boiler
	name = "Boiler"
	desc = "A huge, grotesque xenomorph covered in glowing, oozing acid slime."
	icon = 'icons/Xeno/castes/boiler/basic.dmi'
	icon_state = "Boiler Walking"
	effects_icon = 'icons/Xeno/castes/boiler/effects.dmi'
	bubble_icon = "alienroyal"
	health = 200
	maxHealth = 200
	plasma_stored = 450
	pixel_x = -16
	mob_size = MOB_SIZE_BIG
	tier = XENO_TIER_THREE
	upgrade = XENO_UPGRADE_NORMAL
	gib_chance = 100
	drag_delay = 6 //pulling a big dead xeno is hard
	skins = list(
		/datum/xenomorph_skin/boiler,
		/datum/xenomorph_skin/boiler/rouny,
	)

/mob/living/carbon/xenomorph/boiler/get_liquid_slowdown()
	return BOILER_WATER_SLOWDOWN

/mob/living/carbon/xenomorph/boiler/Initialize(mapload)
	. = ..()
	ammo = GLOB.ammo_list[/datum/ammo/xeno/boiler_gas/corrosive]

// ***************************************
// *********** Gibbing behaviour
// ***************************************
/mob/living/carbon/xenomorph/boiler/gib()
	visible_message(span_danger("[src] begins to bulge grotesquely, and explodes in a cloud of corrosive gas!"))
	var/datum/effect_system/smoke_spread/xeno/smoke = new /datum/effect_system/smoke_spread/xeno/acid(src)
	smoke.set_up(2, get_turf(src))
	smoke.start()
	return ..()

/mob/living/carbon/xenomorph/boiler/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/boiler/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/boiler/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/boiler/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/boiler/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/boiler/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/boiler/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
