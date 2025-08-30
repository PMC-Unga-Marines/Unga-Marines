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
	.["biomass"] = xeno.biomass
	.["max_biomass"] = 100
	.["shell_chambers"] = length(xeno.hive?.shell_chambers) || 0
	.["spur_chambers"] = length(xeno.hive?.spur_chambers) || 0
	.["veil_chambers"] = length(xeno.hive?.veil_chambers) || 0
	.["mutations"] = get_mutations_data(xeno)

/// Get the mutations data for the UI
/datum/mutation_menu/proc/get_mutations_data(mob/living/carbon/xenomorph/xeno)
	var/list/mutations = list()

	// Survival mutations
	var/shell_chambers = length(xeno.hive?.shell_chambers) || 0
	mutations += list(
		list(
			"name" = "Carapace",
			"desc" = "Increase our armor.",
			"category" = "Survival",
			"cost" = XENO_UPGRADE_COST,
			"icon" = "carapace",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_CARAPACE) in xeno.status_effects),
			"chamber_required" = 1,
			"chambers_built" = shell_chambers
		),
		list(
			"name" = "Regeneration",
			"desc" = "Increase our health regeneration.",
			"category" = "Survival",
			"cost" = XENO_UPGRADE_COST,
			"icon" = "regeneration",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_REGENERATION) in xeno.status_effects),
			"chamber_required" = 1,
			"chambers_built" = shell_chambers
		),
		list(
			"name" = "Vampirism",
			"desc" = "Leech from our attacks.",
			"category" = "Survival",
			"cost" = XENO_UPGRADE_COST,
			"icon" = "vampirism",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_VAMPIRISM) in xeno.status_effects),
			"chamber_required" = 1,
			"chambers_built" = shell_chambers
		)
	)

	// Attack mutations
	var/spur_chambers = length(xeno.hive?.spur_chambers) || 0
	mutations += list(
		list(
			"name" = "Celerity",
			"desc" = "Increase our movement speed.",
			"category" = "Attack",
			"cost" = XENO_UPGRADE_COST,
			"icon" = "celerity",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_CELERITY) in xeno.status_effects),
			"chamber_required" = 1,
			"chambers_built" = spur_chambers
		),
		list(
			"name" = "Adrenaline",
			"desc" = "Increase our plasma regeneration.",
			"category" = "Attack",
			"cost" = XENO_UPGRADE_COST,
			"icon" = "adrenaline",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_ADRENALINE) in xeno.status_effects),
			"chamber_required" = 1,
			"chambers_built" = spur_chambers
		),
		list(
			"name" = "Crush",
			"desc" = "Increase our damage to objects.",
			"category" = "Attack",
			"cost" = XENO_UPGRADE_COST,
			"icon" = "crush",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_CRUSH) in xeno.status_effects),
			"chamber_required" = 1,
			"chambers_built" = spur_chambers
		)
	)

	// Utility mutations
	var/veil_chambers = length(xeno.hive?.veil_chambers) || 0
	mutations += list(
		list(
			"name" = "Toxin",
			"desc" = "Inject neurotoxin into the target.",
			"category" = "Utility",
			"cost" = XENO_UPGRADE_COST,
			"icon" = "toxin",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_TOXIN) in xeno.status_effects),
			"chamber_required" = 1,
			"chambers_built" = veil_chambers
		),
		list(
			"name" = "Pheromones",
			"desc" = "Ability to emit pheromones.",
			"category" = "Utility",
			"cost" = XENO_UPGRADE_COST,
			"icon" = "pheromones",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_PHERO) in xeno.status_effects),
			"chamber_required" = 1,
			"chambers_built" = veil_chambers
		),
		list(
			"name" = "Trail",
			"desc" = "Leave a trail behind.",
			"category" = "Utility",
			"cost" = XENO_UPGRADE_COST,
			"icon" = "trail",
			"available" = TRUE,
			"purchased" = (locate(STATUS_EFFECT_UPGRADE_TRAIL) in xeno.status_effects),
			"chamber_required" = 1,
			"chambers_built" = veil_chambers
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

	if(xeno_owner.biomass < XENO_UPGRADE_COST)
		to_chat(usr, span_warning("You don't have enough biomass! You need [XENO_UPGRADE_COST] biomass, but you only have [xeno_owner.biomass]."))
		return

	// Determine which mutation to apply based on name
	var/datum/status_effect/upgrade_to_apply
	var/list/upgrades_to_remove

	switch(mutation_name)
		if("Carapace")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_CARAPACE
			upgrades_to_remove = GLOB.xeno_survival_upgrades
		if("Regeneration")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_REGENERATION
			upgrades_to_remove = GLOB.xeno_survival_upgrades
		if("Vampirism")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_VAMPIRISM
			upgrades_to_remove = GLOB.xeno_survival_upgrades
		if("Celerity")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_CELERITY
			upgrades_to_remove = GLOB.xeno_attack_upgrades
		if("Adrenaline")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_ADRENALINE
			upgrades_to_remove = GLOB.xeno_attack_upgrades
		if("Crush")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_CRUSH
			upgrades_to_remove = GLOB.xeno_attack_upgrades
		if("Toxin")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_TOXIN
			upgrades_to_remove = GLOB.xeno_utility_upgrades
		if("Pheromones")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_PHERO
			upgrades_to_remove = GLOB.xeno_utility_upgrades
		if("Trail")
			upgrade_to_apply = STATUS_EFFECT_UPGRADE_TRAIL
			upgrades_to_remove = GLOB.xeno_utility_upgrades
		else
			return

	// Check if already has this mutation
	var/upgrade = locate(upgrade_to_apply) in xeno_owner.status_effects
	if(upgrade)
		to_chat(usr, span_xenonotice("Existing mutation chosen. No biomass spent."))
		return

	// Apply the mutation
	xeno_owner.biomass -= XENO_UPGRADE_COST
	to_chat(usr, span_xenonotice("Mutation gained: [mutation_name]!"))

	// Remove conflicting mutations
	for(var/datum/status_effect/S AS in upgrades_to_remove)
		xeno_owner.remove_status_effect(S)
		xeno_owner.upgrades_holder.Remove(S.type)

	// Apply new mutation
	xeno_owner.do_jitter_animation(500)
	xeno_owner.apply_status_effect(upgrade_to_apply)
	xeno_owner.upgrades_holder.Add(upgrade_to_apply.type)

	// Log the purchase
	log_game("[key_name(usr)] purchased mutation [mutation_name] for [XENO_UPGRADE_COST] biomass as [xeno_owner]")

	// Update UI
	SStgui.update_uis(src)
