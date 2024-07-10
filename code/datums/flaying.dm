#define FLAY_STAGE_SCALP 1
#define FLAY_STAGE_STRIP 2
#define FLAY_STAGE_SKIN 3

///Records status of flaying attempts and handles progress.
/datum/flaying_datum
	var/mob/living/carbon/human/victim
	var/current_flayer
	var/flaying_stage = FLAY_STAGE_SCALP

/datum/flaying_datum/New(mob/living/carbon/human/target)
	. = ..()
	victim = target
	RegisterSignal(victim, COMSIG_HUMAN_FLAY_ATTEMPT, PROC_REF(begin_flaying))

///Loops until interrupted or done.
/datum/flaying_datum/proc/begin_flaying(mob/living/carbon/human/target, mob/living/carbon/human/user, obj/item/tool, ongoing_attempt)
	SIGNAL_HANDLER
	if(current_flayer)
		if(current_flayer != user)
			to_chat(user, span_warning("You can't flay [target], [current_flayer] is already at work!"))
	else
		current_flayer = user
		if(!ongoing_attempt)
			playsound(user.loc, 'sound/weapons/pierce.ogg', 25)
			user.visible_message(span_danger("<B>[user] resumes the flaying of [victim] with \a [tool]...</B>"),
				span_danger("<B>You resume the flaying of [victim] with your [tool.name]...</B>"))
		INVOKE_ASYNC(src, PROC_REF(flay), target, user, tool) //do_after sleeps.
	return COMPONENT_ITEM_NO_ATTACK

/datum/flaying_datum/proc/flay(mob/living/carbon/human/target, mob/living/carbon/human/user, obj/item/tool)
	if(!do_after(user, 4 SECONDS, NONE, victim, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE))
		to_chat(user, span_warning("You were interrupted before you could finish your work!"))
		current_flayer = null
		return

	switch(flaying_stage)
		if(FLAY_STAGE_SCALP)
			playsound(user.loc, 'sound/weapons/slashmiss.ogg', 25)
			flaying_stage = FLAY_STAGE_STRIP
			var/datum/limb/head/v_head = victim.get_limb("head")
			if(!v_head || (v_head.limb_status & LIMB_DESTROYED)) //they might be beheaded
				victim.apply_damage(10, BRUTE, "chest", sharp = TRUE)
				user.visible_message(span_danger("<B>[user] peels the skin around the stump of [victim]'s head loose with \the [tool].</B>"),
					span_danger("<B>[victim] is missing \his head. Pelts like this just aren't the same... You peel the skin around the stump loose with your [tool.name].</B>"))
			else
				victim.apply_damage(10, BRUTE, v_head, sharp = TRUE)
				v_head.disfigured = TRUE
				create_leftovers(victim, has_meat = FALSE, skin_amount = 1)
				if(victim.h_style == "Bald") //you can't scalp someone with no hair.
					user.visible_message(span_danger("<B>[user] makes some rough cuts on [victim]'s head and face with \a [tool].</B>"),
						span_danger("<B>You make some rough cuts on [victim]'s head and face.</B>"))
				else
					user.visible_message(span_danger("<B>[user] cuts around [victim]'s hairline, then tears \his scalp from \his head!</B>"),
						span_danger("<B>You cut around [victim]'s hairline, then rip \his scalp from \his head.</B>"))
					var/obj/item/scalp/cut_scalp = new(get_turf(user), victim, user) //Create a scalp of the victim at the user's feet.
					user.put_in_inactive_hand(cut_scalp) //Put it in the user's offhand if possible.
					victim.h_style = "Bald"
					victim.update_hair() //tear the hair off with the scalp

		if(FLAY_STAGE_STRIP)
			user.visible_message(span_danger("<B>[user] jabs \his [tool.name] into [victim]'s cuts, prying, cutting, then tearing off large areas of skin. The remainder hangs loosely.</B>"),
				span_danger("<B>You jab your [tool.name] into [victim]'s cuts, prying, cutting, then tearing off large areas of skin. The remainder hangs loosely.</B>"))
			playsound(user.loc, 'sound/weapons/bladeslice.ogg', 25)
			create_leftovers(victim, has_meat = FALSE, skin_amount = 3)
			flaying_stage = FLAY_STAGE_SKIN
			for(var/limb in victim.limbs)
				victim.apply_damage(18, BRUTE, limb, sharp = TRUE)
			victim.remove_overlay(UNIFORM_LAYER)
			victim.dropItemToGround(victim.get_item_by_slot(SLOT_W_UNIFORM)) //Drop uniform, belt etc as well.
			victim.f_style = "Shaved"
			victim.update_hair() //then rip the beard off along the skin
			victim.add_flay_overlay(stage = 2)

		if(FLAY_STAGE_SKIN)
			user.visible_message(span_danger("<B>[user] completely flays [victim], pulling the remaining skin off of \his body like a glove!</B>"),
				span_danger("<B>You completely flay [victim], pulling the remaining skin off of \his body like a glove.\nUse rope to hang \him from the ceiling.</B>"))
			playsound(user.loc, 'sound/weapons/wristblades_hit.ogg', 25)
			create_leftovers(victim, has_meat = TRUE, skin_amount = 2)
			for(var/limb in victim.limbs)
				victim.apply_damage(22, BRUTE, limb, sharp = TRUE)
			for(var/obj/item/item in victim)
				victim.transferItemToLoc(item, victim.loc, FALSE, TRUE)
				ADD_TRAIT(victim, TRAIT_UNDEFIBBABLE, TRAIT_UNDEFIBBABLE)
			victim.add_flay_overlay(stage = 3)

			//End the loop and remove all references to the datum.
			current_flayer = null
			UnregisterSignal(victim, COMSIG_HUMAN_FLAY_ATTEMPT)
			victim = null
			return

	flay(target, user, tool)



/datum/flaying_datum/proc/create_leftovers(mob/living/victim, has_meat, skin_amount)
	if(has_meat)
		var/obj/item/reagent_containers/food/snacks/meat/meat = new /obj/item/reagent_containers/food/snacks/meat(victim.loc)
		meat.name = "raw [victim.name] steak"

	if(skin_amount)
		var/obj/item/stack/sheet/animalhide/human/hide = new /obj/item/stack/sheet/animalhide/human(victim.loc)
		hide.name = "[victim.name]-hide"
		hide.singular_name = "[victim.name]-hide"
		hide.stack_name = "[victim.name]-hide"
		hide.amount = skin_amount

#undef FLAY_STAGE_SCALP
#undef FLAY_STAGE_STRIP
#undef FLAY_STAGE_SKIN
