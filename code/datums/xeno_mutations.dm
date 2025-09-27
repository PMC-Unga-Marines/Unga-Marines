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
	///Описание баффа, желательно числа и цифры
	var/buff_desc = ""
	///Касты, которым будет доступна данная мутация
	var/list/caste_restrictions = list()

	/// Владелец мутации
	var/mob/living/carbon/xenomorph/xenomorph_owner
	/// Алерт для отображения мутации
	var/atom/movable/screen/alert/alert
	/// Тип алерта
	var/atom/movable/screen/alert/alert_typepath
	/// Конфликтующие мутации
	var/list/datum/xeno_mutation/conflicting_mutation_types = list()

/// Global list to store all mutation datums
GLOBAL_LIST_EMPTY(xeno_mutations)

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

/datum/xeno_mutation/New()
	. = ..()
	// Автоматически добавляем мутацию в глобальный список при создании
	if(!GLOB.xeno_mutations)
		GLOB.xeno_mutations = list()
	GLOB.xeno_mutations += src

/// Создает экземпляр мутации для конкретного ксеноморфа
/datum/xeno_mutation/proc/create_instance(mob/living/carbon/xenomorph/xeno)
	var/datum/xeno_mutation/instance = new type()
	instance.xenomorph_owner = xeno
	xeno.owned_mutations += instance

	// Создаем алерт если есть тип алерта
	if(alert_typepath)
		instance.alert = xeno.throw_alert("mutation_[category]", alert_typepath)
		if(instance.alert)
			instance.alert.name = name
			instance.alert.desc = desc

	// Применяем мутацию
	instance.on_mutation_enabled()

	return instance

/// Вызывается когда мутация активируется
/datum/xeno_mutation/proc/on_mutation_enabled()
	return

/// Вызывается когда мутация деактивируется
/datum/xeno_mutation/proc/on_mutation_disabled()
	return

/// Удаляет экземпляр мутации
/datum/xeno_mutation/proc/remove_instance()
	if(alert)
		xenomorph_owner.clear_alert("mutation_[category]")
	if(xenomorph_owner.owned_mutations.Find(src))
		xenomorph_owner.owned_mutations -= src
	on_mutation_disabled()
	qdel(src)


//////////////////////////////////////////////////////////////////////////////////////
/////////////////MUTATIONS////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////


//
// Carapace mutations
//

/// Базовый класс для мутаций брони
/datum/xeno_mutation/carapace
	name = "Carapace I"
	desc = "Слабо увеличивает броню всех типов"
	category = "Survival"
	cost = 10
	icon_state = "carapace"
	tier = 1
	parent_name = null
	child_name = "Carapace II"
	buff_desc = "+2.5 soft armor"
	alert_typepath = /atom/movable/screen/alert/status_effect/carapace

	/// Броня, которая была добавлена
	var/datum/armor/attached_armor
	/// Количество брони для добавления
	var/armor_amount = 2.5

/// Вызывается когда мутация активируется
/datum/xeno_mutation/carapace/on_mutation_enabled()
	. = ..()
	// Добавляем броню
	attached_armor = new(armor_amount, armor_amount, armor_amount, armor_amount, armor_amount, armor_amount, armor_amount, armor_amount)
	xenomorph_owner.soft_armor = xenomorph_owner.soft_armor.attachArmor(attached_armor)

/// Вызывается когда мутация деактивируется
/datum/xeno_mutation/carapace/on_mutation_disabled()
	. = ..()
	// Убираем броню
	if(attached_armor)
		xenomorph_owner.soft_armor = xenomorph_owner.soft_armor.detachArmor(attached_armor)
		attached_armor = null

/// Второй уровень брони
/datum/xeno_mutation/carapace/two
	name = "Carapace II"
	desc = "Еще больше брони... Для богатых"
	cost = 15
	icon_state = "carapace_two"
	tier = 2
	parent_name = "Carapace I"
	child_name = "Carapace III"
	buff_desc = "+5 soft armor"
	armor_amount = 5

/// Третий уровень брони
/datum/xeno_mutation/carapace/three
	name = "Carapace III"
	desc = "Наномашины, сынок"
	cost = 30
	icon_state = "carapace_three"
	tier = 3
	parent_name = "Carapace II"
	child_name = null
	buff_desc = "+10 soft armor"
	armor_amount = 10


//
// Regeneration mutations
//

/// Базовый класс для мутаций регенерации
/datum/xeno_mutation/regeneration
	name = "Regeneration I"
	desc = "Незначительно увеличивает регенерацию"
	category = "Survival"
	cost = 10
	icon_state = "regeneration"
	tier = 1
	parent_name = null
	child_name = "Regeneration II"
	buff_desc = "+0.8% health and sunder regen"
	alert_typepath = /atom/movable/screen/alert/status_effect/regeneration

	/// Скорость регенерации
	var/tick_interval = 5 SECONDS
	/// Таймер для регенерации
	var/timer_id
	/// Буфф регенерации здоровья
	var/regen_buff = 0.008
	/// Буфф регенерации сундера
	var/sunder_regen = 0.166

/// Вызывается когда мутация активируется
/datum/xeno_mutation/regeneration/on_mutation_enabled()
	. = ..()
	// Запускаем регенерацию
	start_regeneration()

/// Вызывается когда мутация деактивируется
/datum/xeno_mutation/regeneration/on_mutation_disabled()
	. = ..()
	// Останавливаем регенерацию
	stop_regeneration()

/// Запускает регенерацию
/datum/xeno_mutation/regeneration/proc/start_regeneration()
	if(timer_id)
		return
	timer_id = addtimer(CALLBACK(src, PROC_REF(heal_xeno)), tick_interval, TIMER_STOPPABLE|TIMER_LOOP|TIMER_UNIQUE)

/// Останавливает регенерацию
/datum/xeno_mutation/regeneration/proc/stop_regeneration()
	if(timer_id)
		deltimer(timer_id)
		timer_id = null

/// Лечит ксеноморфа
/datum/xeno_mutation/regeneration/proc/heal_xeno()
	if(!xenomorph_owner || xenomorph_owner.stat == DEAD)
		stop_regeneration()
		return

	var/amount = xenomorph_owner.maxHealth * regen_buff * (1 + xenomorph_owner.recovery_aura * 0.05)
	xenomorph_owner.heal_xeno_damage(amount, FALSE)
	xenomorph_owner.adjust_sunder(-sunder_regen)
	xenomorph_owner.update_health()

/// Второй уровень регенерации
/datum/xeno_mutation/regeneration/two
	name = "Regeneration II"
	desc = "Ну, её теперь чуть больше, возрадуйся"
	cost = 20
	icon_state = "regeneration_two"
	tier = 2
	parent_name = "Regeneration I"
	child_name = null
	buff_desc = "+1.6% health and sunder regen"
	tick_interval = 2.5 SECONDS
	regen_buff = 0.016
	sunder_regen = 0.332


//
// Vampirism mutations
//

/// Базовый класс для мутаций вампиризма
/datum/xeno_mutation/vampirism
	name = "Vampirism"
	desc = "Регенерирует часть здоровья при базовых атаках"
	category = "Survival"
	cost = 20
	icon_state = "vampirism"
	tier = 1
	parent_name = null
	child_name = "Leech"
	buff_desc = "1% HP per slash"
	alert_typepath = /atom/movable/screen/alert/status_effect/vampirism

	/// Процент восстановления здоровья за атаку
	var/leech_buff = 0.01

/// Вызывается когда мутация активируется
/datum/xeno_mutation/vampirism/on_mutation_enabled()
	. = ..()
	// Регистрируем сигнал для отслеживания атак
	RegisterSignal(xenomorph_owner, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(on_slash))

/// Вызывается когда мутация деактивируется
/datum/xeno_mutation/vampirism/on_mutation_disabled()
	. = ..()
	// Отписываемся от сигнала
	UnregisterSignal(xenomorph_owner, COMSIG_XENOMORPH_ATTACK_LIVING)

/// Обработчик атаки
/datum/xeno_mutation/vampirism/proc/on_slash(datum/source, mob/living/target)
	SIGNAL_HANDLER
	if(target.stat == DEAD)
		return
	if(!ishuman(target))
		return
	var/bruteloss_healed = xenomorph_owner.maxHealth * leech_buff
	var/fireloss_healed = clamp(bruteloss_healed - xenomorph_owner.bruteloss, 0, bruteloss_healed)
	xenomorph_owner.adjust_brute_loss(-bruteloss_healed)
	xenomorph_owner.adjust_fire_loss(-fireloss_healed)
	xenomorph_owner.update_health()

/// Второй уровень вампиризма
/datum/xeno_mutation/vampirism/leech
	name = "Leech"
	desc = "Регенерирует СКОЛЬКО???"
	cost = 40
	icon_state = "leech"
	tier = 2
	parent_name = "Vampirism"
	child_name = null
	buff_desc = "3% HP per slash"
	leech_buff = 0.03


//
// Celerity mutation
//

/// Мутация скорости
/datum/xeno_mutation/celerity
	name = "Celerity"
	desc = "Незначительно увеличивает скорость.. твоего фида"
	category = "Offensive"
	cost = 15
	icon_state = "celerity"
	tier = 1
	parent_name = null
	child_name = null
	buff_desc = "+10% speed"
	alert_typepath = /atom/movable/screen/alert/status_effect/celerity

	/// Буфф скорости
	var/speed_buff = 0.1

/// Вызывается когда мутация активируется
/datum/xeno_mutation/celerity/on_mutation_enabled()
	. = ..()
	// Добавляем модификатор скорости
	xenomorph_owner.add_movespeed_modifier(MOVESPEED_ID_CELERITY_BUFF, TRUE, 0, NONE, TRUE, -speed_buff)

/// Вызывается когда мутация деактивируется
/datum/xeno_mutation/celerity/on_mutation_disabled()
	. = ..()
	// Убираем модификатор скорости
	xenomorph_owner.remove_movespeed_modifier(MOVESPEED_ID_CELERITY_BUFF)


//
// Ionize mutations
//

/// Базовый класс для мутаций ионизации
/datum/xeno_mutation/ionize
	name = "Ionize I"
	desc = "Незначительно увеличивает максимальную ёмкость плазмы"
	category = "Specialized"
	cost = 10
	icon_state = "ionize"
	tier = 1
	parent_name = null
	child_name = "Ionize II"
	buff_desc = "+5% max plasma"
	alert_typepath = /atom/movable/screen/alert/status_effect/ionize

	/// Процент увеличения максимальной плазмы
	var/percent_buff = 0.05
	/// Буфф регенерации плазмы
	var/plasma_regen_buff = 0
	/// Таймер для регенерации плазмы
	var/timer_id

/// Вызывается когда мутация активируется
/datum/xeno_mutation/ionize/on_mutation_enabled()
	. = ..()
	// Увеличиваем максимальную плазму
	xenomorph_owner.xeno_caste.plasma_max += xenomorph_owner.xeno_caste.plasma_max * percent_buff
	// Запускаем регенерацию плазмы если есть буфф
	if(plasma_regen_buff > 0)
		start_plasma_regen()

/// Вызывается когда мутация деактивируется
/datum/xeno_mutation/ionize/on_mutation_disabled()
	. = ..()
	// Возвращаем максимальную плазму к исходному значению
	xenomorph_owner.xeno_caste.plasma_max -= xenomorph_owner.xeno_caste.plasma_max * percent_buff / (1 + percent_buff)
	// Останавливаем регенерацию плазмы
	stop_plasma_regen()

/// Запускает регенерацию плазмы
/datum/xeno_mutation/ionize/proc/start_plasma_regen()
	if(timer_id)
		return
	timer_id = addtimer(CALLBACK(src, PROC_REF(regenerate_plasma)), 5 SECONDS, TIMER_STOPPABLE|TIMER_LOOP|TIMER_UNIQUE)

/// Останавливает регенерацию плазмы
/datum/xeno_mutation/ionize/proc/stop_plasma_regen()
	if(timer_id)
		deltimer(timer_id)
		timer_id = null

/// Регенерирует плазму
/datum/xeno_mutation/ionize/proc/regenerate_plasma()
	if(!xenomorph_owner || xenomorph_owner.stat == DEAD)
		stop_plasma_regen()
		return
	if(HAS_TRAIT(xenomorph_owner, TRAIT_NOPLASMAREGEN))
		return
	xenomorph_owner.gain_plasma(xenomorph_owner.xeno_caste.plasma_gain * plasma_regen_buff * (1 + xenomorph_owner.recovery_aura * 0.05))

/// Второй уровень ионизации
/datum/xeno_mutation/ionize/two
	name = "Ionize II"
	desc = "Больше максимума плазмы, и немного регена в придачу"
	cost = 25
	icon_state = "ionize_two"
	tier = 2
	parent_name = "Ionize I"
	child_name = null
	buff_desc = "+10% max plasma, +10% plasma regen"
	percent_buff = 0.1
	plasma_regen_buff = 0.1

//
//Crush mutation
//

/// Мутация дробления
/datum/xeno_mutation/crush
	name = "Crush"
	desc = "Незначительно увеличивает пробитие базовой атаки"
	category = "Offensive"
	cost = 20
	icon_state = "crush"
	tier = 1
	parent_name = null
	child_name = null
	buff_desc = "+5 penetration"
	alert_typepath = /atom/movable/screen/alert/status_effect/crush

	/// Дополнительное пробитие
	var/penetration_buff = 5

/// Вызывается когда мутация активируется
/datum/xeno_mutation/crush/on_mutation_enabled()
	. = ..()
	// Регистрируем сигнал для отслеживания атак по объектам
	RegisterSignal(xenomorph_owner, COMSIG_XENOMORPH_ATTACK_OBJ, PROC_REF(on_obj_attack))

/// Вызывается когда мутация деактивируется
/datum/xeno_mutation/crush/on_mutation_disabled()
	. = ..()
	// Отписываемся от сигнала
	UnregisterSignal(xenomorph_owner, COMSIG_XENOMORPH_ATTACK_OBJ)

/// Обработчик атаки по объектам
/datum/xeno_mutation/crush/proc/on_obj_attack(datum/source, obj/attacked)
	SIGNAL_HANDLER
	if(attacked.resistance_flags & XENO_DAMAGEABLE)
		attacked.take_damage(xenomorph_owner.xeno_caste.melee_damage, armour_penetration = penetration_buff)

//
//Toxin mutations
//

/// Базовый класс для мутаций токсинов
/datum/xeno_mutation/toxin
	name = "Toxin I"
	desc = "Позволяет вводить выбранный реагент при атаке"
	category = "Offensive"
	cost = 15
	icon_state = "toxin"
	tier = 1
	parent_name = null
	child_name = "Toxin II"
	buff_desc = "0.5 chosen xeno-toxin per slash"
	alert_typepath = /atom/movable/screen/alert/status_effect/toxin

	/// Количество токсина за атаку
	var/toxin_amount = 0.5
	/// Выбранный реагент для введения
	var/datum/reagent/toxin/injected_reagent = /datum/reagent/toxin/xeno_transvitox
	/// Доступные реагенты
	var/list/selectable_reagents = list(
		/datum/reagent/toxin/xeno_ozelomelyn,
		/datum/reagent/toxin/xeno_hemodile,
		/datum/reagent/toxin/xeno_transvitox,
	)

/// Вызывается когда мутация активируется
/datum/xeno_mutation/toxin/on_mutation_enabled()
	. = ..()
	// Регистрируем сигнал для отслеживания атак
	RegisterSignal(xenomorph_owner, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(on_slash))

/// Вызывается когда мутация деактивируется
/datum/xeno_mutation/toxin/on_mutation_disabled()
	. = ..()
	// Отписываемся от сигнала
	UnregisterSignal(xenomorph_owner, COMSIG_XENOMORPH_ATTACK_LIVING)

/// Обработчик атаки
/datum/xeno_mutation/toxin/proc/on_slash(datum/source, mob/living/target)
	SIGNAL_HANDLER
	if(target.stat == DEAD)
		return
	if(!ishuman(target))
		return
	if(!target?.can_sting())
		return
	var/mob/living/carbon/carbon_target = target
	carbon_target.reagents.add_reagent(injected_reagent, 1 + toxin_amount)

/// Второй уровень токсинов
/datum/xeno_mutation/toxin/two
	name = "Toxin II"
	desc = "Увеличивает ввод реагента и открывает sanguinal"
	cost = 20
	icon_state = "toxin_two"
	tier = 2
	parent_name = "Toxin I"
	child_name = null
	buff_desc = "1 chosen xeno-toxin per slash, adds sanguinal"
	toxin_amount = 1.0
	selectable_reagents = list(
		/datum/reagent/toxin/xeno_ozelomelyn,
		/datum/reagent/toxin/xeno_hemodile,
		/datum/reagent/toxin/xeno_transvitox,
		/datum/reagent/toxin/xeno_sanguinal
	)

//
//Pheromones mutations
//

/// Базовый класс для мутаций феромонов
/datum/xeno_mutation/pheromones
	name = "Pheromones I"
	desc = "Позволяет выделять слабые феромоны."
	category = "Specialized"
	cost = 10
	icon_state = "pheromones"
	tier = 1
	parent_name = null
	child_name = "Pheromones II"
	buff_desc = "1.5 pheromone power"
	alert_typepath = /atom/movable/screen/alert/status_effect/pheromones

	/// Текущий эмиттер ауры
	var/datum/aura_bearer/current_aura
	/// Сила феромонов
	var/phero_power = 0.5
	/// Базовая сила феромонов
	var/phero_power_base = 1
	/// Излучаемая аура
	var/emitted_aura

/// Вызывается когда мутация активируется
/datum/xeno_mutation/pheromones/on_mutation_enabled()
	. = ..()
	// Создаем эмиттер ауры
	current_aura = SSaura.add_emitter(xenomorph_owner, AURA_XENO_RECOVERY, 6 + phero_power * 2, phero_power_base + phero_power, -1, FACTION_XENO, xenomorph_owner.hivenumber)

/// Вызывается когда мутация деактивируется
/datum/xeno_mutation/pheromones/on_mutation_disabled()
	. = ..()
	// Останавливаем эмиттер ауры
	if(current_aura)
		current_aura.stop_emitting()

/// Второй уровень феромонов
/datum/xeno_mutation/pheromones/two
	name = "Pheromones II"
	desc = "Позволяет выделять средние феромоны."
	cost = 10
	icon_state = "pheromones_two"
	tier = 2
	parent_name = "Pheromones I"
	child_name = "Pheromones III"
	buff_desc = "3 pheromone power"
	phero_power = 1
	phero_power_base = 2

/// Третий уровень феромонов
/datum/xeno_mutation/pheromones/three
	name = "Pheromones III"
	desc = "Позволяет выделять сильные феромоны."
	cost = 10
	icon_state = "pheromones_three"
	tier = 3
	parent_name = "Pheromones II"
	child_name = null
	buff_desc = "4.5 pheromone power"
	phero_power = 1.5
	phero_power_base = 3

//
// Trail mutations
//

/// Мутация следа
/datum/xeno_mutation/trail
	name = "Trail"
	desc = "Оставляет кислотный след с некоторым шансом."
	category = "Specialized"
	cost = 10
	icon_state = "trail"
	tier = 1
	parent_name = null
	child_name = null
	buff_desc = "50% acid trail chance"
	alert_typepath = /atom/movable/screen/alert/status_effect/trail

	/// Выбранный тип следа
	var/obj/selected_trail = /obj/effect/xenomorph/spray
	/// Базовый шанс
	var/base_chance = 25
	/// Дополнительный шанс
	var/chance = 25
	/// Доступные типы следов
	var/list/selectable_trails = list(
		/obj/effect/xenomorph/spray,
		/obj/alien/resin/sticky/thin/temporary,
	)

/// Вызывается когда мутация активируется
/datum/xeno_mutation/trail/on_mutation_enabled()
	. = ..()
	// Регистрируем сигнал для отслеживания движения
	RegisterSignal(xenomorph_owner, COMSIG_MOVABLE_MOVED, PROC_REF(do_acid_trail))

/// Вызывается когда мутация деактивируется
/datum/xeno_mutation/trail/on_mutation_disabled()
	. = ..()
	// Отписываемся от сигнала
	UnregisterSignal(xenomorph_owner, COMSIG_MOVABLE_MOVED)

/// Создает кислотный след
/datum/xeno_mutation/trail/proc/do_acid_trail()
	SIGNAL_HANDLER
	if(xenomorph_owner.incapacitated(TRUE) || xenomorph_owner.status_flags & INCORPOREAL || xenomorph_owner.is_ventcrawling)
		return
	if(prob(base_chance + chance))
		var/turf/T = get_turf(xenomorph_owner)
		if(T.density || isspaceturf(T))
			return
		for(var/obj/O in T.contents)
			if(is_type_in_typecache(O, GLOB.no_sticky_resin))
				return
		if(selected_trail == /obj/effect/xenomorph/spray)
			new selected_trail(T, rand(2 SECONDS, 5 SECONDS))
			for(var/obj/O in T)
				O.acid_spray_act(xenomorph_owner)
		else
			new selected_trail(T)
