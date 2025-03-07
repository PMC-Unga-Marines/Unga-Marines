/obj/structure/xeno/evotower
	name = "evolution tower"
	desc = "A sickly outcrop from the ground. It seems to ooze a strange chemical that shimmers and warps the ground around it."
	icon = 'icons/Xeno/2x2building.dmi'
	icon_state = "evotower"
	pixel_x = -16
	pixel_y = -16
	obj_integrity = 600
	max_integrity = 600
	xeno_structure_flags = CRITICAL_STRUCTURE|IGNORE_WEED_REMOVAL
	///boost amt to be added per tower per cycle
	var/boost_amount = 0.5

/obj/structure/xeno/evotower/Initialize(mapload, _hivenumber)
	. = ..()
	GLOB.hive_datums[hivenumber].evotowers += src
	set_light(2, 2, LIGHT_COLOR_GREEN)
	SSminimaps.add_marker(src, MINIMAP_FLAG_XENO, image('icons/UI_icons/map_blips.dmi', null, "tower", MINIMAP_BLIPS_LAYER))

/obj/structure/xeno/evotower/Destroy()
	GLOB.hive_datums[hivenumber].evotowers -= src
	return ..()

/obj/structure/xeno/evotower/ex_act(severity)
	take_damage(severity * 2.5, BRUTE, BOMB)

/obj/structure/xeno/psychictower
	name = "Psychic Relay"
	desc = "A sickly outcrop from the ground. It seems to allow for more advanced growth of the Xenomorphs."
	icon = 'icons/Xeno/2x2building.dmi'
	icon_state = "maturitytower"
	pixel_x = -16
	pixel_y = -16
	obj_integrity = 400
	max_integrity = 400
	xeno_structure_flags = CRITICAL_STRUCTURE|IGNORE_WEED_REMOVAL

/obj/structure/xeno/psychictower/Initialize(mapload, _hivenumber)
	. = ..()
	GLOB.hive_datums[hivenumber].psychictowers += src
	set_light(2, 2, LIGHT_COLOR_GREEN)
	SSminimaps.add_marker(src, MINIMAP_FLAG_XENO, image('icons/UI_icons/map_blips.dmi', null, "tower", MINIMAP_BLIPS_LAYER))

/obj/structure/xeno/psychictower/Destroy()
	GLOB.hive_datums[hivenumber].psychictowers -= src
	return ..()

/obj/structure/xeno/psychictower/ex_act(severity)
	take_damage(severity * 2.5, BRUTE, BOMB)

/obj/structure/xeno/pherotower
	name = "Pheromone tower"
	desc = "A resin formation that looks like a small pillar. A faint, weird smell can be perceived from it."
	icon = 'icons/Xeno/1x1building.dmi'
	icon_state = "recoverytower"
	obj_integrity = 400
	max_integrity = 400
	xeno_structure_flags = CRITICAL_STRUCTURE|IGNORE_WEED_REMOVAL
	///The type of pheromone currently being emitted.
	var/datum/aura_bearer/current_aura
	///Strength of pheromones given by this tower.
	var/aura_strength = 5
	///Radius (in tiles) of the pheromones given by this tower.
	var/aura_radius = 32

/obj/structure/xeno/pherotower/Initialize(mapload, _hivenumber)
	. = ..()
	SSminimaps.add_marker(src, MINIMAP_FLAG_XENO, image('icons/UI_icons/map_blips.dmi', null, "phero", MINIMAP_BLIPS_LAYER))
	GLOB.hive_datums[hivenumber].pherotowers += src

	//Pheromone towers start off with recovery.
	current_aura = SSaura.add_emitter(src, AURA_XENO_RECOVERY, aura_radius, aura_strength, -1, FACTION_XENO, hivenumber)
	playsound(src, SFX_ALIEN_DROOL, 25)
	update_icon()

/obj/structure/xeno/pherotower/ex_act(severity)
	take_damage(severity * 2.5, BRUTE, BOMB)

/obj/structure/xeno/pherotower/Destroy()
	GLOB.hive_datums[hivenumber].pherotowers -= src
	QDEL_NULL(current_aura)
	return ..()

// Clicking on the tower brings up a radial menu that allows you to select the type of pheromone that this tower will emit.
/obj/structure/xeno/pherotower/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	var/phero_choice = show_radial_menu(xeno_attacker, src, GLOB.pheromone_images_list, radius = 35, require_near = TRUE)

	if(!phero_choice)
		return

	QDEL_NULL(current_aura)
	current_aura = SSaura.add_emitter(src, phero_choice, aura_radius, aura_strength, -1, FACTION_XENO, hivenumber)
	balloon_alert(xeno_attacker, "[phero_choice]")
	playsound(src, SFX_ALIEN_DROOL, 25)
	update_icon()

/obj/structure/xeno/pherotower/update_icon_state()
	. = ..()
	switch(current_aura.aura_types[1])
		if(AURA_XENO_RECOVERY)
			icon_state = "recoverytower"
			set_light(2, 2, LIGHT_COLOR_BLUE)
		if(AURA_XENO_WARDING)
			icon_state = "wardingtower"
			set_light(2, 2, LIGHT_COLOR_GREEN)
		if(AURA_XENO_FRENZY)
			icon_state = "frenzytower"
			set_light(2, 2, LIGHT_COLOR_RED)
