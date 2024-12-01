//Please use mob or src (not usr) in these procs. This way they can be called in the same fashion as procs.
/client/verb/wiki()
	set name = "wiki"
	set hidden = TRUE

	if(!CONFIG_GET(string/wikiurl))
		to_chat(src, span_warning("The wiki URL is not set in the server configuration."))
		return

	if(tgui_alert(src, "This will open the wiki in your browser. Are you sure?", "Wiki", list("Yes", "No"), 0) != "Yes")
		return

	DIRECT_OUTPUT(src, link(CONFIG_GET(string/wikiurl)))

/client/verb/boosty()
	set name = "boosty"
	set hidden = TRUE

	if(!CONFIG_GET(string/donationurl))
		to_chat(src, span_warning("The donation URL is not set in the server configuration."))
		return

	if(tgui_alert(src, "This will open the boosty in your browser. Are you sure?", "Forum", list("Yes", "No"), 0) != "Yes")
		return

	DIRECT_OUTPUT(src, link(CONFIG_GET(string/donationurl)))

/client/verb/rules()
	set name = "rules"
	set hidden = TRUE

	if(!CONFIG_GET(string/rulesurl))
		to_chat(src, span_warning("The rules URL is not set in the server configuration."))
		return

	if(tgui_alert("This will open the rules in your browser. Are you sure?", "Rules", list("Yes", "No"), 0) != "Yes")
		return

	DIRECT_OUTPUT(src, link(CONFIG_GET(string/rulesurl)))

/client/verb/discord()
	set name = "discord"
	set hidden = TRUE

	if(!CONFIG_GET(string/discordurl))
		to_chat(src, span_warning("The Discord URL is not set in the server configuration."))
		return

	if(tgui_alert(src, "This will open our Discord in your browser. Are you sure?", "Discord", list("Yes", "No"), 0) != "Yes")
		return

	DIRECT_OUTPUT(src, link(CONFIG_GET(string/discordurl)))

/client/verb/github()
	set name = "github"
	set hidden = TRUE

	if(!CONFIG_GET(string/githuburl))
		to_chat(src, span_warning("The bug tracker URL is not set in the server configuration."))
		return

	if(tgui_alert(src, "This will open our bug tracker page in your browser. Are you sure?", "Github", list("Yes", "No"), 0) != "Yes")
		return

	DIRECT_OUTPUT(src, link(CONFIG_GET(string/githuburl)))

/client/verb/webmap()
	set name = "webmap"
	set hidden = TRUE

	var/webmap_host = CONFIG_GET(string/webmap_host)
	if(!webmap_host)
		to_chat(src, span_warning("Webmaps are not setup."))
		return
	var/map_url

	var/choice = tgui_alert(src, "Do you want to view the ground or the ship?", "Webmap", list("Ship", "Ground"), 0)
	switch(choice)
		if("Ship")
			map_url = SSmapping.configs[SHIP_MAP].map_file
		if("Ground")
			map_url = SSmapping.configs[GROUND_MAP].map_file

	if(!map_url)
		to_chat(src, span_warning("Mapping subsystem hasn't finished loading yet, try again later."))
		return

	DIRECT_OUTPUT(src, link("[webmap_host][map_url]"))
