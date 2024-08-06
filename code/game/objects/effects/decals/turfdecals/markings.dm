/obj/effect/turf_decal/tile
	icon = 'icons/turf/decals.dmi'
	icon_state = "whitedecal"

/* RUTGMC DELETION, TODO: repath it from effects so it can properly be exploded
/obj/effect/turf_decal/tile/ex_act(severity)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			qdel(src)
		if(EXPLODE_HEAVY)
			if(prob(50))
				qdel(src)
		if(EXPLODE_LIGHT)
			if(prob(25))
				qdel(src)
*/

/obj/effect/turf_decal/tile/full
	icon_state = "floor_large"

/obj/effect/turf_decal/tile/full/graylarge
	icon_state = "grayfloorlarge"

/obj/effect/turf_decal/tile/full/black
	color = "#6b6b6b"

/obj/effect/turf_decal/tile/full/darkgray
	color = "#818181"

/obj/effect/turf_decal/tile/full/darkgray2
	color = "#d1d3cd"

/obj/effect/turf_decal/tile/full/white
	color = "#f7eeee"

/obj/effect/turf_decal/tile/full/brown
	color = "#443529"

/obj/effect/turf_decal/tile/white
	icon_state = "whitedecal"

/obj/effect/turf_decal/tile/gray
	icon_state = "graydecal"

/obj/effect/turf_decal/tile/green
	icon_state = "greendecal"

/obj/effect/turf_decal/tile/yellow
	icon_state = "yellowdecal"

/obj/effect/turf_decal/tile/red
	icon_state = "redecal"

/obj/effect/turf_decal/tile/black
	icon_state = "blackdecal"

/obj/effect/turf_decal/tile/brown
	icon_state = "browndecal"

/obj/effect/turf_decal/tile/pink
	icon_state = "pinkdecal"

/obj/effect/turf_decal/tile/blue
	icon_state = "bluedecal"

/obj/effect/turf_decal/tile/grid
	icon_state = "grid"

/obj/effect/turf_decal/tile/corsatstraight
	icon_state = "corsattiletwo"

/obj/effect/turf_decal/tile/corsatstraight/red
	color = "#722729"

/obj/effect/turf_decal/tile/corsatstraight/blue
	color = "#2a5d7a"

/obj/effect/turf_decal/tile/corsatstraight/cyan
	color = "#217e7e"

/obj/effect/turf_decal/tile/corsatstraight/green
	color = "#155e19"

/obj/effect/turf_decal/tile/corsatstraight/yellow
	color = "#83810c"

/obj/effect/turf_decal/tile/corsatstraight/brown
	color = "#96561a"

/obj/effect/turf_decal/tile/corsatstraight/purple
	color = "#8d498d"

/obj/effect/turf_decal/tile/corsatstraight/lightpurple
	color = "#a33b94"

/obj/effect/turf_decal/tile/corsatstraight/darkgreen
	color = "#238623"

/obj/effect/turf_decal/tile/corsatstraight/white
	color = "#d3d3d3"

/obj/effect/turf_decal/tile/corsatstraight/gray
	color = "#d3d3d3c0"

/obj/effect/turf_decal/tile/corsatcorner
	icon_state = "corsatlinecornertwo"

/obj/effect/turf_decal/tile/corsatcorner/red
	color = "#722729"

/obj/effect/turf_decal/tile/corsatcorner/blue
	color = "#2a5d7a"

/obj/effect/turf_decal/tile/corsatcorner/cyan
	color = "#217e7e"

/obj/effect/turf_decal/tile/corsatcorner/green
	color = "#155e19"

/obj/effect/turf_decal/tile/corsatcorner/yellow
	color = "#83810c"

/obj/effect/turf_decal/tile/corsatcorner/brown
	color = "#96561a"

/obj/effect/turf_decal/tile/corsatcorner/purple
	color = "#8d498d"

/obj/effect/turf_decal/tile/corsatcorner/lighpurple
	color = "#a33b94"

/obj/effect/turf_decal/tile/corsatcorner/darkgreen
	color = "#238623"

/obj/effect/turf_decal/tile/corsatcorner/white
	color = "#d3d3d3"

/obj/effect/turf_decal/tile/corsatsemi
	icon_state = "corsatlinesemitwo"

/obj/effect/turf_decal/tile/corsatsemi/red
	color = "#722729"

/obj/effect/turf_decal/tile/corsatsemi/blue
	color = "#2a5d7a"

/obj/effect/turf_decal/tile/corsatsemi/cyan
	color = "#217e7e"

/obj/effect/turf_decal/tile/corsatsemi/green
	color = "#155e19"

/obj/effect/turf_decal/tile/corsatsemi/yellow
	color = "#83810c"

/obj/effect/turf_decal/tile/corsatsemi/brown
	color = "#96561a"

/obj/effect/turf_decal/tile/corsatsemi/purple
	color = "#8d498d"

/obj/effect/turf_decal/tile/corsatsemi/lightpurple
	color = "#a33b94"

/obj/effect/turf_decal/tile/corsatsemi/darkgreen
	color = "#238623"

/obj/effect/turf_decal/tile/corsatsemi/white
	color = "#d3d3d3"

/obj/effect/turf_decal/woodsiding
	icon_state = "wood_siding"

/obj/effect/turf_decal/woodsiding/alt
	icon_state = "wood_sidingalt"

/obj/effect/turf_decal/woodsiding/Initialize(mapload)
	. = ..()
	loc.overlays += image(icon, icon_state, dir = src.dir)
	return INITIALIZE_HINT_QDEL

/obj/effect/turf_decal/siding
	icon_state = "siding"

/obj/effect/turf_decal/siding/alt
	icon_state = "sidingalt"

/obj/effect/turf_decal/siding/Initialize(mapload)
	. = ..()
	loc.overlays += image(icon, icon_state, dir = src.dir)
	return INITIALIZE_HINT_QDEL

//METAL DECAL
/obj/effect/turf_decal/siding/metal
	icon_state = "borderfloor_black"

/obj/effect/turf_decal/siding/metal/corner
	icon_state = "borderfloorcorner_black"

/obj/effect/turf_decal/siding/metal/corner2
	icon_state = "borderfloorcorner2_black"

/obj/effect/turf_decal/siding/metal/full
	icon_state = "borderfloorfull_black"

/obj/effect/turf_decal/siding/metal/floorcee
	icon_state = "borderfloorcee_black"

/obj/effect/turf_decal/siding/metal/flatcorner
	icon_state = "corner_white"

/obj/effect/turf_decal/siding/metal/flatcorner/diagonal
	icon_state = "corner_white_diagonal"

/obj/effect/turf_decal/siding/metal/flatcorner/full
	icon_state = "corner_white_full"

//WIDE METAL DECAL
/obj/effect/turf_decal/siding/metal/flatcorner/wide
	icon_state = "wide_corner"

/obj/effect/turf_decal/siding/metal/flatcorner/wide/diagonal
	icon_state = "wide_corner_diagonal"

/obj/effect/turf_decal/siding/metal/flatcorner/wide/full
	icon_state = "wide_corner_full"

/obj/effect/turf_decal/tile/metal
	icon_state = "edge"

/obj/effect/turf_decal/tile/metal/corner
	icon_state = "edge_corner"

/obj/effect/turf_decal/tile/metal/medical
	color = "#53876F"

/obj/effect/turf_decal/tile/metal/corner/medical
	color = "#53876F"

//EMBLEM
/obj/effect/turf_decal/siding/emblem
	icon_state = "logo_central"

/obj/effect/turf_decal/siding/emblem/second
	icon_state = "logo_directional_south"

/obj/effect/turf_decal/siding/emblem/third
	icon_state = "logo_directional_north"

/obj/effect/turf_decal/siding/emblem/fourth
	icon_state = "logo_directional_east"

/obj/effect/turf_decal/siding/emblem/fifth
	icon_state = "logo_directional_west"

/obj/effect/turf_decal/symbol/corsat
	color = "#9c7f42"

/obj/effect/turf_decal/symbol/corsat/symbol/omega
	icon_state = "omega"
	color = "#534563"

/obj/effect/turf_decal/symbol/corsat/symbol/theta
	icon_state = "theta"
	color = "#549c42"

/obj/effect/turf_decal/symbol/corsat/symbol/gamma
	icon_state = "gamma"
	color = "#5d6384"

/obj/effect/turf_decal/symbol/corsat/symbol/sigma
	icon_state = "sigma"

/obj/effect/turf_decal/symbol/apocrune
	icon = 'icons/effects/96x96.dmi'
	icon_state = "apoccolored"

/obj/effect/turf_decal/symbol/large_rune
	icon = 'icons/effects/96x96.dmi'
	icon_state = "rune_large_colored"
