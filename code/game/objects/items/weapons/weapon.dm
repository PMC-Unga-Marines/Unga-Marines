//items designed as weapon
/obj/item/weapon
	name = "weapon"
	icon = 'icons/obj/items/weapons.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/melee_right.dmi',
	)
	hitsound = SFX_SWING_HIT
	///codex
	var/caliber = "missing from codex"
	///codex, defines are below.
	var/load_method = null
	///codex, bullets, shotgun shells TODO: KILL THESE TWO VARS
	var/max_shells = 0
	///codex, energy weapons
	var/max_shots = 0
	///codex
	var/scope_zoom = FALSE
	///codex
	var/self_recharge = FALSE
	var/can_block_xeno = FALSE
	/// 0-100%
	var/can_block_chance = 30

/obj/item/weapon/melee_attack_chain(mob/user, atom/target, params, rightclick)
	if(target == user && !user.do_self_harm)
		return
	return ..()

/obj/item/weapon/get_mechanics_info()
	. = ..()
	if(isgun(src))
		return // no melee weapon info for guns

	var/list/weapon_strings = list()

	var/list/entries = SScodex.retrieve_entries_for_string(name)
	var/datum/codex_entry/general_entry = LAZYACCESS(entries, 1)
	if(general_entry?.mechanics_text)
		weapon_strings += general_entry.mechanics_text + "<br>"

	weapon_strings += "Melee damage: [force]"
	if(CHECK_BITFIELD(item_flags, TWOHANDED))
		var/obj/item/weapon/twohanded/our_weapon = src // yeah...
		weapon_strings += "Melee damage while wielded: [our_weapon.force_wielded]"
	weapon_strings += "Time between attacks: [attack_speed] milliseconds."
	weapon_strings += "Armor penetration: [penetration]"
	weapon_strings += "On throw damage: [throwforce]"
	weapon_strings += "Maximum throw range: [throw_range]"
	weapon_strings += "Throwing speed: [throw_speed]"
	weapon_strings += "Attack distance: [reach] tiles."
	var/sharpness = "dull"
	switch(sharp)
		if(IS_SHARP_ITEM_SIMPLE)
			sharpness = "almost dull"
		if(IS_SHARP_ITEM_ACCURATE)
			sharpness = "sharp"
		if(IS_SHARP_ITEM_BIG)
			sharpness = "very sharp"
	weapon_strings += "It is [sharpness]."
	if(edge)
		weapon_strings += "It has a sharp edge."

	. += jointext(weapon_strings, "<br>")
