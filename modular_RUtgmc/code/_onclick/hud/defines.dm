//Upper-middle right (damage indicators)
#define ui_predator_power "EAST-1:28,CENTER:17"

/atom/movable/screen/fullscreen/machine/pred
	alpha = 140

/atom/movable/screen/fullscreen/machine/pred/meson
	icon_state = "pred_meson"
	icon = 'modular_RUtgmc/icons/mob/screen/full.dmi'

/atom/movable/screen/fullscreen/machine/pred/night
	icon_state = "robothalf"

/datum/hud/var/atom/movable/screen/pred_power_icon

/datum/hud/Destroy()
	pred_power_icon = null
	return ..()
