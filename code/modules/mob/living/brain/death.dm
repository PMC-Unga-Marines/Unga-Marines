/mob/living/brain/gib()
	if(loc)
		if(istype(loc, /obj/item/organ/brain))
			qdel(loc)//Gets rid of the brain item
	return ..()
