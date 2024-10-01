///Mecha health hud updates
/obj/vehicle/sealed/mecha/proc/hud_set_mecha_health()
	var/image/holder = hud_list[MACHINE_HEALTH_HUD]

	if(!holder)
		return

	holder.icon = 'icons/mob/hud/xeno_health.dmi'
	if(obj_integrity < 1)
		holder.icon_state = "xenohealth0"
		return

	var/amount = round(obj_integrity * 100 / max_integrity, 10)
	if(!amount)
		amount = 1 //don't want the 'zero health' icon when we still have 4% of our health
	holder.icon_state = "xenohealth[amount]"

///Updates mecha battery
/obj/vehicle/sealed/mecha/proc/hud_set_mecha_battery()
	var/image/holder = hud_list[MACHINE_AMMO_HUD]

	if(!holder)
		return

	holder.icon = 'icons/mob/hud/xeno_health.dmi'
	if(!cell)
		holder.icon_state = "plasma0"
		return

	var/amount = round(cell.charge * 100 / cell.maxcharge, 10)
	holder.icon_state = "plasma[amount]"
