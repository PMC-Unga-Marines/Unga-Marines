/datum/hud_data
///If set, overrides ui_style
	var/icon
	///Set to draw intent box
	var/has_a_intent = TRUE
	///Set to draw move intent box
	var/has_m_intent = TRUE
	///Set to draw environment warnings
	var/has_warnings = TRUE
	///Set to draw shand
	var/has_hands = TRUE
	///Set to draw drop button
	var/has_drop = TRUE
	///Set to draw throw button
	var/has_throw = TRUE
	///Set to draw resist button
	var/has_resist = TRUE
	///Checked by mob_can_equip()
	var/list/equip_slots = list()

	/**
	 * Contains information on the position and tag for all inventory slots
	 * to be drawn for the mob. This is fairly delicate, try to avoid messing with it
	 * unless you know exactly what it does
	 */
	var/list/gear = list(
		"i_clothing" = list(
			"loc" = ui_iclothing,
			"slot" = SLOT_W_UNIFORM,
			"state" = "uniform",
			"toggle" = TRUE,
		),
		"o_clothing" = list(
			"loc" = ui_oclothing,
			"slot" = SLOT_WEAR_SUIT,
			"state" = "suit",
			"toggle" = TRUE,
		),
		"mask" = list(
			"loc" = ui_mask,
			"slot" = SLOT_WEAR_MASK,
			"state" = "mask",
			"toggle" = TRUE,
		),
		"gloves" = list(
			"loc" = ui_gloves,
			"slot" = SLOT_GLOVES,
			"state" = "gloves",
			"toggle" = TRUE,
		),
		"eyes" = list(
			"loc" = ui_glasses,
			"slot" = SLOT_GLASSES,
			"state" = "glasses",
			"toggle" = TRUE,
		),
		"wear_ear" = list(
			"loc" = ui_wear_ear,
			"slot" = SLOT_EARS,
			"state" = "ears",
			"toggle" = TRUE,
		),
		"head" = list(
			"loc" = ui_head,
			"slot" = SLOT_HEAD,
			"state" = "head",
			"toggle" = TRUE,
		),
		"shoes" = list(
			"loc" = ui_shoes,
			"slot" = SLOT_SHOES,
			"state" = "shoes",
			"toggle" = TRUE,
		),
		"suit storage" = list(
			"loc" = ui_sstore1,
			"slot" = SLOT_S_STORE,
			"state" = "suit_storage",
		),
		"back" = list(
			"loc" = ui_back,
			"slot" = SLOT_BACK,
			"state" = "back",
		),
		"id" = list(
			"loc" = ui_id,
			"slot" = SLOT_WEAR_ID,
			"state" = "id",
		),
		"storage1" = list(
			"loc" = ui_storage1,
			"slot" = SLOT_L_STORE,
			"state" = "pocket",
		),
		"storage2" = list(
			"loc" = ui_storage2,
			"slot" = SLOT_R_STORE,
			"state" = "pocket",
		),
		"belt" = list(
			"loc" = ui_belt,
			"slot" = SLOT_BELT,
			"state" = "belt",
		),
	)

/datum/hud_data/New()
	. = ..()
	for(var/slot in gear)
		equip_slots |= gear[slot]["slot"]

	if(has_hands)
		equip_slots |= SLOT_L_HAND
		equip_slots |= SLOT_R_HAND
		equip_slots |= SLOT_HANDCUFFED
	if(SLOT_HEAD in equip_slots)
		equip_slots |= SLOT_IN_HEAD
	if(SLOT_BACK in equip_slots)
		equip_slots |= SLOT_IN_BACKPACK
		equip_slots |= SLOT_IN_B_HOLSTER
	if(SLOT_BELT in equip_slots)
		equip_slots |= SLOT_IN_HOLSTER
		equip_slots |= SLOT_IN_BELT
	if(SLOT_WEAR_SUIT in equip_slots)
		equip_slots |= SLOT_IN_S_HOLSTER
		equip_slots |= SLOT_IN_SUIT
	if(SLOT_SHOES in equip_slots)
		equip_slots |= SLOT_IN_BOOT
	if(SLOT_W_UNIFORM in equip_slots)
		equip_slots |= SLOT_IN_STORAGE
		equip_slots |= SLOT_IN_L_POUCH
		equip_slots |= SLOT_IN_R_POUCH
		equip_slots |= SLOT_ACCESSORY
		equip_slots |= SLOT_IN_ACCESSORY
