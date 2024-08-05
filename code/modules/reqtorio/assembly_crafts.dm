GLOBAL_LIST_INIT(all_assembly_craft_groups, list("Operations", "Weapons", "Explosives", "Armor", "Clothing", "Medical", "Engineering", "Supplies", "Imports", "Vehicles", "Factory"))

/datum/assembly_craft
	var/name
	var/notes
	var/list/input
	var/list/output
	var/craft_time = 1 SECONDS
	var/group

//metal = 4 points
//silver = 8 points //used to craft osmium
//glass = 2 points
//osmium = 6 points //only craftable
//plasteel = 8 points
//phoron = 6.6 points //craft using junk
//gun powder ~ 8 or 0 points, only fabricated so no exact prices
//cloth = 4 points
//platinum = 12 points
//copper = 4 points
//junk ~ 6.6 points so expensive.. for junk

/datum/assembly_craft/engineering
	group = "Engineering"
	craft_time = 10 SECONDS

/datum/assembly_craft/engineering/plas50
	name = "50 plasteel sheets"
	input = list(/obj/item/stack/sheet/metal = 50, /obj/item/stack/sheet/mineral/phoron = 30) // 200 + 200 points
	output = list(/obj/item/stack/sheet/plasteel/large_stack = 1) // 400 points. metal is fabricated so it worth it

/datum/assembly_craft/engineering/plas_deconstruction
	name = "Break plasteel sheets into iron and phoron"
	input = list(/obj/item/stack/sheet/plasteel = 50) // Vice versa
	output = list(/obj/item/stack/sheet/metal/large_stack = 1, /obj/item/stack/sheet/mineral/phoron/medium_stack = 1)

/datum/assembly_craft/engineering/composite
	name = "50 iron-copper composite sheets"
	input = list(/obj/item/stack/sheet/metal = 25, /obj/item/stack/sheet/mineral/copper = 25) // 200 + 200 points
	output = list(/obj/item/stack/sheet/composite/large_stack = 1) // 400 points

/datum/assembly_craft/engineering/jeweler_steel
	name = "3 jeweler steel sheets"
	input = list(/obj/item/stack/sheet/metal = 2, /obj/item/stack/sheet/mineral/platinum = 1) // 8 + 12 points
	output = list(/obj/item/stack/sheet/jeweler_steel = 3) // 20 points

/datum/assembly_craft/engineering/osmium50_silver
	name = "50 osmium sheets via silver"
	input = list(/obj/item/stack/sheet/mineral/silver = 25, /obj/item/stack/sheet/mineral/phoron = 10) // 200 + 66 points
	output = list(/obj/item/stack/sheet/mineral/osmium/large_stack = 1) // ~300 points, let's imagine that these are atomic reactions

/datum/assembly_craft/engineering/osmium50_copper
	name = "50 osmium sheets via copper"
	input = list(/obj/item/stack/sheet/mineral/copper = 50, /obj/item/stack/sheet/mineral/phoron = 10)
	output = list(/obj/item/stack/sheet/mineral/osmium/large_stack = 1) // dont count

/datum/assembly_craft/engineering/osmium50_plasteel
	name = "50 osmium sheets via plasteel"
	input = list(/obj/item/stack/sheet/plasteel = 25, /obj/item/stack/sheet/mineral/phoron = 15)
	output = list(/obj/item/stack/sheet/mineral/osmium/large_stack = 1) // dont count

/datum/assembly_craft/engineering/junk_platinum_convert
	name = "Сlearing junk in various resources like copper and platinum"
	craft_time = 15 SECONDS
	input = list(/obj/item/stack/sheet/mineral/junk = 5) // 20 points
	output = list(/obj/item/stack/sheet/mineral/copper = 4, /obj/item/stack/sheet/mineral/platinum = 1) //12 + 12

/datum/assembly_craft/engineering/junk_silver_convert
	name = "Сlearing junk in various resources like plasteel and silver"
	craft_time = 15 SECONDS
	input = list(/obj/item/stack/sheet/mineral/junk = 4) // 20 points
	output = list(/obj/item/stack/sheet/plasteel = 1, /obj/item/stack/sheet/mineral/silver = 1) //~ 8 + 8

/datum/assembly_craft/engineering/junk_phoron_convert
	name = "Сlearing junk in phoron and glass? Explosion transformation power!"
	craft_time = 15 SECONDS
	input = list(/obj/item/stack/sheet/mineral/junk = 4) // 20 points
	output = list(/obj/item/stack/sheet/glass = 3, /obj/item/stack/sheet/mineral/phoron = 1) //that expensive! but automized!

//one in one craft cuz junk is multi use resource
/datum/assembly_craft/engineering/junk_phoron_iron
	name = "Сlearing junk in iron"
	craft_time = 15 SECONDS
	input = list(/obj/item/stack/sheet/mineral/junk = 50) // 300 from cargo
	output = list(/obj/item/stack/sheet/metal/large_stack = 1) //200 points so what?

/datum/assembly_craft/engineering/drop_pod
	name = "Zeus orbital drop pod assembly refill"
	craft_time = 20 SECONDS
	input = list(/obj/item/stack/sheet/plasteel = 5, /obj/item/stack/sheet/glass = 3) // 40 + 6
	output = list(/obj/structure/drop_pod_launcher = 1) //40 points

/*******************************************************************************
CLOTHING
*******************************************************************************/
/datum/assembly_craft/clothing
	group = "Clothing"

/datum/assembly_craft/clothing/swat_mask
	name = "SWAT mask"
	input = list(/obj/item/stack/sheet/plasteel = 3, /obj/item/stack/sheet/glass = 3) // 24 + 6 points
	output = list(/obj/item/clothing/mask/gas/swat = 1) // 25 points from old factory


/*******************************************************************************
EXPLOSIVES
*******************************************************************************/
/datum/assembly_craft/explosives
	group = "Explosives"
	craft_time = 8 SECONDS

/datum/assembly_craft/explosives/claymore
	name = "M20 Claymore anti-personnel mine"
	input = list(/obj/item/stack/sheet/composite = 2, /obj/item/stack/gun_powder = 1) // 8 + 8 points
	output = list(/obj/item/explosive/mine = 1) // 10 points from old factory

//-------------------------------------------------------
//nades

/datum/assembly_craft/explosives/phosphos
	name = "M40 HPDP grenade"
	input = list(/obj/item/stack/sheet/plasteel = 5, /obj/item/stack/gun_powder = 3) // 40 + 24 points
	output = list(/obj/item/explosive/grenade/phosphorus = 2) // 72 points from old factory

/datum/assembly_craft/explosives/bignade
	name = "M15 fragmentation grenade"
	input = list(/obj/item/stack/sheet/metal = 5, /obj/item/stack/gun_powder = 2) // 20 + 16 points
	output = list(/obj/item/explosive/grenade/m15 = 2) // 33 points from old factory

/datum/assembly_craft/explosives/razornade
	name = "Razorburn Grenade"
	input = list(/obj/item/stack/sheet/composite = 5, /obj/item/stack/gun_powder = 1) // 20 + 8 points
	output = list(/obj/item/explosive/grenade/chem_grenade/razorburn_smol = 1) // 16.6 points from old factory

//-------------------------------------------------------
//RL-152

/datum/assembly_craft/explosives/sadar_he
	name = "SADAR HE missile - 84mm 'L-G' high-explosive rocket"
	input = list(/obj/item/stack/sheet/jeweler_steel = 5, /obj/item/stack/gun_powder = 5) // 40 + 40 points
	output = list(/obj/item/ammo_magazine/rocket/sadar = 1) // 33 points from old factory

/datum/assembly_craft/explosives/sadar_he_unguided
	name = "SADAR HE unguided missile - 84mm 'Unguided' high-explosive rocket"
	input = list(/obj/item/stack/sheet/jeweler_steel = 5, /obj/item/stack/gun_powder = 5) // 40 + 40 points
	output = list(/obj/item/ammo_magazine/rocket/sadar/unguided = 1) // 33 points from old factory

/datum/assembly_craft/explosives/sadar_ap
	name = "SADAR AP missile - 84mm 'L-G' anti-armor rocket"
	input = list(/obj/item/stack/sheet/jeweler_steel = 8, /obj/item/stack/gun_powder = 5) // 64 + 40 points
	output = list(/obj/item/ammo_magazine/rocket/sadar/ap = 1) // 40 points from old factory

/datum/assembly_craft/explosives/sadar_wp
	name = "SADAR WP missile - 84mm 'L-G' white-phosphorus rocket"
	input = list(/obj/item/stack/sheet/jeweler_steel = 4, /obj/item/stack/gun_powder = 5) // 32 + 40 points
	output = list(/obj/item/ammo_magazine/rocket/sadar/wp = 1) // 26.6 points from old factory

//-------------------------------------------------------
//RL-160 recoilless rifle

/datum/assembly_craft/explosives/standard_recoilless_refill
	name = "Recoilless standard missile - 67mm high-explosive shell"
	input = list(/obj/item/stack/sheet/composite = 5, /obj/item/stack/gun_powder = 3) // 20 + 16 points
	output = list(/obj/item/ammo_magazine/rocket/recoilless = 1) // 20 points from old factory

/datum/assembly_craft/explosives/light_recoilless_refill
	name = "Recoilless light missile - 67mm light-explosive shell"
	input = list(/obj/item/stack/sheet/composite = 5, /obj/item/stack/gun_powder = 3) // 20 + 16 points
	output = list(/obj/item/ammo_magazine/rocket/recoilless/light = 1) // 20 points from old factory

/datum/assembly_craft/explosives/heat_recoilless_refill
	name = "Recoilless heat missile - 67mm HEAT shell"
	input = list(/obj/item/stack/sheet/composite = 5, /obj/item/stack/gun_powder = 3) // 20 + 16 points
	output = list(/obj/item/ammo_magazine/rocket/recoilless/heat = 1) // 20 points from old factory

/datum/assembly_craft/explosives/smoke_recoilless_refill
	name = "Recoilless smoke missile - 67mm Chemical (Smoke) shell"
	input = list(/obj/item/stack/sheet/composite = 5, /obj/item/stack/gun_powder = 3) // 20 + 16 points
	output = list(/obj/item/ammo_magazine/rocket/recoilless/smoke = 1) // 20 points from old factory

/datum/assembly_craft/explosives/cloak_recoilless_refill
	name = "Recoilless cloak missile - 67mm Chemical (Cloak) shell"
	input = list(/obj/item/stack/sheet/composite = 5, /obj/item/stack/gun_powder = 3) // 20 + 16 points
	output = list(/obj/item/ammo_magazine/rocket/recoilless/cloak = 1) // 20 points from old factory

/datum/assembly_craft/explosives/tfoot_recoilless_refill
	name = "Recoilless tfoot missile - 67mm Chemical (Tanglefoot) shell"
	input = list(/obj/item/stack/sheet/jeweler_steel = 5, /obj/item/stack/gun_powder = 3) // 20 + 16 points
	output = list(/obj/item/ammo_magazine/rocket/recoilless/plasmaloss = 1) // 20 points from old factory

/*******************************************************************************
WEAPONS
*******************************************************************************/

/datum/assembly_craft/weapons
	group = "Weapons"
	craft_time = 5 SECONDS

/datum/assembly_craft/weapons/smartgun_minigun_box
	name = "SG-85 ammo bin"
	input = list(/obj/item/stack/sheet/mineral/osmium = 5, /obj/item/stack/gun_powder = 1) // 30 + 8 points
	output = list(/obj/item/ammo_magazine/packet/smart_minigun = 1) // 25 points from old factory

/datum/assembly_craft/weapons/smartgun_magazine
	name = "SG-29 ammo drum"
	input = list(/obj/item/stack/sheet/mineral/osmium = 5, /obj/item/stack/gun_powder = 1) // 30 + 8 points
	output = list(/obj/item/ammo_magazine/standard_smartmachinegun = 1) // 25 points from old factory

/datum/assembly_craft/weapons/smartgun_targetrifle
	name = "SG-62 ammo magazine"
	input = list(/obj/item/stack/sheet/mineral/osmium = 5, /obj/item/stack/gun_powder = 1) // 30 + 8 points
	output = list(/obj/item/ammo_magazine/rifle/standard_smarttargetrifle = 1) // 25 points from old factory

/datum/assembly_craft/weapons/autosniper_magazine
	name = "SR-81 IFF Auto Sniper magazine"
	input = list(/obj/item/stack/sheet/mineral/platinum = 1, /obj/item/stack/gun_powder = 2) // 12 + 16 points
	output = list(/obj/item/ammo_magazine/rifle/autosniper = 1) // 13.3 points from old factory

/datum/assembly_craft/weapons/scout_rifle_magazine
	name = "BR-8 scout rifle magazine"
	input = list(/obj/item/stack/sheet/plasteel = 1, /obj/item/stack/gun_powder = 1) // 8 + 16 points
	output = list(/obj/item/ammo_magazine/rifle/autosniper = 1) // 10 points from old factory

/datum/assembly_craft/weapons/mateba_speedloader
	name = "Mateba autorevolver speedloader"
	input = list(/obj/item/stack/sheet/plasteel = 1, /obj/item/stack/gun_powder = 1) // 8 + 8 points
	output = list(/obj/item/ammo_magazine/revolver/mateba = 1) // 10 points from old factory

/datum/assembly_craft/weapons/mateba_speedloader
	name = "Mateba autorevolver speedloader"
	input = list(/obj/item/stack/sheet/plasteel = 1, /obj/item/stack/gun_powder = 1) // 8 + 8 points
	output = list(/obj/item/ammo_magazine/revolver/mateba = 1) // 10 points from old factory

/datum/assembly_craft/weapons/railgun_magazine
	name = "Railgun magazine"
	input = list(/obj/item/stack/sheet/mineral/silver = 1, /obj/item/stack/gun_powder = 1) // 8 + 8 points
	output = list(/obj/item/ammo_magazine/railgun = 1) // 10 points from old factory

/datum/assembly_craft/weapons/minigun_powerpack
	name = "Railgun magazine"
	input = list(/obj/item/stack/sheet/plasteel = 2, /obj/item/stack/gun_powder = 2) // 16 + 16 points
	output = list(/obj/item/ammo_magazine/minigun_powerpack = 1) // 25 points from old factory

/datum/assembly_craft/weapons/howitzer_shell_he_refill
	name = "T-26 AMR magazine"
	input = list(/obj/item/stack/sheet/metal = 4, /obj/item/stack/gun_powder = 1) // 16 + 8 points
	output = list(/obj/item/ammo_magazine/sniper = 1) // 20 points from old factory

/datum/assembly_craft/weapons/amr_magazine_incend
	name = "T-26 AMR incendiary magazine"
	input = list(/obj/item/stack/sheet/metal = 4, /obj/item/stack/gun_powder = 1) // 16 + 8 points
	output = list(/obj/item/ammo_magazine/sniper/incendiary = 1) // 20 points from old factory

/datum/assembly_craft/weapons/amr_magazine_flak
	name = "T-26 AMR flak magazine assembly refill"
	input = list(/obj/item/stack/sheet/metal = 4, /obj/item/stack/gun_powder = 1) // 16 + 8 points
	output = list(/obj/item/ammo_magazine/sniper/flak = 1) // 20 points from old factory

/datum/assembly_craft/weapons/howitzer_shell_he
	name = "Howitzer HE shell"
	input = list(/obj/item/stack/sheet/metal = 6, /obj/item/stack/gun_powder = 2) // 16 + 16 points
	output = list(/obj/item/mortal_shell/howitzer/he = 1) // 26 points from old factory

/datum/assembly_craft/weapons/howitzer_shell_incen_refill
	name = "Howitzer HE shell"
	input = list(/obj/item/stack/sheet/metal = 6, /obj/item/stack/gun_powder = 2) // 16 + 16 points
	output = list(/obj/item/mortal_shell/howitzer/incendiary = 1) // 26 points from old factory

/datum/assembly_craft/weapons/howitzer_shell_wp_refill
	name = "Howitzer HE shell"
	input = list(/obj/item/stack/sheet/metal = 6, /obj/item/stack/gun_powder = 3) // 16 + 24 points
	output = list(/obj/item/mortal_shell/howitzer/white_phos = 1) // 33 points from old factory

/datum/assembly_craft/weapons/howitzer_shell_tfoot_refill
	name = "Howitzer HE shell"
	input = list(/obj/item/stack/sheet/metal = 6, /obj/item/stack/gun_powder = 3) // 16 + 24 points
	output = list(/obj/item/mortal_shell/howitzer/plasmaloss = 1) // 33 points from old factory

/datum/assembly_craft/weapons/mortar_shell_he
	name = "Mortar High Explosive shell"
	input = list(/obj/item/stack/sheet/metal = 1, /obj/item/stack/gun_powder = 1) // 4 + 8 points
	output = list(/obj/item/mortal_shell/he = 1) // 4 points from old factory

/datum/assembly_craft/weapons/mortar_shell_incen
	name = "Mortar Incendiary shell"
	input = list(/obj/item/stack/sheet/metal = 1, /obj/item/stack/gun_powder = 1) // 4 + 8 points
	output = list(/obj/item/mortal_shell/incendiary = 1) // 4 points from old factory

/datum/assembly_craft/weapons/mortar_shell_tfoot
	name = "Mortar Tanglefoot Gas shell"
	input = list(/obj/item/stack/sheet/metal = 2, /obj/item/stack/gun_powder = 1) // 8 + 8 points
	output = list(/obj/item/mortal_shell/plasmaloss = 1) // 6.6 points from old factory

/datum/assembly_craft/weapons/mortar_shell_flare
	name = "Mortar Flare shell"
	input = list(/obj/item/stack/sheet/metal = 1, /obj/item/stack/gun_powder = 1) // 4 + 8 points
	output = list(/obj/item/mortal_shell/flare = 1) // 4 points from old factory

/datum/assembly_craft/weapons/mortar_shell_smoke
	name = "Mortar Smoke shell"
	input = list(/obj/item/stack/sheet/metal = 1, /obj/item/stack/gun_powder = 1) // 4 + 8 points
	output = list(/obj/item/mortal_shell/smoke = 1) // 4 points from old factory

/datum/assembly_craft/weapons/mlrs_rocket
	name = "MLRS High Explosive rocket"
	input = list(/obj/item/stack/sheet/plasteel = 4, /obj/item/stack/gun_powder = 4) // 32 + 32 points
	output = list(/obj/item/storage/box/mlrs_rockets = 1) // 40 points from old factory

/datum/assembly_craft/weapons/mlrs_rocket
	name = "RL-57 Thermobaric WP rocket array"
	input = list(/obj/item/stack/sheet/plasteel = 3, /obj/item/stack/gun_powder = 3) // 24 + 24 points
	output = list(/obj/item/storage/box/mlrs_rockets = 1) // 33 points from old factory
