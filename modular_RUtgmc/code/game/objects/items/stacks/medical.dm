/obj/item/stack/medical
	var/alien = FALSE

#define BANDAGE (1<<0)
#define SALVE (1<<1)
#define DISINFECT (1<<2)

/obj/item/stack/medical/heal_pack/advanced/bruise_pack/predator
	name = "mending herbs"
	singular_name = "mending herb"
	desc = "A poultice made of soft leaves that is rubbed on bruises."
	icon = 'modular_RUtgmc/icons/obj/hunter/pred_gear.dmi'
	icon_state = "brute_herbs"
	heal_brute = 15
	alien = TRUE

/obj/item/stack/medical/heal_pack/ointment/predator
	name = "soothing herbs"
	singular_name = "soothing herb"
	desc = "A poultice made of cold, blue petals that is rubbed on burns."
	icon = 'modular_RUtgmc/icons/obj/hunter/pred_gear.dmi'
	icon_state = "burn_herbs"
	heal_burn = 15
	alien = TRUE

/// return TRUE if a given limb can be healed by src, FALSE otherwise
/obj/item/stack/medical/heal_pack/can_heal_limb(datum/limb/affecting)
	if(zero_amount())
		return FALSE
	if(!affecting)
		return FALSE
	if(affecting.limb_status & LIMB_DESTROYED)
		return FALSE
	if(!can_affect_limb(affecting))
		return FALSE
	if(heal_flags & BANDAGE && !affecting.is_bandaged())
		return TRUE
	if(heal_flags & SALVE && !affecting.is_salved())
		return TRUE
	if(heal_flags & DISINFECT && !affecting.is_disinfected())
		return TRUE
	return FALSE

/obj/item/stack/medical/heal_pack/advanced/bruise_combat_pack
	name = "combat trauma kit"
	singular_name = "combat trauma kit"
	desc = "An expensive huge kit for prolonged combat conditions. Has more space and better medicine compared to a regular one."
	icon = 'modular_RUtgmc/icons/obj/stack_objects.dmi'
	item_icons = list(
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/inhands/equipment/medical_left.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/inhands/equipment/medical_right.dmi',
	)
	icon_state = "brute_advanced"
	item_state = "brute_advanced"
	amount = 140
	max_amount = 140
	w_class = WEIGHT_CLASS_NORMAL
	heal_brute = 15
	number_of_extra_variants = 6
	heal_flags = BANDAGE|DISINFECT

/obj/item/stack/medical/heal_pack/advanced/bruise_combat_pack/generate_treatment_messages(mob/user, mob/patient, datum/limb/target_limb, success)
	if(!success)
		to_chat(user, span_warning("The wounds on [patient]'s [target_limb.display_name] have already been treated."))
		return
	user.visible_message(span_notice("[user] cleans [patient]'s [target_limb.display_name] and seals its wounds with bioglue."),
		span_notice("You clean and seal all the wounds on [patient]'s [target_limb.display_name]."))

/obj/item/stack/medical/heal_pack/advanced/burn_combat_pack
	name = "combat burn kit"
	singular_name = "combat burn kit"
	desc = "An expensive huge kit for prolonged combat conditions. Has more space and better medicine compared to a regular one."
	icon = 'modular_RUtgmc/icons/obj/stack_objects.dmi'
	item_icons = list(
		slot_l_hand_str = 'modular_RUtgmc/icons/mob/inhands/equipment/medical_left.dmi',
		slot_r_hand_str = 'modular_RUtgmc/icons/mob/inhands/equipment/medical_right.dmi',
	)
	icon_state = "burn_advanced"
	item_state = "burn_advanced"
	w_class = WEIGHT_CLASS_NORMAL
	amount = 140
	max_amount = 140
	heal_burn = 15
	number_of_extra_variants = 6
	heal_flags = SALVE|DISINFECT

/obj/item/stack/medical/heal_pack/advanced/burn_combat_pack/generate_treatment_messages(mob/user, mob/patient, datum/limb/target_limb, success)
	if(!success)
		to_chat(user, span_warning("The wounds on [patient]'s [target_limb.display_name] have already been treated."))
		return
	user.visible_message(span_notice("[user] covers the wounds on [patient]'s [target_limb.display_name] with regenerative membrane."),
	span_notice("You cover the wounds on [patient]'s [target_limb.display_name] with regenerative membrane."))

/obj/item/stack/medical/heal_pack/advanced/bruise_pack/predator
	name = "mending herbs"
	singular_name = "mending herb"
	desc = "A poultice made of soft leaves that is rubbed on bruises."
	icon = 'modular_RUtgmc/icons/obj/hunter/pred_gear.dmi'
	icon_state = "brute_herbs"
	heal_brute = 15
	alien = TRUE

/obj/item/stack/medical/heal_pack/ointment/predator
	name = "soothing herbs"
	singular_name = "soothing herb"
	desc = "A poultice made of cold, blue petals that is rubbed on burns."
	icon = 'modular_RUtgmc/icons/obj/hunter/pred_gear.dmi'
	icon_state = "burn_herbs"
	heal_burn = 15
	alien = TRUE

#undef BANDAGE
#undef SALVE
#undef DISINFECT
