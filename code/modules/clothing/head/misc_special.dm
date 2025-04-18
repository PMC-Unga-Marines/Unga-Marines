/*
* Contents:
*		Welding mask
*		Cakehat
*		Ushanka
*		Pumpkin head
*
*/

/*
* Welding mask
*/
/obj/item/clothing/head/welding
	name = "welding helmet"
	desc = "A head-mounted face cover designed to protect the wearer completely from space-arc eye."
	icon_state = "welding"
	worn_icon_state = "welding"
	soft_armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	atom_flags = CONDUCT
	inventory_flags = COVEREYES|COVERMOUTH|BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDEEYES|HIDEFACE
	armor_protection_flags = HEAD|FACE|EYES
	actions_types = list(/datum/action/item_action/toggle)
	siemens_coefficient = 0.9
	w_class = WEIGHT_CLASS_NORMAL
	anti_hug = 2
	eye_protection = 2
	var/up = FALSE
	var/hug_memory = 0 //Variable to hold the "memory" of how many anti-hugs remain.  Because people were abusing the fuck out of it.

/obj/item/clothing/head/welding/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/clothing_tint, TINT_5)

/obj/item/clothing/head/welding/attack_self(mob/user)
	toggle_worn_icon_state(user)

/obj/item/clothing/head/welding/verb/verbtoggle()
	set category = "IC.Clothing"
	set name = "Adjust welding mask"
	set src in usr

	if(!usr.incapacitated())
		toggle_worn_icon_state(usr)

/obj/item/clothing/head/welding/proc/flip_up()
	DISABLE_BITFIELD(inventory_flags, COVEREYES|COVERMOUTH|BLOCKSHARPOBJ)
	DISABLE_BITFIELD(inv_hide_flags, HIDEEARS|HIDEEYES|HIDEFACE)
	eye_protection = 0
	hug_memory = anti_hug
	anti_hug = 0
	icon_state = "[initial(icon_state)]up"

/obj/item/clothing/head/welding/proc/flip_down()
	ENABLE_BITFIELD(inventory_flags, COVEREYES|COVERMOUTH|BLOCKSHARPOBJ)
	ENABLE_BITFIELD(inv_hide_flags, HIDEEARS|HIDEEYES|HIDEFACE)
	eye_protection = initial(eye_protection)
	anti_hug = hug_memory
	icon_state = initial(icon_state)

/obj/item/clothing/head/welding/toggle_worn_icon_state(mob/user)
	. = ..()
	up = !up
	icon_state = "[initial(icon_state)][up ? "up" : ""]"
	if(up)
		flip_up()
	else
		flip_down()
	if(user)
		to_chat(usr, "You [up ? "push [src] up out of your face" : "flip [src] down to protect your eyes"].")

	update_clothing_icon()	//so our mob-overlays update

	update_action_button_icons()

/obj/item/clothing/head/welding/flipped //spawn in flipped up.
	up = TRUE

/obj/item/clothing/head/welding/flipped/Initialize(mapload)
	. = ..()
	flip_up()
	AddComponent(/datum/component/clothing_tint, TINT_5, FALSE)

/*
* Cakehat
*/
/obj/item/clothing/head/cakehat
	name = "cake-hat"
	desc = "It's tasty looking!"
	icon_state = "cake0"
	inventory_flags = COVEREYES
	var/onfire = 0
	var/status = 0
	var/processing = 0 //I dont think this is used anywhere.
	armor_protection_flags = EYES

/obj/item/clothing/head/cakehat/process()
	if(!onfire)
		STOP_PROCESSING(SSobj, src)
		return

/obj/item/clothing/head/cakehat/attack_self(mob/user as mob)
	if(status > 1)	return
	src.onfire = !( src.onfire )
	if (src.onfire)
		src.force = 3
		src.damtype = FIRE
		src.icon_state = "cake1"
		START_PROCESSING(SSobj, src)
		return

	force = null
	damtype = BRUTE
	icon_state = "cake0"

/*
* Pumpkin head
*/

/obj/item/clothing/head/pumpkinhead
	name = "carved pumpkin"
	desc = "A jack o' lantern! Believed to ward off evil spirits."
	icon_state = "hardhat0_pumpkin"//Could stand to be renamed
	worn_icon_state = "hardhat0_pumpkin"
	inventory_flags = COVEREYES|COVERMOUTH
	inv_hide_flags = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEALLHAIR
	armor_protection_flags = HEAD|EYES
	w_class = WEIGHT_CLASS_NORMAL
	anti_hug = 1
