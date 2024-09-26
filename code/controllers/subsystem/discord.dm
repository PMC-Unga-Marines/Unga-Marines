/*
NOTES:
There is a DB table to track ckeys and associated discord IDs.
This system REQUIRES TGS, and will auto-disable if TGS is not present.
The SS uses fire() instead of just pure shutdown, so people can be notified if it comes back after a crash, where the SS wasn't properly shutdown
It only writes to the disk every 5 minutes, and it won't write to disk if the file is the same as it was the last time it was written. This is to save on disk writes
The system is kept per-server (EG: Terry will not notify people who pressed notify on Sybil), but the accounts are between servers so you dont have to relink on each server.

##################
# HOW THIS WORKS #
##################

ROUNDSTART:
1] The file is loaded and the discord IDs are extracted
2] A ping is sent to the discord with the IDs of people who wished to be notified
3] The file is emptied

MIDROUND:
1] Someone usees the notify verb, it adds their discord ID to the list.
2] On fire, it will write that to the disk, as long as conditions above are correct

END ROUND:
1] The file is force-saved, incase it hasn't fired at end round

This is an absolute clusterfuck, but its my clusterfuck -aa07
*/

SUBSYSTEM_DEF(discord)
	name = "Discord"
	wait = 3000
	init_order = INIT_ORDER_DISCORD

	/// List that holds accounts to link, used in conjunction with TGS
	var/list/account_link_cache = list()
	/// list of people who tried to use Boosty styff, so we don't call the API every time
	var/list/boosty_cache = list()
	/// Is TGS enabled (If not we won't fire because otherwise this is useless)
	var/enabled = FALSE

/datum/controller/subsystem/discord/Initialize(start_timeofday)
	// Check for if we are using TGS, otherwise return and disables firing
	if(world.TgsAvailable())
		enabled = TRUE // Allows other procs to use this (Account linking, etc)
		return SS_INIT_SUCCESS
	else
		can_fire = FALSE // We dont want excess firing
		return SS_INIT_NO_NEED



/datum/controller/subsystem/discord/fire()
	if(!enabled)
		return // Dont do shit if its disabled

// Returns ID from ckey
/datum/controller/subsystem/discord/proc/lookup_id(lookup_ckey)
	//We cast the discord ID to varchar to prevent BYOND mangling
	//it into it's scientific notation
	var/datum/db_query/query_get_discord_id = SSdbcore.NewQuery(
		"SELECT CAST(discord_id AS CHAR(25)) FROM [format_table_name("player")] WHERE ckey = :ckey",
		list("ckey" = lookup_ckey)
	)
	if(!query_get_discord_id.Execute())
		qdel(query_get_discord_id)
		return
	if(query_get_discord_id.NextRow())
		. = query_get_discord_id.item[1]
	qdel(query_get_discord_id)

// Returns ckey from ID
/datum/controller/subsystem/discord/proc/lookup_ckey(lookup_id)
	var/datum/db_query/query_get_discord_ckey = SSdbcore.NewQuery(
		"SELECT ckey FROM [format_table_name("player")] WHERE discord_id = :discord_id",
		list("discord_id" = lookup_id)
	)
	if(!query_get_discord_ckey.Execute())
		qdel(query_get_discord_ckey)
		return
	if(query_get_discord_ckey.NextRow())
		. = query_get_discord_ckey.item[1]
	qdel(query_get_discord_ckey)

// Finalises link
/datum/controller/subsystem/discord/proc/link_account(ckey)
	var/datum/db_query/link_account = SSdbcore.NewQuery(
		"UPDATE [format_table_name("player")] SET discord_id = :discord_id WHERE ckey = :ckey",
		list("discord_id" = account_link_cache[ckey], "ckey" = ckey)
	)
	link_account.Execute()
	qdel(link_account)
	account_link_cache -= ckey

// Unlink account (Admin verb used)
/datum/controller/subsystem/discord/proc/unlink_account(ckey)
	var/datum/db_query/unlink_account = SSdbcore.NewQuery(
		"UPDATE [format_table_name("player")] SET discord_id = NULL WHERE ckey = :ckey",
		list("ckey" = ckey)
	)
	unlink_account.Execute()
	qdel(unlink_account)

// Clean up a discord account mention
/datum/controller/subsystem/discord/proc/id_clean(input)
	var/regex/num_only = regex("\[^0-9\]", "g")
	return num_only.Replace(input, "")

/datum/controller/subsystem/discord/proc/get_boosty_tier(ckey, silent = TRUE)
	#ifdef TESTING
	if(!silent)
		to_chat(src, span_warning("Test mod gave you tier 3 boost"))
	return BOOSTY_TIER_3
	#endif

	// Safety checks
	if(!CONFIG_GET(flag/sql_enabled))
		if(!silent)
			to_chat(src, span_warning("This feature requires the SQL backend to be running."))
		return BOOSTY_TIER_0

	// ss is still starting
	if(!SSdiscord)
		if(!silent)
			to_chat(src, span_notice("The server is still starting up. Please wait before attempting to link your account!"))
		return BOOSTY_TIER_0

	if(!SSdiscord.enabled)
		if(!silent)
			to_chat(usr, span_warning("TGS is not enabled"))
		return BOOSTY_TIER_0

	//use cache if possible
	if(boosty_cache[ckey])
		return boosty_cache[ckey]

	var/discord_id = lookup_id(ckey)

	if(!discord_id) // Account is not linked
		if(!silent)
			to_chat(usr, "Link your discord account via the linkdiscord verb in the OOC tab first");
		return BOOSTY_TIER_0

	var/url = "https://discord.com/api/guilds/[CONFIG_GET(string/discord_guildid)]/members/[discord_id]"
	// Make the request
	var/datum/http_request/req = new()
	req.prepare(RUSTG_HTTP_METHOD_GET, url, "", list("Authorization" = "Bot [CONFIG_GET(string/discord_token)]"))
	req.begin_async()
	UNTIL(req.is_complete())
	var/datum/http_response/res = req.into_response()

	var/list/data = list()

	try
		data = json_decode(res.body)
	catch(var/exception/e)
		if(!silent)
			to_chat(usr, span_warning("JSON parsing FAILED: [e]: [res.body]"))
		return BOOSTY_TIER_0

	if(!data["roles"])
		if(!silent)
			to_chat(usr, span_warning("Failed to check discord roles"));
		return BOOSTY_TIER_0

	//save cache and return tier

	if(CONFIG_GET(string/discord_boosty_roleid_tier_3) in data["roles"])
		boosty_cache[ckey] = BOOSTY_TIER_3
		return BOOSTY_TIER_3

	if(CONFIG_GET(string/discord_boosty_roleid_tier_2) in data["roles"])
		boosty_cache[ckey] = BOOSTY_TIER_2
		return BOOSTY_TIER_2

	if(CONFIG_GET(string/discord_boosty_roleid_tier_1) in data["roles"])
		boosty_cache[ckey] = BOOSTY_TIER_1
		return BOOSTY_TIER_1

	boosty_cache[ckey] = BOOSTY_TIER_0
	return BOOSTY_TIER_0
