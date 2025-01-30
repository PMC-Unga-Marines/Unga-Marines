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
	icon_state = "station_intact"
	plane = SPLASHSCREEN_PLANE
	layer = SPLASHSCREEN_LAYER
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

/datum/cinematic/Destroy()
	GLOB.cinematics -= src
	QDEL_NULL(screen)
	for(var/mob/M in locked)
		M.notransform = FALSE
	return ..()

/datum/cinematic/proc/play(watchers)
	//Check if you can actually play it (stop mob cinematics for global ones) and create screen objects
	for(var/A in GLOB.cinematics)
		var/datum/cinematic/C = A
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

	for(var/i in GLOB.mob_list)
		var/mob/M = i
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
	else
		for(var/C in watching)
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
	var/icon_to_flick = "station_explode_fade_red"
	var/sound_to_play = 'sound/effects/explosion/far0.ogg'
	var/summary_icon_state = "summary_nukewin"

/datum/cinematic/nuke/pre_content()
	flick("intro_nuke", screen)
	addtimer(CALLBACK(src, PROC_REF(content)), runtime)

/datum/cinematic/nuke/content()
	flick(icon_to_flick, screen)
	cinematic_sound(sound(sound_to_play, channel = CHANNEL_CINEMATIC))
	special()
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

/datum/cinematic/nuke/selfdestruct_miss/content()
	cinematic_sound(sound('sound/effects/explosion/far0.ogg', channel = CHANNEL_CINEMATIC))
	special()
	screen.icon_state = "station_intact"

/datum/cinematic/nuke/annihilation
	id = CINEMATIC_ANNIHILATION
	summary_icon_state = "summary_totala"

/datum/cinematic/nuke/fake
	id = CINEMATIC_NUKE_FAKE
	cleanup_time = 10 SECONDS

/datum/cinematic/nuke/fake/content()
	cinematic_sound(sound('sound/items/bikehorn.ogg', channel = CHANNEL_CINEMATIC))
	flick("summary_selfdes", screen)
	special()

/datum/cinematic/nuke/no_core
	id = CINEMATIC_NUKE_NO_CORE
	cleanup_time = 10 SECONDS

/datum/cinematic/nuke/no_core/content()
	flick("station_intact", screen)
	cinematic_sound(sound('sound/ambience/signal.ogg', channel = CHANNEL_CINEMATIC))

/datum/cinematic/nuke_far
	id = CINEMATIC_NUKE_FAR
	cleanup_time = 0

/datum/cinematic/nuke_far/content()
	cinematic_sound(sound('sound/effects/explosion/far0.ogg', channel = CHANNEL_CINEMATIC))
	special()

/datum/cinematic/nuke/crash
	id = CINEMATIC_CRASH_NUKE
	cleanup_time = 15 SECONDS
	icon_to_flick = "planet_nuke"
	summary_icon_state = "planet_end"

/datum/cinematic/nuke/crash/pre_content()
	screen.icon_state = "planet_start"
	return ..()

/datum/cinematic/malf
	id = CINEMATIC_MALF
	runtime = 7.6 SECONDS

/datum/cinematic/malf/pre_content()
	flick("intro_malf", screen)
	addtimer(CALLBACK(src, PROC_REF(content)), runtime)

/datum/cinematic/malf/content()
	flick("station_explode_fade_red", screen)
	cinematic_sound(sound('sound/effects/explosion/far0.ogg', channel = CHANNEL_CINEMATIC))
	special()
	screen.icon_state = "summary_malf"
