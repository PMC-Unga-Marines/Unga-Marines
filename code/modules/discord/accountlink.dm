// Verb to link discord accounts to BYOND accounts
/client/verb/linkdiscord()
	set category = "OOC.Discord"
	set name = "Link Discord Account"
	set desc = "Link your discord account to your BYOND account."

	// Safety checks
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(src, span_warning("This feature requires the SQL backend to be running."))
		return

	if(!SSdiscord) // SS is still starting
		to_chat(src, span_notice("The server is still starting up. Please wait before attempting to link your account!"))
		return

	if(!SSdiscord.enabled)
		to_chat(src, span_warning("This feature requires the server is running on the TGS toolkit."))
		return

	var/stored_id = SSdiscord.lookup_id(usr.ckey)
	if(!stored_id) // Account is not linked
		var/know_how = alert("Do you know how to get a Discord user ID? This ID is NOT your Discord username and numbers! (Pressing NO will open a guide.)","Question","Yes","No","Cancel Linking")
		if(know_how == "No") // Opens discord support on how to collect IDs
			src << link("https://tgstation13.org/wiki/How_to_find_your_Discord_User_ID")
		if(know_how == "Cancel Linking")
			return
		var/entered_id = tgui_input_text(usr, "Please enter your Discord ID (18-ish digits)", "Enter Discord ID")
		SSdiscord.account_link_cache[replacetext(lowertext(usr.ckey), " ", "")] = "[entered_id]" // Prepares for TGS-side verification, also fuck spaces
		alert(usr, "Account link started. Please ping the bot of the server you\'re currently on, followed by \"verify [usr.ckey]\" in Discord to successfully verify your account (Example: @Mr_Terry verify [usr.ckey])")

	else // Account is already linked
		var/choice = alert("You already have the Discord Account [stored_id] linked to [usr.ckey]. Would you like to link a different account?","Already Linked","Yes","No")
		if(choice == "Yes")
			var/know_how = alert("Do you know how to get a Discord user ID? This ID is NOT your Discord username and numbers! (Pressing NO will open a guide.)","Question","Yes","No", "Cancel Linking")
			if(know_how == "No")
				src << link("https://tgstation13.org/wiki/How_to_find_your_Discord_User_ID")

			if(know_how == "Cancel Linking")
				return

			var/entered_id = tgui_input_text(usr, "Please enter your Discord ID (18-ish digits)", "Enter Discord ID")
			SSdiscord.account_link_cache[replacetext(lowertext(usr.ckey), " ", "")] = "[entered_id]" // Prepares for TGS-side verification, also fuck spaces
			alert(usr, "Account link started. Please ping the bot of the server you\'re currently on, followed by \"verify [usr.ckey]\" in Discord to successfully verify your account (Example: @Mr_Terry verify [usr.ckey])")

// IF you have linked your account, this will trigger a verify of the user
/client/verb/check_discord()
	set category = "OOC.Discord"
	set name = "Check discord id"
	set desc = "Verify or reverify your discord account against your linked ckey"

	// Safety checks
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(src, span_warning("This feature requires the SQL backend to be running."))
		return

	// ss is still starting
	if(!SSdiscord)
		to_chat(src, span_notice("The server is still starting up. Please wait before attempting to link your account!"))
		return

	// check that tgs is alive and well
	if(!SSdiscord.enabled)
		to_chat(src, span_warning("This feature requires the server is running on the TGS toolkit."))
		return

	// check that account is linked with discord
	var/stored_id = SSdiscord.lookup_id(usr.ckey)
	if(!stored_id) // Account is not linked
		to_chat(usr, "Link your discord account via the linkdiscord verb in the OOC tab first");
		return

	// honey its time for your role flattening
	to_chat(usr, span_notice("Discord - [stored_id] - verified"))

// IF you have linked your account, this will trigger a verify of the user
/client/verb/boosty_roly()
	set category = "OOC.Discord"
	set name = "Check boosty"
	set desc = "Checking if you have permission to bind to boosty"

	// Safety checks
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(src, span_warning("This feature requires the SQL backend to be running."))
		return

	// ss is still starting
	if(!SSdiscord)
		to_chat(src, span_notice("The server is still starting up. Please wait before attempting to link your account!"))
		return

	// check that tgs is alive and well
	if(!SSdiscord.enabled)
		to_chat(src, span_warning("This feature requires the server is running on the TGS toolkit."))
		return

	if(SSdiscord.is_boosty(usr.ckey, FALSE))
		to_chat(usr, span_notice("Boosty discord role is verified"))
		return

	to_chat(usr, span_notice("You don't have a boosty permission"))
