/datum/round_event_control/intel_computer
	name = "Intel computer activation"
	typepath = /datum/round_event/intel_computer
	weight = 25

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

///sets the icon on the map. Toggles it between active and inactive, notifies xenos and marines of the existence of the computer.
/datum/round_event/intel_computer/proc/activate(obj/machinery/computer/intel_computer/I)
	I.active = TRUE
	I.update_minimap_icon()
	priority_announce("Обнаружена ценная информация в [get_area(I)]. Если эти данные будут восстановлены наземными силами, будет выдано вознаграждение.", title = "Отдел Разведки UPP", sound = 'sound/AI/bonus_found.ogg')
	xeno_message("Кажется в [get_area(I)] есть что-то полезное для морпехов. Следует держать их подальше от этого места.")
