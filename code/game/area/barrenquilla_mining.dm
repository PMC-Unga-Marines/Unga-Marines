// Barrenquilla "Barren" Mining Facility

//Base Area

//Why is /area/barren a lava area?
/area/barren
	name = "Lava"
	icon_state = "lava"
	always_unpowered = TRUE

//Caves
/area/lavaland/cave
	minimap_color = MINIMAP_AREA_CAVES

/area/barren/cave
	name = "Caves"
	ambience = list('sound/ambience/ambicave.ogg', 'sound/ambience/ambilava1.ogg', 'sound/ambience/ambilava2.ogg', 'sound/ambience/ambilava3.ogg')
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_COLONY

/area/barren/cave/central
	name = "Central Caves"
	icon_state = "lava_cave_c"

/area/barren/cave/north
	name = "North Caves"
	icon_state = "lava_cave_n"

/area/barren/cave/northeast
	name = "North East Caves"
	icon_state = "lava_cave_ne"

/area/barren/cave/northwest
	name = "North West Caves"
	icon_state = "lava_cave_nw"

/area/barren/cave/east
	name = "East Caves"
	icon_state = "lava_cave_e"

/area/barren/cave/west
	name = "West Caves"
	icon_state = "lava_cave_w"

/area/barren/cave/lz1
	name = "Landing Zone 1"
	icon_state = "lava_lz1"
	outside = FALSE
	always_unpowered = FALSE

/area/barren/cave/lz2
	name = "Landing Zone 2"
	icon_state = "lava_lz2"
	outside = FALSE
	always_unpowered = FALSE

/area/barren/caves
	name = "Unknown Area"
	icon_state = "bluenew"
	ceiling = CEILING_DEEP_UNDERGROUND
	outside = FALSE
	ambience = list('sound/ambience/ambicave.ogg', 'sound/ambience/ambilava1.ogg', 'sound/ambience/ambilava2.ogg', 'sound/ambience/ambilava3.ogg')
	minimap_color = MINIMAP_AREA_CAVES
	always_unpowered = TRUE

/area/barren/caves/rock
	name = "Enclosed Area"
	icon_state = "transparent"

/area/barren/caves/southwest
	name = "South West Caves"
	icon_state = "lava_cave_sw"

/area/barren/caves/south
	name = "South Caves"
	icon_state = "lava_cave_s"

/area/barren/caves/southeast
	name = "South East Caves"
	icon_state = "lava_cave_se"


//Medical

/area/barren/medical
	name = "Medical Clinic"
	icon_state = "lava_med"
	outside = FALSE
	minimap_color = MINIMAP_AREA_MEDBAY
	always_unpowered = FALSE

/area/barren/medical/chemistry
	name = "Medical Clinic Chemistry"
	icon_state = "lava_chem"

/area/barren/medical/cmo
	name = "Chief Medical Office"
	icon_state = "lava_cmo"

/area/barren/medical/research
	name = "Research Outpost"
	icon_state = "lava_research"
	ceiling = CEILING_DEEP_UNDERGROUND

//"Engineer"
/area/barren/engie
	outside = FALSE
	icon_state = "lava_engine"
	minimap_color = MINIMAP_AREA_ENGI
	always_unpowered = FALSE

/area/barren/engie/one
	name = "Generator One"
	icon_state = "lava_eng1"

/area/barren/engie/two
	name = "Generator Two"
	icon_state = "lava_eng2"

/area/barren/engie/three
	name = "Generator Three"
	icon_state = "lava_eng3"

/area/barren/engie/engine
	name = "Engineering Facility"
	icon_state = "lava_eng4"

//Security

/area/barren/security
	name = "Prison Facility"
	icon_state = "lava_sec_prison"
	outside = FALSE
	minimap_color = MINIMAP_AREA_SEC
	always_unpowered = FALSE

/area/barren/security/storage
	name = "Prison Facility Storage"
	icon_state = "lava_sec_secure"

/area/barren/security/infocenter
	name = "Prison Facility Information Center"
	icon_state = "lava_sec"

/area/barren/security/nuke
	name = "Emergency Nuclear Fission Facility"
	icon_state = "lava_sec_nuke"
	ceiling = CEILING_DEEP_UNDERGROUND

//Civilian

/area/barren/civilian
	name = "Civilian Housing"
	icon_state = "lava_civ"
	minimap_color = MINIMAP_AREA_LIVING
	ceiling = CEILING_METAL
	outside = FALSE
	always_unpowered = FALSE

/area/barren/civilian/cook
	name = "Civilian Kitchen"
	icon_state = "lava_civ_cook"

/area/barren/civilian/botany
	name = "Civilian Botany"
	icon_state = "lava_civ_bot"

/area/barren/civilian/garden
	name = "Civilian Garden"
	icon_state = "lava_civ_garden"

/area/barren/civilian/cargo
	name = "Civilian Cargo"
	icon_state = "lava_civ_cargo"

/area/barren/civilian/workdorm
	name = "Worker Dormitory"
	icon_state = "lava_work_dorm"
	ceiling = CEILING_DEEP_UNDERGROUND
	outside = FALSE
	minimap_color = MINIMAP_AREA_CAVES

/area/barren/civilian/laundry
	name = "Laundry"
	icon_state = "bluenew"

//Misc Locations

/area/lavaland/misc
	minimap_color = MINIMAP_AREA_COLONY

/area/barren/misc
	minimap_color = MINIMAP_AREA_COLONY
	outside = FALSE

/area/barren/misc/stationed
	name = "Stationed Ship"
	icon_state = "lava_misc_stationed"

/area/barren/misc/outpost
	name = "Abandoned Outpost"
	icon_state = "lava_misc_outpost"

/area/barren/misc/alienstorage
	name = "Alien Storage"
	icon_state = "lava_misc_alienstorage"

/area/barren/misc/shack
	name = "Shack"
	icon_state = "lava_misc_shack"

/area/barren/misc/genstorage
	name = "General Storage"
	icon_state =  "lava_misc_genstorage"
	always_unpowered = FALSE

/area/barren/misc/eastarmory
	name = "Eastern Armory"
	icon_state =  "lava_misc_armory1"
	always_unpowered = FALSE

/area/barren/misc/westarmory
	name = "Western Armory"
	icon_state =  "lava_misc_armory2"

/area/barren/misc/refinery
	name = "Ore Processing Facility"
	icon_state = "lava_misc_refinery"
	minimap_color = MINIMAP_AREA_ENGI
	always_unpowered = FALSE

/area/barren/misc/crashed
	name = "Crashed Ship"
	icon_state = "lava_misc_crashed"

/area/barren/misc/clocknuke //This'll come into play later
	name = "The Brass Gavel"
	icon_state = "lava_clock_nuke"
	requires_power = 0

/area/barren/misc/ashshelter
	name = "Ash Shelter"
	icon_state = "lava_ash_shelter"
	always_unpowered = FALSE

/area/barren/misc/ruin
	name = "\improper Unknown structure"
	icon_state = "red"
