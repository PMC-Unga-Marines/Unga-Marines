/datum/outfit/quick
	///Description of the loadout
	var/desc = "Description here"
	///How much of this loadout there is. infinite by default
	var/quantity = -1
	///What job this loadout is associated with. Used for tabs and access.
	var/jobtype = SQUAD_MARINE

/datum/outfit/quick/equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/override_client)
	pre_equip(H, visualsOnly, override_client)

	//Start with uniform,suit,backpack for additional slots. Deletes any existing equipped item to avoid accidentally losing half your loadout. Not suitable for standard gamemodes!
	if(w_uniform)
		qdel(H.w_uniform)
		H.equip_to_slot_or_del(new w_uniform(H), SLOT_W_UNIFORM, override_nodrop = TRUE)
	if(wear_suit)
		qdel(H.wear_suit)
		H.equip_to_slot_or_del(new wear_suit(H), SLOT_WEAR_SUIT, override_nodrop = TRUE)
	if(back)
		qdel(H.back)
		H.equip_to_slot_or_del(new back(H), SLOT_BACK, override_nodrop = TRUE)
	if(belt)
		qdel(H.belt)
		H.equip_to_slot_or_del(new belt(H), SLOT_BELT, override_nodrop = TRUE)
	if(gloves)
		qdel(H.gloves)
		H.equip_to_slot_or_del(new gloves(H), SLOT_GLOVES, override_nodrop = TRUE)
	if(shoes)
		qdel(H.shoes)
		H.equip_to_slot_or_del(new shoes(H), SLOT_SHOES, override_nodrop = TRUE)
	if(head)
		qdel(H.head)
		H.equip_to_slot_or_del(new head(H), SLOT_HEAD, override_nodrop = TRUE)
	if(mask)
		qdel(H.wear_mask)
		H.equip_to_slot_or_del(new mask(H), SLOT_WEAR_MASK, override_nodrop = TRUE)
	if(ears)
		qdel(H.wear_ear)
		if(visualsOnly)
			H.equip_to_slot_or_del(new /obj/item/radio/headset(H), SLOT_EARS, override_nodrop = TRUE)
		else
			H.equip_to_slot_or_del(new ears(H, H.assigned_squad, H.job.type), SLOT_EARS, override_nodrop = TRUE)
	if(glasses)
		qdel(H.glasses)
		H.equip_to_slot_or_del(new glasses(H), SLOT_GLASSES, override_nodrop = TRUE)
	if(id)
		H.equip_to_slot_or_del(new id(H), SLOT_WEAR_ID, override_nodrop = TRUE)
	if(suit_store)
		qdel(H.s_store)
		H.equip_to_slot_or_del(new suit_store(H), SLOT_S_STORE, override_nodrop = TRUE)
	if(l_hand)
		qdel(H.l_hand)
		H.put_in_l_hand(new l_hand(H))
	if(r_hand)
		qdel(H.r_hand)
		H.put_in_r_hand(new r_hand(H))

	if(!visualsOnly) // Items in pockets or backpack don't show up on mob's icon.
		if(l_store)
			qdel(H.l_store)
			H.equip_to_slot_or_del(new l_store(H), SLOT_L_STORE, override_nodrop = TRUE)
		if(r_store)
			qdel(H.r_store)
			H.equip_to_slot_or_del(new r_store(H), SLOT_R_STORE, override_nodrop = TRUE)

		if(box)
			if(!backpack_contents)
				backpack_contents = list()
			backpack_contents.Insert(1, box)
			backpack_contents[box] = 1

		if(backpack_contents)
			for(var/path in backpack_contents)
				var/number = backpack_contents[path]
				if(!isnum(number))//Default to 1
					number = 1
				for(var/i in 1 to number)
					H.equip_to_slot_or_del(new path(H), SLOT_IN_BACKPACK, override_nodrop = TRUE)

	post_equip(H, visualsOnly)

	H.update_body()
	return TRUE
