/mob/living/carbon/xenomorph/defender
	caste_base_type = /datum/xeno_caste/defender
	name = "Defender"
	desc = "An alien with an armored head crest."
	icon = 'icons/Xeno/castes/defender/basic.dmi'
	icon_state = "Defender Walking"
	effects_icon = 'icons/Xeno/castes/defender/effects.dmi'
	rouny_icon = 'icons/Xeno/castes/defender/rouny.dmi'
	bubble_icon = "alienroyal"
	health = 200
	maxHealth = 200
	plasma_stored = 50
	pixel_x = -16
	old_x = -16
	tier = XENO_TIER_ONE
	upgrade = XENO_UPGRADE_NORMAL
	pull_speed = -2
	extract_rewards = list(
		/obj/item/weapon/claymore/mercsword/defender_tail,
	)

// ***************************************
// *********** Icon
// ***************************************
/mob/living/carbon/xenomorph/defender/handle_special_state()
	if(fortify)
		icon_state = "[xeno_caste.caste_name] Fortify"
		return TRUE
	if(crest_defense)
		icon_state = "[xeno_caste.caste_name] Crest"
		return TRUE
	return FALSE

/mob/living/carbon/xenomorph/defender/handle_special_wound_states(severity)
	. = ..()
	if(fortify)
		return "wounded_fortify_[severity]" // we don't have the icons, but still
	if(crest_defense)
		return "wounded_crest_[severity]"

// ***************************************
// *********** Life overrides
// ***************************************
/mob/living/carbon/xenomorph/defender/set_stat()
	. = ..()
	if(isnull(.))
		return
	if(. == CONSCIOUS && fortify) //No longer conscious.
		var/datum/action/ability/xeno_action/fortify/FT = actions_by_path[/datum/action/ability/xeno_action/fortify]
		FT.set_fortify(FALSE) //Fortify prevents dragging due to the anchor component.


// ***************************************
// *********** Mob overrides
// ***************************************

/mob/living/carbon/xenomorph/defender/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/throw_parry)

/obj/item/weapon/claymore/mercsword/defender_tail
	name = "\improper Defender's tail"
	desc = "sd"
	icon_state = "defender_tail"
	item_state = "defender_tail"
	attack_speed = 15
	w_class = WEIGHT_CLASS_BULKY
	force = 85
	penetration = 20
	icon = 'icons/obj/items/weapons.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/melee_right.dmi',
	)
	flags_equip_slot = NONE
	var/target_throw_distance = 2
	var/target_throw_speed = 1

/obj/item/weapon/claymore/mercsword/defender_tail/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(M.status_flags & INCORPOREAL || user.status_flags & INCORPOREAL) //Incorporeal beings cannot attack or be attacked
		return
	var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
	M.throw_at(throw_target, target_throw_distance, target_throw_speed)
	return ..()

/obj/item/weapon/claymore/mercsword/defender_tail/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/strappable)
