GLOBAL_LIST_EMPTY(cinematics)

// Use to play cinematics.
// Watcher can be world,mob, or a list of mobs
// Blocks until sequence is done.
/proc/Cinematic(id, watcher, datum/callback/special_callback)
	var/datum/cinematic/playing
	for(var/V in subtypesof(/datum/cinematic))
		var/datum/cinematic/C = V
		if(initial(C.id) == id)
			playing = new V()
			break
	if(!playing)
		CRASH("Cinematic type not found")
	if(special_callback)
		playing.special_callback = special_callback
	if(watcher == world)
		playing.is_global = TRUE
		watcher = GLOB.mob_list
	playing.play(watcher)

/atom/movable/screen/cinematic
	icon = 'icons/effects/station_explosion.dmi'
	plane = SPLASHSCREEN_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	screen_loc = "CENTER-7,CENTER-7"

/datum/cinematic
	var/id = CINEMATIC_DEFAULT
	///List of clients watching this
	var/list/watching = list()
	///Who had notransform set during the cinematic
	var/list/locked = list()
	///Global cinematics will override mob-specific ones
	var/is_global = FALSE
	var/atom/movable/screen/cinematic/screen
	var/screen_icon_state = "station_intact"
	///For special effects synced with animation (explosions after the countdown etc)
	var/datum/callback/special_callback
	///How long it runs for
	var/runtime = 5 SECONDS
	///How long for the final screen to remain
	var/cleanup_time = 30 SECONDS
	///Turns off ooc when played globally.
	var/stop_ooc = TRUE

/datum/cinematic/New()
	GLOB.cinematics += src
	screen = new(src)
	screen.icon_state = screen_icon_state

/datum/cinematic/Destroy()
	GLOB.cinematics -= src
	QDEL_NULL(screen)
	for(var/mob/M as anything in locked)
		M.notransform = FALSE
	return ..()

/datum/cinematic/proc/play(watchers)
	//Check if you can actually play it (stop mob cinematics for global ones) and create screen objects
	for(var/datum/cinematic/C as anything in GLOB.cinematics)
		if(C == src)
			continue
		if(C.is_global || !is_global)
			return //Can't play two global or local cinematics at the same time

	//Close all open windows if global
	if(is_global)
		SStgui.close_all_uis()

	//Pause OOC
	var/ooc_toggled = FALSE
	if(is_global && stop_ooc && GLOB.ooc_allowed)
		ooc_toggled = TRUE
		GLOB.ooc_allowed = FALSE

	for(var/mob/M as anything  in GLOB.mob_list)
		if(M in watchers)
			M.notransform = TRUE //Should this be done for non-global cinematics or even at all ?
			locked += M
			if(M.client)
				watching += M.client
				M.client.screen += screen
		else if(is_global)
			M.notransform = TRUE
			locked += M

	//Actually play it
	pre_content()

	//Cleanup
	addtimer(CALLBACK(src, PROC_REF(cleanup_content), ooc_toggled), cleanup_time)

///Sound helper
/datum/cinematic/proc/cinematic_sound(s)
	if(is_global)
		SEND_SOUND(world, s)
		return
	for(var/C as anything in watching)
		SEND_SOUND(C, s)

///Fire up special callback for actual effects synchronized with animation (eg real nuke explosion happens midway)
/datum/cinematic/proc/special()
	if(!special_callback)
		return
	special_callback.Invoke()

///Prepare for the content() proc
/datum/cinematic/proc/pre_content()
	content()

///Actual cinematic goes in here
/datum/cinematic/proc/content()
	sleep(runtime)

///Cleanup after the content
/datum/cinematic/proc/cleanup_content(ooc_toggled = FALSE)
	//Restore OOC
	if(ooc_toggled)
		GLOB.ooc_allowed = TRUE
	qdel(src)

/datum/cinematic/nuke
	runtime = 3.5 SECONDS
	cleanup_time = 15 SECONDS
	var/intro_icon = "intro_nuke"
	var/icon_to_flick = "station_explode_fade_red"
	var/sound_to_play = 'sound/effects/explosion/far0.ogg'
	var/summary_icon_state = "summary_nukewin"

/datum/cinematic/nuke/pre_content()
	flick(intro_icon, screen)
	addtimer(CALLBACK(src, PROC_REF(content)), runtime)

/datum/cinematic/nuke/content()
	if(icon_to_flick)
		flick(icon_to_flick, screen)
	cinematic_sound(sound(sound_to_play, channel = CHANNEL_CINEMATIC))
	special()
	if(summary_icon_state)
		screen.icon_state = summary_icon_state

/datum/cinematic/nuke/win
	id = CINEMATIC_NUKE_WIN

/datum/cinematic/nuke/miss
	id = CINEMATIC_NUKE_MISS
	icon_to_flick = "station_intact_fade_red"
	summary_icon_state = "summary_nukefail"

/datum/cinematic/nuke/selfdestruct
	id = CINEMATIC_SELFDESTRUCT
	summary_icon_state = "summary_selfdes"

/datum/cinematic/nuke/selfdestruct_miss
	id = CINEMATIC_SELFDESTRUCT_MISS
	icon_to_flick = ""
	summary_icon_state = "station_intact"

/datum/cinematic/nuke/annihilation
	id = CINEMATIC_ANNIHILATION
	summary_icon_state = "summary_totala"

/datum/cinematic/nuke/fake
	id = CINEMATIC_NUKE_FAKE
	icon_to_flick = "summary_selfdes"
	sound_to_play = 'sound/items/bikehorn.ogg'
	summary_icon_state = ""

/datum/cinematic/nuke/no_core
	id = CINEMATIC_NUKE_NO_CORE
	icon_to_flick = "station_intact"
	sound_to_play = 'sound/ambience/signal.ogg'
	summary_icon_state = ""

/datum/cinematic/nuke/crash
	id = CINEMATIC_CRASH_NUKE
	screen_icon_state = "planet_start"
	intro_icon = "planet_start"
	icon_to_flick = "planet_nuke"
	summary_icon_state = "planet_end"

/datum/cinematic/nuke/far
	id = CINEMATIC_NUKE_FAR
	icon_to_flick = ""
	summary_icon_state = ""

/datum/cinematic/nuke/malf
	id = CINEMATIC_MALF
	runtime = 7.6 SECONDS
	intro_icon = "intro_malf"
	icon_to_flick = "station_explode_fade_red"
	summary_icon_state = "summary_malf"
