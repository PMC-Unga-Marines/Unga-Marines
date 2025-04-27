//Analyzer, pestkillers, weedkillers, nutrients, hatchets, cutters.

/obj/item/tool/wirecutters/clippers
	name = "plant clippers"
	desc = "A tool used to take samples from plants."

/obj/item/tool/analyzer/plant_analyzer
	name = "plant analyzer"
	icon_state = "hydro"
	worn_icon_state = "analyzer"

// *************************************
// Nutrient defines for hydroponics
// *************************************

/obj/item/reagent_containers/glass/fertilizer
	name = "fertilizer bottle"
	desc = "A small glass bottle. Can hold up to 10 units."
	icon = 'icons/obj/items/chemistry.dmi'
	icon_state = "bottle16"
	possible_transfer_amounts = null
	w_class = WEIGHT_CLASS_SMALL

	var/fertilizer //Reagent contained, if any.

	//Like a shot glass!
	amount_per_transfer_from_this = 10
	volume = 10

/obj/item/reagent_containers/glass/fertilizer/Initialize(mapload)
	. = ..()

	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

	if(fertilizer)
		reagents.add_reagent(fertilizer,10)


/obj/item/reagent_containers/glass/fertilizer/ez
	name = "bottle of E-Z-Nutrient"
	icon_state = "bottle16"
	fertilizer = /datum/reagent/toxin/fertilizer/eznutrient

/obj/item/reagent_containers/glass/fertilizer/l4z
	name = "bottle of Left 4 Zed"
	icon_state = "bottle18"
	fertilizer = /datum/reagent/toxin/fertilizer/left4zed

/obj/item/reagent_containers/glass/fertilizer/rh
	name = "bottle of Robust Harvest"
	icon_state = "bottle15"
	fertilizer = /datum/reagent/toxin/fertilizer/robustharvest
