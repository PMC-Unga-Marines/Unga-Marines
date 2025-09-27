//*********************//
//    Direct Effects   //
//*********************//

/// Пример мутации с прямым применением эффектов без status_effects
/datum/xeno_mutation/bull_direct_speed
	name = "Direct Speed Boost"
	desc = "Increases movement speed by 20% directly through traits and signals."
	category = "Enhancement"
	cost = 10
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = null // Не используем status_effect
	buff_desc = "+20% movement speed"
	caste_restrictions = list("bull")
	alert_typepath = /atom/movable/screen/alert/status_effect/bull_direct_speed

/// Вызывается когда мутация активируется
/datum/xeno_mutation/bull_direct_speed/on_mutation_enabled()
	. = ..()
	// Добавляем трейт для увеличения скорости
	ADD_TRAIT(xenomorph_owner, TRAIT_FASTER, MUTATION_TRAIT)
	// Регистрируем сигнал для отслеживания движения
	RegisterSignal(xenomorph_owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))

/// Вызывается когда мутация деактивируется
/datum/xeno_mutation/bull_direct_speed/on_mutation_disabled()
	. = ..()
	// Убираем трейт
	REMOVE_TRAIT(xenomorph_owner, TRAIT_FASTER, MUTATION_TRAIT)
	// Отписываемся от сигнала
	UnregisterSignal(xenomorph_owner, COMSIG_MOVABLE_MOVED)

/// Обработчик движения
/datum/xeno_mutation/bull_direct_speed/proc/on_moved()
	SIGNAL_HANDLER
	// Здесь можно добавить дополнительную логику при движении
	// Например, создание эффектов или звуков

/// Пример мутации с прямым изменением переменных
/datum/xeno_mutation/bull_direct_health
	name = "Direct Health Boost"
	desc = "Increases maximum health by 50 points directly."
	category = "Survival"
	cost = 15
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = null // Не используем status_effect
	buff_desc = "+50 max health"
	caste_restrictions = list("bull")
	alert_typepath = /atom/movable/screen/alert/status_effect/bull_direct_health

/// Вызывается когда мутация активируется
/datum/xeno_mutation/bull_direct_health/on_mutation_enabled()
	. = ..()
	// Увеличиваем максимальное здоровье
	xenomorph_owner.maxHealth += 50
	xenomorph_owner.health += 50 // Также восстанавливаем здоровье

/// Вызывается когда мутация деактивируется
/datum/xeno_mutation/bull_direct_health/on_mutation_disabled()
	. = ..()
	// Уменьшаем максимальное здоровье
	xenomorph_owner.maxHealth -= 50
	// Не даем здоровью стать отрицательным
	if(xenomorph_owner.health > xenomorph_owner.maxHealth)
		xenomorph_owner.health = xenomorph_owner.maxHealth
