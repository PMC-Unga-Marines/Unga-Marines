/obj/item/clothing/gloves/valigloves
	name = "Y-15 Vali chemical enhancement gloves"
	desc = "The advanced technology of the Vali module built into the gloves, unfortunately, due to the reduction in space, the gloves are unable to provide the second level of treatment. Gloves cannot be equipped with the Vali module in armor.."
	icon = 'icons/obj/clothing/gloves.dmi'
	icon_state = "vali_gloves_unactive"
	worn_icon_state = "vali_gloves"
	item_flags = SYNTH_RESTRICTED
	soft_armor = list(MELEE = 35, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 25, BIO = 15, FIRE = 15, ACID = 20)
	resistance_flags = UNACIDABLE
	cold_protection_flags = HANDS
	heat_protection_flags = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
	var/chemsystem_is_active = FALSE
	var/datum/component/chem_booster/chemsystem

/obj/item/clothing/gloves/valigloves/Initialize(mapload)
	. = ..()
	chemsystem = AddComponent(/datum/component/chem_booster/gloves)
	RegisterSignal(chemsystem, COMSIG_CHEMSYSTEM_TOGGLED, PROC_REF(update_module_icon))

/obj/item/clothing/gloves/valigloves/Destroy()
	UnregisterSignal(chemsystem, COMSIG_CHEMSYSTEM_TOGGLED)
	chemsystem = null
	return ..()

/obj/item/clothing/gloves/valigloves/proc/update_module_icon(datum/source, toggle)
	SIGNAL_HANDLER
	chemsystem_is_active = toggle
	update_icon()

/obj/item/clothing/gloves/valigloves/update_icon_state()
	. = ..()
	if(chemsystem_is_active)
		icon_state = "vali_gloves_active"
		return
	icon_state = initial(icon_state)

/obj/item/clothing/gloves/valigloves/mob_can_equip(mob/living/carbon/human/user, slot, warning = FALSE, override_nodrop = FALSE, bitslot = FALSE)
	if(slot == SLOT_GLOVES)
		var/obj/item/clothing/suit/armor = user.wear_suit

		if(armor && istype(armor, /obj/item/clothing/suit/modular))
			var/obj/item/clothing/suit/modular/modular_armor = armor

			if(ATTACHMENT_SLOT_MODULE in modular_armor.attachments_by_slot)
				var/obj/item/armor_module/module/chemsystem/vali_module = modular_armor.attachments_by_slot[ATTACHMENT_SLOT_MODULE]
				if(istype(vali_module, /obj/item/armor_module/module/chemsystem))
					user.balloon_alert(user, "<span class='warning'>Вы не можете надеть эти перчатки, пока на вас надета броня с модулем Вали.</span>")
					return FALSE
	return ..()

/obj/item/clothing/suit/modular/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot != SLOT_WEAR_SUIT)
		return

	if(!(ATTACHMENT_SLOT_MODULE in attachments_by_slot))
		return

	var/obj/item/armor_module/module/chemsystem/vali_module = attachments_by_slot[ATTACHMENT_SLOT_MODULE]
	if(!istype(vali_module, /obj/item/armor_module/module/chemsystem))
		return

	var/obj/item/clothing/gloves/valigloves/vali_gloves = user.gloves
	if(istype(vali_gloves, /obj/item/clothing/gloves/valigloves))
		user.dropItemToGround(vali_gloves)
		user.balloon_alert(user, "<span class='warning'>Вали перчатки сброшены из-за конфликта с модулем брони!</span>")

/obj/item/clothing/gloves/valigloves/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot != SLOT_GLOVES)
		return

	if(usr != user)
		if(istype(vali_gloves, /obj/item/clothing/gloves/valigloves))
			user.dropItemToGround(vali_gloves)
			user.balloon_alert(user, "<span class='warning'>Другой человек не может надеть на вас перчатки!</span>")
