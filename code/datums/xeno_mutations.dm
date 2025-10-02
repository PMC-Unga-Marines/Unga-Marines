/datum/xeno_mutation
	var/name = "Unknown Mutation"
	var/desc = "A mysterious mutation"
	var/category = "Survival"
	var/cost = 0
	var/icon_state

	///Тир, очередь в дереве, 1 если дерева нет
	var/tier = 1
	///Предыдущая мутация в дереве
	var/parent_name
	///Следующая мутация в дереве
	var/child_name
	///Статус эффект, который мутация применяет (бафф)
	var/status_effect_type
	///Описание баффа, желательно числа и цифры
	var/buff_desc = ""
	///Касты, которым будет доступна данная мутация
	var/list/caste_restrictions = list()


/datum/xeno_mutation/proc/is_available(mob/living/carbon/xenomorph/xeno)
	if(length(caste_restrictions) > 0)
		var/current_caste = lowertext(xeno.xeno_caste.caste_name)
		return current_caste in caste_restrictions
	return TRUE

/datum/xeno_mutation/proc/is_purchased(mob/living/carbon/xenomorph/xeno)
	if(name in xeno.purchased_mutations)
		return TRUE
	return is_higher_tier_purchased(xeno)

/datum/xeno_mutation/proc/is_higher_tier_purchased(mob/living/carbon/xenomorph/xeno)
	if(child_name && (child_name in xeno.purchased_mutations))
		return TRUE
	if(child_name)
		var/datum/xeno_mutation/child_mutation = get_xeno_mutation_by_name(child_name)
		if(child_mutation && child_mutation.is_higher_tier_purchased(xeno))
			return TRUE
	return FALSE

/datum/xeno_mutation/proc/is_unlocked(mob/living/carbon/xenomorph/xeno)
	if(!parent_name)
		return TRUE
	return parent_name in xeno.purchased_mutations

/datum/xeno_mutation/proc/to_list(mob/living/carbon/xenomorph/xeno)
	return list(
		"name" = name,
		"desc" = desc,
		"category" = category,
		"cost" = cost,
		"icon" = icon_state,
		"available" = is_available(xeno),
		"purchased" = is_purchased(xeno),
		"tier" = tier,
		"parent" = parent_name,
		"children" = child_name ? list(child_name) : list(),
		"unlocked" = is_unlocked(xeno),
		"buff_desc" = buff_desc,
		"caste_restriction" = caste_restrictions
	)


//////////////////////////////////////////////////////////////////////////////////////
/////////////////MUTATIONS////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////


//
// Carapace mutations
//

/datum/xeno_mutation/carapace_one
	name = "Carapace I"
	desc = "Слабо увеличивает броню всех типов"
	category = "Survival"
	cost = 10
	icon_state = "carapace"
	tier = 1
	parent_name = null
	child_name = "Carapace II"
	status_effect_type = STATUS_EFFECT_CARAPACE
	buff_desc = "+2.5 soft armor"

/datum/xeno_mutation/carapace_two
	name = "Carapace II"
	desc = "Еще больше брони... Для богатых"
	category = "Survival"
	cost = 15
	icon_state = "carapace_two"
	tier = 2
	parent_name = "Carapace I"
	child_name = "Carapace III"
	status_effect_type = STATUS_EFFECT_CARAPACE_TWO
	buff_desc = "+5 soft armor"

/datum/xeno_mutation/carapace_three
	name = "Carapace III"
	desc = "Наномашины, сынок"
	category = "Survival"
	cost = 30
	icon_state = "carapace_three"
	tier = 3
	parent_name = "Carapace II"
	child_name = null
	status_effect_type = STATUS_EFFECT_CARAPACE_THREE
	buff_desc = "+10 soft armor"


//
// Regeneration mutations
//

/datum/xeno_mutation/regeneration_one
	name = "Regeneration I"
	desc = "Незначительно увеличивает регенерацию"
	category = "Survival"
	cost = 10
	icon_state = "regeneration"
	tier = 1
	parent_name = null
	child_name = "Regeneration II"
	status_effect_type = STATUS_EFFECT_REGENERATION
	buff_desc = "+0.8% health and sunder regen"

/datum/xeno_mutation/regeneration_two
	name = "Regeneration II"
	desc = "Ну, её теперь чуть больше, возрадуйся"
	category = "Survival"
	cost = 20
	icon_state = "regeneration_two"
	tier = 2
	parent_name = "Regeneration I"
	child_name = null
	status_effect_type = STATUS_EFFECT_REGENERATION_TWO
	buff_desc = "+1.6% health and sunder regen"


//
// Vampirism mutations
//

/datum/xeno_mutation/vampirism
	name = "Vampirism"
	desc = "Регенерирует часть здоровья при базовых атаках"
	category = "Survival"
	cost = 20
	icon_state = "vampirism"
	tier = 1
	parent_name = null
	child_name = "Leech"
	status_effect_type = STATUS_EFFECT_VAMPIRISM
	buff_desc = "1% HP per slash"

/datum/xeno_mutation/leech
	name = "Leech"
	desc = "Регенерирует СКОЛЬКО???"
	category = "Survival"
	cost = 40
	icon_state = "leech"
	tier = 2
	parent_name = "Vampirism"
	child_name = null
	status_effect_type = STATUS_EFFECT_VAMPIRISM_TWO
	buff_desc = "3% HP per slash"


//
// Celerity mutation
//

/datum/xeno_mutation/celerity
	name = "Celerity"
	desc = "Незначительно увеличивает скорость.. твоего фида"
	category = "Offensive"
	cost = 15
	icon_state = "celerity"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CELERITY
	buff_desc = "+10% speed"


//
// Ionize mutations
//

/datum/xeno_mutation/ionize
	name = "Ionize I"
	desc = "Незначительно увеличивает максимальную ёмкость плазмы"
	category = "Specialized"
	cost = 10
	icon_state = "ionize"
	tier = 1
	parent_name = null
	child_name = "Ionize II"
	status_effect_type = STATUS_EFFECT_IONIZE
	buff_desc = "+5% max plasma"

/datum/xeno_mutation/ionize_two
	name = "Ionize II"
	desc = "Больше максимума плазмы, и немного регена в придачу"
	category = "Specialized"
	cost = 25
	icon_state = "ionize_two"
	tier = 2
	parent_name = "Ionize I"
	child_name = null
	status_effect_type = STATUS_EFFECT_IONIZE_TWO
	buff_desc = "+10% max plasma, +10% plasma regen"

//
//Crush mutation
//

/datum/xeno_mutation/crush
	name = "Crush"
	desc = "Незначительно увеличивает пробитие базовой атаки"
	category = "Offensive"
	cost = 20
	icon_state = "crush"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_CRUSH
	buff_desc = "+5 penetration"

//
//Toxin mutations
//

/datum/xeno_mutation/toxin
	name = "Toxin I"
	desc = "Позволяет вводить выбранный реагент при атаке"
	category = "Offensive"
	cost = 15
	icon_state = "toxin"
	tier = 1
	parent_name = null
	child_name = "Toxin II"
	status_effect_type = STATUS_EFFECT_TOXIN
	buff_desc = "0.5 chosen xeno-toxin per slash"

/datum/xeno_mutation/toxin_two
	name = "Toxin II"
	desc = "Увеличивает ввод реагента и открывает sanguinal"
	category = "Offensive"
	cost = 20
	icon_state = "toxin_two"
	tier = 2
	parent_name = "Toxin I"
	child_name = null
	status_effect_type = STATUS_EFFECT_TOXIN_TWO
	buff_desc = "1 chosen xeno-toxin per slash, adds sanguinal"

//
//Pheromones mutations
//

/datum/xeno_mutation/pheromones
	name = "Pheromones I"
	desc = "Позволяет выделять слабые феромоны."
	category = "Specialized"
	cost = 10
	icon_state = "pheromones"
	tier = 1
	parent_name = null
	child_name = "Pheromones II"
	status_effect_type = STATUS_EFFECT_PHERO
	buff_desc = "1.5 pheromone power"

/datum/xeno_mutation/pheromones_two
	name = "Pheromones II"
	desc = "Позволяет выделять средние феромоны."
	category = "Specialized"
	cost = 10
	icon_state = "pheromones_two"
	tier = 2
	parent_name = "Pheromones I"
	child_name = "Pheromones III"
	status_effect_type = STATUS_EFFECT_PHERO_TWO
	buff_desc = "3 pheromone power"

/datum/xeno_mutation/pheromones_three
	name = "Pheromones III"
	desc = "Позволяет выделять сильные феромоны."
	category = "Specialized"
	cost = 10
	icon_state = "pheromones_three"
	tier = 3
	parent_name = "Pheromones II"
	child_name = null
	status_effect_type = STATUS_EFFECT_PHERO_THREE
	buff_desc = "4.5 pheromone power"

//
// Trail mutations
//

/datum/xeno_mutation/trail
	name = "Trail"
	desc = "Оставляет кислотный след с некоторым шансом."
	category = "Specialized"
	cost = 10
	icon_state = "trail"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_TRAIL
	buff_desc = "50% acid trail chance"

/// Drone Mastery mutation
/datum/xeno_mutation/drone_mastery
	name = "Drone Mastery"
	desc = "Улучшает способности строителя, увеличивая скорость постройки и эффективность ремонта."
	category = "Enhancement"
	cost = 12
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_UPGRADE_DRONE_MASTERY
	buff_desc = "+25% build speed, +15% repair efficiency"
	caste_restrictions = list("drone", "shrike")

/// Runner Agility mutation
/datum/xeno_mutation/runner_agility
	name = "Runner Agility"
	desc = "Максимально увеличивает скорость и маневренность, делая раннера неуловимым."
	category = "Enhancement"
	cost = 10
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_UPGRADE_RUNNER_AGILITY
	buff_desc = "+20% speed, +10% dodge chance"
	caste_restrictions = list("runner", "ravager")

/// Global list to store all mutation datums
GLOBAL_LIST_EMPTY(xeno_mutations)

/// Initialize all mutation datums
/proc/initialize_xeno_mutations()
	if(length(GLOB.xeno_mutations))
		return // Already initialized

	var/mutation_types = list(
		/datum/xeno_mutation/carapace_one,
		/datum/xeno_mutation/carapace_two,
		/datum/xeno_mutation/carapace_three,
		/datum/xeno_mutation/regeneration_one,
		/datum/xeno_mutation/regeneration_two,
		/datum/xeno_mutation/vampirism,
		/datum/xeno_mutation/leech,
		/datum/xeno_mutation/celerity,
		/datum/xeno_mutation/ionize,
		/datum/xeno_mutation/ionize_two,
		/datum/xeno_mutation/crush,
		/datum/xeno_mutation/toxin,
		/datum/xeno_mutation/toxin_two,
		/datum/xeno_mutation/pheromones,
		/datum/xeno_mutation/pheromones_two,
		/datum/xeno_mutation/pheromones_three,
		/datum/xeno_mutation/trail,
		/datum/xeno_mutation/drone_mastery,
		/datum/xeno_mutation/runner_agility
	)

	for(var/mutation_type in mutation_types)
		var/datum/xeno_mutation/mutation = new mutation_type()
		GLOB.xeno_mutations += mutation

/// Get mutation datum by name
/proc/get_xeno_mutation_by_name(mutation_name)
	initialize_xeno_mutations()
	for(var/datum/xeno_mutation/mutation in GLOB.xeno_mutations)
		if(mutation.name == mutation_name)
			return mutation
	return null
