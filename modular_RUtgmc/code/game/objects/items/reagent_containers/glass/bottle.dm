/obj/item/reagent_containers/glass/bottle/update_icon()
	overlays.Cut()

	if(reagents?.total_volume && (icon_state == "bottle-1" || icon_state == "bottle-2" || icon_state == "bottle-3" || icon_state == "bottle-4")) //only for those who have reagentfillings icons
		var/image/filling = image('icons/obj/reagentfillings.dmi', src, "[icon_state]10")

		var/percent = round((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0 to 9)
				filling.icon_state = "[icon_state]--10"
			if(10 to 24)
				filling.icon_state = "[icon_state]-10"
			if(25 to 49)
				filling.icon_state = "[icon_state]-25"
			if(50 to 74)
				filling.icon_state = "[icon_state]-50"
			if(75 to 79)
				filling.icon_state = "[icon_state]-75"
			if(80 to 90)
				filling.icon_state = "[icon_state]-80"
			if(91 to INFINITY)
				filling.icon_state = "[icon_state]-100"

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		overlays += filling

	if(!is_open_container())
		var/image/lid = image(icon, src, "lid_bottle")
		overlays += lid

/obj/item/reagent_containers/glass/bottle/medicalnanites
	name = "\improper Nanomachines bottle"
	desc = "A small bottle. Contains nanomachines modified for medical use, A potent new method of healing that that reproduces using a subject's blood and has a brief but potentially dangerous activation period!"
	icon_state = "bottle7"
	list_reagents = list(/datum/reagent/medicine/research/medicalnanites = 30)
