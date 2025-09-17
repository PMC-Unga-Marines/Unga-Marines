/obj/item/clothing/shoes/marine
	name = "marine combat boots"
	desc = "Standard issue combat boots for combat scenarios or combat situations. All combat, all the time."
	icon_state = "marine"
	worn_icon_state = "marine"
	armor_protection_flags = FEET
	cold_protection_flags = FEET
	heat_protection_flags = FEET
	inventory_flags = NOQUICKEQUIP|NOSLIPPING
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.7
	storage_type = /datum/storage/internal/shoes
	/// The knife we add to the storage on Initialize
	var/obj/item/knife_to_add

/obj/item/clothing/shoes/marine/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/clothing/shoes/marine/PopulateContents()
	if(knife_to_add)
		new knife_to_add(src)

/obj/item/clothing/shoes/marine/update_icon_state()
	. = ..()
	icon_state = initial(icon_state)
	if(!storage_datum)
		return
	for(var/obj/item/item AS in contents)
		if(!istype(item, /obj/item/weapon/combat_knife) && !istype(item, /obj/item/attachable/bayonetknife) && !istype(item, /obj/item/stack/throwing_knife))
			continue
		icon_state += "-knife"
		break

/obj/item/clothing/shoes/marine/full
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/brown
	name = "brown marine combat boots"
	icon_state = "marine_brown"
	worn_icon_state = "marine_brown"

/obj/item/clothing/shoes/marine/brown/full
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/upp
	knife_to_add = /obj/item/weapon/combat_knife/upp

/obj/item/clothing/shoes/marinechief
	name = "chief officer shoes"
	desc = "Only a small amount of monkeys, kittens, and orphans were killed in making this."
	icon_state = "laceups"
	soft_armor = list(MELEE = 35, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 25)
	inventory_flags = NOSLIPPING
	siemens_coefficient = 0.6

/obj/item/clothing/shoes/marinechief/captain
	name = "captain's shoes"
	desc = "Has special soles for better trampling those underneath."

/obj/item/clothing/shoes/marinechief/som
	name = "officer's boots"
	desc = "A shiny pair of boots, normally seen on the feet of SOM officers."
	icon_state = "som_officer_boots"

/obj/item/clothing/shoes/marinechief/sa
	name = "spatial agent's shoes"
	desc = "Shoes worn by a spatial agent."
	item_flags = DELONDROP

/obj/item/clothing/shoes/marine/pmc
	name = "polished shoes"
	desc = "The height of fashion, but these look to be woven with protective fiber."
	icon_state = "jackboots"
	worn_icon_state = "jackboots"
	armor_protection_flags = FEET
	soft_armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 15)
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE
	cold_protection_flags = FEET
	heat_protection_flags = FEET
	inventory_flags = NOSLIPPING
	siemens_coefficient = 0.6

/obj/item/clothing/shoes/marine/pmc/full
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/deathsquad
	name = "\improper PMC commando boots"
	desc = "A pair of heavily armored, acid-resistant boots."
	icon_state = "commando_boots"
	worn_icon_state = "commando_boots"
	permeability_coefficient = 0.01
	soft_armor = list(MELEE = 40, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 25)
	siemens_coefficient = 0.2
	resistance_flags = UNACIDABLE

/obj/item/clothing/shoes/marine/deathsquad
	knife_to_add = /obj/item/weapon/combat_knife

/*=========Imperium=========*/

/obj/item/clothing/shoes/marine/imperial
	name = "guardsmen combat boots"
	desc = "A pair of boots issued to the Imperial Guard, just like anything else they use, they are mass produced."
	//icon_state = ""
	soft_armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 25)

/obj/item/clothing/shoes/marine/som
	name = "\improper S11 combat shoes"
	desc = "Shoes with origins dating back to the old mining colonies. These were made for more than just walking."
	icon_state = "som"
	worn_icon_state = "som"

/obj/item/clothing/shoes/marine/som/knife
	knife_to_add = /obj/item/attachable/bayonetknife/som

/obj/item/clothing/shoes/sectoid
	name = "psionic field"
	desc = "A field of invisible energy, it protects the wearer but prevents any clothing from being worn."
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield-blue"
	item_flags = DELONDROP
	soft_armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 25)
	inventory_flags = NOSLIPPING

/obj/item/clothing/shoes/sectoid/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, SECTOID_TRAIT)

/obj/item/clothing/shoes/cowboy
	name = "sturdy western boots"
	desc = "As sturdy as they are old fashioned these will keep your ankles from snake bites on any planet. These cannot store anything, but has extra fashion with those unneeded spurs on their heels."
	icon_state = "cboots"
	worn_icon_state = "cboots"

/obj/item/clothing/shoes/marine/clf
	name = "\improper frontier boots"
	desc = "A pair of well worn boots, commonly seen on most outer colonies."
	icon_state = "boots"
	worn_icon_state = "boots"

/obj/item/clothing/shoes/marine/vsd
	name = "\improper combat boots"
	desc = "V.S.D's standard issue combat boots"
	icon_state = "boots"
	worn_icon_state = "boots"

/obj/item/clothing/shoes/marine/vsd/full
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/clf/full
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/icc
	name = "\improper Modelle/32 combat shoes"
	desc = "A set of sturdy working boots."
	icon_state = "icc"

/obj/item/clothing/shoes/marine/icc/knife
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/icc/guard
	name = "\improper Modelle/33 tactical shoes"
	desc = "A set of sturdy tactical boots."
	icon_state = "icc_guard"

/obj/item/clothing/shoes/marine/icc/guard/knife
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/headskin
	name = "marine veteran combat boots"
	desc = "Usual combat boots. There is nothing unusual about them. Nothing."
	icon_state = "headskin"
	worn_icon_state = "headskin"

/obj/item/clothing/shoes/marine/headskin
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/separatist
	name = "Reinforced boots TS-28"
	desc = "Well-robusted rubberized boots that protect against moisture, small fragments and impacts. The artisanal design of these shoes, of course, was canceled by production machines in order to provide for all employees as much as possible."
	icon_state = "separatist"
	worn_icon_state = "separatist"

/obj/item/clothing/shoes/marine/separatist
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/srf //Basically SWAT shoes combined with galoshes.
	name = "combat boots"
	desc = "When you REALLY want to turn up the heat"
	icon_state = "swat"
	worn_icon_state = "swat"
	item_flags = SYNTH_RESTRICTED
	soft_armor = list(MELEE = 80, BULLET = 60, LASER = 50, ENERGY = 25, BOMB = 50, BIO = 10, FIRE = 25, ACID = 25)
	inventory_flags = NOSLIPPING
	siemens_coefficient = 0.6

	cold_protection_flags = FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_flags = FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/shoes/marine/srf/full
	knife_to_add = /obj/item/weapon/combat_knife
