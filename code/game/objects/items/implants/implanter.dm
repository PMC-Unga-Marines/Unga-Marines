/obj/item/implanter
	name = "implanter"
	icon = 'icons/obj/items/implants.dmi'
	icon_state = "implanter0"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_right.dmi',
	)
	item_state = "syringe_0"
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	var/obj/item/implant/internal_implant = null

/obj/item/implanter/Initialize(mapload, ...)
	. = ..()
	if(internal_implant)
		internal_implant = new internal_implant(src)
		update_icon()

/obj/item/implanter/Destroy()
	QDEL_NULL(internal_implant)
	return ..()

/obj/item/implanter/update_icon_state()
	. = ..()
	icon_state = "implanter[internal_implant?"1":"0"]"

/obj/item/implanter/examine(mob/user, distance, infix, suffix)
	. = ..()
	. += "it contains [internal_implant ? "a [internal_implant.name]" : "no implant"]!"

/obj/item/implanter/attack(mob/target, mob/user)
	. = ..()
	if(!ishuman(target))
		return FALSE
	if(!internal_implant)
		to_chat(user, span_warning("There is no implant in the [src]!"))
		return FALSE
	user.visible_message(span_warning("[user] is attemping to implant [target]."), span_notice("You're attemping to implant [target]."))

	if(!do_after(user, 5 SECONDS, NONE, target, BUSY_ICON_GENERIC) || !internal_implant)
		to_chat(user, span_notice("You failed to implant [target]."))
		return

	if(internal_implant.try_implant(target, user))
		target.visible_message(span_warning("[target] has been implanted by [user]."))
		log_combat(user, target, "implanted", src)
		internal_implant = null
		update_icon()
		return TRUE
	to_chat(user, span_notice("You fail to implant [target]."))

/obj/item/implanter/neurostim
	name = "neurostim implanter"
	internal_implant = /obj/item/implant/neurostim

/obj/item/implanter/chem
	name = "chem implant implanter"
	internal_implant = /obj/item/implant/chem

/obj/item/implanter/chem/blood
	name = "blood recovery implant implanter"
	internal_implant = /obj/item/implant/chem/blood

/obj/item/implanter/cloak
	name = "cloak implant implanter"
	internal_implant = /obj/item/implant/cloak

/obj/item/implanter/blade
	name = "blade implant implanter"
	internal_implant = /obj/item/implant/deployitem/blade

/obj/item/implanter/suicide_dust
	name = "Self-Gibbing implant"
	internal_implant = /obj/item/implant/suicide_dust

/obj/item/implanter/cargo
	name = "implanter"
	icon_state = "cargo"
	var/spent = FALSE
	var/allowed_limbs
	var/list/implants

/obj/item/implanter/cargo/Initialize(mapload, ...)
	. = ..()
	update_icon_state()
	if(internal_implant)
		update_icon_state()
		desc = internal_implant.desc
		internal_implant = new internal_implant(src)
	if(!allowed_limbs)
		allowed_limbs = GLOB.human_body_parts

/obj/item/implanter/cargo/update_icon_state()
	. = ..()
	icon_state = "cargo"
	if(internal_implant)
		icon_state = "cargo_full"
	if(!internal_implant)
		icon_state = "cargo_s"

/obj/item/implanter/cargo/proc/has_implant(datum/limb/targetlimb)
	for (var/obj/item/implant/skill/I in targetlimb.implants)
		if(!is_type_in_list(I, GLOB.known_implants))
			return TRUE
	return FALSE

/obj/item/implanter/cargo/attack(mob/living/target, mob/living/user, list/implants, datum/limb/targetlimb, var/obj/item/implant/skill/i)
	. = ..()
	if(!ishuman(target))
		return FALSE
	if(spent == TRUE)
		balloon_alert(user, "already used!")
		return FALSE
	if(!internal_implant)
		to_chat(user, span_warning("There is no implant in the [src]!"))
		return FALSE
	if(!(user.zone_selected in allowed_limbs))
		balloon_alert(user, "wrong limb!")
		return FALSE
	for(i in user.zone_selected)
		has_implant(targetlimb)
		balloon_alert(user, "limb already implanted!")
		return FALSE
	user.visible_message(span_warning("[user] is attemping to implant [target]."), span_notice("You're attemping to implant [target]."))
	if(!do_after(user, 5 SECONDS, NONE, target, BUSY_ICON_GENERIC) || !internal_implant)
		to_chat(user, span_notice("You failed to implant [target]."))
		return FALSE
	if(internal_implant.try_implant(target, user))
		target.visible_message(span_warning("[target] has been implanted by [user]."))
		log_combat(user, target, "implanted", src)
		internal_implant = null
		spent = TRUE
		update_icon_state()
		return TRUE
	to_chat(user, span_notice("You fail to implant [target]."))
