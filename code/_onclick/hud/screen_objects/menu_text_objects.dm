
/*!
 * Screen Lobby objects
 * Uses maptext to display the objects
 * Automatically will align in the order that they are defined
 * Stuff happens on Click(), although hrefs are also valid to get stuff done
 * hrefs will make the text blue though  so dont do it :/
 */

///Unclickable Lobby UI objects
/atom/movable/screen/text/lobby
	screen_loc = "CENTER"
	maptext_height = 480
	maptext_width = 480
	maptext_x = 24
	maptext_y = 9


///This proc updates the maptext of the buttons.
/atom/movable/screen/text/lobby/proc/update_text()
	SIGNAL_HANDLER
	return

/atom/movable/screen/text/lobby/title
	icon = 'icons/UI_Icons/lobbytext.dmi'
	icon_state = "tgmc"

///Clickable UI lobby objects which do stuff on Click() when pressed
/atom/movable/screen/text/lobby/clickable
	maptext = "if you see this a coder was stinky"
	icon = 'icons/UI_Icons/lobby_button.dmi' //hitbox prop
	mouse_opacity = MOUSE_OPACITY_ICON

/atom/movable/screen/text/lobby/clickable/MouseEntered(location, control, params)
	. = ..()
	if(!(atom_flags & INITIALIZED)) //yes this can happen, fuck me
		return
	color = COLOR_LOBBY_RED
	var/mob/new_player/player = usr
	player.playsound_local(player, 'sound/effects/menu_click.ogg', 50)

/atom/movable/screen/text/lobby/clickable/MouseExited(location, control, params)
	. = ..()
	color = initial(color)

/atom/movable/screen/text/lobby/clickable/Click()
	if(!(atom_flags & INITIALIZED)) //yes this can happen, fuck me
		to_chat(usr, span_warning("The game is still setting up, please try again later."))
		return
	var/mob/new_player/player = usr
	player.playsound_local(player, 'sound/effects/menu_select.ogg', 50)


/atom/movable/screen/text/lobby/clickable/setup_character
	maptext = "<span class='maptext' style=font-size:6px>ПЕРСОНАЖ: ...</span>"
	icon_state = "setup"
	///Bool, whether we registered to listen for charachter updates already
	var/registered = FALSE
	maptext_y = 11

/atom/movable/screen/text/lobby/clickable/setup_character/Click()
	. = ..()
	hud.mymob.client?.prefs.ShowChoices(hud.mymob)

/atom/movable/screen/text/lobby/clickable/setup_character/update_text()
	maptext = "<span class='maptext' style=font-size:6px>ПЕРСОНАЖ: [hud?.mymob.client ? hud.mymob.client.prefs.real_name : "Unknown User"]</span>"
	if(registered)
		return
	RegisterSignal(hud.mymob.client, COMSIG_CLIENT_PREFERENCES_UIACTED, PROC_REF(update_text))
	registered = TRUE

/atom/movable/screen/text/lobby/clickable/join_game
	maptext = "<span class='maptext' style=font-size:8px>ПРИСОЕДИНИТЬСЯ</span>"
	icon_state = "join"

/atom/movable/screen/text/lobby/clickable/join_game/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	update_text()
	RegisterSignal(SSdcs, COMSIG_GLOB_GAMEMODE_LOADED, TYPE_PROC_REF(/atom/movable/screen/text/lobby, update_text))

/atom/movable/screen/text/lobby/clickable/join_game/Click()
	. = ..()
	var/mob/new_player/player = hud.mymob
	if(SSticker?.current_state > GAME_STATE_PREGAME)
		player.attempt_late_join()
		return
	player.toggle_ready()
	update_text()

/atom/movable/screen/text/lobby/clickable/join_game/update_text()
	if(SSticker?.current_state > GAME_STATE_PREGAME)
		maptext = "<span class='maptext' style=font-size:8px>ПРИСОЕДИНИТЬСЯ</span>"
		icon_state = "join"
		return
	if(!hud?.mymob)
		return
	var/mob/new_player/player = hud.mymob
	maptext = "<span class='maptext' style=font-size:8px>ВЫ: [player.ready ? "" : "НЕ "]ГОТОВЫ</span>"
	icon_state = player.ready ? "ready" : "unready"

/atom/movable/screen/text/lobby/clickable/observe
	maptext = "<span class='maptext' style=font-size:8px>НАБЛЮДАТЬ</span>"
	icon_state = "observe"

/atom/movable/screen/text/lobby/clickable/observe/Click()
	. = ..()
	var/mob/new_player/player = hud.mymob
	player.try_to_observe()

/atom/movable/screen/text/lobby/clickable/manifest
	maptext = "<span class='maptext' style=font-size:8px>МАНИФЕСТ</span>"
	icon_state = "manifest"

/atom/movable/screen/text/lobby/clickable/manifest/Click()
	. = ..()
	var/mob/new_player/player = hud.mymob
	switch(tgui_alert(player, "Whose Manifest do you want to see?", "Choose Manifest", list("Marine", "Xenomorph")))
		if("Marine")
			player.view_manifest()
		if("Xenomorph")
			player.view_xeno_manifest()

/atom/movable/screen/text/lobby/clickable/background
	maptext = "<span class='maptext' style=font-size:8px>ПРЕДЫСТОРИЯ</span>"
	icon_state = "background"

/atom/movable/screen/text/lobby/clickable/background/Click()
	. = ..()
	var/mob/new_player/player = hud.mymob
	player.view_lore()


/atom/movable/screen/text/lobby/clickable/changelog
	maptext = "<span class='maptext' style=font-size:8px>ЛОГ ИЗМЕНЕНИЙ</span>"
	icon_state = "changelog"

/atom/movable/screen/text/lobby/clickable/changelog/Click()
	. = ..()
	hud.mymob.client?.changes()


/atom/movable/screen/text/lobby/clickable/polls
	maptext = "<span class='maptext' style=font-size:8px>POLLS</span>"
	icon_state = "poll"

/atom/movable/screen/text/lobby/clickable/polls/update_text()
	INVOKE_ASYNC(src, PROC_REF(fetch_polls)) //this sleeps and it shouldn't because update_text uses a signal sometimes

///Proc that fetches the polls, exists so we can async it in update_text
/atom/movable/screen/text/lobby/clickable/polls/proc/fetch_polls()
	var/mob/new_player/player = hud.mymob
	var/hasnewpolls = player.check_playerpolls()
	if(isnull(hasnewpolls))
		maptext = "<span class='maptext' style=font-size:8px>НЕТ БАЗЫ ДАННЫХ!</span>"
		return
	maptext = "<span class='maptext' style=font-size:8px>ПОКАЗАТЬ ОПРОСЫ[hasnewpolls ? " (NEW!)" : ""]</span>"

/atom/movable/screen/text/lobby/clickable/polls/Click()
	. = ..()
	var/mob/new_player/player = hud.mymob
	player.handle_playeR_DBRANKSing()
	fetch_polls()

