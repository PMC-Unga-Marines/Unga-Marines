/obj/item/tool/pickaxe/plasmacutter/start_cut(mob/user, name = "", atom/source, charge_amount = PLASMACUTTER_BASE_COST, custom_string, no_string, SFX = TRUE)
	if(!(cell.charge >= charge_amount) || !powered)
		fizzle_message(user)
		return FALSE
	eyecheck(user)
	if(SFX)
		playsound(source, cutting_sound, 25, 1)
		var/datum/effect_system/spark_spread/spark_system
		spark_system = new /datum/effect_system/spark_spread()
		spark_system.set_up(5, 0, source)
		spark_system.attach(source)
		spark_system.start(source)
	if(!no_string)
		if(custom_string)
			to_chat(user, span_notice(custom_string))
		else
			balloon_alert(user, "Starts cutting apart")
	return TRUE

/obj/item/tool/pickaxe/plasmacutter/cut_apart(mob/user, name = "", atom/source, charge_amount = PLASMACUTTER_BASE_COST, custom_string)
	eyecheck(user)
	playsound(source, cutting_sound, 25, 1)
	var/datum/effect_system/spark_spread/spark_system
	spark_system = new /datum/effect_system/spark_spread()
	spark_system.set_up(5, 0, source)
	spark_system.attach(source)
	spark_system.start(source)
	use_charge(user, charge_amount, TRUE)
	if(custom_string)
		to_chat(user, span_notice(custom_string))
	else
		to_chat(user, span_notice("You cut \the [source] apart."))

/obj/item/tool/pickaxe/plasmacutter/use_charge(mob/user, amount = PLASMACUTTER_BASE_COST, mention_charge = TRUE)
	cell.charge -= min(cell.charge, amount)
	if(mention_charge && amount > 0)
		balloon_alert(user, "Charge Remaining: [cell.charge]/[cell.maxcharge]")
	update_plasmacutter()
