/mob/living/brain/gib()
	if(!loc)
		return ..()
	if(!istype(loc, /obj/item/organ/brain))
		return ..()
	qdel(loc)//Gets rid of the brain item
	return ..()
