GLOBAL_LIST_INIT(all_assembly_craft_groups, list("Operations", "Weapons", "Explosives", "Armor", "Clothing", "Medical", "Engineering", "Supplies", "Imports", "Vehicles", "Factory"))

/datum/assembly_craft
	var/name
	var/notes
	var/list/input
	var/list/output
	var/craft_time = 1 SECONDS
	var/group

//metal = 4 point
//glass = 2 point
//plasteel = 8 points
//phoron = 6.6 points
//gun powder ~ 8 or 0 points, only fabricated so no exact prices
//cloth = 4 point

/datum/assembly_craft/operations
	group = "Operations"

/datum/assembly_craft/engineering
	group = "Engineering"

/datum/assembly_craft/engineering/plas50
	name = "50 plasteel sheets"
	craft_time = 10 SECONDS
	input = list(/obj/item/stack/sheet/metal = 50, /obj/item/stack/sheet/mineral/phoron = 30) // 200 + 200 points
	output = list(/obj/item/stack/sheet/plasteel/large_stack = 1) // 400 points. metal is fabricated so it worth it

/datum/assembly_craft/weapons
	group = "Weapons"

/datum/assembly_craft/weapons/smartgun_ammo
	name = "SG-29 drum magazine"
	craft_time = 10 SECONDS
	input = list(/obj/item/stack/sheet/plasteel = 5, /obj/item/stack/gun_powder = 5) // 40 + 40 points
	output = list(/obj/item/ammo_magazine/standard_smartmachinegun = 2) // 100 points

/*******************************************************************************
EXPLOSIVES
*******************************************************************************/
/datum/assembly_craft/explosives
	group = "Explosives"

//-------------------------------------------------------
//nades

/datum/assembly_craft/explosives/phosphos
	name = "M40 HPDP grenade"
	craft_time = 2 SECONDS
	input = list(/obj/item/stack/sheet/plasteel = 5, /obj/item/stack/gun_powder = 5) // 40 + 40 points
	output = list(/obj/item/explosive/grenade/phosphorus = 2) // 72 points from old factory

/datum/assembly_craft/explosives/bignade
	name = "M15 fragmentation grenade"
	input = list(/obj/item/stack/sheet/metal = 5, /obj/item/stack/gun_powder = 3) // 20 + 24 points
	output = list(/obj/item/explosive/grenade/m15 = 2) // 33 points from old factory

//-------------------------------------------------------
//RL-152

/datum/assembly_craft/explosives/sadar_he
	name = "SADAR HE missile - 84mm 'L-G' high-explosive rocket"
	input = list(/obj/item/stack/sheet/plasteel = 5, /obj/item/stack/gun_powder = 5) // 40 + 40 points
	output = list(/obj/item/ammo_magazine/rocket/sadar = 1) // 33 points from old factory

/datum/assembly_craft/explosives/sadar_he_unguided
	name = "SADAR HE unguided missile - 84mm 'Unguided' high-explosive rocket"
	input = list(/obj/item/stack/sheet/plasteel = 5, /obj/item/stack/gun_powder = 5) // 40 + 40 points
	output = list(/obj/item/ammo_magazine/rocket/sadar/unguided = 1) // 33 points from old factory

/datum/assembly_craft/explosives/sadar_ap
	name = "SADAR AP missile - 84mm 'L-G' anti-armor rocket"
	input = list(/obj/item/stack/sheet/plasteel = 8, /obj/item/stack/gun_powder = 5) // 64 + 40 points
	output = list(/obj/item/ammo_magazine/rocket/sadar/ap = 1) // 40 points from old factory

/datum/assembly_craft/explosives/sadar_wp
	name = "SADAR WP missile - 84mm 'L-G' white-phosphorus rocket"
	input = list(/obj/item/stack/sheet/plasteel = 4, /obj/item/stack/gun_powder = 5) // 32 + 40 points
	output = list(/obj/item/ammo_magazine/rocket/sadar/wp = 1) // 26.6 points from old factory

//-------------------------------------------------------
//RL-160 recoilless rifle

/datum/assembly_craft/explosives/standard_recoilless_refill
	name = "Recoilless standard missile - 67mm high-explosive shell"
	input = list(/obj/item/stack/sheet/metal = 5, /obj/item/stack/gun_powder = 2) // 20 + 16 points
	output = list(/obj/item/ammo_magazine/rocket/recoilless = 1) // 20 points from old factory

/datum/assembly_craft/explosives/light_recoilless_refill
	name = "Recoilless light missile - 67mm light-explosive shell"
	input = list(/obj/item/stack/sheet/metal = 5, /obj/item/stack/gun_powder = 2) // 20 + 16 points
	output = list(/obj/item/ammo_magazine/rocket/recoilless/light = 1) // 20 points from old factory

/datum/assembly_craft/explosives/heat_recoilless_refill
	name = "Recoilless heat missile - 67mm HEAT shell"
	input = list(/obj/item/stack/sheet/metal = 5, /obj/item/stack/gun_powder = 2) // 20 + 16 points
	output = list(/obj/item/ammo_magazine/rocket/recoilless/heat = 1) // 20 points from old factory

/datum/assembly_craft/explosives/smoke_recoilless_refill
	name = "Recoilless smoke missile - 67mm Chemical (Smoke) shell"
	input = list(/obj/item/stack/sheet/metal = 5, /obj/item/stack/gun_powder = 2) // 20 + 16 points
	output = list(/obj/item/ammo_magazine/rocket/recoilless/smoke = 1) // 20 points from old factory

/datum/assembly_craft/explosives/cloak_recoilless_refill
	name = "Recoilless cloak missile - 67mm Chemical (Cloak) shell"
	input = list(/obj/item/stack/sheet/metal = 5, /obj/item/stack/gun_powder = 2) // 20 + 16 points
	output = list(/obj/item/ammo_magazine/rocket/recoilless/cloak = 1) // 20 points from old factory

/datum/assembly_craft/explosives/tfoot_recoilless_refill
	name = "Recoilless tfoot missile - 67mm Chemical (Tanglefoot) shell"
	input = list(/obj/item/stack/sheet/metal = 5, /obj/item/stack/gun_powder = 2) // 20 + 16 points
	output = list(/obj/item/ammo_magazine/rocket/recoilless/plasmaloss = 1) // 20 points from old factory

//-------------------------------------------------------
//Ammo
