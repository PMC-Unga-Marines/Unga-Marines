///Makes sentry health visible
/obj/proc/hud_set_machine_health()
	var/image/holder = hud_list[MACHINE_HEALTH_HUD]

	if(!holder)
		return

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

	if(!current_rounds)
		holder.icon_state = "plasma0"
		return

	var/amount = round(current_rounds * 100 / max_rounds, 10)
	holder.icon_state = "plasma[amount]"
