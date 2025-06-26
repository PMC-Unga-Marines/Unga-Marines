// Verb to manipulate IDs and ckeys
ADMIN_VERB(discord_id_manipulation, R_ADMIN, "Discord Manipulation", "Manipulate with verified discord users and their ckey", ADMIN_CATEGORY_MAIN)
	user.holder.discord_manipulation()

/datum/admins/proc/discord_manipulation()
	if(!usr.client.holder)
		return

	if(!SSdiscord.enabled)
		to_chat(usr, span_warning("TGS is not enabled"))
		return

	var/lookup_choice = alert(usr, "Do you wish to lookup account by ID or ckey?", "Lookup Type", "ID", "Ckey", "Cancel")
	switch(lookup_choice)
		if("ID")
			var/lookup_id = tgui_input_text(usr, "Enter Discord ID to lookup ckey")
			var/returned_ckey = SSdiscord.lookup_ckey(lookup_id)
			if(returned_ckey)
				var/unlink_choice = alert(usr, "Discord ID [lookup_id] is linked to Ckey [returned_ckey]. Do you wish to unlink or cancel?", "Account Found", "Unlink", "Cancel")
				if(unlink_choice == "Unlink")
					SSdiscord.unlink_account(returned_ckey)
			else
				to_chat(usr, span_warning("Discord ID <b>[lookup_id]</b> has no associated ckey"))
		if("Ckey")
			var/lookup_ckey = tgui_input_text(usr, "Enter Ckey to lookup ID")
			var/returned_id = SSdiscord.lookup_id(lookup_ckey)
			if(returned_id)
				to_chat(usr, span_notice("Ckey <b>[lookup_ckey]</b> is assigned to Discord ID <b>[returned_id]</b>"))
				to_chat(usr, span_notice("Discord mention format: <b>&lt;@[returned_id]&gt;</b>")) // &lt; and &gt; print < > in HTML without using them as tags
