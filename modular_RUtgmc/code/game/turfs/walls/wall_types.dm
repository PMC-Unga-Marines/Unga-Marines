/turf/closed/wall
	icon = 'modular_RUtgmc/icons/turf/walls/regular_wall.dmi'

/turf/closed/wall/mainship
	icon = 'modular_RUtgmc/icons/turf/walls/testwall.dmi'

/turf/closed/wall/r_wall
	icon = 'modular_RUtgmc/icons/turf/walls/rwall.dmi'

/turf/closed/wall/r_wall/unmeltable/regular
	icon = 'modular_RUtgmc/icons/turf/walls/regular_wall.dmi'

/turf/closed/wall/mainship/gray
	icon = 'modular_RUtgmc/icons/turf/walls/gwall.dmi'

/turf/closed/shuttle/escapeshuttle
	icon = 'modular_RUtgmc/icons/turf/walls/sulaco.dmi'

/turf/closed/wall/sulaco
	icon = 'modular_RUtgmc/icons/turf/walls/sulaco.dmi'

/turf/closed/wall/indestructible/splashscreen
	icon = 'modular_RUtgmc/icons/misc/title.dmi'

/turf/closed/wall/indestructible/splashscreen/New()
	..()
	if(icon_state == "title_painting1")
		icon_state = "title_painting[rand(0,40)]"

/turf/closed/wall/mineral/sandstone/runed
	name = "sandstone temple wall"
	desc = "A heavy wall of sandstone."
	icon = 'icons/turf/walls/cult.dmi'
	icon_state = "cult-0"
	base_icon_state = "cult"
	walltype = "cult"
	mineral = "runed sandstone"
	color = "#DDB5A4"
	smoothing_behavior = DIAGONAL_SMOOTHING
	smoothing_groups = SMOOTH_GROUP_GENERAL_STRUCTURES
	max_integrity = 9000//Strong, but only available to Hunters, can can still be blown up or melted by boilers.

/turf/closed/wall/mineral/sandstone/runed/attack_alien(mob/living/carbon/xenomorph/user, damage_amount = user.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = "", effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	visible_message("[user] scrapes uselessly against [src] with their claws.")
	return

/turf/closed/wall/huntership
	name = "hunter wall"
	desc = "Nigh indestructible walls that make up the hull of a hunter ship."
	icon = 'modular_RUtgmc/icons/turf/walls/hunter.dmi'
	icon_state = "hunter-0"//DMI specific name
	walltype = "hunter"
	base_icon_state = "hunter"
	resistance_flags = RESIST_ALL

/turf/closed/wall/huntership/destructible
	name = "degraded hunter wall"
	color = "#c5beb4"
	desc = "Ancient beyond measure, these walls make up the hull of a vessel of non human origin. Despite this, they can be felled with plastic explosives like any other opaque blocker."
	resistance_flags = NONE
