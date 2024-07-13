/mob/living/carbon/xenomorph/king
	icon = 'modular_RUtgmc/icons/Xeno/castes/king.dmi'
	footstep_type = FOOTSTEP_XENO_STOMPY

/mob/living/carbon/xenomorph/king/generate_name()
	var/playtime_mins = client?.get_exp(xeno_caste.caste_name)
	var/prefix = (hive.prefix || xeno_caste.upgrade_name) ? "[hive.prefix][xeno_caste.upgrade_name] " : ""
	switch(playtime_mins)
		if(0 to 300)
			name = prefix + "Young King ([nicknumber])"
		if(301 to 1500)
			name = prefix + "Mature King ([nicknumber])"
		if(1501 to 4200)
			name = prefix + "Elder Emperor ([nicknumber])"
		if(4201 to 9000)
			name = prefix + "Ancient Emperor ([nicknumber])"
		if(9001 to INFINITY)
			name = prefix + "Prime Emperor ([nicknumber])"
		else
			name = prefix + "Young King ([nicknumber])"

	real_name = name
	if(mind)
		mind.name = name
