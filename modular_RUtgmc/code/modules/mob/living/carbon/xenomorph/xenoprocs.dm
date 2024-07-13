/mob/living/carbon/xenomorph/proc/update_progression()
	if(!upgrade_possible())
		return
	if(incapacitated())
		return
	upgrade_xeno(upgrade_next())
