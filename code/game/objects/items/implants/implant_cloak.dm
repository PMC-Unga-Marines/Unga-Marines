#define CLOAK_IMPLANT_ALPHA 26
#define CLOAK_IMPLANT_COOLDOWN_TIME 50 SECONDS

/obj/item/implant/cloak
	name = "cloak implant"
	desc = "A top of the line nanotrasen implant, designed for infiltration."
	icon_state = "gripper"
	cooldown_time = 0
	var/deactivation_timer

/obj/item/implant/cloak/get_data()
	return {"
	<b>Implant Specifications:</b><BR>
	<b>Name:</b> Nanotrasen CD-64 CloakMate Implant<BR>
	<HR>
	<b>Implant Details:</b><BR>
	<b>Function:</b> Upon activation, this implant decreases the reflection rate of light in order to reduce user visibility.<BR>
	<b>Current Implant status:</b>
	Recharge time remaining: [S_TIMER_COOLDOWN_TIMELEFT(src, COOLDOWN_CLOAK_IMPLANT) * 0.1] seconds
	Active time remaining: [deactivation_timer ? "[timeleft(deactivation_timer) * 0.1] seconds" :"Implant Inactive"]."}


/obj/item/implant/cloak/activate(accidental = FALSE)
	. = ..()
	if(!.)
		return
	if(malfunction == MALFUNCTION_PERMANENT)
		return FALSE
	if(deactivation_timer)
		deactivate_cloak()
		return TRUE
	if(accidental)
		return FALSE
	if(implant_owner.do_actions)
		return FALSE
	if(HAS_TRAIT(implant_owner, TRAIT_STEALTH))
		to_chat(implant_owner, span_warning("WARNING. Implant activation failed; Error code 518: Subject already cloaked."))
		return FALSE
	INVOKE_ASYNC(src, PROC_REF(stealth_user))

///stealths the implant user
/obj/item/implant/cloak/proc/stealth_user()
	apply_wibbly_filters(implant_owner)
	playsound(implant_owner, 'sound/effects/seedling_chargeup.ogg', 100, TRUE)
	if(!do_after(implant_owner, 3 SECONDS, IGNORE_HELD_ITEM, implant_owner))
		to_chat(implant_owner, span_warning("WARNING. Implant activation failed; Error code 423: Subject cancelled activation."))
		remove_wibbly_filters(implant_owner)
		return
	remove_wibbly_filters(implant_owner)
	playsound(implant_owner, 'sound/effects/pred_cloakon.ogg', 60, TRUE)
	implant_owner.alpha = CLOAK_IMPLANT_ALPHA
	ADD_TRAIT(implant_owner, TRAIT_STEALTH, TRAIT_STEALTH)
	deactivation_timer = addtimer(CALLBACK(src, PROC_REF(deactivate_cloak)), 12 SECONDS, TIMER_STOPPABLE)

///Deactivates the implant when someone turns it off or its forced off
/obj/item/implant/cloak/proc/deactivate_cloak(datum/source)
	SIGNAL_HANDLER
	if(deactivation_timer)
		deltimer(deactivation_timer)
		deactivation_timer = null
	playsound(implant_owner, 'sound/effects/pred_cloakoff.ogg', 60, TRUE)
	to_chat(implant_owner, span_warning("[src] deactivates!"))
	implant_owner.alpha = initial(implant_owner.alpha)
	REMOVE_TRAIT(implant_owner, TRAIT_STEALTH, TRAIT_STEALTH)
	S_TIMER_COOLDOWN_START(src, COOLDOWN_CLOAK_IMPLANT, CLOAK_IMPLANT_COOLDOWN_TIME)
