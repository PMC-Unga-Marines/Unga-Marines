/obj/item/clothing/shoes/proc/step_action() //this was made to rewrite clown shoes squeaking
	SEND_SIGNAL(src, COMSIG_SHOES_STEP_ACTION)

/obj/item/clothing/shoes/mime
	name = "mime shoes"
	icon_state = "mime"

/obj/item/clothing/shoes/swat
	name = "\improper SWAT shoes"
	desc = "When you want to turn up the heat."
	icon_state = "swat"
	soft_armor = list(MELEE = 80, BULLET = 60, LASER = 50, ENERGY = 25, BOMB = 50, BIO = 10, FIRE = 25, ACID = 25)
	inventory_flags = NOSLIPPING
	item_flags = SYNTH_RESTRICTED
	siemens_coefficient = 0.6

/obj/item/clothing/shoes/ruggedboot
	name = "Rugged Boots"
	desc = "A pair of boots used by workers in dangerous environments."
	icon_state = "swat"
	soft_armor = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 25, BOMB = 20, BIO = 20, FIRE = 20, ACID = 20)
	inventory_flags = NOSLIPPING
	item_flags = SYNTH_RESTRICTED
	siemens_coefficient = 0.6

	cold_protection_flags = FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_flags = FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/shoes/sandal
	desc = "A pair of rather plain, wooden sandals."
	name = "sandals"
	icon_state = "wizard"
	armor_protection_flags = NONE

/obj/item/clothing/shoes/sandal/marisa
	desc = "A pair of magic, black shoes."
	name = "magic shoes"
	icon_state = "black"
	armor_protection_flags = FEET

/obj/item/clothing/shoes/galoshes
	desc = "Rubber boots"
	name = "galoshes"
	icon_state = "galoshes"
	permeability_coefficient = 0.05
	inventory_flags = NOSLIPPING
	slowdown = SHOES_SLOWDOWN+1

/obj/item/clothing/shoes/clown_shoes
	desc = "The prankster's standard-issue clowning shoes. Damn they're huge!"
	name = "clown shoes"
	icon_state = "clown"
	worn_icon_state = "clown"
	slowdown = SHOES_SLOWDOWN + 1

/obj/item/clothing/shoes/clown_shoes/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/effects/clownstep1.ogg', 'sound/effects/clownstep2.ogg'), 50)

/obj/item/clothing/shoes/clown_shoes/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_SHOES)
		user.AddElement(/datum/element/waddling)

/obj/item/clothing/shoes/clown_shoes/unequipped(mob/user)
	. = ..()
	user.RemoveElement(/datum/element/waddling)

/obj/item/clothing/shoes/clown_shoes/erp
	desc ="The prankster's military-standard-issue clowning shoes. Damn they're huge! And reinforced!"
	name = "reinforced clown shoes"
	armor_protection_flags = FEET
	cold_protection_flags = FEET
	heat_protection_flags = FEET
	inventory_flags = NOQUICKEQUIP|NOSLIPPING
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.7

/obj/item/clothing/shoes/jackboots
	name = "jackboots"
	desc = "Security combat boots for combat scenarios or combat situations. All combat, all the time."
	icon_state = "jackboots"
	worn_icon_state = "jackboots"
	siemens_coefficient = 0.7

/obj/item/clothing/shoes/jackboots/mp
	soft_armor = list(MELEE = 10, BULLET = 85, LASER = 85, ENERGY = 5, BOMB = 0, BIO = 85, FIRE = 0, ACID = 0)

/obj/item/clothing/shoes/cult
	name = "boots"
	desc = "A pair of boots worn by the followers of Nar-Sie."
	icon_state = "cult"
	worn_icon_state = "cult"
	siemens_coefficient = 0.7

	cold_protection_flags = FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_flags = FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/shoes/slippers
	name = "bunny slippers"
	desc = "Fluffy!"
	icon_state = "slippers"
	worn_icon_state = "slippers"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/shoes/slippers_worn
	name = "worn bunny slippers"
	desc = "Fluffy..."
	icon_state = "slippers_worn"
	worn_icon_state = "slippers_worn"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/shoes/laceup
	name = "laceup shoes"
	desc = "The height of fashion, and they're pre-polished!"
	icon_state = "laceups"

/obj/item/clothing/shoes/swimmingfins
	desc = "Help you swim good."
	name = "swimming fins"
	icon_state = "flippers"
	inventory_flags = NOSLIPPING
	slowdown = SHOES_SLOWDOWN+1

/obj/item/clothing/shoes/snow
	name = "snow boots"
	desc = "When you feet are as cold as your heart"
	icon_state = "swat"
	siemens_coefficient = 0.6
	cold_protection_flags = FEET
	heat_protection_flags = FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/shoes/techpriest
	name = "Techpriest boots"
	desc = "Praise the machine spirit!"
	icon_state = "tp_boots"
	worn_icon_state = "tp_boots"
	inventory_flags = NOSLIPPING
