/obj/item/healthanalyzer/gloves
	icon = 'icons/obj/clothing/gloves.dmi'

/obj/item/healthanalyzer
	var/alien = FALSE

/obj/item/healthanalyzer/alien
	name = "\improper YMX scanner"
	icon = 'modular_RUtgmc/icons/obj/hunter/pred_gear.dmi'
	icon_state = "scanner"
	item_state = "analyzer"
	desc = "An alien design hand-held body scanner able to distinguish vital signs of the subject. The front panel is able to provide the basic readout of the subject's status."
	alien = TRUE
