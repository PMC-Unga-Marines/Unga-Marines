//*********************//
//        Shell        //
//*********************//
/datum/xeno_mutation/bull_unstoppable
	name = "Unstoppable"
	desc = "Charging will grant you complete stagger immunity if you reach the maximum number of steps minus 1/2/3."
	category = "Enhancement"
	cost = 15
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BULL_UNSTOPPABLE
	buff_desc = "Stagger immunity when charging at max steps"
	caste_restrictions = list("bull")
	alert_typepath = /atom/movable/screen/alert/status_effect/bull_unstoppable

/// Вызывается когда мутация активируется
/datum/xeno_mutation/bull_unstoppable/on_mutation_enabled()
	. = ..()
	// Добавляем трейт для сопротивления стаггеру
	ADD_TRAIT(xenomorph_owner, TRAIT_STAGGER_RESISTANT, MUTATION_TRAIT)
	// Регистрируем сигнал для отслеживания заряда
	RegisterSignal(xenomorph_owner, COMSIG_XENO_CHARGE_START, PROC_REF(on_charge_start))

/// Вызывается когда мутация деактивируется
/datum/xeno_mutation/bull_unstoppable/on_mutation_disabled()
	. = ..()
	// Убираем трейт
	REMOVE_TRAIT(xenomorph_owner, TRAIT_STAGGER_RESISTANT, MUTATION_TRAIT)
	// Отписываемся от сигнала
	UnregisterSignal(xenomorph_owner, COMSIG_XENO_CHARGE_START)

/// Обработчик начала заряда
/datum/xeno_mutation/bull_unstoppable/proc/on_charge_start()
	SIGNAL_HANDLER
	// Логика для проверки максимальных шагов заряда
	// Здесь можно добавить проверку количества шагов и применение иммунитета к стаггеру

//*********************//
//         Spur        //
//*********************//
/datum/xeno_mutation/bull_speed_demon
	name = "Speed Demon"
	desc = "Charging costs twice as much plasma. The speed multiplier per step is increased by 0.02/0.04/0.06."
	category = "Enhancement"
	cost = 20
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BULL_SPEED_DEMON
	buff_desc = "Increased charge speed, higher plasma cost"
	caste_restrictions = list("bull")

//*********************//
//         Veil        //
//*********************//
/datum/xeno_mutation/bull_railgun
	name = "Railgun"
	desc = "Charge's maximum steps is increased by 4/8/12."
	category = "Enhancement"
	cost = 25
	icon_state = "xenobuff_generic"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_BULL_RAILGUN
	buff_desc = "Increased maximum charge steps"
	caste_restrictions = list("bull")
