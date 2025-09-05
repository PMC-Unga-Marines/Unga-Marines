/mob/living/carbon/xenomorph/king
	caste_base_type = /datum/xeno_caste/king
	name = "King"
	desc = "A primordial creature, evolved to smash the hardiest of defences and hunt the hardiest of prey."
	icon = 'icons/Xeno/castes/king/basic.dmi'
	icon_state = "King Walking"
	effects_icon = 'icons/Xeno/castes/king/effects.dmi'
	health = 500
	maxHealth = 500
	plasma_stored = 300
	pixel_x = -16
	mob_size = MOB_SIZE_BIG
	drag_delay = 6
	tier = XENO_TIER_FOUR //King, like queen, doesn't count towards population limit.
	upgrade = XENO_UPGRADE_NORMAL
	bubble_icon = "alienroyal"
	skins = list(
		/datum/xenomorph_skin/king,
		/datum/xenomorph_skin/king/red,
	)
	footstep_type = FOOTSTEP_XENO_STOMPY
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/hijack,
	)

/mob/living/carbon/xenomorph/king/Initialize(mapload)
	. = ..()
	playsound(loc, 'sound/voice/alien/xenos_roaring.ogg', 75, 0)

/mob/living/carbon/xenomorph/king/generate_name()
	var/playtime_mins = client?.get_exp(xeno_caste.caste_name)
	var/prefix = "[hive.prefix ? "[hive.prefix] " : ""][xeno_caste.upgrade_name ? "[xeno_caste.upgrade_name] " : ""]"
	if(!client?.prefs.show_xeno_rank || !client)
		name = prefix + "King ([nicknumber])"
		real_name = name
		if(mind)
			mind.name = name
		return
	switch(playtime_mins)
		if(0 to 300)
			name = prefix + "Young King ([nicknumber])"
		if(301 to 1500)
			name = prefix + "Mature King ([nicknumber])"
		if(1501 to 4200)
			name = prefix + "Elder Emperor ([nicknumber])"
		if(4201 to 9000)
			name = prefix + "Ancient Emperor ([nicknumber])"
		if(9001 to INFINITY)
			name = prefix + "Primal Emperor ([nicknumber])"
		else
			name = prefix + "Young King ([nicknumber])"

	real_name = name
	if(mind)
		mind.name = name

/mob/living/carbon/xenomorph/king/death_cry()
	playsound(loc, 'sound/voice/alien/king_died.ogg', 75, 0)

/mob/living/carbon/xenomorph/king/add_to_hive(datum/hive_status/HS, force = FALSE, prevent_ruler=FALSE)
	. = ..()

	if(HS.living_xeno_ruler)
		return
	if(prevent_ruler)
		return

	HS.update_ruler()

/mob/living/carbon/xenomorph/king/remove_from_hive()
	var/datum/hive_status/hive_removed_from = hive

	. = ..()

	if(hive_removed_from.living_xeno_ruler == src)
		hive_removed_from.set_ruler(null)
		hive_removed_from.update_ruler() //Try to find a successor.

/mob/living/carbon/xenomorph/king/primordial
	upgrade = XENO_UPGRADE_PRIMO

/mob/living/carbon/xenomorph/king/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/king/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/king/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/king/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/king/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/king/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
