///Makes sentry health visible
/obj/proc/hud_set_machine_health()
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

///Makes mounted guns ammo visible
/obj/machinery/deployable/mounted/proc/hud_set_gun_ammo()
	var/image/holder = hud_list[MACHINE_AMMO_HUD]

	if(!holder)
		return
	var/obj/item/weapon/gun/internal_gun = internal_item.resolve()
	holder.icon = 'icons/mob/hud/xeno_health.dmi'
	if(!internal_gun?.rounds)
		holder.icon_state = "plasma0"
		return
	var/amount = internal_gun.max_rounds ? round(internal_gun.rounds * 100 / internal_gun.max_rounds, 10) : 0
	holder.icon_state = "plasma[amount]"

///Makes unmanned vehicle ammo visible
/obj/vehicle/unmanned/proc/hud_set_uav_ammo()
	var/image/holder = hud_list[MACHINE_AMMO_HUD]

	if(!holder)
		return

	holder.icon = 'icons/mob/hud/xeno_health.dmi'
	if(!current_rounds)
		holder.icon_state = "plasma0"
		return

	var/amount = round(current_rounds * 100 / max_rounds, 10)
	holder.icon_state = "plasma[amount]"

/obj/machinery/deployable/tesla_turret/proc/hud_set_tesla_battery()
	var/image/holder = hud_list[MACHINE_AMMO_HUD]

	if(!holder)
		return

	if(!battery)
		holder.icon = 'icons/mob/hud/xeno_health.dmi'
		holder.icon_state = "plasma0"
		return

	var/amount = round(battery.charge * 100 / battery.maxcharge, 10)
	holder.icon = 'icons/mob/hud/xeno_health.dmi'
	holder.icon_state = "plasma[amount]"
