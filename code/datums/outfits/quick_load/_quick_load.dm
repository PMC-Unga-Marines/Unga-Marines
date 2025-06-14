/datum/outfit/quick
	///Description of the loadout
	var/desc = "Description here"
	///How much of this loadout there is. infinite by default
	var/quantity = -1
	///What job this loadout is associated with. Used for tabs and access.
	var/jobtype = "Squad Marine"

/datum/outfit/quick/equip(mob/living/carbon/human/equipping_human, visualsOnly = FALSE)
	//Start with uniform,suit,backpack for additional slots. Deletes any existing equipped item to avoid accidentally losing half your loadout. Not suitable for standard gamemodes!
	if(w_uniform)
		qdel(equipping_human.w_uniform)
	if(wear_suit)
		qdel(equipping_human.wear_suit)
	if(back)
		qdel(equipping_human.back)
	if(belt)
		qdel(equipping_human.belt)
	if(gloves)
		qdel(equipping_human.gloves)
	if(shoes)
		qdel(equipping_human.shoes)
	if(head)
		qdel(equipping_human.head)
	if(mask)
		qdel(equipping_human.wear_mask)
	if(ears)
		qdel(equipping_human.wear_ear)
	if(glasses)
		qdel(equipping_human.glasses)
	if(suit_store)
		qdel(equipping_human.s_store)
	if(l_hand)
		qdel(equipping_human.l_hand)
	if(r_hand)
		qdel(equipping_human.r_hand)
	return ..()
