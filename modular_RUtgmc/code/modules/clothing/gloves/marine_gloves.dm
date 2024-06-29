/obj/item/clothing/gloves/marine/separatist
	name = "kevlar gloves TG-94"
	desc = "Once before, the original of these gloves had protected the hands of the civilian militia of the colony of Terra during the heroic liberation of their territories from the hands of the enemy. 'Wear it with honor,' reads the inscription at the bottom"
	icon_state = "separatist"
	item_state = "separatist"

/obj/item/clothing/gloves/marine/veteran/marine
	name = "veteran gloves"
	desc = "Ordinary Marine gloves, artfully reinforced for personal gain. An extra steel plate and a pair of cool white laces will definitely make this item look better. You're sure. The Marine Widows Association is outraged."
	icon_state = "veteran_1"
	item_state = "veteran"
	var/gloves_inside_out = FALSE

/obj/item/clothing/gloves/marine/veteran/marine/examine(mob/user)
	. = ..()
	. += span_info("You could <b>use it in-hand</b> to turn it inside out and change it's appearance.")

/obj/item/clothing/gloves/marine/veteran/marine/attack_self(mob/user)
	. = ..()
	if(!gloves_inside_out)
		to_chat(user, span_notice("You turn the gloves inside out and change their appearance."))
		gloves_inside_out = TRUE
	else
		to_chat(user, span_notice("You roll the gloves back inside and they look just right."))
		gloves_inside_out = initial(gloves_inside_out)
	update_icon_state()

/obj/item/clothing/gloves/marine/veteran/marine/update_icon_state()
	if(gloves_inside_out)
		icon_state = "veteran_2"
	else
		icon_state = "veteran_1"
