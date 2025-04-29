/obj/item/organ
	name = "organ"
	desc = "It looks like it probably just plopped out."
	icon = 'icons/obj/items/organs.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/bodyparts_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/bodyparts_right.dmi',
	)

/obj/item/organ/heart
	name = "heart"
	icon_state = "heart-on"

/obj/item/organ/heart/examine(mob/user)
	. = ..()
	if(iszombiecrashgamemode(SSticker.mode))
		. += span_notice("It looks like it could be sold to requisitions for supply points.")

/obj/item/organ/heart/get_export_value()
	if(iszombiecrashgamemode(SSticker.mode))
		return 50
	return 0

/obj/item/organ/lungs
	name = "lungs"
	icon_state = "lungs"
	gender = PLURAL

/obj/item/organ/kidneys
	name = "kidneys"
	icon_state = "kidneys"
	gender = PLURAL

/obj/item/organ/liver
	name = "liver"
	icon_state = "liver"

/obj/item/organ/appendix
	name = "appendix"
	icon_state = "appendix"

/obj/item/organ/stomach
	name = "stomach"
	icon_state = "stomach"

/obj/item/organ/eyes
	name = "eyeballs"
	icon_state = "eyes"
	gender = PLURAL

/obj/item/organ/brain
	name = "brain"
	icon_state = "brain2"
