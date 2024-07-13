/obj/item/tool/surgery/retractor/predatorretractor
	name = "opener"
	icon = 'modular_RUtgmc/icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_retractor"

/obj/item/tool/surgery/hemostat/predatorhemostat
	name = "pincher"
	icon = 'modular_RUtgmc/icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_hemostat"

/obj/item/tool/surgery/cautery/predatorcautery
	name = "cauterizer"
	icon = 'modular_RUtgmc/icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_cautery"
	flags_item = ITEM_PREDATOR

/obj/item/tool/surgery/surgicaldrill/predatorsurgicaldrill
	name = "bone drill"
	icon = 'modular_RUtgmc/icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_drill"

/obj/item/tool/surgery/scalpel/predatorscalpel
	name = "cutter"
	icon_state = "predator_scalpel"
	force = 20

/obj/item/tool/surgery/circular_saw/predatorbonesaw
	name = "bone saw"
	icon = 'modular_RUtgmc/icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_bonesaw"
	flags_item = ITEM_PREDATOR
	force = 20

/obj/item/tool/surgery/bonegel/predatorbonegel
	name = "gel gun"
	icon = 'modular_RUtgmc/icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_bone-gel"

/obj/item/tool/surgery/FixOVein/predatorFixOVein
	name = "vein fixer"
	icon = 'modular_RUtgmc/icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_fixovein"

/obj/item/tool/surgery/bonesetter/predatorbonesetter
	name = "bone placer"
	icon = 'modular_RUtgmc/icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_bonesetter"

/*
 * MEDICOMP TOOLS
 */

/obj/item/tool/surgery/stabilizer_gel
	name = "stabilizer gel vial"
	desc = "Used for stabilizing wounds for treatment."
	icon = 'modular_RUtgmc/icons/obj/items/surgery_tools.dmi'
	icon_state = "stabilizer_gel"
	force = 0
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	flags_item = ITEM_PREDATOR

/obj/item/tool/surgery/healing_gun
	name = "healing gun"
	desc = "Used for mending stabilized wounds."
	icon = 'modular_RUtgmc/icons/obj/items/surgery_tools.dmi'
	icon_state = "healing_gun"
	force = 0
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	flags_item = ITEM_PREDATOR
	var/loaded  = TRUE

/obj/item/tool/surgery/healing_gun/update_icon()
	if(loaded)
		icon_state = "healing_gun"
	else
		icon_state = "healing_gun_empty"

/obj/item/tool/surgery/healing_gun/attackby(obj/item/O, mob/user)
	if(!HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		to_chat(user, span_warning("You have no idea how to put \the [O] into \the [src]!"))
		return
	if(istype(O, /obj/item/tool/surgery/healing_gel))
		if(loaded)
			to_chat(user, span_warning("There's already a capsule inside the healing gun!"))
			return
		user.visible_message(span_warning("[user] loads \the [src] with \a [O]."), span_warning("You load \the [src] with \a [O]."))
		playsound(loc, 'modular_RUtgmc/sound/items/air_release.ogg',25)
		loaded = TRUE
		update_icon()
		qdel(O)
		return
	return ..()

/obj/item/tool/surgery/healing_gel
	name = "healing gel capsule"
	desc = "Used for reloading the healing gun."
	icon = 'modular_RUtgmc/icons/obj/items/surgery_tools.dmi'
	icon_state = "healing_gel"
	force = 0
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	flags_item = ITEM_PREDATOR

/obj/item/tool/surgery/wound_clamp
	name = "wound clamp"
	desc = "Used for clamping wounds after treatment."
	icon = 'modular_RUtgmc/icons/obj/items/surgery_tools.dmi'
	icon_state = "wound_clamp"
	force = 0
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	flags_item = ITEM_PREDATOR
