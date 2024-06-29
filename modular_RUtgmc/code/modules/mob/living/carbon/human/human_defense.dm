/mob/living/carbon/human/attackby(obj/item/I, mob/living/user, params)
	if(stat != DEAD || I.sharp < IS_SHARP_ITEM_ACCURATE || user.a_intent != INTENT_HARM || user.zone_selected != BODY_ZONE_CHEST || !internal_organs_by_name["heart"])
		return ..()
	if(!HAS_TRAIT(src, TRAIT_UNDEFIBBABLE))
		to_chat(user, span_warning("You cannot resolve yourself to destroy [src]'s heart, as [p_they()] can still be saved!"))
		return
	to_chat(user, span_notice("You start to remove [src]'s heart, preventing [p_them()] from rising again!"))
	if(!do_after(user, 2 SECONDS, NONE, src))
		return
	if(!internal_organs_by_name["heart"])
		to_chat(user, span_notice("The heart is no longer here!"))
		return
	log_combat(user, src, "ripped [src]'s heart", I)
	visible_message(span_notice("[user] ripped off [src]'s heart!"), span_notice("You ripped off [src]'s heart!"))
	internal_organs_by_name -= "heart"
	var/obj/item/organ/heart/heart = new
	heart.die()
	user.put_in_hands(heart)
	chestburst = 2
	update_burst()

/mob/living/carbon/human/ExtinguishMob()
	. = ..()
	SEND_SIGNAL(src, COMSIG_HUMAN_EXTINGUISH)

/mob/living/carbon/human/proc/check_pred_shields(damage = 0, attack_text = "the attack", combistick = FALSE, backside_attack = FALSE, xenomorph = FALSE)
	if(skills.getRating("swordplay") < SKILL_SWORDPLAY_TRAINED)
		return FALSE

	var/block_effect = /obj/effect/temp_visual/block
	var/owner_turf = get_turf(src)
	for(var/obj/item/weapon/I in list(l_hand, r_hand))
		if(I && istype(I, /obj/item/weapon) && !isgun(I) && !istype(I, /obj/item/weapon/twohanded/offhand))//Current base is the prob(50-d/3)
			if(combistick && istype(I, /obj/item/weapon/yautja/combistick) && prob(I.can_block_chance))
				var/obj/item/weapon/yautja/combistick/C = I
				if(C.on)
					return TRUE

			if(istype(I, /obj/item/weapon/shield/riot/yautja)) // Activable shields
				var/obj/item/weapon/shield/riot/yautja/S = I
				var/shield_blocked = FALSE
				if(S.shield_readied && prob(S.readied_block)) // User activated his shield before the attack. Lower if it blocks.
					S.lower_shield(src)
					shield_blocked = TRUE
				else if(prob(S.passive_block))
					shield_blocked = TRUE

				if(shield_blocked)
					new block_effect(owner_turf, COLOR_YELLOW)
					playsound(src, 'modular_RUtgmc/sound/items/block_shield.ogg', BLOCK_SOUND_VOLUME, vary = TRUE)
					visible_message(span_danger("<B>[src] blocks [attack_text] with the [I.name]!</B>"), null, null, 5)
					return TRUE
				// We cannot return FALSE on fail here, because we haven't checked r_hand yet. Dual-wielding shields perhaps!

			else if((!xenomorph || I.can_block_xeno) && (prob(I.can_block_chance - round(damage / 3)))) // 'other' shields, like predweapons. Make sure that item/weapon/shield does not apply here, no double-rolls.
				new block_effect(owner_turf, COLOR_YELLOW)
				if(istype(I, /obj/item/weapon/shield))
					playsound(src, 'modular_RUtgmc/sound/items/block_shield.ogg', BLOCK_SOUND_VOLUME, vary = TRUE)
				else
					playsound(src, 'modular_RUtgmc/sound/items/parry.ogg', BLOCK_SOUND_VOLUME, vary = TRUE)
				visible_message(span_danger("<B>[src] blocks [attack_text] with the [I.name]!</B>"), null, null, 5)
				return TRUE

	var/obj/item/weapon/shield/riot/yautja/shield = back
	if(backside_attack && istype(shield) && prob(shield.readied_block))
		if(shield.blocks_on_back)
			playsound(src, 'modular_RUtgmc/sound/items/block_shield.ogg', BLOCK_SOUND_VOLUME, vary = TRUE)
			visible_message(span_danger("<B>The [back] on [src]'s back blocks [attack_text]!</B>"), null, null, 5)
			return TRUE

	return FALSE
