/datum/hud/human/species/yautja/New(mob/living/carbon/human/owner, ui_style='icons/mob/screen/White.dmi', ui_color = "#ffffff", ui_alpha = 230)
	. = ..()

	pred_power_icon = new /atom/movable/screen()
	pred_power_icon.icon = 'modular_RUtgmc/icons/mob/screen/yautja.dmi'
	pred_power_icon.icon_state = "powerbar10"
	pred_power_icon.name = "bracer power stored"
	pred_power_icon.screen_loc = ui_predator_power
	infodisplay += pred_power_icon

/mob/living/carbon/human/species/yautja/create_mob_hud()
	if(client && !hud_used)
		var/ui_style = ui_style2icon(client.prefs.ui_style)
		var/ui_color = client.prefs.ui_style_color
		var/ui_alpha = client.prefs.ui_style_alpha
		hud_used = new /datum/hud/human/species/yautja(src, ui_style, ui_color, ui_alpha)
	else
		hud_used = new /datum/hud/human/species/yautja(src)
