/mob/living/proc/blind_eyes(amount)
	if(amount <= 0)
		return
	var/old_eye_blind = eye_blind
	eye_blind = max(eye_blind, amount)
	if(!old_eye_blind)
		overlay_fullscreen("blind", /atom/movable/screen/fullscreen/blind)

/mob/living/proc/adjust_blindness(amount)
	if(amount > 0)
		var/old_eye_blind = eye_blind
		eye_blind += amount
		if(!old_eye_blind)
			overlay_fullscreen("blind", /atom/movable/screen/fullscreen/blind)
	else if(eye_blind)
		var/blind_minimum = 0
		if(stat != CONSCIOUS)
			blind_minimum = 1
		if(isliving(src))
			var/mob/living/L = src
			if(!L.has_vision())
				blind_minimum = 1
		eye_blind = max(eye_blind+amount, blind_minimum)
		if(!eye_blind)
			clear_fullscreen("blind")

/mob/living/proc/set_blindness(amount)
	if(amount > 0)
		var/old_eye_blind = eye_blind
		eye_blind = amount
		if(client && !old_eye_blind)
			overlay_fullscreen("blind", /atom/movable/screen/fullscreen/blind)
	else if(eye_blind)
		var/blind_minimum = 0
		if(stat != CONSCIOUS)
			blind_minimum = 1
		if(isliving(src))
			var/mob/living/L = src
			if(!L.has_vision())
				blind_minimum = 1
		eye_blind = blind_minimum
		if(!eye_blind)
			clear_fullscreen("blind")
