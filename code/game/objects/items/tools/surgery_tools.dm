// Surgery Tools
/obj/item/tool/surgery
	icon = 'icons/obj/items/surgery_tools.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/surgery_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/surgery_right.dmi',
	)
	attack_speed = 11 //Used to be 4 which made them attack insanely fast.

/obj/item/tool/surgery/retractor
	name = "retractor"
	desc = "Retracts stuff."
	icon_state = "retractor"
	atom_flags = CONDUCT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/tool/surgery/hemostat
	name = "hemostat"
	desc = "You think you have seen this before."
	icon_state = "hemostat"
	atom_flags = CONDUCT
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("attacks", "pinches")

/obj/item/tool/surgery/cautery
	name = "cautery"
	desc = "This stops bleeding."
	icon_state = "cautery"
	atom_flags = CONDUCT
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("burns")

/obj/item/tool/surgery/surgicaldrill
	name = "surgical drill"
	desc = "You can drill using this item. You dig?"
	icon_state = "drill"
	hitsound = 'sound/weapons/circsawhit.ogg'
	atom_flags = CONDUCT
	force = 15
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("drills")

/obj/item/tool/surgery/scalpel
	name = "scalpel"
	desc = "Cut, cut, and once more cut."
	icon_state = "scalpel"
	atom_flags = CONDUCT
	force = 20
	sharp = IS_SHARP_ITEM_ACCURATE
	edge = 1
	w_class = WEIGHT_CLASS_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	attack_verb = list("attacks", "slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")

/*
* Researchable Scalpels
*/
/obj/item/tool/surgery/scalpel/laser3
	name = "laser scalpel"
	desc = "A scalpel augmented with a directed laser, for more precise cutting without blood entering the field.  This one looks to be the pinnacle of precision energy cutlery!"
	icon_state = "scalpel_laser3_on"
	damtype = BURN
	force = 15

/obj/item/tool/surgery/scalpel/manager
	name = "incision management system"
	desc = "A true extension of the surgeon's body, this marvel instantly and completely prepares an incision allowing for the immediate commencement of therapeutic steps."
	icon_state = "scalpel_manager_on"
	force = 7.5

/*
* Circular Saw
*/
/obj/item/tool/surgery/circular_saw
	name = "circular saw"
	desc = "For heavy duty cutting."
	icon_state = "saw"
	hitsound = 'sound/weapons/circsawhit.ogg'
	atom_flags = CONDUCT
	force = 30
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 9
	throw_speed = 3
	throw_range = 5
	attack_verb = list("attacks", "slashes", "saws", "cuts")
	sharp = IS_SHARP_ITEM_BIG
	edge = 1

//misc, formerly from code/defines/weapons.dm
/obj/item/tool/surgery/bonegel
	name = "bone gel"
	icon_state = "bone-gel"
	force = 0
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 1

/obj/item/tool/surgery/FixOVein
	name = "FixOVein"
	icon_state = "fixovein"
	force = 0
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	var/usage_amount = 10

/obj/item/tool/surgery/bonesetter
	name = "bone setter"
	icon_state = "bonesetter"
	force = 8
	throwforce = 9
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("attacks", "hits", "bludgeons")

/obj/item/tool/surgery/suture
	name = "surgical suture"
	icon_state = "suture"
	force = 3
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("needles", "sews", "stabs")

/obj/item/tool/surgery/surgical_membrane
	name = "surgical membrane"
	icon_state = "surgical_membrane"
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL

//pred shit

/obj/item/tool/surgery/retractor/predatorretractor
	name = "opener"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_retractor"

/obj/item/tool/surgery/hemostat/predatorhemostat
	name = "pincher"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_hemostat"

/obj/item/tool/surgery/cautery/predatorcautery
	name = "cauterizer"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_cautery"
	item_flags = ITEM_PREDATOR

/obj/item/tool/surgery/surgicaldrill/predatorsurgicaldrill
	name = "bone drill"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_drill"

/obj/item/tool/surgery/scalpel/predatorscalpel
	name = "cutter"
	icon_state = "predator_scalpel"
	force = 20

/obj/item/tool/surgery/circular_saw/predatorbonesaw
	name = "bone saw"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_bonesaw"
	item_flags = ITEM_PREDATOR
	force = 20

/obj/item/tool/surgery/bonegel/predatorbonegel
	name = "gel gun"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_bone-gel"

/obj/item/tool/surgery/FixOVein/predatorFixOVein
	name = "vein fixer"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_fixovein"

/obj/item/tool/surgery/bonesetter/predatorbonesetter
	name = "bone placer"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_bonesetter"

/*
 * MEDICOMP TOOLS
 */

/obj/item/tool/surgery/stabilizer_gel
	name = "stabilizer gel vial"
	desc = "Used for stabilizing wounds for treatment."
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "stabilizer_gel"
	force = 0
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	item_flags = ITEM_PREDATOR

/obj/item/tool/surgery/healing_gun
	name = "healing gun"
	desc = "Used for mending stabilized wounds."
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "healing_gun"
	force = 0
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	item_flags = ITEM_PREDATOR
	var/loaded  = TRUE

/obj/item/tool/surgery/healing_gun/update_icon()
	. = ..()
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
		playsound(loc, 'sound/items/air_release.ogg',25)
		loaded = TRUE
		update_icon()
		qdel(O)
		return
	return ..()

/obj/item/tool/surgery/healing_gel
	name = "healing gel capsule"
	desc = "Used for reloading the healing gun."
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "healing_gel"
	force = 0
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	item_flags = ITEM_PREDATOR

/obj/item/tool/surgery/wound_clamp
	name = "wound clamp"
	desc = "Used for clamping wounds after treatment."
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "wound_clamp"
	force = 0
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	item_flags = ITEM_PREDATOR
