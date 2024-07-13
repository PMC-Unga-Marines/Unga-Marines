/obj/machinery/chem_dispenser/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ChemDispenser", name)
		ui.open()

/obj/machinery/chem_dispenser/beer/pred
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'
	icon_state = "booze_dispenser"

/obj/machinery/chem_dispenser/pred
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'
	icon_state = "dispenser"

/obj/machinery/chem_dispenser/soda/pred
	icon = 'modular_RUtgmc/icons/obj/machines/yautja_machines.dmi'
	icon_state = "soda_dispenser"

/obj/machinery/chem_dispenser/ex_act(severity)
	take_damage(severity, BRUTE, BOMB)
