/mob/living/carbon/examine(mob/user)
	. = ..()
	if(isyautja(user))
		var/honor_value = max(life_kills_total + life_value, default_honor_value)
		if(user.hunter_data && (hunter_data in user.hunter_data.targets))
			honor_value += 3
		. += span_blue("[src] is worth [honor_value] honor.")
		if(hunter_data.automatic_target)
			. += span_red("[src] marked as target for [hunter_data.targeted.real_name]")
		if(hunter_data.hunted)
			. += span_orange("[src] is being hunted by [hunter_data.hunter.real_name].")

		if(hunter_data.dishonored)
			. += span_green("[src] was marked as dishonorable for '[hunter_data.dishonored_reason]'.")
		else if(hunter_data.honored)
			. += span_green("[src] was honored for '[hunter_data.honored_reason]'.")

		if(hunter_data.thralled)
			. += span_green("[src] was thralled by [hunter_data.thralled_set.real_name] for '[hunter_data.thralled_reason]'.")
		else if(hunter_data.gear)
			. += span_red("[src] was marked as carrying gear by [hunter_data.gear_set].")

/mob/living/carbon/plastique_act()
	ex_act(500)
