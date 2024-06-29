/mob/living/carbon/xenomorph/larva
	hud_possible = list(HEALTH_HUD_XENO, PHEROMONE_HUD, QUEEN_OVERWATCH_HUD, ARMOR_SUNDER_HUD, XENO_DEBUFF_HUD, XENO_FIRE_HUD, XENO_BANISHED_HUD, XENO_BLESSING_HUD, XENO_EVASION_HUD, HUNTER_CLAN, HUNTER_HUD)

	talk_sound = "larva_talk"
	life_value = 0
	default_honor_value = 0

/datum/xeno_caste/larva_predalien
	caste_name = "Predalien Larva"
	display_name = "Predalien Bloody Larva"
	upgrade_name = ""
	caste_desc = "D'awwwww, so cute!"
	caste_type_path = /mob/living/carbon/xenomorph/larva/predalien
	tier = XENO_TIER_ZERO
	upgrade = XENO_UPGRADE_BASETYPE
	wound_type = "larva" //used to match appropriate wound overlays

	gib_anim = "larva_gib_corpse"
	gib_flick = "larva_gib"

	// *** Melee Attacks *** //
	melee_damage = 0

	// *** Speed *** //
	speed = -1.6

	// *** Plasma *** //
	plasma_gain = 1

	// *** Health *** //
	max_health = 50
	crit_health = -25

	// *** Evolution *** //
	evolution_threshold = 50
	evolves_to = list(
		/mob/living/carbon/xenomorph/predalien,
	)

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED|CASTE_INNATE_HEALING
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_RIDE_CRUSHER
	caste_traits = list(TRAIT_CAN_VENTCRAWL)

	// *** Defense *** //
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)

	// *** Minimap Icon *** //
	minimap_icon = "predalien_larva"

	// *** Abilities *** //
	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/xeno_action/xenohide,
	)

	// *** Vent Crawl Parameters *** //
	vent_enter_speed = LARVA_VENT_CRAWL_TIME
	vent_exit_speed = LARVA_VENT_CRAWL_TIME
	silent_vent_crawl = TRUE

/datum/xeno_caste/larva_predalien/young
	upgrade = XENO_UPGRADE_INVALID

/mob/living/carbon/xenomorph/larva/predalien
	icon = 'modular_RUtgmc/icons/Xeno/castes/predalien_larva.dmi'
	icon_state = "Predalien Larva"
	base_icon_state = "Predalien Larva"
	caste_base_type = /mob/living/carbon/xenomorph/larva/predalien

/mob/living/carbon/xenomorph/larva/predalien/Initialize(mapload, mob/living/carbon/xenomorph/oldxeno, h_number)
	. = ..()
	hunter_data.dishonored = TRUE
	hunter_data.dishonored_reason = "An abomination upon the honor of us all!"
	hunter_data.dishonored_set = src
	hud_set_hunter()

// ***************************************
// *********** Name
// ***************************************
/mob/living/carbon/xenomorph/larva/predalien/generate_name()
	name = "[hive.prefix] Predalien Larva ([nicknumber])"

	//Update linked data so they show up properly
	real_name = name
	if(mind)
		mind.name = name //This gives them the proper name in deadchat if they explode on death. It's always the small things

// ***************************************
// *********** Icon
// ***************************************
/mob/living/carbon/xenomorph/larva/predalien/update_icons()
	generate_name()

	color = hive.color

	if(stat == DEAD)
		icon_state = "[base_icon_state] Dead"
	else if(handcuffed)
		icon_state = "[base_icon_state] Cuff"

	else if(lying_angle)
		if((resting || IsSleeping()) && (!IsParalyzed() && !IsUnconscious() && health > 0))
			icon_state = "[base_icon_state] Sleeping"
		else
			icon_state = "[base_icon_state] Stunned"
	else
		icon_state = "[base_icon_state]"
