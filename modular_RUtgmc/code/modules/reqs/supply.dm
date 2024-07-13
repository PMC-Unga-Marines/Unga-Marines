/datum/supply_ui/ui_data(mob/living/user)
	. = ..()
	.["personalpoints"] = round(SSpoints.personal_supply_points[user.ckey])

/datum/supply_ui/requests/ui_data(mob/living/user)
	. = ..()
	.["personalpoints"] = round(SSpoints.personal_supply_points[user.ckey])

/obj/item/storage/backpack/marine/radiopack/attack_self(mob/living/user)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(update_beacon_location)), 5 SECONDS)

/obj/item/storage/backpack/marine/radiopack/proc/update_beacon_location()
	if(beacon_datum)
		beacon_datum.drop_location = get_turf(src)
		addtimer(CALLBACK(src, PROC_REF(update_beacon_location), beacon_datum), 5 SECONDS)
