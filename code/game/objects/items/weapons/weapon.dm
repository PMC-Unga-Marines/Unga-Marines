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
