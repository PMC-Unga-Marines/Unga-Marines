/// Temporary visual effects
/obj/effect/temp_visual
	icon_state = "nothing"
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/duration = 1 SECONDS
	var/randomdir = TRUE
	var/timerid


/obj/effect/temp_visual/Initialize(mapload)
	. = ..()
	if(randomdir)
		setDir(pick(GLOB.cardinals))

	timerid = QDEL_IN_STOPPABLE(src, duration)


/obj/effect/temp_visual/Destroy()
	deltimer(timerid)
	return ..()

/obj/effect/temp_visual/dir_setting
	randomdir = FALSE


/obj/effect/temp_visual/dir_setting/Initialize(mapload, set_dir)
	if(set_dir)
		setDir(set_dir)
	return ..()

GLOBAL_DATUM_INIT(flare_particles, /particles/flare_smoke, new)
/particles/flare_smoke
	icon = 'icons/effects/effects.dmi'
	icon_state = "smoke"
	width = 100
	height = 200
	count = 1000
	spawning = 3
	lifespan = 2 SECONDS
	fade = 7 SECONDS
	velocity = list(0, 5, 0)
	drift = generator(GEN_CIRCLE, 0, 1, NORMAL_RAND)
	spin = generator(GEN_NUM, -20, 20)
	scale = 0.3
	friction = 0.2
	gravity = list(0, 0.95)
	grow = 0.05

/obj/effect/temp_visual/above_flare
	icon = 'icons/effects/64x64.dmi'
	icon_state = "flare"
	layer = FLY_LAYER
	light_system = STATIC_LIGHT
	light_power = 12
	light_color = COLOR_VERY_SOFT_YELLOW
	light_range = 12 //Way brighter than most lights
	pixel_x = -18
	pixel_y = 150
	duration = 90 SECONDS

/obj/effect/temp_visual/above_flare/Initialize(mapload)
	. = ..()
	particles = GLOB.flare_particles
	loc.visible_message(span_warning("You see a tiny flash, and then a blindingly bright light from a flare as it lights off in the sky!"))
	playsound(loc, 'sound/weapons/guns/fire/flare.ogg', 50, 1, 4)
	animate(src, time = duration, pixel_y = 0)

/obj/effect/temp_visual/dropship_flyby
	icon = 'icons/obj/structures/dropship_prop.dmi'
	icon_state = "fighter_shadow"
	layer = FLY_LAYER
	resistance_flags = RESIST_ALL
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	duration = 3 SECONDS
	pixel_x = -48
	pixel_y = -120
	pixel_z = -480

/obj/effect/temp_visual/dropship_flyby/Initialize()
	. = ..()
	animate(src, pixel_z = 960, time = 3 SECONDS)

/obj/effect/temp_visual/dropship_flyby/som
	icon_state = "harbinger_shadow"

/obj/effect/temp_visual/block //color is white by default, set to whatever is needed
	name = "blocking glow"
	icon_state = "block"
	icon = 'icons/effects/effects.dmi'
	duration = 6.7

/obj/effect/temp_visual/block/Initialize(mapload, set_color)
	if(set_color)
		add_atom_colour(set_color, FIXED_COLOUR_PRIORITY)
	. = ..()
	pixel_x = rand(-12, 12)
	pixel_y = rand(-9, 0)

/obj/effect/temp_visual/oppose_shatter
	icon = 'icons/effects/96x96.dmi'
	icon_state = "oppose_shatter"
	name = "veined terrain"
	desc = "blood rushes below the ground, forcing it upwards."
	layer = PODDOOR_OPEN_LAYER
	pixel_x = -32
	pixel_y = -32
	duration = 3 SECONDS
	alpha = 200

/obj/effect/temp_visual/oppose_shatter/Initialize(mapload)
	. = ..()
	animate(src, alpha = 0, time = 3 SECONDS)
