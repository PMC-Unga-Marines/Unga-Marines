//LV311 AREAS--------------------------------------//
/area/lv311
	icon_state = "lv-311"

/area/lv311/ground
	name = "Ground"
	icon_state = "green"
	always_unpowered = TRUE //Will this mess things up? God only knows

//Jungle
/area/lv311/ground/beach
	name = "Southeast beach"
	icon_state = "southeast"
	ambience = list('sound/ambience/jungle_amb1.ogg')
	minimap_color = MINIMAP_AREA_JUNGLE

/area/lv311/ground/beach2
	name = "Southern beach"
	icon_state = "south"
	ambience = list('sound/ambience/jungle_amb1.ogg')
	minimap_color = MINIMAP_AREA_JUNGLE

/area/lv311/ground/beach3
	name = "Southwest beach"
	icon_state = "southwest"
	ambience = list('sound/ambience/jungle_amb1.ogg')
	minimap_color = MINIMAP_AREA_JUNGLE

/area/lv311/ground/beach4
	name = "Central Western beach"
	icon_state = "west"
	ambience = list('sound/ambience/jungle_amb1.ogg')
	minimap_color = MINIMAP_AREA_JUNGLE

/area/lv311/ground/beach5
	name = "Eastern beach"
	icon_state = "east"
	ambience = list('sound/ambience/jungle_amb1.ogg')
	minimap_color = MINIMAP_AREA_JUNGLE

/area/lv311/ground/beach6
	name = "Northwest beach"
	icon_state = "northwest"
	ambience = list('sound/ambience/jungle_amb1.ogg')
	minimap_color = MINIMAP_AREA_JUNGLE

/area/lv311/ground/beach7
	name = "Northern beach"
	icon_state = "north"
	ambience = list('sound/ambience/jungle_amb1.ogg')
	minimap_color = MINIMAP_AREA_JUNGLE

/area/lv311/ground/beach8
	name = "Northeast beach"
	icon_state = "northeast"
	ambience = list('sound/ambience/jungle_amb1.ogg')
	minimap_color = MINIMAP_AREA_JUNGLE

/area/lv311/ground/beach9
	name = "Central beach"
	icon_state = "central"
	ambience = list('sound/ambience/jungle_amb1.ogg')
	minimap_color = MINIMAP_AREA_JUNGLE

/area/lv311/ground/beach10
	name = "Western beach"
	icon_state = "west2"
	ambience = list('sound/ambience/jungle_amb1.ogg')
	minimap_color = MINIMAP_AREA_JUNGLE

/area/lv311/ground/shack
	name = "\improper shack"
	icon_state = "blue"
	outside = FALSE

/area/lv311/ground/sea
	name = "\improper sea"
	icon_state = "blue"

/area/lv311/ground/ruin
	name = "\improper Unknown structure"
	icon_state = "red"
	outside = FALSE

/area/lv311/ground/caves //Does not actually exist
	name = "Caves"
	icon_state = "cave"
	ambience = list('sound/ambience/ambimine.ogg','sound/ambience/ambigen10.ogg','sound/ambience/ambigen12.ogg','sound/ambience/ambisin4.ogg')
	ceiling = CEILING_DEEP_UNDERGROUND
	outside = FALSE
	minimap_color = MINIMAP_AREA_CAVES

//Caves
/area/lv311/ground/caves/rock //catchall for closed turfs we want immune to rain/easily visible to map editing tools
	name = "Enclosed Area"
	icon_state = "transparent"
	minimap_color = null

/area/lv311/ground/caves/east1/garbledradio
	ceiling = CEILING_UNDERGROUND_METAL

/area/lv311/ground/caves/the_bow_of_the_ship

	name = "the bow of the ship"
	icon_state = "cave"

/area/lv311/ground/caves/the_bow_of_the_ship/garbledradio

	ceiling = CEILING_UNDERGROUND_METAL
	outside = FALSE

/area/lv311/ground/caves/the_central_part_of_the_ship

	name = "the central part of the ship"
	icon_state = "cave"

/area/lv311/ground/caves/the_central_part_of_the_ship/garbledradio

	ceiling = CEILING_UNDERGROUND_METAL
	outside = FALSE

/area/lv311/ground/caves/the_tail_section_of_the_ship

	name = "the tail section of the ship"
	icon_state = "cave"

/area/lv311/ground/caves/the_tail_section_of_the_ship/garbledradio

	ceiling = CEILING_UNDERGROUND_METAL
	outside = FALSE

/area/lv311/ground/caves/the_north_wing_of_the_ship

	name = "the north wing of the ship"
	icon_state = "away2"

/area/lv311/ground/caves/the_north_wing_of_the_ship/garbledradio

	ceiling = CEILING_UNDERGROUND_METAL
	outside = FALSE

/area/lv311/ground/caves/the_eastern_part_of_the_ship

	name = "the eastern part of the ship"
	icon_state = "purple"

/area/lv311/ground/caves/the_eastern_part_of_the_ship/garbledradio

	ceiling = CEILING_UNDERGROUND_METAL
	outside = FALSE


//Lazarus landing
/area/lv311/lazarus
	name = "\improper Lazarus"
	icon_state = "green"
	ceiling = CEILING_METAL
	outside = FALSE
	minimap_color = MINIMAP_AREA_COLONY


/area/lv311/lazarus/Reactor
	name = "\improper Reactor"
	icon_state = "engine_smes"
	minimap_color = MINIMAP_AREA_ENGI
	ceiling = CEILING_UNDERGROUND_METAL

/area/lv311/lazarus/crashed_ship
	name = "\improper Crashed Ship"
	icon_state = "shuttlered"
	ceiling = CEILING_DEEP_UNDERGROUND_METAL
	always_unpowered = TRUE
	minimap_color = MINIMAP_AREA_SHIP

/area/lv311/lazarus/crashed_ship/desparity
	always_unpowered = FALSE
	ceiling = CEILING_UNDERGROUND_METAL

/area/lv311/lazarus/relay
	name = "\improper Secret Relay Room"
	icon_state = "tcomsatcham"
	minimap_color = MINIMAP_AREA_ENGI

/area/lv311/lazarus/console
	name = "\improper Shuttle Console"
	icon_state = "tcomsatcham"
	flags_area = NO_DROPPOD
	requires_power = FALSE

/area/lv311/lazarus/spaceport
	name = "\improper Eastern Space Port"
	icon_state = "landingzone1"
	flags_area = NO_DROPPOD
	minimap_color = MINIMAP_AREA_LZ

/area/lv311/lazarus/spaceport2
	name = "\improper Western Space Port"
	icon_state = "landingzone2"
	flags_area = NO_DROPPOD
	minimap_color = MINIMAP_AREA_LZ
