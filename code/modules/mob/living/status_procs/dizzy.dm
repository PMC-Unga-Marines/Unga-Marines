/// Adds a dizziness amount to a mob, use this rather than directly changing var/dizziness
/// since this ensures that the dizzy_process proc is started, currently only carbons get dizzy
/// value of dizziness ranges from 0 to 1000, below 100 is not dizzy
/mob/living/proc/dizzy(amount)
	return

/mob/living/proc/dizzy_process()
	is_dizzy = TRUE
	while(dizziness > 100)
		if(client)
			var/amplitude = dizziness*(sin(dizziness * 0.044 * world.time) + 1) / 70
			client.pixel_x = amplitude * sin(0.008 * dizziness * world.time)
			client.pixel_y = amplitude * cos(0.008 * dizziness * world.time)

		sleep(0.1 SECONDS)
	//endwhile - reset the pixel offsets to zero
	is_dizzy = FALSE
	if(client)
		client.pixel_x = 0
		client.pixel_y = 0
