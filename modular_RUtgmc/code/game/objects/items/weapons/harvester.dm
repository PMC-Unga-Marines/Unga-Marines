//All the harvester weapons go in here

//Vali Sword
/obj/item/weapon/claymore/harvester
	icon = 'modular_RUtgmc/icons/obj/items/vali.dmi'
	item_icons = list(
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/inhands/weapons/vali_left.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/inhands/weapons/vali_right.dmi',
	)

//Vali rapier
/obj/item/weapon/claymore/mercsword/officersword/valirapier
	name = "\improper HP-C Harvester rapier"
	desc = "Extremely expensive looking blade, with a golden handle and engravings, unexpectedly effective in combat, despite its ceremonial looks, compacted with a vali module."
	icon = 'modular_RUtgmc/icons/obj/items/vali.dmi'
	item_icons = list(
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/inhands/weapons/vali_left.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/inhands/weapons/vali_right.dmi',
	)
	icon_state = "rapier"
	item_state = "rapier"
	force = 60
	attack_speed = 5

/obj/item/weapon/claymore/mercsword/officersword/valirapier/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/harvester)
	RemoveElement(/datum/element/strappable)


//Vali Spear
/obj/item/weapon/twohanded/spear/tactical/harvester
	name = "\improper HP-S Harvester spear"
	desc = "TerraGov Marine Corps' experimental High Point-Singularity 'Harvester' spear. An advanced weapon that trades sheer force for the ability to apply a variety of debilitating effects when loaded with certain reagents. Activate after loading to prime a single use of an effect. It also harvests substances from alien lifeforms it strikes when connected to the Vali system."
	icon = 'modular_RUtgmc/icons/obj/items/vali.dmi'
	icon_state = "vali_spear"
	item_icons = list(
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/inhands/weapons/vali_left.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/inhands/weapons/vali_right.dmi',
	)
	item_state = "vali_spear"
	force = 32
	force_wielded = 60
	throwforce = 60

/obj/item/weapon/twohanded/spear/tactical/harvester/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/harvester)


///////////////////////////////////////////////////////////////////////
////////////////// VAL-HAL-A, the Vali Halberd ////////////////////////
///////////////////////////////////////////////////////////////////////
/obj/item/weapon/twohanded/glaive/halberd/harvester
	name = "\improper VAL-HAL-A halberd harvester"
	desc = "TerraGov Marine Corps' cutting-edge 'Harvester' halberd, with experimental plasma regulator. An advanced weapon that combines sheer force with the ability to apply a variety of debilitating effects when loaded with certain reagents, but should be used with both hands. Activate after loading to prime a single use of an effect. It also harvests substances from alien lifeforms it strikes when connected to the Vali system."
	icon = 'modular_RUtgmc/icons/obj/items/vali.dmi'
	icon_state = "VAL-HAL-A"
	item_state = "VAL-HAL-A"
	item_icons = list(
		slot_back_str = 'modular_RUtgmc/icons/mob/clothing/back.dmi',
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/inhands/weapons/vali_left.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/inhands/weapons/vali_right.dmi',
	)
	force = 40
	force_wielded = 95 //Reminder: putting trama inside deals 60% additional damage
	flags_item = TWOHANDED
	resistance_flags = 0 //override glavie
	attack_speed = 10 //Default is 7, this has slower attack
	reach = 2 //like spear
	slowdown = 0 //Slowdown in back slot
	var/wielded_slowdown = 0.5 //Slowdown in hands, wielded
	var/wield_delay = 0.8 SECONDS

/obj/item/weapon/twohanded/glaive/halberd/harvester/Initialize()
	. = ..()
	AddComponent(/datum/component/harvester)

// Stuff which should ideally be in /twohanded code
/obj/item/weapon/twohanded/glaive/halberd/harvester/unwield(mob/user)
	. = ..()
	user.remove_movespeed_modifier(MOVESPEED_ID_WIELDED_SLOWDOWN)


/obj/item/weapon/twohanded/glaive/halberd/harvester/wield(mob/user)
	. = ..()

	if (!(flags_item & WIELDED))
		return

	if(wield_delay > 0)
		if (!do_after(user, wield_delay, IGNORE_LOC_CHANGE, user, BUSY_ICON_HOSTILE, null, PROGRESS_CLOCK))
			unwield(user)
			return

	user.add_movespeed_modifier(MOVESPEED_ID_WIELDED_SLOWDOWN, TRUE, 0, NONE, TRUE, wielded_slowdown)
