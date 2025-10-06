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

// todo replace this shit with tg's style status effect for this
/mob/living/proc/update_eye_blur()
	if(!client)
		return
	if(SEND_SIGNAL(src, COMSIG_LIVING_UPDATE_PLANE_BLUR) & COMPONENT_CANCEL_BLUR)
		return
	var/atom/movable/plane_master_controller/game_plane_master_controller = hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	if(eye_blurry <= 0)
		game_plane_master_controller.remove_filter("eye_blur")
	else
		game_plane_master_controller.add_filter("eye_blur", 1, gauss_blur_filter(clamp(eye_blurry * 0.1, 0.6, 3)))
