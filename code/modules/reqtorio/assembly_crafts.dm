GLOBAL_LIST_INIT(all_assembly_craft_groups, list("Operations", "Weapons", "Explosives", "Armor", "Clothing", "Medical", "Engineering", "Supplies", "Imports", "Vehicles", "Factory"))

/datum/assembly_craft
	var/name
	var/notes
	var/list/input
	var/list/output
	var/craft_time = 1 SECONDS
	var/group

/datum/assembly_craft/operations
	group = "Operations"

/datum/assembly_craft/engineering
	group = "Engineering"

/datum/assembly_craft/engineering/plas50
	name = "50 plasteel sheets"
	notes = "50 plasteel sheets craft"
	craft_time = 10 SECONDS
	input = list(/obj/item/stack/sheet/metal = 25, /obj/item/stack/sheet/mineral/phoron = 15) // 50 + 50 points
	output = list(/obj/item/stack/sheet/plasteel/large_stack = 1) // 200 points

/datum/assembly_craft/weapons
	group = "Weapons"

/datum/assembly_craft/weapons/smartgun_ammo
	name = "SG-29 drum magazine"
	notes = "A wide drum magazine carefully filled to capacity with 10x26mm specialized smart rounds."
	craft_time = 10 SECONDS
	input = list(/obj/item/stack/sheet/plasteel = 10, /obj/item/stack/gun_powder = 40) // 40 + x points
	output = list(/obj/item/ammo_magazine/standard_smartmachinegun = 1) // 50 points
