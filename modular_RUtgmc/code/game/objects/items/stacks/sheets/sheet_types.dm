GLOBAL_LIST_INIT(metal_recipes, list ( \
	new/datum/stack_recipe("metal barricade", /obj/structure/barricade/metal, 4, time = 6 SECONDS, max_per_turf = STACK_RECIPE_ONE_DIRECTIONAL_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("metal folding barricade", /obj/structure/barricade/plasteel/metal, 6, time = 10 SECONDS, max_per_turf = STACK_RECIPE_ONE_DIRECTIONAL_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("barbed wire", /obj/item/stack/barbed_wire, 2, 1, 20, time = 1 SECONDS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("razor wire", /obj/item/stack/razorwire, 4, 2, 20, time = 5 SECONDS, skill_req = SKILL_CONSTRUCTION_METAL), \
	null, \
	new/datum/stack_recipe("apc frame", /obj/item/frame/apc, 2), \
	new/datum/stack_recipe("wall girder", /obj/structure/girder, 8, time = 10 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_ADVANCED), \
	new/datum/stack_recipe("window frame", /obj/structure/window_frame, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("metal rod", /obj/item/stack/rods, 1, 4, 60), \
	new/datum/stack_recipe("floor tile", /obj/item/stack/tile/plasteel, 1, 4, 20), \
	null, \
	new/datum/stack_recipe("bed", /obj/structure/bed, 2, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE), \
	new/datum/stack_recipe("chair", /obj/structure/bed/chair, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE), \
	new/datum/stack_recipe("comfy chair", /obj/structure/bed/chair/comfy/beige, 2, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE), \
	new/datum/stack_recipe("office chair",/obj/structure/bed/chair/office/dark, 2, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE), \
	new/datum/stack_recipe("light fixture frame", /obj/item/frame/light_fixture, 2), \
	new/datum/stack_recipe("small light fixture frame", /obj/item/frame/light_fixture/small, 1), \
	new/datum/stack_recipe("table parts", /obj/item/frame/table, 1), \
	new/datum/stack_recipe("reinforced table parts", /obj/item/frame/table/reinforced, 2), \
	new/datum/stack_recipe("rack parts", /obj/item/frame/rack, 1), \
	new/datum/stack_recipe_list("airlock assemblies", list( \
		new/datum/stack_recipe("standard airlock assembly", /obj/structure/door_assembly, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		new/datum/stack_recipe("command airlock assembly", /obj/structure/door_assembly/door_assembly_com, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		new/datum/stack_recipe("security airlock assembly", /obj/structure/door_assembly/door_assembly_sec, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		new/datum/stack_recipe("engineering airlock assembly", /obj/structure/door_assembly/door_assembly_eng, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		new/datum/stack_recipe("mining airlock assembly", /obj/structure/door_assembly/door_assembly_min, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		new/datum/stack_recipe("atmospherics airlock assembly", /obj/structure/door_assembly/door_assembly_atmo, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		new/datum/stack_recipe("research airlock assembly", /obj/structure/door_assembly/door_assembly_research, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		new/datum/stack_recipe("medical airlock assembly", /obj/structure/door_assembly/door_assembly_med, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		new/datum/stack_recipe("maintenance airlock assembly", /obj/structure/door_assembly/door_assembly_mai, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		new/datum/stack_recipe("external airlock assembly", /obj/structure/door_assembly/door_assembly_ext, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		new/datum/stack_recipe("freezer airlock assembly", /obj/structure/door_assembly/door_assembly_fre, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		new/datum/stack_recipe("airtight hatch assembly", /obj/structure/door_assembly/door_assembly_hatch, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		new/datum/stack_recipe("maintenance hatch assembly", /obj/structure/door_assembly/door_assembly_mhatch, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		new/datum/stack_recipe("high security airlock assembly", /obj/structure/door_assembly/door_assembly_highsecurity, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		new/datum/stack_recipe("multi-tile airlock assembly", /obj/structure/door_assembly/multi_tile, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
		), 4), \
	null, \
	))

GLOBAL_LIST_INIT(metal_radial_images, list(
	"recipes" = image('icons/Marine/barricades.dmi', icon_state = "plus"),
	"metal barricade" = image('icons/Marine/barricades.dmi', icon_state = "metal_0"),
	"folding metal barricade" = image('icons/Marine/barricades.dmi', icon_state = "folding_metal_0"), //RUTGMC ADDON
	"razorwire" = image('icons/obj/structures/barbedwire.dmi', icon_state = "barbedwire_assembly"),
	"barbedwire" = image('icons/Marine/marine-items.dmi', icon_state = "barbed_wire")
	))

GLOBAL_LIST_INIT(plasteel_radial_images, list(
	"plasteel barricade" = image('icons/Marine/barricades.dmi', icon_state = "new_plasteel_0"),
	"folding plasteel barricade" = image('icons/Marine/barricades.dmi', icon_state = "plasteel_closed_0"),
	))

GLOBAL_LIST_INIT(plasteel_recipes, list ( \
	new/datum/stack_recipe("plasteel barricade", /obj/structure/barricade/metal/plasteel, 4, time = 6 SECONDS, max_per_turf = STACK_RECIPE_ONE_DIRECTIONAL_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_PLASTEEL), \
	new/datum/stack_recipe("plasteel folding barricade", /obj/structure/barricade/plasteel, 6, time = 10 SECONDS, max_per_turf = STACK_RECIPE_ONE_DIRECTIONAL_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_PLASTEEL), \
	null, \
	))

/obj/item/stack/sheet/plasteel/Initialize(mapload, amount)
	. = ..()
	recipes = GLOB.plasteel_recipes

/obj/item/stack/sheet/plasteel/select_radial(mob/user)
	if(user.get_active_held_item() != src)
		return
	if(!can_interact(user))
		return TRUE

	add_fingerprint(usr, "topic")

	var/choice = show_radial_menu(user, src, GLOB.plasteel_radial_images, require_near = TRUE)

	switch (choice)
		if("recipes")
			return TRUE
		if("plasteel barricade") //RUTGMC ADDON
			create_object(user, new/datum/stack_recipe("folding plasteel barricade", /obj/structure/barricade/metal/plasteel, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_DIRECTIONAL_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_PLASTEEL), 1)
		if("folding plasteel barricade") //RUTGMC ADDON
			create_object(user, new/datum/stack_recipe("folding plasteel barricade", /obj/structure/barricade/plasteel, 6, time = 10 SECONDS, max_per_turf = STACK_RECIPE_ONE_DIRECTIONAL_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_PLASTEEL), 1)

	return FALSE

/obj/item/stack/sheet/mineral/sandstone/runed/Initialize(mapload)
	. = ..()
	recipes = GLOB.runedsandstone_recipes

GLOBAL_LIST_INIT(runedsandstone_recipes, list ( \
	new/datum/stack_recipe("brazier frame", /obj/structure/prop/brazier/frame, req_amount = 5, time = 3 SECONDS, max_per_turf = STACK_RECIPE_ONE_DIRECTIONAL_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("torch frame", /obj/item/frame/torch_frame, req_amount = 3, time = 2 SECONDS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("sandstone floor tile", /obj/item/stack/tile/plasteel/sandstone/runed, 1, 4, 20), \
	new/datum/stack_recipe("sandstone wall", /turf/closed/wall/mineral/sandstone/runed, req_amount = 15, time = 10 SECONDS, max_per_turf = STACK_RECIPE_ONE_DIRECTIONAL_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER),
))
