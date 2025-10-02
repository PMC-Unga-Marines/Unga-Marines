/// Temporary visual effects
/obj/effect/temp_visual
	icon_state = "nothing"
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	///How long before the temp_visual gets deleted
	var/duration = 1 SECONDS
	///Timer that our duration is stored in
	var/timerid
	///Gives our effect a random direction on init
	var/randomdir = TRUE



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
		add_atom_colour(set_color, FIXED_COLOR_PRIORITY)
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

/particles/blood_explosion
	icon = 'icons/effects/effects.dmi'
	icon_state = "smoke"
	width = 500
	height = 500
	count = 45
	spawning = 45
	lifespan = 0.7 SECONDS
	fade = 0.9 SECONDS
	grow = 0.1
	scale = 0.4
	spin = generator(GEN_NUM, -20, 20)
	velocity = generator(GEN_CIRCLE, 15, 15)
	friction = generator(GEN_NUM, 0.15, 0.65)
	position = generator(GEN_CIRCLE, 6, 6)

/particles/gib_splatter
	icon = 'icons/effects/blood.dmi'
	icon_state = list("mgibbl3" = 1, "mgibbl5" = 1)
	width = 500
	height = 500
	count = 22
	spawning = 22
	lifespan = 1 SECONDS
	fade = 1.7 SECONDS
	grow = 0.05
	gravity = list(0, -3)
	scale = generator(GEN_NUM, 1, 1.25)
	rotation = generator(GEN_NUM, -10, 10)
	spin = generator(GEN_NUM, -10, 10)
	velocity = list(0, 18)
	friction = generator(GEN_NUM, 0.15, 0.1)
	position = generator(GEN_CIRCLE, 9, 9)
	drift = generator(GEN_CIRCLE, 2, 1)

/obj/effect/temp_visual/gib_particles
	///blood explosion particle holder
	var/obj/effect/abstract/particle_holder/blood
	///gib blood splatter particle holder
	var/obj/effect/abstract/particle_holder/gib_splatter
	duration = 1 SECONDS

/obj/effect/temp_visual/gib_particles/Initialize(mapload, gib_color)
	. = ..()
	blood = new(src, /particles/blood_explosion)
	blood.color = gib_color
	gib_splatter = new(src, /particles/gib_splatter)
	gib_splatter.color = gib_color
	addtimer(CALLBACK(src, PROC_REF(stop_spawning)), 5, TIMER_CLIENT_TIME)

/obj/effect/temp_visual/gib_particles/proc/stop_spawning()
	blood.particles.count = 0
	gib_splatter.particles.count = 0
