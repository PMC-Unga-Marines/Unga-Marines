/datum/job/terragov
	faction = FACTION_TERRAGOV

/datum/job/terragov/radio_help_message(mob/M)
	. = ..()
	if(istype(SSticker.mode, /datum/game_mode/hvh/combat_patrol))
		if(issensorcapturegamemode(SSticker.mode))
			to_chat(M, span_highdanger("Your platoon has orders to attack sensor towers in the AO and reactivate them in order to alert other TerraGov forces in the sector about the invasion. High Command considers the successful reactivation of the sensor towers a major victory"))
		else
			to_chat(M, span_highdanger("Your platoon has orders to patrol a remote TerraGov territory that the Sons of Mars are illegally attempting to claim. Intel suggests hostile patrols are in the area to try maintain defacto control. Work with your team and eliminate all SOM you encounter while minimising your own casualties! High Command considers wiping out all enemies a major victory, or inflicting more casualties a minor victory."))
		return
	if(CONFIG_GET(number/minimal_access_threshold))
		var/msg = "As this ship was initially staffed with a [CONFIG_GET(flag/jobs_have_minimal_access) ? "skeleton crew, additional access may" : "full crew, only the job's necessities"] have been added to the crew's ID cards."
		to_chat(M, span_notice(msg))

/datum/job/terragov/return_spawn_type(datum/preferences/prefs)
	switch(prefs?.species)
		if("Vatborn")
			return /mob/living/carbon/human/species/vatborn
		else
			return /mob/living/carbon/human
