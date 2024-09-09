/datum/round_event_control/intel_computer
	name = "Intel computer activation"
	typepath = /datum/round_event/intel_computer
	weight = 25

	gamemode_blacklist = list("Crash", "Combat Patrol", "Sensor Capture")

/datum/round_event_control/intel_computer/can_spawn_event(players_amt, gamemode)
	if(length(GLOB.intel_computers) <= 0)
		return FALSE
	return ..()

/datum/round_event/intel_computer/start()
	for(var/obj/machinery/computer/intel_computer/I in shuffle(GLOB.intel_computers))
		if(I.active)
			continue

		activate(I)
		break

/datum/round_event/intel_computer/proc/activate(obj/machinery/computer/intel_computer/I)
	I.active = TRUE
	SSminimaps.add_marker(I, MINIMAP_FLAG_ALL, image('icons/UI_icons/map_blips.dmi', null, "intel", ABOVE_FLOAT_LAYER))
	priority_announce("Наш алгоритм просеивания данных обнаружил ценную секретную информацию на точке доступа в [get_area(I)]. Если эти данные будут восстановлены наземными силами, будет выдано вознаграждение в виде увеличенных активов.", title = "Отдел Разведки TGMC", sound = 'sound/AI/bonus_found.ogg')
	xeno_message("Мы чувствуем надвигающуюся угрозу со стороны [get_area(I)]. Мы должны держать этих мясных идиотов подальше от этого места.")
