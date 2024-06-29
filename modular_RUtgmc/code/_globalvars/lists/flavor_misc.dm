//Backpacks
GLOBAL_LIST_INIT(backpacklist, list("Nothing", "Backpack", "Satchel", "Green Satchel", "Molle Backpack", "Molle Satchel", "Scav Backpack"))

GLOBAL_LIST_INIT(playable_icons, list(
	"behemoth",
	"boiler",
	"bull",
	"captain",
	"clown",
	"military_police",
	"carrier",
	"chief_medical",
	"cl",
	"crusher",
	"cse",
	"defender",
	"defiler",
	"drone",
	"facehugger",
	"fieldcommander",
	"gorger",
	"hivelord",
	"hivemind",
	"hunter",
	"larva",
	"mech_pilot",
	"medical",
	"panther",
	"pilot",
	"praetorian",
	"private",
	"ravager",
	"requisition",
	"researcher",
	"runner",
	"sentinel",
	"spitter",
	"st",
	"staffofficer",
	"synth",
	"warlock",
	"warrior",
	"xenoking",
	"xenominion",
	"xenoqueen",
	"xenoshrike",
	"chimera",
	"predator",
	"thrall",
	"hellhound",
))

GLOBAL_LIST_EMPTY(human_ethnicities_list)
GLOBAL_LIST_EMPTY(yautja_ethnicities_list)

GLOBAL_LIST_EMPTY(yautja_hair_styles_list)

GLOBAL_LIST_INIT(ethnicities_list, init_ethnicities())

/// Ethnicity - Initialise all /datum/ethnicity into a list indexed by ethnicity name
/proc/init_ethnicities()
	. = list()

	for(var/path in subtypesof(/datum/ethnicity) - /datum/ethnicity/human - /datum/ethnicity/yautja)
		var/datum/ethnicity/E = new path()
		.[E.name] = E

		if(istype(E, /datum/ethnicity/human))
			GLOB.human_ethnicities_list[E.name] = E

		if(istype(E, /datum/ethnicity/yautja))
			GLOB.yautja_ethnicities_list[E.name] = E

	for(var/path in subtypesof(/datum/sprite_accessory/yautja_hair))
		var/datum/sprite_accessory/yautja_hair/H = new path()
		GLOB.yautja_hair_styles_list[H.name] = H


GLOBAL_LIST_INIT(minimap_icons, init_minimap_icons())

/proc/init_minimap_icons()
	. = list()
	for(var/icon_state in GLOB.playable_icons)
		.[icon_state] = icon2base64(icon('modular_RUtgmc/icons/UI_icons/map_blips.dmi', icon_state, frame = 1)) //RUTGMC edit - icon change
