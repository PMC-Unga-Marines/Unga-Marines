// Verify
/datum/tgs_chat_command/verify
	name = "verify"
	help_text = "Verifies your discord account and your BYOND account linkage"

/datum/tgs_chat_command/verify/Run(datum/tgs_chat_user/sender, params)
	var/lowerparams = replacetext(lowertext(params), " ", "") // Fuck spaces
	var/discordid = SSdiscord.id_clean(sender.mention)
	if(SSdiscord.account_link_cache[lowerparams]) // First if they are in the list, then if the ckey matches
		if(SSdiscord.account_link_cache[lowerparams] == discordid) // If the associated ID is the correct one
			// Link the account in the DB table
			SSdiscord.link_account(lowerparams)
			return "Successfully linked accounts"
		else
			return "That ckey is not associated to this discord account. If someone has used your ID, please inform an administrator"
	else
		return "Account not setup for linkage"


/// Gets the discord user's Discord UserID
/datum/tgs_chat_command/myuserid
	name = "myuserid"
	help_text = "Returns your userid"

/datum/tgs_chat_command/myuserid/Run(datum/tgs_chat_user/sender, params)
	var/discordid = SSdiscord.id_clean(sender.mention)
	return "<@[discordid]> Your Discord UserID is [discordid]"
