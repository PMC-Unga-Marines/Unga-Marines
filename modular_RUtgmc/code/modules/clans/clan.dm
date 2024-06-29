/proc/create_new_clan(clanname)
	var/datum/db_query/query_create_clan = SSdbcore.NewQuery("INSERT INTO [format_table_name("clan")] (name, description, honor, color) VALUES (:name, :desc, 0, :color)", list("name" = clanname, "desc" = "This is a clan.", "color" = "#FFF"))
	query_create_clan.Execute()
	qdel(query_create_clan)
