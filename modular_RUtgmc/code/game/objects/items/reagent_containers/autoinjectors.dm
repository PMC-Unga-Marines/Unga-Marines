/obj/item/reagent_containers/hypospray/autoinjector/yautja
	name = "unusual crystal"
	desc = "A strange glowing crystal with a spike at one end."
	icon = 'modular_RUtgmc/icons/obj/hunter/pred_gear.dmi'
	icon_state = "crystal"
	item_state = ""
	amount_per_transfer_from_this = REAGENTS_OVERDOSE
	volume = REAGENTS_OVERDOSE

	list_reagents = list(/datum/reagent/thwei = REAGENTS_OVERDOSE)

/obj/item/reagent_containers/hypospray/autoinjector/yautja/attack(mob/M, mob/user)
	if(HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		..()
	else
		to_chat(user, span_danger("You have no idea where to inject [src]."))

/obj/item/reagent_containers/hypospray/autoinjector/yautja/interact(mob/user)
	return

/obj/item/reagent_containers/hypospray/autoinjector/synaptizine
	volume = 18
	list_reagents = list(
		/datum/reagent/medicine/synaptizine = 6,
		/datum/reagent/medicine/hyronalin = 12,
	)
