/obj/item/stack/gun_powder
	name = "gunpowder pile"
	desc = "Some gunpowder pile."
	singular_name = "layer"
	icon_state = "gun_powder"
	w_class = WEIGHT_CLASS_HUGE
	merge_type = /obj/item/stack/gun_powder
	force = 2
	throw_speed = 5
	throw_range = 1
	max_amount = 25

/obj/item/stack/gun_powder/large_stack
	amount = 25

/obj/item/stack/sheet/composite
	name = "iron-copper composite"
	desc = "Сomposite made of iron and copper plates"
	singular_name = "composite sheet"
	icon_state = "CuFe_composite"
	item_state = "CuFe_composite"
	flags_item = NOBLUDGEON
	throwforce = 14
	flags_atom = CONDUCT
	merge_type = /obj/item/stack/sheet/composite
	number_of_extra_variants = 1

/obj/item/stack/sheet/composite/large_stack
	amount = 50

/obj/item/stack/sheet/jeweler_steel
	name = "jeweler steel"
	desc = "Jeweler steel, contains precious metals"
	singular_name = "steel sheet"
	icon_state = "jeweler_steel"
	item_state = "jeweler_steel"
	flags_item = NOBLUDGEON
	throwforce = 14
	flags_atom = CONDUCT
	merge_type = /obj/item/stack/sheet/jeweler_steel
	number_of_extra_variants = 3

/obj/item/stack/sheet/jeweler_steel/large_stack
	amount = 50
