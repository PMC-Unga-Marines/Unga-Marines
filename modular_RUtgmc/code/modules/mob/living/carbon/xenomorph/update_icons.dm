/mob/living/carbon/xenomorph/proc/create_shriekwave(color)
	var/image/shriekwave = image("icon"='icons/Xeno/64x64_Xeno_overlays.dmi', "icon_state" = "shriek_waves") //Ehh, suit layer's not being used.
	if(color)
		shriekwave.color = color
	overlays_standing[X_SUIT_LAYER] = shriekwave
	apply_temp_overlay(X_SUIT_LAYER, 3 SECONDS)
