/mob/living/proc/blur_eyes(amount)
	if(amount > 0)
		eye_blurry = max(amount, eye_blurry)
	update_eye_blur()

/mob/living/proc/adjust_blurriness(amount)
	eye_blurry = max(eye_blurry + amount, 0)
	update_eye_blur()

/mob/living/proc/set_blurriness(amount)
	eye_blurry = max(amount, 0)
	update_eye_blur()

/mob/living/proc/update_eye_blur()
	if(!client)
		return
	var/atom/movable/screen/plane_master/floor/OT = locate(/atom/movable/screen/plane_master/floor) in client.screen
	var/atom/movable/screen/plane_master/game_world/GW = locate(/atom/movable/screen/plane_master/game_world) in client.screen
	GW.backdrop(src)
	OT.backdrop(src)
