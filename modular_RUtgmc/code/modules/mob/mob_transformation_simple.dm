/mob/living/carbon/human/species/yautja/on_transformation(subspecies)
	var/final_name = "Le'pro"
	ethnicity = "Tan"
	gender = MALE
	age = 100
	flavor_text = ""

	if(client)
		h_style = client.prefs.predator_h_style
		ethnicity = client.prefs.predator_skin_color
		gender = client.prefs.predator_gender
		age = client.prefs.predator_age
		final_name = client.prefs.predator_name
		flavor_text = client.prefs.predator_flavor_text
		r_eyes = client.prefs.pred_r_eyes
		g_eyes = client.prefs.pred_g_eyes
		b_eyes = client.prefs.pred_b_eyes
		if(!final_name || final_name == "Undefined") //In case they don't have a name set or no prefs, there's a name.
			final_name = "Le'pro"

		update_body()
		update_hair()
		regenerate_icons()

	real_name = final_name
	name = final_name

	if(mind)
		mind.name = real_name
