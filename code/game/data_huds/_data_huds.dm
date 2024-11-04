/*
* Data HUDs have been rewritten in a more generic way.
* In short, they now use an observer-listener pattern.
* See code/datum/hud.dm for the generic hud datum.
* Update the HUD icons when needed with the appropriate hook. (see below)
*/

/* DATA HUD DATUMS */
/atom/proc/add_to_all_mob_huds()
	return

/atom/proc/remove_from_all_mob_huds()
	return

/mob/proc/med_hud_set_health()
	return

/mob/proc/med_hud_set_status() //called when mob stat changes, or get a virus/xeno host, etc
	return
