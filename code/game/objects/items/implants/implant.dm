/obj/item/implant
	name = "implant"
	icon = 'icons/obj/items/implants.dmi'
	icon_state = "implant"
	embedding = list("embedded_flags" = EMBEDDED_DEL_ON_HOLDER_DEL, "embed_process_chance" = 0, "embed_chance" = 0, "embedded_fall_chance" = 0)
	///Whether this implant has been implanted inside a human yet
	var/implanted = FALSE
	///Owner mob this implant is inserted to
	var/mob/living/implant_owner
	///The owner limb this implant is inside
	var/datum/limb/part
	///Color of the implant, used for selecting the implant cases icon_state
	var/implant_color = "b"
	///whether this implant allows reagents to be inserted into it
	var/allow_reagents = FALSE
	///What level of malfunction/breakage this implant is at, used for functionality checks
	var/malfunction = MALFUNCTION_NONE
	///Implant secific flags
	var/flags_implant = GRANT_ACTIVATION_ACTION
	///Whitelist for llimbs that this implavnt is allowed to be inserted into, all limbs by default
	var/list/allowed_limbs
	///Activation_action reference
	var/datum/action/item_action/implant/activation_action
	///Cooldown between usages of the implant
	var/cooldown_time = 1 SECONDS
	COOLDOWN_DECLARE(activation_cooldown)

/obj/item/implant/Initialize(mapload)
	. = ..()
	if(flags_implant & GRANT_ACTIVATION_ACTION)
		activation_action = new(src, src)
	if(allow_reagents)
		reagents = new /datum/reagents(MAX_IMPLANT_REAGENTS)
		reagents.my_atom = WEAKREF(src)
	if(!allowed_limbs)
		allowed_limbs = GLOB.human_body_parts

/obj/item/implant/proc/on_initialize()
	if(flags_implant & GRANT_ACTIVATION_ACTION)
		activation_action = new(src, src)
	if(allow_reagents)
		reagents = new /datum/reagents(MAX_IMPLANT_REAGENTS)
		reagents.my_atom = WEAKREF(src)

/obj/item/implant/Destroy(force)
	unimplant()
	QDEL_NULL(activation_action)
	part?.implants -= src
	return ..()

/obj/item/implant/ui_action_click(mob/user, datum/action/item_action/action)
	activate()

///Handles the actual activation of the implant/it's effects. Returns TRUE on succesful activation and FALSE on failure for parentcalls
/obj/item/implant/proc/activate()
	if(!COOLDOWN_CHECK(src, activation_cooldown))
		return FALSE
	COOLDOWN_START(src, activation_cooldown, cooldown_time)
	return TRUE

///Attempts to implant a mob with this implant, TRUE on success, FALSE on failure
/obj/item/implant/proc/try_implant(mob/living/carbon/human/target, mob/living/user)
	if(!ishuman(target))
		return FALSE
	if(!(user.zone_selected in allowed_limbs))
		to_chat(user, span_warning("You cannot implant this into that limb!"))
		return FALSE
	return implant(target, user)

/**
 * What does the implant do upon injection?
 * returns TRUE if the implant succeeds
 */

/obj/item/implant/proc/implant(mob/living/carbon/human/target, mob/living/user)
	forceMove(target)
	implant_owner = target
	implanted = TRUE
	var/limb_targeting = (user ? user.zone_selected : BODY_ZONE_CHEST)
	var/datum/limb/affected = target.get_limb(limb_targeting)
	if(!affected)
		CRASH("[src] implanted into [target] [user ? "by [user]" : ""] but had no limb, despite being set to implant in [limb_targeting].")
	affected.implants += src
	part = affected
	if(flags_implant & ACTIVATE_ON_HEAR)
		RegisterSignal(src, COMSIG_MOVABLE_HEAR, PROC_REF(on_hear))
	activation_action?.give_action(target)
	embed_into(target, limb_targeting, TRUE)
	return TRUE

/obj/item/implant/unembed_ourself()
	. = ..()
	unimplant()

/obj/item/implant/proc/unimplant()
	if(!implanted)
		return FALSE
	activation_action?.remove_action(implant_owner)
	if(flags_implant & ACTIVATE_ON_HEAR)
		UnregisterSignal(src, COMSIG_MOVABLE_HEAR)
	implanted = FALSE
	part.implants -= src
	part = null
	forceMove(get_turf(implant_owner))
	implant_owner = null

///Returns info about a implant concerning its usage and such
/obj/item/implant/proc/get_data()
	return "No information available"

///Called when the implant hears a message, used for activation phrases and the like
/obj/item/implant/proc/on_hear(datum/source, message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode)
	SIGNAL_HANDLER
	return

///Destroys and makes the implant unusable
/obj/item/implant/proc/meltdown()
	to_chat(implant_owner, span_warning("You feel something melting inside [part ? "your [part.display_name]" : "you"]!"))
	part.take_damage_limb(0, 15)

	name = "melted implant"
	desc = "Charred circuit in melted plastic case. Wonder what that used to be..."
	icon_state = "implant_melted"
	malfunction = MALFUNCTION_PERMANENT

/datum/action/item_action/implant
	desc = "Activates a currently implanted implant"

/obj/item/implanter/implantator
	name = "skill" //teeeeest.
	desc = "Used to implant occupants with skill implants."
	icon = 'icons/obj/items/implants.dmi'
	icon_state = "skill"
	var/empty_icon = "skill"
	item_state = "syringe_0"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_right.dmi',
	)
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	allowed_limbs
	var/spented = FALSE
	var/max_skills
	var/list/implants
	var/allowed_limbs

/obj/item/implanter/implantator/Initialize(mapload, ...)
	. = ..()
	name = name + " implanter"
	desc = internal_implant.desc
	if(!allowed_limbs)
		allowed_limbs = GLOB.human_body_parts

/obj/item/implanter/update_icon_state()
	return

/obj/item/implanter/implantator/proc/has_implant(datum/limb/targetlimb)
	for (var/obj/item/implant/skill/I in targetlimb.implants)
		if(!is_type_in_list(I, GLOB.known_implants))
			return TRUE
	return FALSE

/obj/item/implanter/implantator/attack(mob/living/target, mob/living/user, list/implants, datum/limb/targetlimb, var/obj/item/implant/skill/i)
	. = ..()
	if(spented == TRUE)
		return FALSE
	if(!ishuman(target))
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
	if(!do_after(user, 5 SECONDS, NONE, target, BUSY_ICON_GENERIC))
		to_chat(user, span_notice("You failed to implant [target]."))
		return FALSE
	if(internal_implant.try_implant(target, user))
		target.visible_message(span_warning("[target] has been implanted by [user]."))
		log_combat(user, target, "implanted", src)
		internal_implant = null
		name = name + "used"
		desc = desc + "It's spent."
		icon_state = empty_icon + "_s"
		spented = TRUE
		return TRUE
	to_chat(user, span_notice("You fail to implant [target]."))
	return

/obj/item/implanter/implantator/combat
	allowed_limbs = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
	internal_implant = /obj/item/implant/skill/combat

/obj/item/implanter/implantator/codex
	allowed_limbs = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)
	internal_implant = /obj/item/implant/skill/codex

/obj/item/implanter/implantator/oper_system
	allowed_limbs = list(BODY_ZONE_HEAD)
	internal_implant = /obj/item/implant/skill/oper_system

/obj/item/implant/skill
	name = "skill" //teeeeeest.
	desc = "Hey! You dont see it!"
	icon = 'icons/obj/items/implants.dmi'
	icon_state = "implant"
	w_class = WEIGHT_CLASS_TINY
	var/list/max_skills
	var/storage_skill = null
//pamplet copy-past. :clueless:
	var/cqc
	var/melee_weapons
	var/firearms
	var/pistols
	var/shotguns
	var/rifles
	var/smgs
	var/heavy_weapons
	var/swordplay
	var/smartgun
	var/engineer
	var/construction
	var/leadership
	var/medical
	var/surgery
	var/pilot
	var/police
	var/powerloader
	var/large_vehicle
	var/stamina

/obj/item/implant/skill/Initialize()
	. = ..()
	name = name + " implant"
	if(!allowed_limbs)
		allowed_limbs = GLOB.human_body_parts

/obj/item/implant/skill/on_initialize()
	return

/obj/item/implant/skill/try_implant(mob/living/carbon/human/target, mob/living/user)
	if(!ishuman(target))
		return
	if(!(user.zone_selected in allowed_limbs))
		to_chat(user, span_warning("You cannot implant this into that limb!"))
		return FALSE
	implanted = TRUE
	return implant(target, user)

/obj/item/implant/skill/implant(mob/living/carbon/human/target, mob/living/user)
	forceMove(target)
	implant_owner = target
	implanted = TRUE
	var/limb_targeting = (user ? user.zone_selected : BODY_ZONE_CHEST)
	var/datum/limb/affected = target.get_limb(limb_targeting)
	if(!affected)
		CRASH("[src] implanted into [target] [user ? "by [user]" : ""] but had no limb, despite being set to implant in [limb_targeting].")
	affected.implants += src
	part = affected
	activation_action?.give_action(target)
	embed_into(target, limb_targeting, TRUE)
	target.set_skills(target.skills.modifyRating(cqc, melee_weapons, firearms, pistols, shotguns, rifles, smgs, heavy_weapons, swordplay, smartgun,\
	engineer, construction, leadership, medical, surgery, pilot, police, powerloader, large_vehicle, stamina))
	return TRUE

/obj/item/implant/skill/unimplant()
	if(!implanted)
		return FALSE
	activation_action?.remove_action(implant_owner)
	implanted = FALSE
	part.implants -= src
	part = null
	implant_owner.set_skills(implant_owner.skills.modifyRating(-cqc, -melee_weapons, -firearms, -pistols, -shotguns, -rifles, -smgs, -heavy_weapons, -swordplay, -smartgun,\
	-engineer, -construction, -leadership, -medical, -surgery, -pilot, -police, -powerloader, -large_vehicle, -stamina))
	forceMove(get_turf(implant_owner))
	implant_owner = null

/obj/item/implant/skill/combat
	name = "combat implants"
	desc = "Non-game"
	icon_state = "combat_implant"
	allowed_limbs = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)

/obj/item/implant/skill/codex
	name = "CODEX"
	desc = "A support skill update-shit."
	icon_state = "support_implant"
	allowed_limbs = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)

/obj/item/implant/skill/oper_system
	name = "HEAD SLOT!"
	desc = "All non-sorted special shit (leadership, probaly SG and more)"
	icon_state = "skill_implant"
	allowed_limbs = list(BODY_ZONE_HEAD)
