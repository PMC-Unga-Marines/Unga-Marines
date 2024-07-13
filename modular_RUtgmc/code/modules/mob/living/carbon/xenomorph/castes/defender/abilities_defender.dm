// ***************************************
// *********** Regenerate Skin
// ***************************************

/datum/action/ability/xeno_action/regenerate_skin
	ability_cost = 80

// ***************************************
// *********** Fortify
// ***************************************

/datum/action/ability/xeno_action/fortify/set_fortify(on, silent)
	. = ..()
	if(on)
		owner.drop_all_held_items() // drop items (hugger/jelly)
