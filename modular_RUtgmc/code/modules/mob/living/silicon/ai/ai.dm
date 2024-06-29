/mob/living/silicon/ai/update_sight()
	see_in_dark = initial(see_in_dark)
	lighting_alpha = initial(lighting_alpha)
	eyeobj.see_in_dark = initial(eyeobj.see_in_dark)
	eyeobj.lighting_alpha = initial(eyeobj.lighting_alpha)

	if(HAS_TRAIT(src, TRAIT_SEE_IN_DARK))
		see_in_dark = max(see_in_dark, 8)
		lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
		eyeobj.see_in_dark = max(eyeobj.see_in_dark, 8)
		eyeobj.lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE

	return ..()
