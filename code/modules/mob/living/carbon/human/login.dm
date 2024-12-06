/mob/living/carbon/human/Login()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_IS_RESURRECTING))
		to_chat(src, span_notice("You are resurrecting, hold still..."))
