/// Datum for handling the xenomorph mutation menu TGUI
/datum/mutation_menu
	/// The xenomorph using this menu
	var/mob/living/carbon/xenomorph/xeno_owner

/datum/mutation_menu/New(mob/living/carbon/xenomorph/xeno)
	. = ..()
	xeno_owner = xeno

/datum/mutation_menu/ui_interact(mob/user, datum/tgui/ui)
	// Xeno only screen
	if(!isxeno(user))
		return

	// Minions can't access mutations
	var/mob/living/carbon/xenomorph/xeno = user
	if(xeno.xeno_caste.caste_flags & CASTE_IS_A_MINION)
		to_chat(user, span_warning("We are too primitive to understand mutations."))
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MutationMenu")
		ui.open()

/// Checks for xeno access and prevents unconscious / dead xenos from interacting.
/datum/mutation_menu/ui_state(mob/user)
	return GLOB.xeno_state

/// Assets for the UI
/datum/mutation_menu/ui_assets(mob/user)
	. = ..()
	. += get_asset_datum(/datum/asset/spritesheet/mutationmenu)

/// Static data provided once when the ui is opened
/datum/mutation_menu/ui_static_data(mob/living/carbon/xenomorph/xeno)
	. = list()
	.["categories"] = list("Survival", "Attack", "Utility")

/// Dynamic data that updates every tick
/datum/mutation_menu/ui_data(mob/living/carbon/xenomorph/xeno)
	. = list()

	// Minions don't have biomass or mutations
	if(xeno.xeno_caste.caste_flags & CASTE_IS_A_MINION)
		.["biomass"] = 0
		.["max_biomass"] = 0
		.["mutations"] = list()
		.["passive_biomass_gain"] = 0
		return

	.["biomass"] = xeno.biomass
	.["max_biomass"] = 50
	.["mutations"] = get_mutations_data(xeno)

	// Calculate passive biomass gain rate
	var/biomass_gain_rate = 0.0 // Default: no passive gain

	// Check if we're in Valhalla (testing area) - get +50 biomass boost
	var/area/A = get_area(xeno)
	var/is_valhalla = istype(A, /area/centcom/valhalla)

	// Check if generators are corrupted (like psy points system)
	var/has_corrupted_generators = FALSE
	if(GLOB.generators_on_ground > 0) //Prevent division by 0
		// Count corrupted generators for this hive
		var/corrupted_count = 0
		for(var/obj/machinery/power/geothermal/generator in GLOB.machines)
			if(generator.corrupted == xeno.hivenumber && generator.corruption_on)
				corrupted_count++

		// Only accumulate biomass if we have corrupted generators AND marines on ground (like psy points)
		if(corrupted_count > 0 && (length(GLOB.humans_by_zlevel["2"]) > 0.2 * length(GLOB.alive_human_list_faction[FACTION_TERRAGOV])))
			has_corrupted_generators = TRUE

	// Calculate biomass gain rate
	biomass_gain_rate = xeno.biomass_gain_bonus / 60.0 // Psydrain bonus (always works)

	// Add corrupted generators biomass gain if conditions are met
	if(has_corrupted_generators)
		biomass_gain_rate += 1.0 / 60.0 // Base: 1 per minute from corrupted generators

	// Hivemind bonus: +0.5 biomass per minute if hivemind is alive
	var/has_living_hivemind = FALSE
	for(var/mob/living/carbon/xenomorph/hivemind/hivemind AS in GLOB.alive_xeno_list_hive[xeno.hivenumber])
		if(isxenohivemind(hivemind) && !QDELETED(hivemind))
			has_living_hivemind = TRUE
			break

	if(has_living_hivemind)
		biomass_gain_rate += 0.5 / 60.0 // Hivemind bonus: +0.5 per minute

	// Valhalla boost: +99.9 biomass per minute
	if(is_valhalla)
		biomass_gain_rate += 99.9 / 60.0

	// Apply strength trait bonus (1.5x if strength is present)
	if(HAS_TRAIT(xeno, TRAIT_SUPER_STRONG))
		biomass_gain_rate *= 1.5

	.["passive_biomass_gain"] = biomass_gain_rate

/// Get the mutations data for the UI
/datum/mutation_menu/proc/get_mutations_data(mob/living/carbon/xenomorph/xeno)
	var/list/mutations = list()

	mutations += list(
		// Tier 1 - Base mutations (no dependencies)
		list(
			"name" = "Carapace",
			"desc" = "Незначительно увеличивает броню",
			"category" = "Survival",
			"cost" = 5,
			"icon" = "xenobuff_carapace",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_CARAPACE) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ENHANCED_CARAPACE) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_CARAPACE) in xeno.status_effects),
			"tier" = 1,
			"parent" = null,
			"children" = list("Enhanced Carapace"),
			"unlocked" = TRUE,
			"buff_desc" = "+ 2.5 soft armor"
		),
		list(
			"name" = "Regeneration",
			"desc" = "Незначительно увеличивает регенерацию от травы.",
			"category" = "Survival",
			"cost" = 8,
			"icon" = "xenobuff_regeneration",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_REGENERATION) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_RAPID_REGENERATION) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_REGENERATION) in xeno.status_effects),
			"tier" = 1,
			"parent" = null,
			"children" = list("Rapid Regeneration"),
			"unlocked" = TRUE,
			"buff_desc" = "+0.8% health regen"
		),
		// Tier 2 - Advanced mutations (require tier 1)
		list(
			"name" = "Enhanced Carapace",
			"desc" = "Существенно увеличивает броню.",
			"category" = "Survival",
			"cost" = 15,
			"icon" = "xenobuff_carapace",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_ENHANCED_CARAPACE) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_CARAPACE) in xeno.status_effects),
			"tier" = 2,
			"parent" = "Carapace",
			"children" = list("Ultimate Carapace"),
			"unlocked" = (locate(STATUS_EFFECT_UPGRADE_CARAPACE) in xeno.status_effects),
			"buff_desc" = "+ 5 soft armor"
		),
		list(
			"name" = "Rapid Regeneration",
			"desc" = "Существенно увеличивает регенерацию от травы.",
			"category" = "Survival",
			"cost" = 20,
			"icon" = "xenobuff_regeneration",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_RAPID_REGENERATION) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_REGENERATION) in xeno.status_effects),
			"tier" = 2,
			"parent" = "Regeneration",
			"children" = list("Ultimate Regeneration"),
			"unlocked" = (locate(STATUS_EFFECT_UPGRADE_REGENERATION) in xeno.status_effects),
			"buff_desc" = "+1.6% health regen"
		),
		list(
			"name" = "Vampirism",
			"desc" = "Регенерирует мизерную часть здоровья при базовой атаке.",
			"category" = "Survival",
			"cost" = 12,
			"icon" = "xenobuff_vampirism",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_VAMPIRISM) in xeno.status_effects),
			"tier" = 1,
			"parent" = null,
			"children" = list(),
			"unlocked" = TRUE,
			"buff_desc" = "1.6% HP per slash"
		)
	)

	// Attack mutations - Tree structure
	mutations += list(
		// Tier 1 - Base mutations
		list(
			"name" = "Celerity",
			"desc" = "Незначительно увеличивает скорость.",
			"category" = "Attack",
			"cost" = 6,
			"icon" = "xenobuff_attack",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_CELERITY) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ENHANCED_CELERITY) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_CELERITY) in xeno.status_effects),
			"tier" = 1,
			"parent" = null,
			"children" = list("Enhanced Celerity"),
			"unlocked" = TRUE,
			"buff_desc" = "+10% speed"
		),
		list(
			"name" = "Adrenaline",
			"desc" = "Незначительно увеличивает регенерацию плазмы и максимальную ёмкость",
			"category" = "Attack",
			"cost" = 10,
			"icon" = "xenobuff_attack",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_ADRENALINE) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_BERSERKER_RAGE) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_BERSERKER) in xeno.status_effects),
			"tier" = 1,
			"parent" = null,
			"children" = list("Berserker Rage"),
			"unlocked" = TRUE,
			"buff_desc" = "+12% plasma regen + 2% max plasma"
		),
		// Tier 2 - Advanced mutations
		list(
			"name" = "Enhanced Celerity",
			"desc" = "Существенно увеличивает скорость.",
			"category" = "Attack",
			"cost" = 18,
			"icon" = "xenobuff_attack",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_ENHANCED_CELERITY) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_CELERITY) in xeno.status_effects),
			"tier" = 2,
			"parent" = "Celerity",
			"children" = list("Ultimate Celerity"),
			"unlocked" = (locate(STATUS_EFFECT_UPGRADE_CELERITY) in xeno.status_effects),
			"buff_desc" = "+20% speed"
		),
		list(
			"name" = "Berserker Rage",
			"desc" = "Существенно увеличивает регенерацию плазмы и максимальную ёмкость",
			"category" = "Attack",
			"cost" = 25,
			"icon" = "xenobuff_attack",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_BERSERKER_RAGE) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_BERSERKER) in xeno.status_effects),
			"tier" = 2,
			"parent" = "Adrenaline",
			"children" = list("Ultimate Berserker"),
			"unlocked" = (locate(STATUS_EFFECT_UPGRADE_ADRENALINE) in xeno.status_effects),
			"buff_desc" = "+24% plasma regen + 4% max plasma"
		),
		list(
			"name" = "Crush",
			"desc" = "Незначительно увеличивает пробитие базовой атаки",
			"category" = "Attack",
			"cost" = 7,
			"icon" = "xenobuff_generic",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_CRUSH) in xeno.status_effects),
			"tier" = 1,
			"parent" = null,
			"children" = list(),
			"unlocked" = TRUE,
			"buff_desc" = "+ 5 penetration"
		)
	)

	// Utility mutations - Tree structure
	mutations += list(
		// Tier 1 - Base mutations
		list(
			"name" = "Toxin",
			"desc" = "Позволяет вводить небольшое кол-во токсинов при базовой атаке",
			"category" = "Utility",
			"cost" = 4,
			"icon" = "xenobuff_generic",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_TOXIN) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ADVANCED_TOXIN) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_TOXIN) in xeno.status_effects),
			"tier" = 1,
			"parent" = null,
			"children" = list("Advanced Toxin"),
			"unlocked" = TRUE,
			"buff_desc" = "0.5 chosen xenotoxin per slash"
		),
		list(
			"name" = "Pheromones",
			"desc" = "Позволяет выделять слабые феромоны.",
			"category" = "Utility",
			"cost" = 9,
			"icon" = "xenobuff_phero",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_PHERO) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_HIVE_MIND) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_HIVE_MIND) in xeno.status_effects),
			"tier" = 1,
			"parent" = null,
			"children" = list("Hive Mind"),
			"unlocked" = TRUE,
			"buff_desc" = "0.5 pheromone power"
		),
		// Tier 2 - Advanced mutations
		list(
			"name" = "Advanced Toxin",
			"desc" = "Позволяет вводить значительное кол-во токсинов при базовой атаке.",
			"category" = "Utility",
			"cost" = 14,
			"icon" = "xenobuff_generic",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_ADVANCED_TOXIN) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_TOXIN) in xeno.status_effects),
			"tier" = 2,
			"parent" = "Toxin",
			"children" = list("Ultimate Toxin"),
			"unlocked" = (locate(STATUS_EFFECT_UPGRADE_TOXIN) in xeno.status_effects),
			"buff_desc" = "1 chosen xenotoxin per slash"
		),
		list(
			"name" = "Hive Mind",
			"desc" = "Позволяет выделять сильные феромоны.",
			"category" = "Utility",
			"cost" = 22,
			"icon" = "xenobuff_phero",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_HIVE_MIND) in xeno.status_effects) || (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_HIVE_MIND) in xeno.status_effects),
			"tier" = 2,
			"parent" = "Pheromones",
			"children" = list("Ultimate Hive Mind"),
			"unlocked" = (locate(STATUS_EFFECT_UPGRADE_PHERO) in xeno.status_effects),
			"buff_desc" = "1 pheromone power"
		),
		list(
			"name" = "Trail",
			"desc" = "Оставляет кислотный след с некоторым шансом.",
			"category" = "Utility",
			"cost" = 3,
			"icon" = "xenobuff_generic",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_TRAIL) in xeno.status_effects),
			"tier" = 1,
			"parent" = null,
			"children" = list(),
			"unlocked" = TRUE,
			"buff_desc" = "15% acid trail chance"
		)
	)

	// Tier 3 - Ultimate mutations (require tier 2)
	mutations += list(
		// Survival Tier 3
		list(
			"name" = "Ultimate Carapace",
			"desc" = "Максимально увеличивает защиту, делая ксеноморфа практически неуязвимым.",
			"category" = "Survival",
			"cost" = 25,
			"icon" = "xenobuff_carapace",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_CARAPACE) in xeno.status_effects),
			"tier" = 3,
			"parent" = "Enhanced Carapace",
			"children" = list(),
			"unlocked" = (locate(STATUS_EFFECT_UPGRADE_ENHANCED_CARAPACE) in xeno.status_effects),
			"buff_desc" = "+25 armor + 10% damage reduction"
		),
		list(
			"name" = "Ultimate Regeneration",
			"desc" = "Максимально увеличивает регенерацию, позволяя восстанавливаться даже в бою.",
			"category" = "Survival",
			"cost" = 25,
			"icon" = "xenobuff_survival",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_REGENERATION) in xeno.status_effects),
			"tier" = 3,
			"parent" = "Rapid Regeneration",
			"children" = list(),
			"unlocked" = (locate(STATUS_EFFECT_UPGRADE_RAPID_REGENERATION) in xeno.status_effects),
			"buff_desc" = "+2.5% health regen + combat healing"
		),
		// Attack Tier 3
		list(
			"name" = "Ultimate Celerity",
			"desc" = "Максимально увеличивает скорость, делая ксеноморфа молниеносным.",
			"category" = "Attack",
			"cost" = 25,
			"icon" = "xenobuff_attack",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_CELERITY) in xeno.status_effects),
			"tier" = 3,
			"parent" = "Enhanced Celerity",
			"children" = list(),
			"unlocked" = (locate(STATUS_EFFECT_UPGRADE_ENHANCED_CELERITY) in xeno.status_effects),
			"buff_desc" = "+35% speed + dodge chance"
		),
		list(
			"name" = "Ultimate Berserker",
			"desc" = "Максимально увеличивает урон и скорость атаки, делая ксеноморфа смертоносным.",
			"category" = "Attack",
			"cost" = 25,
			"icon" = "xenobuff_attack",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_BERSERKER) in xeno.status_effects),
			"tier" = 3,
			"parent" = "Berserker Rage",
			"children" = list(),
			"unlocked" = (locate(STATUS_EFFECT_UPGRADE_BERSERKER_RAGE) in xeno.status_effects),
			"buff_desc" = "+50% damage + 25% attack speed"
		),
		// Utility Tier 3
		list(
			"name" = "Ultimate Toxin",
			"desc" = "Максимально увеличивает токсичность, делая каждую атаку смертельной.",
			"category" = "Utility",
			"cost" = 25,
			"icon" = "xenobuff_generic",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_TOXIN) in xeno.status_effects),
			"tier" = 3,
			"parent" = "Advanced Toxin",
			"children" = list(),
			"unlocked" = (locate(STATUS_EFFECT_UPGRADE_ADVANCED_TOXIN) in xeno.status_effects),
			"buff_desc" = "2.5 chosen xenotoxin per slash"
		),
		list(
			"name" = "Ultimate Hive Mind",
			"desc" = "Максимально увеличивает силу феромонов, объединяя весь улей.",
			"category" = "Utility",
			"cost" = 25,
			"icon" = "xenobuff_phero",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_ULTIMATE_HIVE_MIND) in xeno.status_effects),
			"tier" = 3,
			"parent" = "Hive Mind",
			"children" = list(),
			"unlocked" = (locate(STATUS_EFFECT_UPGRADE_HIVE_MIND) in xeno.status_effects),
			"buff_desc" = "2 pheromone power + hive coordination"
		)
	)

	return mutations

/// Handle UI actions
/datum/mutation_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	switch(action)
		if("purchase_mutation")
			var/mutation_name = params["mutation_name"]
			purchase_mutation(mutation_name)
			return TRUE

/// Purchase a mutation
/datum/mutation_menu/proc/purchase_mutation(mutation_name)
	if(!xeno_owner)
		to_chat(usr, span_warning("Invalid xenomorph reference!"))
		return

	if(xeno_owner.incapacitated(TRUE))
		to_chat(usr, span_warning("Can't do that right now!"))
		return

	if(xeno_owner.stat == DEAD)
		to_chat(usr, span_warning("You're dead!"))
		return

	// Get the mutation data to check cost
	var/list/mutation_data
	for(var/list/mutation in get_mutations_data(xeno_owner))
		if(mutation["name"] == mutation_name)
			mutation_data = mutation
			break

	if(!mutation_data)
		to_chat(usr, span_warning("Invalid mutation name!"))
		return

	var/required_cost = mutation_data["cost"]
	if(xeno_owner.biomass < required_cost)
		to_chat(usr, span_warning("You don't have enough biomass! You need [required_cost] biomass, but you only have [xeno_owner.biomass]."))
		return

	// Determine which mutation to apply based on name
	var/datum/status_effect/upgrade_to_apply

	switch(mutation_name)
		// Survival mutations
		if("Carapace")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_CARAPACE
		if("Enhanced Carapace")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_ENHANCED_CARAPACE
		if("Regeneration")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_REGENERATION
		if("Rapid Regeneration")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_RAPID_REGENERATION
		if("Vampirism")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_VAMPIRISM
		// Attack mutations
		if("Celerity")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_CELERITY
		if("Enhanced Celerity")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_ENHANCED_CELERITY
		if("Adrenaline")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_ADRENALINE
		if("Berserker Rage")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_BERSERKER_RAGE
		if("Crush")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_CRUSH
		// Utility mutations
		if("Toxin")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_TOXIN
		if("Advanced Toxin")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_ADVANCED_TOXIN
		if("Pheromones")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_PHERO
		if("Hive Mind")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_HIVE_MIND
		if("Trail")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_TRAIL
		// Tier 3 - Ultimate mutations
		if("Ultimate Carapace")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_ULTIMATE_CARAPACE
		if("Ultimate Regeneration")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_ULTIMATE_REGENERATION
		if("Ultimate Celerity")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_ULTIMATE_CELERITY
		if("Ultimate Berserker")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_ULTIMATE_BERSERKER
		if("Ultimate Toxin")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_ULTIMATE_TOXIN
		if("Ultimate Hive Mind")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_ULTIMATE_HIVE_MIND
		else
			return

	// Check if already has this mutation
	var/upgrade = locate(upgrade_to_apply) in xeno_owner.status_effects
	if(upgrade)
		to_chat(usr, span_xenonotice("Existing mutation chosen. No biomass spent."))
		return


	// Remove tier 1 mutation if purchasing tier 2
	var/datum/status_effect/tier1_to_remove
	switch(mutation_name)
		if("Enhanced Carapace")
			tier1_to_remove = locate(STATUS_EFFECT_UPGRADE_CARAPACE) in xeno_owner.status_effects
		if("Rapid Regeneration")
			tier1_to_remove = locate(STATUS_EFFECT_UPGRADE_REGENERATION) in xeno_owner.status_effects
		if("Enhanced Celerity")
			tier1_to_remove = locate(STATUS_EFFECT_UPGRADE_CELERITY) in xeno_owner.status_effects
		if("Berserker Rage")
			tier1_to_remove = locate(STATUS_EFFECT_UPGRADE_ADRENALINE) in xeno_owner.status_effects
		if("Advanced Toxin")
			tier1_to_remove = locate(STATUS_EFFECT_UPGRADE_TOXIN) in xeno_owner.status_effects
		if("Hive Mind")
			tier1_to_remove = locate(STATUS_EFFECT_UPGRADE_PHERO) in xeno_owner.status_effects

	// Tier 3 mutations remove their tier 2 parent
	var/datum/status_effect/tier2_to_remove
	switch(mutation_name)
		if("Ultimate Carapace")
			tier2_to_remove = locate(STATUS_EFFECT_UPGRADE_ENHANCED_CARAPACE) in xeno_owner.status_effects
		if("Ultimate Regeneration")
			tier2_to_remove = locate(STATUS_EFFECT_UPGRADE_RAPID_REGENERATION) in xeno_owner.status_effects
		if("Ultimate Celerity")
			tier2_to_remove = locate(STATUS_EFFECT_UPGRADE_ENHANCED_CELERITY) in xeno_owner.status_effects
		if("Ultimate Berserker")
			tier2_to_remove = locate(STATUS_EFFECT_UPGRADE_BERSERKER_RAGE) in xeno_owner.status_effects
		if("Ultimate Toxin")
			tier2_to_remove = locate(STATUS_EFFECT_UPGRADE_ADVANCED_TOXIN) in xeno_owner.status_effects
		if("Ultimate Hive Mind")
			tier2_to_remove = locate(STATUS_EFFECT_UPGRADE_HIVE_MIND) in xeno_owner.status_effects

	if(tier1_to_remove)
		xeno_owner.remove_status_effect(tier1_to_remove)
	if(tier2_to_remove)
		xeno_owner.remove_status_effect(tier2_to_remove)

	// Apply the mutation
	xeno_owner.biomass -= required_cost
	to_chat(usr, span_xenonotice("Mutation gained: [mutation_name]!"))

	// Remove conflicting mutations (only the specific one being replaced)
	var/datum/status_effect/conflicting_upgrade = locate(upgrade_to_apply) in xeno_owner.status_effects
	if(conflicting_upgrade)
		xeno_owner.remove_status_effect(conflicting_upgrade)
		xeno_owner.upgrades_holder.Remove(conflicting_upgrade.type)

	// Apply new mutation
	xeno_owner.do_jitter_animation(500)
	xeno_owner.apply_status_effect(upgrade_to_apply)
	xeno_owner.upgrades_holder.Add(upgrade_to_apply.type)

	// Log the purchase
	log_game("[key_name(usr)] purchased mutation [mutation_name] for [required_cost] biomass as [xeno_owner]")

	// Update UI
	SStgui.update_uis(src)
