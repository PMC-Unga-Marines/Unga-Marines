//word of warning: using a matrix like this as a color value will simplify it back to a string after being set
/proc/color_hex2color_matrix(string)
	var/length = length(string)
	if((length != 7 && length != 9) || length != length_char(string))
		return color_matrix_identity()
	var/r = hex2num(copytext(string, 2, 4))/255
	var/g = hex2num(copytext(string, 4, 6))/255
	var/b = hex2num(copytext(string, 6, 8))/255
	var/a = 1
	if(length == 9)
		a = hex2num(copytext(string, 8, 10))/255
	if(!isnum(r) || !isnum(g) || !isnum(b) || !isnum(a))
		return color_matrix_identity()
	return list(r, 0, 0, 0, 0, g, 0, 0, 0, 0, b, 0, 0, 0, 0, a, 0, 0, 0, 0)


///Converts a hex color string to a color matrix.
/proc/color_matrix_from_string(string)
	if(!string || !istext(string))
		return color_matrix_identity()

	var/string_r = hex2num(copytext(string, 2, 4)) / 255
	var/string_g = hex2num(copytext(string, 4, 6)) / 255
	var/string_b = hex2num(copytext(string, 6, 8)) / 255

	return list(string_r, 0, 0, 0, 0, string_g, 0, 0, 0, 0, string_b, 0, 0, 0, 0, 1, 0, 0, 0, 0)



/*Changing/updating a mob's client color matrices. These render over the map window and affect most things the player sees, except things like inventory,
text popups, HUD, and some fullscreens. Code based on atom filter code, since these have similar issues with application order - for ex. if you have
a desaturation and a recolor matrix, you'll get very different results if you desaturate before recoloring, or recolor before desaturating.
See matrices.dm for the matrix procs.
If you want to recolor a specific atom, you should probably do it as a color matrix filter instead since that code already exists.
Apparently color matrices are not the same sort of matrix used by matrix datums and can't be worked with using normal matrix procs.*/

///Adds a color matrix and updates the client. Priority is the order the matrices are applied, lowest first. Will replace an existing matrix of the same name, if one exists.
/mob/proc/add_client_color_matrix(name, priority, list/params, time, easing)
	LAZYINITLIST(client_color_matrices)

	//Package the matrices in another list that stores priority.
	client_color_matrices[name] = list("priority" = priority, "color_matrix" = params.Copy())

	update_client_color_matrices(time, easing)

/**Combines all color matrices and applies them to the client.
Also used on login to give a client its new body's color matrices.
Responsible for sorting the matrices.
Transition is animated but instant by default.**/
/mob/proc/update_client_color_matrices(time = 0 SECONDS, easing = LINEAR_EASING)
	if(!client)
		return

	if(!length(client_color_matrices))
		animate(client, color = null, time = time, easing = easing)
		UNSETEMPTY(client_color_matrices)
		SEND_SIGNAL(src, COMSIG_MOB_RECALCULATE_CLIENT_COLOR)
		return

	//Sort the matrix packages by priority.
	client_color_matrices = sortTim(client_color_matrices, GLOBAL_PROC_REF(cmp_filter_data_priority), TRUE)

	var/list/final_matrix

	for(var/package in client_color_matrices)
		var/list/current_matrix = client_color_matrices[package]["color_matrix"]
		if(!final_matrix)
			final_matrix = current_matrix
		else
			final_matrix = color_matrix_multiply(final_matrix, current_matrix)

	animate(client, color = final_matrix, time = time, easing = easing)
	SEND_SIGNAL(src, COMSIG_MOB_RECALCULATE_CLIENT_COLOR)

///Changes a matrix package's priority and updates client.
/mob/proc/change_client_color_matrix_priority(name, new_priority, time, easing)
	if(!client_color_matrices || !client_color_matrices[name])
		return

	client_color_matrices[name]["priority"] = new_priority

	update_client_color_matrices(time, easing)

///Returns the matrix of that name, if it exists.
/mob/proc/get_client_color_matrix(name)
	return client_color_matrices[name]["color_matrix"]

///Can take either a single name or a list of several. Attempts to remove target matrix packages and update client.
/mob/proc/remove_client_color_matrix(name_or_names, time, easing)
	if(!client_color_matrices)
		return

	var/found = FALSE
	var/list/names = islist(name_or_names) ? name_or_names : list(name_or_names)

	for(var/name in names)
		if(client_color_matrices[name])
			client_color_matrices -= name
			found = TRUE

	if(found)
		update_client_color_matrices(time, easing)

///Removes all matrices and updates client.
/mob/proc/clear_client_color_matrices(time, easing)
	client_color_matrices = null
	update_client_color_matrices(time, easing)
