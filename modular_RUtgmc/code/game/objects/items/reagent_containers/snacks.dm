/obj/item/reagent_containers/food/snacks/meat/xenomeat
	name = "meat"
	desc = "A slab of acrid smelling meat."
	icon_state = "xenomeat"
	filling_color = "#43DE18"

/obj/item/reagent_containers/food/snacks/meat/xenomeat/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/toxin/acid, 3)
	src.bitesize = 6
